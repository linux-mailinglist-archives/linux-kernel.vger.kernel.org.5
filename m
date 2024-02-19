Return-Path: <linux-kernel+bounces-70714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F8859B70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D3CB21CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2471CD23;
	Mon, 19 Feb 2024 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K1fRXEr1"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99855257D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317954; cv=none; b=XJJOpkngBT1wCGCnradHDMXrb3axc6w0ydQG+VcIOJnDWGR5e+kRb/TPGHb6Uqhfxy2h5kY0Oh1AFym5pewEkmQJTadOmaNSH4nctLGVw7TbA1xe40zibZ4MlUFTqPcPJzY+V9bq8sjFuFftpNCfNIuK4z/7LNLOfW4rpTAIR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317954; c=relaxed/simple;
	bh=AG6oUJLp4G2BsZYn1jZDFdciqjT6A0PJ0BJXgDCWjAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F16OdgTPuxK6E5c/kUjSyZkTVtF40tK10Hc38siNs0sNpddysjM1XJkuyBK1WGR91xfijMjNOx1a8MQqPSBrlk/qG+gN+AEy66FL0Zd+tod/hUBe76iu06+uG78T3h47LVVO9dRQaQhLWoCFBq2EIzcypfQO16rC1w9tH0pKuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K1fRXEr1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41265d2f7acso3868875e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 20:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708317951; x=1708922751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7y1laujVjSrryFs6iJ5GCZwVB/NRNVw3uguZLpIQqk=;
        b=K1fRXEr1BygoMtQ0LnKVRwvSxIwEqG2noyPgCxHawOi/i5n4zqcQncX4MfimdGOH8r
         RKGLt8DJf4xRWFpFZ/OXSgjU9HKeR9FnRD/kAoO+JHcExISIFORWBnFiOUef+t0GrurL
         8DDiGwceJzKQatNODZLGRvVPbU/AV7oEmkEjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708317951; x=1708922751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7y1laujVjSrryFs6iJ5GCZwVB/NRNVw3uguZLpIQqk=;
        b=Ssi99qdI3zj4J70qiT6/eAXOTw+RDBOt4OAEeAeifZEN7lgiCWOcE6IZu03DVu1KwT
         aHi8eR9iLqbu27KnvOxsOGf5crT7mL5TTyqXkOsCOFtmXavXFv82UQFY7jzQMcJa+m89
         GsrwAVGPPr8Ql/b66C3HPmMC3+TweuCVW5nT+TE0979dQ8rzlZIyp1heHunR7j1gK8AT
         5Si3tfqGdyvvcXPd+4Mj0xgY5FMrFEjfmMqtCiy7HDT8kTseqGe/JwkuXNdx+oBA89F/
         p21tIY3EvJ9yHiewMR0yKi4HgNm91043tMOui2CBGwGuhJyM9FaSUjn2BwCYHdh0JiuF
         HOUw==
X-Forwarded-Encrypted: i=1; AJvYcCUS06XcMKBg2U14I0WYaDmpgtl/ugZENK1iDntbsehJGcZp1wzayPdypnjx0VY0f2FnkybBkZ7SemZe/X6Qng0TG0ljzgAO4fVqiLN8
X-Gm-Message-State: AOJu0YxjW8Y8/xYX+bLjS+6y2AUdDxs/pciQYA9Ypg9xmBvJDu/6zuVw
	FW76zB5swmrim4lIFIzgNvL5rhxoBQhjS15UDJr4P2goAq34nH6vdlXZ7KwfXX0bMAVn7li1oC4
	LQRGdGaCXy7v+EWl1kRV5m3OBPJ+hVhDAft3h
X-Google-Smtp-Source: AGHT+IFmD5ws3SRz0ys/c7GsQE1n5zbIG2sA9x5gW1fhOmHKqofyiRm9MM4uDUDgT3IR0dKVANwZ1jVmYBAj6ebfv64=
X-Received: by 2002:a05:600c:2218:b0:410:ac80:bf3e with SMTP id
 z24-20020a05600c221800b00410ac80bf3emr10578913wml.37.1708317950949; Sun, 18
 Feb 2024 20:45:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
 <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com>
 <87sf1u58k0.fsf@intel.com> <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
 <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org> <CAD=FV=UtakQZ6OEKwERW5gNeAfS88EqkuQAHkrQoN=SicDG1JA@mail.gmail.com>
