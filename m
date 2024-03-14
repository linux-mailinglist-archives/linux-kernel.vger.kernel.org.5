Return-Path: <linux-kernel+bounces-103421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5E87BF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8B12828E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC78270CBB;
	Thu, 14 Mar 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeLGiayu"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D65D756
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427341; cv=none; b=sJMTmdGJUNgsMrOW0VE3ZQvkqMYEHm8pTqYJ3q4jzPC/JWKtDpfTbeYcALa2w6liL75mBRgumfejmGHQR/Q6eVb2v4PTkqIhBjB4KrtcJNklk9++Hs5F+FSW+4lCX9Ww24caDo3+hMupuklEW4bAlZCn2mSvG6sV20PYz121q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427341; c=relaxed/simple;
	bh=PZgguATQJxMG3xWOh3Fg79pBfvVKAazktmQ4UUvzWHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkuvIF7A8Du+XFCPcCPOZnwYPyqo7/5Q1mkzr0gAI0ZVTifK2LULawbbp0GMRs4LeSQi8q8GBnbNjhmIWGwbqyl9ZOn1FzOAZfDzXbcN3j23niUf98YVaSY7/QmPpyNR98lsCPGA/3PKsBKc9B73Bvwe7lD3Fn2faqGxM8Y8+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeLGiayu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29de2dd22d8so215324a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710427339; x=1711032139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za5iucYxSXOJJRA/mt5b8AE1A6QwDe4Iqg1yMlydUGA=;
        b=PeLGiayuYhJ5mTmDeXt6JwOafT7y8ezPl7JGvFJv9N4VsEP3OtKLP9lnXn6aTHW73f
         2XQLBKZ/HN+8AkVeef8Ikt1IMPXFiZTHlXEEnrA3xfROeq1hHcM8AxzNlpQ0PmLb+zRB
         b+9uHx7N+vlYwGdCVRg+87zQ5mPFoQrkdDR4KAvmXrVIAyPKA4WKmFfMStYZLwEgw8xI
         KvEEY4BueTo909/vdbc1vsMTq7D4LcfRXszgN8a8Mhh3T3TMVX0ypWMtYEgN+snvZ/9K
         ZaJdieuzyztlvrAAmEqqerujPVHZY4X5Y5SyxwHETtbe12HWZz6t9MiBnrjMJPXf5WTC
         SM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427339; x=1711032139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za5iucYxSXOJJRA/mt5b8AE1A6QwDe4Iqg1yMlydUGA=;
        b=kCcl8Oxmu562od9EYtf1QT49/eE+UNYyV30DLQcz2Uw4Rk6ix9pDOjs8rk1umpqfDV
         2tueu0mm6yaXYF5kDXgK/RqNmEc/8lN1Bs7rjWX8G6LhOn9hZnuDtJNWjnP1IQdPaeCN
         5qoEk69kkqLEAS3TnoVuGs8RDrXLqq13vqYLz+yL6CTbvfvB3YUcsfZdNKHvGLdOeqhn
         7aY9G9Z29sdyOx3Dl5Osc5u4pWEFFmPw1119NRqRL9OAnDlP8bEZb1EyIp0x9XWO2pe0
         m6pZBCmZG9YrwwvoqRdZbHSlevm4fZYuOF+hgLe56YVIpSMWLb9WIVDNei688H98mJAp
         91Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWGsSSnOyJgE1byr/bBCShueaGLqRPoovxczzTmnFO+nKHDhpDbHAZxTmnLRw6euKMySNvwDsaIwoxVjIBwxnwRVAK+sQcHhOjIuzaI
X-Gm-Message-State: AOJu0YzslUKfOI4a0+zwgqHAlqIVjD0Al0Ml2xeUcJTWsQmmiTeAHXh8
	4D1/Dvua+2IDBhFjsh+2bUHabj3eoROiAJKxXOXdXKUYW7Wt/g+v+rG3AITevn2QR6RmkjVeEY3
	VFSsTUuyAlKBN8rJ3tdXuZzRjYlU=
