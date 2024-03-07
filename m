Return-Path: <linux-kernel+bounces-96217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035528758C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1B02817CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29929139598;
	Thu,  7 Mar 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6+dPddM"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A551386AF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844345; cv=none; b=drngBDCsLbtg/TVeqCQQQNAoROLKtl7akYlSoyPZU2qVYi28fenbiTXkTgozNgdTclXxKuq5Aq7WAMbNtwabq2Kw8zq0npsM5j8CHXUuXb6KhpICKw41ggWwU85Emr+29OGcIL3WCXjByr3UXhbC1XJNn5gCY6MLZC58Wb51uJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844345; c=relaxed/simple;
	bh=kgVsBO9fAWx4C4lKypuEs11y4Czdj0K9xrrVMK3VHyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHBzunfnh/JLKG1b0rY+n3CjXPi31d52dReGMw0BX5ZWtjGBdyhGqdjdWJPZjuajAsEmsXpLgxOk/KmBZSA5k1vV9jtRuBwtt/ziahX5QUwdT30JsL3qPZKbO967gTtK31Bmb9HTZRb4/eswp2MQVE2/ZRnCxcz0D/WjSF0LEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6+dPddM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd0d46ecc3so10527035ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709844343; x=1710449143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+3FhdmrXd3GVtm7VM7YbcxkD8Ujzz7d6MpBmECMceE=;
        b=Q6+dPddMQvTiVxca7XTVlnGPomZB8AR7UNm7M/7vf0ODqvYG3H8SKAEQavurdd4+1r
         iS93o0HZNFBjzPOGR7ZmNKOw32J8ylDF1yGGCzFCCi6kXBKbHOuPiQG/w5TItALMbmqH
         axqHSQMqyqqxedVqk0elxRvgPQZ8Yx6kEslrm+OhbId/NsbSHPhxue2XvHobsg7xBkt+
         mhXarHp9JNoSijfsnvBGnK8CHslf30lPYlQEqgq9haO3bROcRR2nIwJZuqlWjBqIr41B
         BNvDrPwLMlwcwOG+2p1BtkyaG2MSoozF2/gm6+6jLS7xzwrfy4//85N3r+V4ZPI+c5Y/
         /Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709844343; x=1710449143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+3FhdmrXd3GVtm7VM7YbcxkD8Ujzz7d6MpBmECMceE=;
        b=K+kOeTZNkp303664d+f7R6rQY55ayyo6KvYe4hRDPGzHk2Wn+eAZXT1HgHQD1q5HRJ
         VP106oWalXhpMa+azd/TTLRj83JmpYVhK0FYVduHRDtSaDLKXIsqVVu9F0zLHVfn9O2E
         Vy8fDHcI7pStapn+xN+H7OBn5p5adLyhyNnYJeCsl91z6Qbhl8M2mcf6mkH342OelhEQ
         gLFXar+j+mNe2NMekXqlMIFPceegA4kQXLzeni/RpU7gCFL+XOUtJie0T59W0Gp71oHt
         9kDh6ylj/pVmMkI4OGVu6lp4XwO1e46RPb9BnaZ0pbD57BFgcIBriC0iiKQ/pJjm0QiR
         IDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJz/SF1dQ5LuHsOrnn3z53xarRPK2cYFW9ZyZLoqyTNr8BhJe/ONAUD50xUnBkyPl+bLub+gjiC/+FM5QcHZyHKE/SjXdOnxSUgv6n
X-Gm-Message-State: AOJu0Yy9UjL5zRQAF810XZegVuhKQZ0+G28yCThYJhyL0IpEPAr96ECp
	dOUAhUaflI0m4Juv5Y1luZ4JsdhikKCMrhZuzuU/kL6pe6/7hu9cpSYrCdr1ZrHx5rkiGE7aRJi
	LAXo00nwxTsGqYf3n/K1JlxzR8yk=
