Return-Path: <linux-kernel+bounces-95027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61D874859
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDBB1C2329B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D41CF89;
	Thu,  7 Mar 2024 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sCUfvg8Z"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA411184
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794283; cv=none; b=j5MP1fdeYooF01jcq68T3J5n8X2r9x66QHVWrAUAR3gIaNP8h3XcBcQPqlOw8I6baXnVLt8NRWL0gt7kfHTYTJIUlXeGlbSXsRgavWUMm3qZqfauu+JPXaqSrNADU+3ZbtqLbIUjvsffc79VpPILrRhmdQSGQEUNKqV1ABDbCn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794283; c=relaxed/simple;
	bh=3H/lvOapkzvFzelyzgbt32NSIz7kMrDaoswIBUoWId0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a48UjVKMD4exIJqaZcLrpsqH2+yGkECx9QlIxoxyQMoxwcIeUGBC7NsR9t2Sz0z08APpw4RcjE/D/z5ZBaEajk5BPeKjzYOcs9thHC9DmvjTA2kC9KuTXQdA9137VSbseNfCI5oICU/WdtxJhTUo2kftUJjn3ziB4RSFZXdVsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sCUfvg8Z; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4CDE54112B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709794279;
	bh=1XHqEKGDEWpYWhhB4V3kQVznnM/0tQjfz0REQnBC9xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sCUfvg8ZRDyO4WCJSmgpvgv7dvQOB+SRjOau9wuBe44QYwYNUq/w/qgdzQnAJIQ+1
	 e5ZaU7NtDftJ0CAQxnMSfehpwQ6rOgOT3VlW5zgnryV2StlTZBZWKeG4T9IdaORidU
	 mKJkMNv8W8iYxzDUkrVYWIDT3sGh3IRBsbUKFwPRR8/lfnnDO+0iE85IB/01yfGYaI
	 o3fqRuPIpmDBkBYu6F3zdTJy84cHiv50aJi2IhuwAeK4PeLCztjVCfBcLLDOgjfk5X
	 VJv+qXuBeBlSYZAmuRDWAnRbBLIqX/dbk8e3XWQQnhZc2SIJmD67rSihDb1pVhduig
	 Rwy3VGKwEUUUw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29b9babb547so17064a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 22:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794278; x=1710399078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XHqEKGDEWpYWhhB4V3kQVznnM/0tQjfz0REQnBC9xs=;
        b=VRGgc6GoMKdYj4kPGPsRzpR6/ZC0zZViuupaEgTbLTGOjYyqSz4tam12DTF8umDVK7
         WgRj+c+0/u/zAebSMK3GLHRd7s5Ib47VxyWXCRsHWfa9fVeWSnM6pL1ps9EFrNsHiGYe
         dR7dMOf1Hxs7Io+6xAMNKq5F58vhxIkpFk6rvdrhpQt/P74dGAVRaelE6QiZZ3b4zWUE
         rd4H9CTAcRR9NFnba2av+Kps9FGTqtSIT6XE2UHbNiQbX3b7/JKbAMsObVtFNDcTmTDM
         aNlPrBM5FHMMkriuq0rUAgtKSQtR+UgPBat77CejCInStc+8Y/uyfDikZpKrnyqLFjnC
         TGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX183zE8RpmU7P019amtynE9H0FTXHr17dBmg/BDYtlL+rl3GZhyO6/9e9tXeUQXnhN/qv7a/MW+LIa9Q1OZKqItiufQOZkW7bEqPU
X-Gm-Message-State: AOJu0Yxm4kiGFAYdhc9Q1hqe/IT/wFr9QVyrJNUvWUCcYJN2sGtHGj9K
	SFTd/JXdwRoZNFJq5PyLxp27xu4Vh3r9VyjgSHV4tuinNJcBzNU63A+fl4SHQhpMdrDi79vSao9
	4HeRr8jDdaGB7fq0Kjs2seV4ihr+XxGlIOaMS8mkKV2g04XlkRWXygkBO1jIkNfd5xQJMFwgO7s
	g4zzs4/VYEeq7QoQrampxgreXTYp+JaztZlTaAOY5+12w1MiwbDDYL
