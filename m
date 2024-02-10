Return-Path: <linux-kernel+bounces-60396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DC850464
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E322817D6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19047F59;
	Sat, 10 Feb 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXReNp7G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C223EA66
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707568318; cv=none; b=Hy0fv2sf7xej1OUtx+Hq9hawQ7s+3hfraFOHAYDk8Qj3DhAJOdTvjP/ipqluGb03n+7NYGEgP3lHK4uv4bx8O06pe1rS7rCargLJfxtcq2b4krJyT2tl+QUQT/mktp5Q/BTSfxobwEMBQ+rh6YOrobFZXLXI/FZQu3YT7f5i6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707568318; c=relaxed/simple;
	bh=b/+bunSHR5UhPdFTXfBKcRLs2qkDpn8Qrz7Q+Zf0Neg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvfuV+3c0fL1222liOWND8UpxQkirLC6Bup8A4+ltOA7VrkahbvhChiL4RInwr/fCRRDWWYCqHf3z4PKWUg9pBXICsQ999OhoiSuHjjp/GNweooNFcQS2J0Br/YgxXfGVY97HpR7VLLIS7pe3xSh3cH4xndbeaPY1uHCbR5KdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXReNp7G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707568316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rsa8Sa2RaRjXmbcIJ9/cp3lURU1N9XcuIpnY+VN8kcI=;
	b=AXReNp7GN5C3BWNiOzedgxO5AcPjqEQzg5JXDGWoRX71UiqUNqCSA4NItOwGvlS2Eivn+5
	m083+AV/XjCFvjioZ3FvR4QAXB/KPX2is3eFv1Xff+YSzOO+6H2ipqEUfKRsmgH2u4USSE
	sEYLEVmsFHEpRS+9F0Z4WPElOTLNr1s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-euPsEMJsOUOA3OZtIC3yHg-1; Sat,
 10 Feb 2024 07:31:52 -0500
X-MC-Unique: euPsEMJsOUOA3OZtIC3yHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B560380451B;
	Sat, 10 Feb 2024 12:31:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with SMTP id 13E2840C9444;
	Sat, 10 Feb 2024 12:31:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 10 Feb 2024 13:30:35 +0100 (CET)
Date: Sat, 10 Feb 2024 13:30:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210123033.GA27557@redhat.com>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Christian,

Thanks again! the last 2 commits in vfs.pidfd look good to me.

As for this patch, I am not sure I understand your concerns, and I
have another concern, please see below.

For the moment, please forget about PIDFD_THREAD.

On 02/10, Christian Brauner wrote:
>
> (1) kill(-1234) => kill process group with id 1234
> (2) kill(0)     => kill process group of @current
>
> which implementation wise is indicated by
>
> __kill_pgrp_info(..., pid ? find_vpid(-pid) ? task_pgrp(current))
>
> We're obviously not going to implement (2) as that doesn't really make a
> sense for pidfd_send_signal().

Sure,

> But (1) is also wrong for pidfd_send_signal(). If we'd ever implement
> (1) it should be via pidfd_open(1234, PIDFD_PROCESS_GROUP).

Why do you think we need another flag for open() ?

To me it looks fine if we allow to send the signal to pgrp if
flags & PIDFD_SIGNAL_PROCESS_GROUP.

And pidfd_send_signal() can just do

	if (PIDFD_SIGNAL_THREAD_GROUP)
		ret = __kill_pgrp_info(sig, kinfo, pid);
	else
		ret = kill_pid_info_type(...);
		
(yes, yes, this needs tasklist, just a pseudo code to simpliy)

Now lets recall about PIDFD_THREAD.

If the target task is a group leader - there is no difference.

If it is not a leader - then __kill_pgrp_info() will always return
-ESRCH, do_each_pid_task(PIDTYPE_PGID) won't find any task.

And personally I think this is all we need.

------------------------------------------------------------------------------
But if you want to make PIDFD_SIGNAL_THREAD_GROUP work even if the
target task is not a leader, then yes, we need something like

	task_pgrp(pid_task(pid, PIDTYPE_PID))

like you did in the new kill_pgrp_info() helper in this patch.

I won't argue, but do you think this makes a lot of sense?

Oleg.


