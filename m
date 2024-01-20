Return-Path: <linux-kernel+bounces-31718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5EB8332F2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F54AB2326F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB7420E0;
	Sat, 20 Jan 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0hmsRm4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C0EA3;
	Sat, 20 Jan 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705732648; cv=none; b=sPdzE1QDQazaVo/sjvu1HUJtsdTx9+IFbMQe874TG+tc4Wpf/Oc5oQTIYJ7vxiqmZ6vjZU6TWexCO/MAw/s2AGHDJ8j9BM30zpcFUI8eF8c1KUBNvnUIa8/vH3pCEnKS5n0ltH4+KMs9AAkYUMNomz2ItGX324PlF5HqXXFU2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705732648; c=relaxed/simple;
	bh=2Rz4etFd4YcasZMsepXctMvLqiF+vrceqDv3so5hvMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHvOJJUTDsxo5SXN+P0yjb+T7RJySLAP/wR+ZTPJgIyBdhg/QW2Y1I3xWKHy+eBs1x3AGowL+79yzpiH49YLKK05WxrAfS1JL7KBL+FUUPaKrvT8IPMN9b7Hq1te+xl8MKiN/mnT92hOdB9BC5CoFOK1vg3uyutxUesE8MR35MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0hmsRm4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABB6C433F1;
	Sat, 20 Jan 2024 06:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705732647;
	bh=2Rz4etFd4YcasZMsepXctMvLqiF+vrceqDv3so5hvMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0hmsRm4Il+AXIoXg+ZIBx7ghi0whFL03nil5mxnB8ZMe1qHwQy3gbKcLJm0/A2N2c
	 E3mnJo/xXEj6YBo13vPgVwKp0zFBdEqSYFWyem1LhKXPIZZ9RmSHQL9mnjqVyPIyAi
	 bWSO7mkgs0kazW6mhbkH5IGES0Rtx8lwtWERtGdw=
Date: Sat, 20 Jan 2024 07:37:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
Message-ID: <2024012013-zoologist-reawake-8ebe@gregkh>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-4-cmllamas@google.com>
 <Zal8A95q3jVl4nu5@google.com>
 <2024011935-placidly-justifier-4338@gregkh>
 <ZaqsBTQ1x5lQG9Rq@google.com>
 <ZaqzUrkfSqw0jKkG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqzUrkfSqw0jKkG@google.com>

On Fri, Jan 19, 2024 at 05:37:22PM +0000, Carlos Llamas wrote:
> On Fri, Jan 19, 2024 at 05:06:13PM +0000, Carlos Llamas wrote:
> > 
> > Oops, here is the complete info:
> > 
> > Commit ID: 9a9ab0d963621d9d12199df9817e66982582d5a5
> > Subject:   "binder: fix race between mmput() and do_exit()"
> > Reason:    Fixes a race condition in binder.
> > Versions:  v4.19+
> > 
> > Note this will have a trivial conflict in v4.19 and v5.10 kernels as
> > commit d8ed45c5dcd4 is not there. Please let me know if I should send
> > those patches separately.
> > 
> > Thanks,
> > --
> > Carlos Llamas
> 
> Sigh, I meant to type "conflict in v4.19 and v5.4". The patch applies
> cleanly in v5.10+.

Yes, I need backported patches please.

thanks,

greg k-h

