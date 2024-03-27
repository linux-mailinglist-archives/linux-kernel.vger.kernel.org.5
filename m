Return-Path: <linux-kernel+bounces-121811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A088EE02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC2628A283
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296C415216F;
	Wed, 27 Mar 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSSGaKwe"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A21914E2F4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563197; cv=none; b=CvHW1rxXw0FqQoS64ChtUJdi+yzfAaNl34vm61kVTFhVdTqPIPyuo8pkJaq5vpWXMR3SdEHZ3LVJm9np3bo2ddZy3av+4Chk1JXwgmLzMUYv4C4VUOZHfb68AdB4w1eQN1Hc7y8rm1NukadGQkXltef8BKzZUS1zkP6kD37j7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563197; c=relaxed/simple;
	bh=wyryXguB8266lLWCkFJS/84WDCfywSXsHKF549oL7yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+l5llOM9fCNB52mhTvIMBtros9ouiREw97JyXfVos8/7FJARefS8XwN/t1BQIStLdfceJuebj6gV8CNINcJK19hOFV9pZj0p9OHFyJup2vFolaigA4az3/PT14g2ik5PP0ukaYUshaqqUBO2HsatEbKnuOV8HO47W5Y3k6ho9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSSGaKwe; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso117355a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563195; x=1712167995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Apmp+5NG0ozOI/JWe7g3FmXSoAcJcuTi09oKHmC84=;
        b=JSSGaKweBG1L3L9Qgcjl3ewrFGPfrEtmGdzmqX6vggN5D8fOpgcVs/egVmHVI8GH4s
         JqsO9BtEuo0pbXXgX+WDq1dvS+D/69FpY5kQpLyth97GmGQDssZD3hYu/dCzhUqI3atX
         V8o8+Y7cd3BjN60tAm0iFnP3voj2+JHCWKX7ZGEUjaWbspGTgUtuTCYL75dhSoEFtE60
         NvPcFeIsUzwdQ9ks6JRBNo0soiquH2YGZLzy2f+/BUCVsN0bAGekCvu+9rcXt5GL+S9c
         +S5U6j8joSkrhAdOLlXIAhSdTrWOjYux6f42xcpqP/JiSFFPpG0kKidvlURU2iGbwztm
         5JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563195; x=1712167995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+Apmp+5NG0ozOI/JWe7g3FmXSoAcJcuTi09oKHmC84=;
        b=NEBNmj61nsj+Zdsb/NtWuFIB8saE8v5a2T4oxD5HmBUD4r/87xpkvt9FlGtA3cBo8O
         8FuqDvbbl5a8Hen3W3Ot5/roPh9VmMnyrOXDn5FNRTCw0E7jakURB0dAGE5A9vNjJ4qy
         nAnYKl33tn2CPi404iypm86VHfGLBdoZRdI2rZiUUbgA1q4hu+OsaJtGuPHF2i9GHXBz
         3a/641ImurQ0CYk3XLRAig8JYHN3qr5Gco5Uw1OqLL2FBD9wOdvVgB+KfzIsHX/17c51
         i1uvxSduknh2NVTT0AuaHUrerhb35lPceOjsl3Y4JVsIc5uOgib4owrE2e6P4TVagfKn
         DF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOmzZTPegyqzEPgjUKEn4Tm7Wi47lDigq1nnP84dZnJwSTk+DmsOrbgTMfdkzDdAFeqDXigTFhtk4HjVQknOGf5bF3VDnGYl4rBF3Q
X-Gm-Message-State: AOJu0YxHAOMENKPSSVDgSPkTY010v8ku4+YINyAB5Z+WGF5pXuFNmhsv
	10OPTZ6Hn5di+frKMMH4lJkbqgNUvynORkXt744tbdEivIFjDcW7eHpZ9Uz46YM4hQHjmzAB1Bm
	p9M2IT2XkqWLNZhwXeVLcxyeHS2s=
X-Google-Smtp-Source: AGHT+IHLikdTRV0YFY05LU+4dKjjaqnZE0r4ZhQYCDgh/j+5MZTT1jmReESMvyU/J8EN3USD/LkkQwkRCTSMfu5GTf8=
X-Received: by 2002:a17:90b:3702:b0:29d:dfae:4fac with SMTP id
 mg2-20020a17090b370200b0029ddfae4facmr514671pjb.23.1711563195269; Wed, 27 Mar
 2024 11:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>
 <20240327-magnetic-nonchalant-hare-bbe8d2@houat> <CANiq72kqqQfUxLkHJYqeBAhpc6YcX7bfR96gmmbF=j8hEOykqw@mail.gmail.com>
In-Reply-To: <CANiq72kqqQfUxLkHJYqeBAhpc6YcX7bfR96gmmbF=j8hEOykqw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Mar 2024 19:12:47 +0100
Message-ID: <CANiq72=hguVfscJQSCAYS2FfL1VpUVvX_Chd4X8gAX4Twq-TLQ@mail.gmail.com>
Subject: Re: drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
 but not used
To: Maxime Ripard <mripard@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:43=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Will do -- I found another one when running the CI with the above one fix=
ed:
>
>     drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable
> 'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]
>
> I will send you one for that too then.

Done: https://lore.kernel.org/lkml/20240327175556.233126-1-ojeda@kernel.org=
/

Cheers,
Miguel