X-Google-Smtp-Source: AGHT+IFdvxrAlUjPzWK3dLgAyn1B+EzTBvk4oL8SOwi1urs+btyPwqeGrxBQ9IvKUCGqQcdRRrs3CaiIyxgPjEY4ndQ=
X-Received: by 2002:a17:902:eccc:b0:1dc:b3bc:b7e1 with SMTP id
 a12-20020a170902eccc00b001dcb3bcb7e1mr11971789plh.1.1709844343172; Thu, 07
 Mar 2024 12:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307165932.3856952-1-sunil.khatri@amd.com>
 <20240307165932.3856952-3-sunil.khatri@amd.com> <CADnq5_OaCRAjCZGOEpd1gTFSUHdNkVbDqDgx_LQKw_JR1Qtv3Q@mail.gmail.com>
 <c33f5ede-19de-491b-8f97-c78db47fdf30@amd.com>
In-Reply-To: <c33f5ede-19de-491b-8f97-c78db47fdf30@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Mar 2024 15:45:30 -0500
Message-ID: <CADnq5_M1ti9A0t8HgBX9o_DytyHCbH=qhOKJZXkCM=C99Z7ptw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add vm fault information to devcoredump
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Mukul Joshi <mukul.joshi@amd.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:42=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wro=
te:
>
>
> On 3/8/2024 12:44 AM, Alex Deucher wrote:
> > On Thu, Mar 7, 2024 at 12:00=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.=
com> wrote:
> >> Add page fault information to the devcoredump.
> >>
> >> Output of devcoredump:
> >> **** AMDGPU Device Coredump ****
> >> version: 1
> >> kernel: 6.7.0-amd-staging-drm-next
> >> module: amdgpu
> >> time: 29.725011811
> >> process_name: soft_recovery_p PID: 1720
> >>
> >> Ring timed out details
> >> IP Type: 0 Ring Name: gfx_0.0.0
> >>
> >> [gfxhub] Page fault observed
> >> Faulty page starting at address 0x0000000000000000
> > Do you want a : before the address for consistency?
> sure.
> >
> >> Protection fault status register:0x301031
> > How about a space after the : for consistency?
> >
> > For parsability, it may make more sense to just have a list of key valu=
e pairs:
> > [GPU page fault]
> > hub:
> > addr:
> > status:
> > [Ring timeout details]
> > IP:
> > ring:
> > name:
> >
> > etc.
>
> Sure i agree but till now i was capturing information like we shared in
> dmesg which is user readable. But surely one we have enough data i could
> arrange all in key: value pairs like you suggest in a patch later if
> that works ?

Sure.

Alex

>
> >
> >> VRAM is lost due to GPU reset!
> >>
> >> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_reset.c
> >> index 147100c27c2d..dd39e614d907 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >> @@ -203,8 +203,20 @@ amdgpu_devcoredump_read(char *buffer, loff_t offs=
et, size_t count,
> >>                             coredump->ring->name);
> >>          }
> >>
> >> +       if (coredump->adev) {
> >> +               struct amdgpu_vm_fault_info *fault_info =3D
> >> +                       &coredump->adev->vm_manager.fault_info;
> >> +
> >> +               drm_printf(&p, "\n[%s] Page fault observed\n",
> >> +                          fault_info->vmhub ? "mmhub" : "gfxhub");
> >> +               drm_printf(&p, "Faulty page starting at address 0x%016=
llx\n",
> >> +                          fault_info->addr);
> >> +               drm_printf(&p, "Protection fault status register:0x%x\=
n",
> >> +                          fault_info->status);
> >> +       }
> >> +
> >>          if (coredump->reset_vram_lost)
> >> -               drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> >> +               drm_printf(&p, "\nVRAM is lost due to GPU reset!\n");
> >>          if (coredump->adev->reset_info.num_regs) {
> >>                  drm_printf(&p, "AMDGPU register dumps:\nOffset:     V=
alue:\n");
> >>
> >> --
> >> 2.34.1
> >>