X-Received: by 2002:a17:90b:1214:b0:29b:23bc:19a5 with SMTP id gl20-20020a17090b121400b0029b23bc19a5mr16294044pjb.26.1709794277970;
        Wed, 06 Mar 2024 22:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/lzIcUCqv0H8CBqPe30CqTsc2cPSeSmtT2lFHGN90fG85b/xxIUsgCM/tV1RPHe7TGAt8/gKh/V1tFsZ+8OE=
X-Received: by 2002:a17:90b:1214:b0:29b:23bc:19a5 with SMTP id
 gl20-20020a17090b121400b0029b23bc19a5mr16294025pjb.26.1709794277695; Wed, 06
 Mar 2024 22:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <954f0b86-dd9e-4d84-8d67-fba7e80bc94e@5challer.de>
 <20240105155100.GA1861423@bhelgaas> <CAAd53p5Eg4J9bRtAHY+JZ11cy1D0TnKmAaLfzcRJzw15VRBxXw@mail.gmail.com>
 <9f0f9de4-2d34-4ff3-a901-c3e4b48e4ab0@5challer.de>
In-Reply-To: <9f0f9de4-2d34-4ff3-a901-c3e4b48e4ab0@5challer.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 7 Mar 2024 14:51:05 +0800
Message-ID: <CAAd53p6GEPJe3rNNrUAah5PdLXspKh5Gz9tFstR6SFCREs+9=Q@mail.gmail.com>
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
To: Michael Schaller <michael@5challer.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, macro@orcam.me.uk, 
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	gregkh@linuxfoundation.org, hkallweit1@gmail.com, 
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Sorry for the belated response.

On Wed, Jan 10, 2024 at 8:40=E2=80=AFPM Michael Schaller <michael@5challer.=
de> wrote:
>
>
> On 10.01.24 04:43, Kai-Heng Feng wrote:
> > On Fri, Jan 5, 2024 at 11:51=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> >>
> >> On Fri, Jan 05, 2024 at 12:18:32PM +0100, Michael Schaller wrote:
> >>> On 05.01.24 04:25, Kai-Heng Feng wrote:
> >>>> Just wondering, does `echo 0 > /sys/power/pm_asysnc` help?
> >>>
> >>> Yes, `echo 0 | sudo tee /sys/power/pm_async` does indeed also result =
in a
> >>> working resume. I've tested this on kernel 6.6.9 (which still has com=
mit
> >>> 08d0cc5f3426). I've also attached the relevant dmesg output of the
> >>> suspend/resume cycle in case this helps.
> >>
> >> Thanks for testing that!
> >>
> >>> Furthermore does this mean that commit 08d0cc5f3426 isn't at fault bu=
t
> >>> rather that we are dealing with a timing issue?
> >>
> >> PCI does have a few software timing requirements, mostly related to
> >> reset and power state (D0/D3cold).  ASPM has some timing parameters,
> >> too, but I think they're all requirements on the hardware, not on
> >> software.
> >>
> >> Adding an arbitrary delay anywhere shouldn't break anything, and other
> >> than those few required situations, it shouldn't fix anything either.
> >
> > At least it means 8d0cc5f3426 isn't the culprit?
> >
> > Michael, does the issue happen when iwlwifi module is not loaded? It
> > can be related to iwlwifi firmware.
> >
> > Kai-Heng
> >
> The issue still happens if the iwlwifi module has been blacklisted and
> after a reboot. This was again with vanilla kernel 6.6.9 and I've
> confirmed via dmesg that iwlwifi wasn't loaded.

Can you please give latest mainline kernel a try? With commit
f93e71aea6c60ebff8adbd8941e678302d377869 (Revert "PCI/ASPM: Remove
pcie_aspm_pm_state_change()") reverted.

Also do you have efi-pstore enabled? Is there anything logged in
/var/lib/systemd/pstore (assuming systemd is used)?

Kai-Heng

>
> I've also checked if there is a newer firmware but Ubuntu 23.10 is
> already using the newest firmware available from
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it/log/iwlwifi-8265-36.ucode
> (version 36.ca7b901d.0 according to dmesg).
>
> Michael
>
> >>
> >> Bjorn

