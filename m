Return-Path: <linux-kernel+bounces-103638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5887C240
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567B9283648
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0374BEB;
	Thu, 14 Mar 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJaWvpoA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA8745D5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438717; cv=none; b=bLWMqFtWnY8FBaqpYPVz4IplQcbzKy+/wt3wmucq0b5DBBGqlYyh79JQdxaJsy9vUmrGkc/Mz77GgzIvdaypHktscHcrfbogo9ql/15QdQVrq2Nxoj415Guz7uMhw7W4sr93m9UZ90mQGHXOD4jXziv4Kt5cJOA2EDcHb9xGfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438717; c=relaxed/simple;
	bh=W4fz5aM1Xj6mRv+GxOPNP6rsBtXJG7XPvD6c5p5zsZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J66VGLx8whOiVckitWF1y8jJWCLsPyJkncO46mM8C1RR2iudyG3Ri9CcyQUTVpeXSOiKSRo4ejd55EuEF7gkFLA5imA4jWc68LzGHejwZ3kzmTt3O1HmWnzt4cdH9d+mhquDxGkHc8HHbAi26OWDiWty9i1gNxC/pzCsLQwHsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJaWvpoA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd955753edso11042525ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710438715; x=1711043515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83o/z763nISRcPT8Ce4hg/uxvl1Iug2mRWFmiJSQha0=;
        b=FJaWvpoADUHLohVoV3rHtXueyMji46KgbHN20QukdDaHAum7hNYP0I+1t7Q6p26UUj
         zngdI0zQgRaFwFgSSfEZFGRNQUCmI4+T00bRv0q08FyCT1OzgTc1MDqHjGNurf6Q7/uQ
         rVoiu+yqcNPyoB0MfdNeT1lndsILvkNR/niEJioW9xnW3bY1fhUQU6mP64bu50QUOhTx
         o4IzLw2Fyo5U6gzPDC4gXDsZokOHF3V89kjKsyTrMpGpBVqdDVuTfURflNMeAgqL74pg
         UOt1RQixqhfG6CZQ0kujIsdjxLo4jQ7algMYQrL2deZ11rUgexYKc4EP/8ooVGawIpdQ
         JF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438715; x=1711043515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83o/z763nISRcPT8Ce4hg/uxvl1Iug2mRWFmiJSQha0=;
        b=iUHBo+6XB0Em9E+UbIeBYxTfB7FqYhG8bl+iu1KNV8xGm0FY4fngPqS0BYwqG7txSZ
         qKjVyrXyrJKGhVPIJwF6XnqTeawRr8nuDK3E4+8P8z9fdPWvVQbeO74ekV3oyXrEjDEZ
         sKsnsOPQAOjyYv6AR4QrBDICXBL2Uuhgcs8nAGrvkZLpr4OVh7r6xJMlTs1vs5o6mEtM
         0gkTDqKYGkW1Oy92/ZaM3VdpbCrIgicAEyNpc3v9Hs+XY4a6Hxtm1//i7MuVt9duw+Aq
         /tcFL/MYbNUijNvYEybOnlGqEKIAo58jHyVjl6X0eZwUQbyp/qVXi8HNVZvBQ2qQDlsr
         TtOA==
X-Forwarded-Encrypted: i=1; AJvYcCXSZJUqqEO2INd8T0c55a9q6OGsrMk+ZFUOqo+Ix4RXu0HOeYzP6MPme/06g96G9B42dANV3YOGy1QSLhY4BEb89ENYi1x3ahpXF+sy
X-Gm-Message-State: AOJu0YwetzBr4eQSXzDkFPsTM9g8LFfz3pb4l9lTIAKplO+SlBno+Cry
	+vtnffiROZrrkVZA3gCU4eCjaxVBbC1oQizlofgatKYHzEO2pR1hLpUrTOaNcvMvvmYCcpORxuT
	kvUwUkAda6YgBViZHSwsRVWb98IrawSwamCU=
X-Google-Smtp-Source: AGHT+IGME2ZBAjfwN5W4buTyp4q6UKGQ3GqH2t3Nk3YFMv7LRHDx2QR5986+nNZie6GdhVNX/cqIqgT3EyzylKiQKAk=
X-Received: by 2002:a17:90a:6c06:b0:29b:4d0b:66ab with SMTP id
 x6-20020a17090a6c0600b0029b4d0b66abmr684578pjj.33.1710438715102; Thu, 14 Mar
 2024 10:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312124148.257067-1-sunil.khatri@amd.com> <CADnq5_O-cyDkNLznZpvnZtz15Mi1_rkigirG80BmYJprP_udnw@mail.gmail.com>
 <59cf081e-5924-42b5-a3f1-de8b012f09d1@amd.com> <CADnq5_N0H75UU2aFTAkqUrdGxKPxBQUnodsH-bcpS-ZUqgUb3A@mail.gmail.com>
 <32aad098-9392-4899-9839-1beaedcac8b8@amd.com>
