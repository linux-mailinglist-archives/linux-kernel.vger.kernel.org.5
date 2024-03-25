Return-Path: <linux-kernel+bounces-116743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8504188A33B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AAF1F3D0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A715884E;
	Mon, 25 Mar 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="KegD/lyp"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9316FF45;
	Mon, 25 Mar 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358608; cv=none; b=MWlRt1jvXKVH/6nKGuOftnBnbCWBQbCXA1NXwYsvfEoWPL48J+hMnBKojHtI1RsotTufvB8zNbWlrjsTOWdVQ3I14KHurgYLBzvAphksOsFk5BrbWQ9nVIVSPnQajxThkIRFQaR5sdy+wwDEoqSlkdO7S3U0u3LRE+PIHS1QKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358608; c=relaxed/simple;
	bh=3Q6d0awRn/5rq006A03kM9rdEFFKW+5OGEOZySjvGew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3GWI9rqSc5LyKxEiH2/KCaHjP5vONO0c+Rx8tbyhYJGqy1kjX2hmxxsBb1wLXBNubeRHYhuldHrwRathqBHa07EogwpLvd/TOuKNE8hP3anvk59XyMDJDWaU9sxmUBJA69mJTTkhvtXk2jifnFzpm3G3uIl6LwvaxIaZ9GG6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=KegD/lyp; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id E08916346550;
	Mon, 25 Mar 2024 10:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1711358593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q6d0awRn/5rq006A03kM9rdEFFKW+5OGEOZySjvGew=;
	b=KegD/lypESKOUC6MOy/GT2VvR+37bLyTc9DaYUrEaaCcK48IDKshxaJOT0mATs72VNXZlM
	JzxsCKduDWYQKRUB2bdvmLlkGbXp7tuUsYgkvQ+/pEm/aefjD52ItZD6VaeLxSx/qTIbI+
	1xiCGsPG61sIfBKLUGVJ0kMCvZHKSb0=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH v10 3/6] media: uvcvideo: Quirk for invalid dev_sof in Logitech
 C922
Date: Mon, 25 Mar 2024 10:23:00 +0100
Message-ID: <12403186.O9o76ZdvQC@natalenko.name>
In-Reply-To:
 <CANiDSCsnOdTaW0Eg68+-niPXwPhYc3Br6cWoGiHytZrFOGmcZA@mail.gmail.com>
References:
 <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <2722561.mvXUDI8C0e@natalenko.name>
 <CANiDSCsnOdTaW0Eg68+-niPXwPhYc3Br6cWoGiHytZrFOGmcZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5764187.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5764187.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 10:23:00 +0100
Message-ID: <12403186.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 25. b=C5=99ezna 2024 8:52:57, CET Ricardo Ribalda wrot=
e:
> Hi Oleksandr
>=20
> On Sat, 23 Mar 2024 at 13:16, Oleksandr Natalenko
> <oleksandr@natalenko.name> wrote:
>=20
> >
> > How do I check whether C920 (046d:082d) is affected too? I have got one=
, I can run tests on it as long as those will not blow the webcam up.
> >
> > Thanks.
> >
>=20
> First of all you need to enable the hwtimestamps in the driver. You
> could do that with
>=20
> ```
> rmmod uvcvideo; modprobe uvcvideo hwtimestamps=3D1
> ```

```
$ cat /sys/module/uvcvideo/parameters/hwtimestamps
1
```

> Then capture some frames with yavta
> ```
> yavta -c /dev/video0
> ```
>=20
> After around 5 seconds all the frames should have a stable fps, the
> fps is not stable then your camera is affected with this bug.

```
$ ./yavta -c /dev/video1
Device /dev/video1 opened.
Device `HD Pro Webcam C920' on `usb-0000:0f:00.3-3.4' (driver 'uvcvideo') s=
upports video, capture, without mplanes.
Video format: MJPEG (47504a4d) 1920x1080 (stride 0) field none buffer size =
4147200
=E2=80=A6
100 (4) [-] none 100 200717 B 212.919114 213.079004 33.727 fps ts mono/SoE
101 (5) [-] none 101 200889 B 213.003703 213.114996 11.822 fps ts mono/SoE
102 (6) [-] none 102 200926 B 213.035571 213.146999 31.379 fps ts mono/SoE
103 (7) [-] none 103 200839 B 213.067424 213.179003 31.394 fps ts mono/SoE
104 (0) [-] none 104 200692 B 213.293180 213.214991 4.430 fps ts mono/SoE
105 (1) [-] none 105 200937 B 213.322374 213.247001 34.254 fps ts mono/SoE
106 (2) [-] none 106 201013 B 213.352228 213.279005 33.496 fps ts mono/SoE
=E2=80=A6
168 (0) [-] none 168 200914 B 215.183707 215.347066 33.676 fps ts mono/SoE
169 (1) [-] none 169 201141 B 215.271693 215.379066 11.365 fps ts mono/SoE
170 (2) [-] none 170 201005 B 215.303449 215.415057 31.490 fps ts mono/SoE
171 (3) [-] none 171 201195 B 215.335295 215.447062 31.401 fps ts mono/SoE
172 (4) [-] none 172 200933 B 215.557731 215.479072 4.496 fps ts mono/SoE
173 (5) [-] none 173 200973 B 215.587033 215.515063 34.127 fps ts mono/SoE
174 (6) [-] none 174 200698 B 215.616811 215.547063 33.582 fps ts mono/SoE
175 (7) [-] none 175 201290 B 215.646196 215.579075 34.031 fps ts mono/SoE
176 (0) [-] none 176 200807 B 215.675857 215.615073 33.714 fps ts mono/SoE
=E2=80=A6
```

Does the above mean the webcam is affected?

Thank you.

>=20
>=20
> Thanks!
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5764187.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYBQnQACgkQil/iNcg8
M0tJ5hAA2/2MfH760f37fFEr2GY0ERSMacRe6SX/GADkgvTF2Z7N2/s5EBWQBdSZ
wRC/7uZfFpuEjj7rPqRVZczxEhZRYhL/w5aiBPw7pRGTZwhP4bX4Ue+cnTBLo5JQ
i8Hdodc8CfNHb9YInvW1JcICHMr0FRZ4VzJTcowsFsIUwLL0nr0CZcOPRMRmfttr
Z4TSoeNb9pcLbRo7qiD5IPVr1Hy1+yuFLRe9O+V72vX3TJkxlYozj8Arl83SBaGL
CsNYb/unCiIQXhWitLt+6/i0RVdR+brn9Qxevc7qdglMD9dUe37SftWQJwedZeZ1
MA/D3K44VQ0lvTzdzMUbeDkU+GlKfqvK2KQ+7BeDy0oPbfJIO4DcmL3bEYvuYJrv
EypIZv8vOtCGJ3xaDXUCi2ZOtpAaiSYrmpM6KvLjVASZNRAhBL6QULwamGTv+DHT
OBfR7ROIimImbW8aNdyggsKjb72M18Z4I55Ps4wM3ElQ0YSxMkJIKuHEbTu1bMRh
sR7QOpPThabvzgw6hhyoD+FlstYswZwmLGAqz+Z5VlaWxBUbJHTtquZixScpBoAs
x9AQ/Gwvt4Ejwi6gK/5FMkjHWG3XojOQG73BClRA8jhkk14rlw1+ZUWJqIERSkDu
NIYZxi/hiYWf04o/JQuNA6wcNMJUjL6ecWy6VYUIdCS+5Djh+o8=
=4YOZ
-----END PGP SIGNATURE-----

--nextPart5764187.DvuYhMxLoT--




