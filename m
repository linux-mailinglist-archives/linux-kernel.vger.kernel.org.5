Return-Path: <linux-kernel+bounces-99185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D11287849F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9AB4B206B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DF4594B;
	Mon, 11 Mar 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlsr675w"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A248CF2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173266; cv=none; b=fiQd/kp09mY/O0TPBcAM0UHJv8a8sYrXujnkPUlgfjwOJcAyyu+woHosOay7viyKL3CGo9UY1eYu6XOndoJ157f0dNCyMsI2fso92WXYI0nBoD4j49P/l0iO5tJGBdy1V9iGBwCczCrEugiH3iphEbse7EmDYX8Fn2qeoWCJ2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173266; c=relaxed/simple;
	bh=Vf1D/drG8dAvyzL6c7x+BSkJoHS3u5JICDtceL4dw9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SzAMAtQywG0ABGXDneY1wO7UPhXTgXj9WjBIvjoN4ZaF7HHldnoMeE94quY0GslVLe6GELHtHHT4wq3EcJxU+wJwgDyeGuSN3Fif4Sy6BNF3+3OCOqKtXgBMvLE2uAHDoFR3KuTjsRK95pxEq1bI9YRDIWn3dpId8QhA6K6F9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlsr675w; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f07so31537997b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710173264; x=1710778064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2I1JSNuwoRbdZ2LtvsNthD0wIWUGF8lxvDDDFf/XXwI=;
        b=rlsr675wTD8K9fKVfX0C+c2ZBmfS62NMrMMPie7N9kpiD4gCA6sYWfE8huejmOSGpY
         NzI9bv6Rcxt+b2WxmVbA/304d9zUdcpMU8iVQD2xPxOZNRyVG6roMe/WiX4eqBxsCebZ
         fhVmGeJ5fwe2dMeWURQgc4ioMI/yI843SqBi0QmdZTOkc8VMHLlHOmjnLGrktuQtMOk7
         Miy/HzKvIIWoAMi0FK/J2zW7xtsb6oGrsM90qqf07HXn1cTP0ZLaJGw7wxqhWvPz2Go4
         rLeMwohXSAMRT2ATZmJrTpS6BpX+K5xjrpEkRpXEOpYD3mAI9kd7KEnv5CAj5Xvnt3tu
         VrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173264; x=1710778064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2I1JSNuwoRbdZ2LtvsNthD0wIWUGF8lxvDDDFf/XXwI=;
        b=aeEi7DbaFZoTX2PMS7/ATY+doOW+rdn559Z2kfqsr3cHelL6phC/Qux3BxzNmkE7HZ
         mG5kpSXhaj0CSuXgLNY+MS4rT11zPpZhUoiwEYxRKJw+lI6SHTOjj6UHuxVTDSVHEXwx
         3SoRiWcXWKy+3PvY23/SeCGRKa+ef7YxtLTNB7ygY15noWT87nHbLS5DvvzuU6YuFrZD
         8hmZTsgkvYCzHFlskxp751ezNdyU89QQv372utACwHOeSAWBxvqUxyQx8zQtbhcplpBD
         TadVkHRoA8t8PRxC/O+/n1W7GFb5sw1JGdF56s1xx64Yj+jygcj0IFiJ3PF11H1PNzcj
         az+A==
X-Forwarded-Encrypted: i=1; AJvYcCWeV/PLotWBzVy/JxQzFe5PakAkyWOOYnX0f5VVf733F+rHuHoIbm80WMFDo1Whlk5GHD86uNMFvT+R6sTGvQZQktD973pdW6C7yM7X
X-Gm-Message-State: AOJu0YyFrusWyvHhGwFMb8kuDOnrKZZpV34U1bq2zot2xDEWJsvdgsMz
	0vSK0czN2QAEW3xI2uv+wftKBSZYzEd8v9a4uYMnpWniRyXSsozoanI3gSK4Y0wf7YoU6++X08h
	SzA==
X-Google-Smtp-Source: AGHT+IH7ZTmuIMKrfes3mdxvE6B/9dW9KrRKc/OFzWnNh/fm0pvaaWzXshEZCqE+/gFWjTlOKiCD9fW9G2k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d843:0:b0:60a:16ae:38ee with SMTP id
 a64-20020a0dd843000000b0060a16ae38eemr1797523ywe.3.1710173264289; Mon, 11 Mar
 2024 09:07:44 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:07:42 +0000
In-Reply-To: <20240311134202.GQ86322@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024030251-CVE-2023-52514-c93d@gregkh> <Ze7d0YCDKdu_LJWc@tiehlicka>
 <20240311134202.GQ86322@google.com>
Message-ID: <Ze8sTnE16lbYuX01@google.com>
Subject: Re: CVE-2023-52514: x86/reboot: VMCLEAR active VMCSes before
 emergency reboot
From: Sean Christopherson <seanjc@google.com>
To: Lee Jones <lee@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juergen Gross <jgross@suse.com>, 
	Andrew Cooper <Andrew.Cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024, Lee Jones wrote:
> On Mon, 11 Mar 2024, Michal Hocko wrote:
> 
> > On Sat 02-03-24 22:52:59, Greg KH wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > x86/reboot: VMCLEAR active VMCSes before emergency reboot
> > > 
> > > VMCLEAR active VMCSes before any emergency reboot, not just if the kernel
> > > may kexec into a new kernel after a crash.  Per Intel's SDM, the VMX
> > > architecture doesn't require the CPU to flush the VMCS cache on INIT.  If
> > > an emergency reboot doesn't RESET CPUs, cached VMCSes could theoretically
> > > be kept and only be written back to memory after the new kernel is booted,
> > > i.e. could effectively corrupt memory after reboot.
> > > 
> > > Opportunistically remove the setting of the global pointer to NULL to make
> > > checkpatch happy.
> > > 
> > > The Linux kernel CVE team has assigned CVE-2023-52514 to this issue.
> > 
> > I do not really see the security aspect of this fix. Guests systems
> > shouldn't be able to trigger host reboot nor any untrusted entity should
> > on the host either or this would be a serious security hole.

And not just any reboot either, this only comes into play with something like
`reboot -f`.  Not to mention the impact of the bug is ridiculously theroetical
(I didn't tag the patch for stable@ for a reason).

> > Or am I missing something?
> 
> Thanks for reporting.
> 
> If Sean and/or Paolo agree, we can revoke the CVE for you.

Please do.