In-Reply-To: <32aad098-9392-4899-9839-1beaedcac8b8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Mar 2024 13:51:42 -0400
Message-ID: <CADnq5_NvBsbmTteDKmzi1DZHPKGfoSMjW5TFfy2x60YDxydc=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add the IP information of the soc
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 12:16=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> w=
rote:
>
>
> On 3/14/2024 8:12 PM, Alex Deucher wrote:
> > On Thu, Mar 14, 2024 at 1:44=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com=
> wrote:
> >>
> >> On 3/14/2024 1:58 AM, Alex Deucher wrote:
> >>> On Tue, Mar 12, 2024 at 8:41=E2=80=AFAM Sunil Khatri <sunil.khatri@am=
d.com> wrote:
> >>>> Add all the IP's information on a SOC to the
> >>>> devcoredump.
> >>>>
> >>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 19 ++++++++++++++++++=
+
> >>>>    1 file changed, 19 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reset.c
> >>>> index a0dbccad2f53..611fdb90a1fc 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >>>> @@ -196,6 +196,25 @@ amdgpu_devcoredump_read(char *buffer, loff_t of=
fset, size_t count,
> >>>>                              coredump->reset_task_info.process_name,
> >>>>                              coredump->reset_task_info.pid);
> >>>>
> >>>> +       /* GPU IP's information of the SOC */
> >>>> +       if (coredump->adev) {
> >>>> +               drm_printf(&p, "\nIP Information\n");
> >>>> +               drm_printf(&p, "SOC Family: %d\n", coredump->adev->f=
amily);
> >>>> +               drm_printf(&p, "SOC Revision id: %d\n", coredump->ad=
ev->rev_id);
> >>>> +
> >>>> +               for (int i =3D 0; i < coredump->adev->num_ip_blocks;=
 i++) {
> >>>> +                       struct amdgpu_ip_block *ip =3D
> >>>> +                               &coredump->adev->ip_blocks[i];
> >>>> +                       drm_printf(&p, "IP type: %d IP name: %s\n",
> >>>> +                                  ip->version->type,
> >>>> +                                  ip->version->funcs->name);
> >>>> +                       drm_printf(&p, "IP version: (%d,%d,%d)\n\n",
> >>>> +                                  ip->version->major,
> >>>> +                                  ip->version->minor,
> >>>> +                                  ip->version->rev);
> >>>> +               }
> >>>> +       }
> >>> I think the IP discovery table would be more useful.  Either walk the
> >>> adev->ip_versions structure, or just include the IP discovery binary.
> >> I did explore the adev->ip_versions and if i just go through the array
> >> it doesn't give any useful information directly.
> >> There are no ways to find directly from adev->ip_versions below things
> >> until i also reparse the discovery binary again like done the discover=
y
> >> amdgpu_discovery_reg_base_init and walk through the headers of various
> >> ips using discovery binary.
> >> a. Which IP is available on soc or not.
> >> b. How many instances are there
> >> Also i again have to change back to major, minor and rev convention fo=
r
> >> this information to be useful. I am exploring it more if i find some
> >> other information i will update.
> >>
> >> adev->ip_block[] is derived from ip discovery only for each block whic=
h
> >> is there on the SOC, so we are not reading information which isnt
> >> applicable for the soc. We have name , type and version no of the IPs
> >> available on the soc. If you want i could add no of instances of each =
IP
> >> too if you think that's useful information here. Could you share what
> >> information is missing in this approach so i can include that.
> > I was hoping to get the actual IP versions for the IPs from IP
> > discovery rather than the versions from the ip_block array.  The
> > latter are common so you can end up with the same version used across
> > a wide variety of chips (e.g., all gfx10.x based chips use the same
> > gfx 10 IP code even if the actual IP version is different for most of
> > the chips).
> Got it. let me check how to get it could be done rightly.
> >
> >> For dumping the IP discovery binary, i dont understand how that
> >> information would be useful directly and needs to be decoded like we a=
re
> >> doing in discovery init. Please correct me if my understanding is wron=
g
> >> here.
> > It's probably not a high priority, I was just thinking it might be
> > useful to have in case there ended up being some problem related to
> > the IP discovery table on some boards.  E.g., we'd know that all
> > boards with a certain harvest config seem to align with a reported
> > problem.  Similar for vbios.  It's more for telemetry.  E.g., all the
> > boards reporting some problem have a particular powerplay config or
> > whatever.
> I got it.
> But two points of contention here in my understanding. The dump works
> only where there is reset and not sure if it could be used very early in
> development of not. Second point is that devcoredump is 4096
> bytes/4Kbyte of memory where we are dumping all the information. Not
> sure if that could be increased but it might not be enough if we are
> planning to dump all to it.

ah, ok.  Let's skip the IP versions in that case, we can use the
family and rev_id and external_rev_id to look up the IP versions.

Alex

>
> Another point is since we have sysfs/debugfs/info ioctl etc information
> available. We should sort out what really is helpful in debugging GPU
> hang and that's added in devcore.
>
> Regards
> Sunil
>
> >
> > Alex
> >
> >
> >>> Alex
> >>>
> >>>> +
> >>>>           if (coredump->ring) {
> >>>>                   drm_printf(&p, "\nRing timed out details\n");
> >>>>                   drm_printf(&p, "IP Type: %d Ring Name: %s\n",
> >>>> --
> >>>> 2.34.1
> >>>>