X-Google-Smtp-Source: AGHT+IFDsGELtULQd8kAZwzF1azSs4E+MUi/jEgN69Py3hQjMsHBAvIku8XVK6gdRADILX2kdAyXmSUegd5Y0q2kbMw=
X-Received: by 2002:a17:90b:30c6:b0:299:1777:134c with SMTP id
 hi6-20020a17090b30c600b002991777134cmr1752577pjb.33.1710427338838; Thu, 14
 Mar 2024 07:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312124148.257067-1-sunil.khatri@amd.com> <CADnq5_O-cyDkNLznZpvnZtz15Mi1_rkigirG80BmYJprP_udnw@mail.gmail.com>
 <59cf081e-5924-42b5-a3f1-de8b012f09d1@amd.com>
In-Reply-To: <59cf081e-5924-42b5-a3f1-de8b012f09d1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Mar 2024 10:42:06 -0400
Message-ID: <CADnq5_N0H75UU2aFTAkqUrdGxKPxBQUnodsH-bcpS-ZUqgUb3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add the IP information of the soc
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:44=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 3/14/2024 1:58 AM, Alex Deucher wrote:
> > On Tue, Mar 12, 2024 at 8:41=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.=
com> wrote:
> >> Add all the IP's information on a SOC to the
> >> devcoredump.
> >>
> >> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 19 +++++++++++++++++++
> >>   1 file changed, 19 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_reset.c
> >> index a0dbccad2f53..611fdb90a1fc 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >> @@ -196,6 +196,25 @@ amdgpu_devcoredump_read(char *buffer, loff_t offs=
et, size_t count,
> >>                             coredump->reset_task_info.process_name,
> >>                             coredump->reset_task_info.pid);
> >>
> >> +       /* GPU IP's information of the SOC */
> >> +       if (coredump->adev) {
> >> +               drm_printf(&p, "\nIP Information\n");
> >> +               drm_printf(&p, "SOC Family: %d\n", coredump->adev->fam=
ily);
> >> +               drm_printf(&p, "SOC Revision id: %d\n", coredump->adev=
->rev_id);
> >> +
> >> +               for (int i =3D 0; i < coredump->adev->num_ip_blocks; i=
++) {
> >> +                       struct amdgpu_ip_block *ip =3D
> >> +                               &coredump->adev->ip_blocks[i];
> >> +                       drm_printf(&p, "IP type: %d IP name: %s\n",
> >> +                                  ip->version->type,
> >> +                                  ip->version->funcs->name);
> >> +                       drm_printf(&p, "IP version: (%d,%d,%d)\n\n",
> >> +                                  ip->version->major,
> >> +                                  ip->version->minor,
> >> +                                  ip->version->rev);
> >> +               }
> >> +       }
> > I think the IP discovery table would be more useful.  Either walk the
> > adev->ip_versions structure, or just include the IP discovery binary.
>
> I did explore the adev->ip_versions and if i just go through the array
> it doesn't give any useful information directly.
> There are no ways to find directly from adev->ip_versions below things
> until i also reparse the discovery binary again like done the discovery
> amdgpu_discovery_reg_base_init and walk through the headers of various
> ips using discovery binary.
> a. Which IP is available on soc or not.
> b. How many instances are there
> Also i again have to change back to major, minor and rev convention for
> this information to be useful. I am exploring it more if i find some
> other information i will update.
>
> adev->ip_block[] is derived from ip discovery only for each block which
> is there on the SOC, so we are not reading information which isnt
> applicable for the soc. We have name , type and version no of the IPs
> available on the soc. If you want i could add no of instances of each IP
> too if you think that's useful information here. Could you share what
> information is missing in this approach so i can include that.

I was hoping to get the actual IP versions for the IPs from IP
discovery rather than the versions from the ip_block array.  The
latter are common so you can end up with the same version used across
a wide variety of chips (e.g., all gfx10.x based chips use the same
gfx 10 IP code even if the actual IP version is different for most of
the chips).

>
> For dumping the IP discovery binary, i dont understand how that
> information would be useful directly and needs to be decoded like we are
> doing in discovery init. Please correct me if my understanding is wrong
> here.

It's probably not a high priority, I was just thinking it might be
useful to have in case there ended up being some problem related to
the IP discovery table on some boards.  E.g., we'd know that all
boards with a certain harvest config seem to align with a reported
problem.  Similar for vbios.  It's more for telemetry.  E.g., all the
boards reporting some problem have a particular powerplay config or
whatever.

Alex


> > Alex
> >
> >> +
> >>          if (coredump->ring) {
> >>                  drm_printf(&p, "\nRing timed out details\n");
> >>                  drm_printf(&p, "IP Type: %d Ring Name: %s\n",
> >> --
> >> 2.34.1
> >>