In-Reply-To: <CAD=FV=UtakQZ6OEKwERW5gNeAfS88EqkuQAHkrQoN=SicDG1JA@mail.gmail.com>
From: Eizan Miyamoto <eizan@chromium.org>
Date: Mon, 19 Feb 2024 15:45:39 +1100
Message-ID: <CAAi1THx9TKwr9fESxf2bWzsp2bcJmR+HAATFbJ=gBK1E2XG7jg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, Javier Martinez Canillas <javierm@redhat.com>, 
	Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hiya,

On Fri, Feb 16, 2024 at 4:09=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
[...snip...]
> Sounds good. I know Eizan (CCed, but also a ChromeOS person) was going
> to poke at it a bit and seemed willing to provide a Tested-by. I'll
> let him chime in.

Yup, I've tested this like so:

1. I started by slightly modifying a recent chromeos-5.15 kernel checked
   out to _right before_ the patch we are discussing to emit some
   tracing info to dmesg at entry/exit of auxdev_read_iter(). I
   installed it on a "tentacool" Corsola device.
2. I then rebooted the device and ran these commands:

   # dmesg -w &
   # while /bin/true; do echo -n "dpms: "; cat
/sys/devices/platform/soc/14000000.syscon/mediatek-drm.7.auto/drm/card0/car=
d0-eDP-1/dpms;
dd if=3D/dev/drm_dp_aux1  count=3D1 of=3D/dev/null; sleep 30; done

And after a few minutes, I saw the following output:

dpms: On
[  435.603257] auxdev_open by pid 6327 inode num 108 dev 256901121
[  435.603369] start auxdev_read_iter by pid 6327
1+0 records in
1+0 records out
[  435.756547] finish auxdev_read_iter by pid 6327 status 512
[  435.756632] auxdev_release by pid 6327 inode num 108 dev 256901121
512 bytes copied, 0.153862 s, 3.3 kB/s
[  455.418637] [drm] mtk_crtc_ddp_hw_fini 459 event 0x0000000000000000
0xffffff80c0277080 0xffffff80c0277080
dpms: Off
[  465.775104] auxdev_open by pid 6399 inode num 108 dev 256901121
[  465.775218] start auxdev_read_iter by pid 6399
dd: error reading '/dev/drm_dp_aux1': Connection timed out
0+0 records in
0+0 records out
0 bytes copied, 16.6631 s, 0.0 kB/s
[  482.437762] finish auxdev_read_iter by pid 6399 status -110
[  482.438200] auxdev_release by pid 6399 inode num 108 dev 256901121

(OK, so what to look for in the above is the ETIMEDOUT returned by
auxdev_read_iter after about 17s when dpms was turned off.)

I then checked out the repo to the patch we are discussing and did the
same thing, and after a few minutes, I saw:

dpms: On
[  441.892692] auxdev_open by pid 6317 inode num 108 dev 256901121
[  441.892786] start auxdev_read_iter by pid 6317
1+0 records in
1+0 records out
512 bytes copied, 0.148004 s, 3.5 kB/s
[  442.040597] finish auxdev_read_iter by pid 6317 status 512
[  442.040652] auxdev_release by pid 6317 inode num 108 dev 256901121
[  455.395549] [drm] mtk_crtc_ddp_hw_fini 459 event 0x0000000000000000
0xffffff80c3993080 0xffffff80c3993080
dpms: Off
dd: error reading '/dev/drm_dp_aux1': Device or resource busy
0+0 records in
0+0 records out
0 bytes copied, 0.000241 s, 0.0 kB/s
[  472.055296] auxdev_open by pid 6439 inode num 108 dev 256901121
[  472.055388] start auxdev_read_iter by pid 6439
[  472.055421] finish auxdev_read_iter by pid 6439 status -16
[  472.055571] auxdev_release by pid 6439 inode num 108 dev 256901121

Tested-by: Eizan Miyamoto <eizan@chromium.org>

