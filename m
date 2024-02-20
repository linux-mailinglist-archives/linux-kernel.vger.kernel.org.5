Return-Path: <linux-kernel+bounces-72868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD5E85B9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C59283F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77664CF5;
	Tue, 20 Feb 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGfAHDPX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C33604A9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426899; cv=none; b=dsgD2MbyV+cibyl20N2RcMNiFfFir27Oot3T57VSFBztAdAlXi8pbMZvS3uqC8QwEiIwVENk7Idc8GWWByTQ2P9bCwX87PNzvLl77qNhtda7zJLXmzpclMMYpfYpVLoqTG3sA1PIzev8dmFDSUeOwVQ0lJQ4M+BJJ8FS6e1s7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426899; c=relaxed/simple;
	bh=BZIY99CfCnRkSo2P+adAlO3zZixCMpjO82LAqwFoICo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbH/06aHpjIn+kjZiiWPRvbYgI0lwRyZ67ogCV7M7aanP/2VNr44pCXWtjMzc0T7bgfnpJ14b02WcIgnXSY9baD5I9sU8guFBzXWwcHx6q62n4X/z4LBDM+El6jfIrm5jVveKZkRDbJuThi/5M2n5Xca1XPtmTuG9/5D0iBT7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGfAHDPX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708426897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YApau1FxyR+cDTI8ZV4SeuS97RoxId3RVP36y1FGLzQ=;
	b=GGfAHDPXDaMFjSsAtKkPz0EWualj8D1H+jxXwp5sO+5U9t76HfduPv7UsbSPp2WV3PTMN2
	6IgJxWWtPRlA5Osob9etRwCoLDUwZyUkQWpxSP2C6DakqQ6jAupTx1hWeccyc3hMTWQazL
	E3iWSoZQb2ahYtt7HvBx45Fy3I7p4OU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-gjfv-SoVOOygvW9oZEmTeg-1; Tue,
 20 Feb 2024 06:01:33 -0500
X-MC-Unique: gjfv-SoVOOygvW9oZEmTeg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E4B92806408;
	Tue, 20 Feb 2024 11:01:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.160])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8AEBE492BD7;
	Tue, 20 Feb 2024 11:01:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 Feb 2024 12:00:14 +0100 (CET)
Date: Tue, 20 Feb 2024 12:00:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240220110012.GB7783@redhat.com>
References: <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
 <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 02/20, Christian Brauner wrote:
>
> On Tue, Feb 20, 2024 at 10:02:56AM +0100, Oleg Nesterov wrote:
> >
> > Ah. IIRC criu uses this hack to restore the pending (arbitrary) signals
> > collected at dump time.
> >
> > I was a bit surprise sys_pidfd_send_signal() allows this hack too, I don't
>
> I think that we simply mirrored the restrictions in the other system
> calls.
>
> > think that criu uses pidfd at restore time, but I do not know.
>
> Hm, I just checked and it doesn't use pidfd_send_signal(). It uses
> pidfds but only for pid reuse detection for RPC clients.

But perhaps something else already uses pidfd_send_signal() with info != NULL
or with info->si_code == SI_USER, we can't know. Please see below.

> So right now si_code is blocked for >= 0 and for SI_TKILL. If we were to
> simply ensure that si_code can't be < 0 then this amounts to effectively
> blocking @info from being filled in by userspace at all. Because 0 is a
> valid value.

I'am afraid I misunderstand you again... 0 == SI_USER is not a valid value
when siginfo != NULL.

Perhaps we can kill the "task_pid(current) != pid" check and just return
EPERM if "kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL", I don't think
anobody needs pidfd_send_send_signal() to signal yourself. See below.

> +       /* Currently unused. */
> +       if (info)
> +               return -EINVAL;

Well, to me this looks like the unnecessary restriction... And why?

But whatever we do,

> -               /* Only allow sending arbitrary signals to yourself. */
> -               ret = -EPERM;
> -               if ((task_pid(current) != pid) &&
> -                   (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> -                       goto err;

Can I suggest to fix this check in your tree (add type > PIDTYPE_TGID as
we discussed) first, then do other changes on top?

This way we can revert the next change(s) if we get regressions reports
without re-introducing the security problem.

Oleg.


