Return-Path: <linux-kernel+bounces-13874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D2A8213DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAC9281F15
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06064C85;
	Mon,  1 Jan 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PIGNGs1E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2854689;
	Mon,  1 Jan 2024 13:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F905C433C8;
	Mon,  1 Jan 2024 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704117322;
	bh=9bF83ulcc4J+BxQt4Tt43+iD8iO6iG3MxkjSXNsPzYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIGNGs1EynH9ZG6jspYYK8swv9jfMptWebdyVWA5gGXb9vX8/ttrjb0RB7pHlFIwo
	 YPNNsbeMIXD4LJtvDhxob/X26wSZHyb/P4kyiHvyO3kzW/pTkUJi7tC6SA0m6S7ImY
	 HLhbUr+XiA0kecmJjipNwlrSnTMH2n98MYtlqnVg=
Date: Mon, 1 Jan 2024 13:55:19 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	vegard.nossum@oracle.com, darren.kenny@oracle.com,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [RFC PATCH] VMCI: Silence memcpy() run-time false positive
 warning
Message-ID: <2024010103-connector-plausibly-bc35@gregkh>
References: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>

On Mon, Jan 01, 2024 at 05:08:28AM -0800, Harshit Mogalapalli wrote:
> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
> 
> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
> 
> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
> 
> Some code commentry, based on my understanding:
> 
> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
> /// This is 24 + payload_size
> 
> memcpy(&dg_info->msg, dg, dg_size);
> 	Destination = dg_info->msg ---> this is a 24 byte
> 					structure(struct vmci_datagram)
> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
> 	Size = dg_size = 24 + payload_size
> 
> 
> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
> 
>  35 struct delayed_datagram_info {
>  36         struct datagram_entry *entry;
>  37         struct work_struct work;
>  38         bool in_dg_host_queue;
>  39         /* msg and msg_payload must be together. */
>  40         struct vmci_datagram msg;
>  41         u8 msg_payload[];
>  42 };
> 
> So those extra bytes of payload are copied into msg_payload[], so there
> is no bug, but a run time warning is seen while fuzzing with Syzkaller.
> 
> One possible way to silence the warning is to split the memcpy() into
> two parts -- one -- copying the msg and second taking care of payload.

And what are the performance impacts of this?

thanks,

greg k-h

