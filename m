Return-Path: <linux-kernel+bounces-155612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815D8AF4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2011C227BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749213D8AC;
	Tue, 23 Apr 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B9HV1gg7"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1C208A9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891716; cv=none; b=NZ594u2CyhTVuvX/4S5ZHBIibJ9XM6OLivgzZyRPGAVq6mxCZs9ZmMdmBM/UpPDM/NVoiYXnOd/DPfexhgMl7vGahpaKxoe1JMSados2jktBr9RSsDBeM0Y+ryKVvV7mwW7BbYIKiQyeRzbEKGoMBCJVRZ+ZQldYDeDDXqAFIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891716; c=relaxed/simple;
	bh=/npKp6pnglhDyMQdA7wmpVX4vpQn8igvdQOoUdHXuFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sawZfP5xe63jhCxmU1sOxi5KwDGD6HwpLlF08PQsDw2pYxV63WJPzYgpcvyKxYFnl9rdSUpPlHYgqgVl8Qz1yRB7s3ooUT/WMU2tYmqymAlHY8ZoR9Z6zwhkKZz320T/4yRKUdRX5qapGCTtqOtvQInXUUG7DIKnNzKPivJqSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B9HV1gg7; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b10ead8f5so27623766d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713891712; x=1714496512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/npKp6pnglhDyMQdA7wmpVX4vpQn8igvdQOoUdHXuFA=;
        b=B9HV1gg7ZBt12p7ZBwTSHBPmWIGhczUH3JLwR7u6+yidjbNUcOLN00X0k3aTO3Wmtm
         hP15h3bLSlEMbGgx0P0qKzOmua80RDDTfAr+Y/z2H6pWVt75btVsFyo+o8GSrKI6DApv
         8Ejq8NysslKnQin1JtuVMcLVwFc+2X09qdbKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891712; x=1714496512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/npKp6pnglhDyMQdA7wmpVX4vpQn8igvdQOoUdHXuFA=;
        b=OHSrPxdU7mRRcXhAjOx2EtKtnWjVi56fp51hTUw8c7rsToNZmmRMPI6CMKJWDAi7TX
         j0Mrs4dohcQpvPB8nQ54UiSnUtCUyw/SNN4ATfPCy629hOzaha0Hdc2+M098dhH5moZm
         YtPeTlzMJMHnQEXiXdzzdGb0x4mtfMfloHa4uIkG3DO67r4BM15eKDcW4GmxZn9AnE5v
         rshaTXAqOLPQBrYlVr+FcWxEkjw7l7bz5sqDgdITnDvszINdGSHIYDAAneFemmeCwpCp
         dU5SVq4/4c80iIhWNah6M9P3x9w3U8HY+dtUK8unsd99nkw3Zv/nexq+GSHpLuxoFlj2
         qFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/WUg4QBgiCWT2l/Rsqjk5pzTMlJ0RUfFWcLnObDVjfXu0vpKuBvzqAE52hkfoynEojG920hScL3g6VCKnt+MHLtbKqGfm016MsHn3
X-Gm-Message-State: AOJu0YxJUEJUZm8rrOJmZ9oa4gU8LAl8moXzMzVExj+qlI7NadHSnBP1
	m/CG9myTvI6vf28o/8cRrSiqwOwgzidHzLi16TvxlbmY68fl07AQrWAjbjK+mludp4aG4nP6j0w
	dhft3
X-Google-Smtp-Source: AGHT+IEdLQsb/PHzYLW0MB70k5hFBq0M6rBAD+sfNtmJNatoFBjSvkLHclAKylFWcnI8A0q9xpTntw==
X-Received: by 2002:a0c:e152:0:b0:6a0:5baa:10f9 with SMTP id c18-20020a0ce152000000b006a05baa10f9mr13745155qvl.48.1713891712451;
        Tue, 23 Apr 2024 10:01:52 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id o2-20020a0c8c42000000b006a06f044a34sm3488500qvb.23.2024.04.23.10.01.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:01:52 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43989e6ca42so14411cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:01:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjykaLPFfP5Z0CqMveowGroe2cOPMuYQ1hoGj2A6ZXEEMfTQJuQ/ArH8B9g5St2X+GHB9dr7IQhWxuN5qte8nAyUuNvEDqq3GY8d4A
X-Received: by 2002:ac8:646:0:b0:437:b429:cb0d with SMTP id
 e6-20020ac80646000000b00437b429cb0dmr287375qth.29.1713891710780; Tue, 23 Apr
 2024 10:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
 <CAD=FV=WRLLuOkCJeM6RdAb6xLN-cPH+hfWbOv9-LujB-WMGEFw@mail.gmail.com> <CAGoogDB-mj8_xu04w3V2ZxOBTWoXcPKrVR1NRt6BFcpjHX3-7Q@mail.gmail.com>
In-Reply-To: <CAGoogDB-mj8_xu04w3V2ZxOBTWoXcPKrVR1NRt6BFcpjHX3-7Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Apr 2024 10:01:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WwsR9e-ZXJRY11FvdUZ66YPy9vqmY_=sGDw5Wqk1eV3w@mail.gmail.com>
Message-ID: <CAD=FV=WwsR9e-ZXJRY11FvdUZ66YPy9vqmY_=sGDw5Wqk1eV3w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel CSOT MNB601LS1-1
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 6:28=E2=80=AFPM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> Yes, I read the edid from the panels, one is CSO and the other is CSW.
> The details are as follows, please help check. Thank you!
>
>
> 1. MNC207QS1-1
> edid-decode (hex):
> 00 ff ff ff ff ff ff 00 0e 6f 00 12 e7 00 00 00
> 1e 21 01 04 a5 1b 12 78 03 8a d5 9c 5e 59 90 25
> 1b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ae 3f 80 18 71 b0 23 40 30 20
> 36 00 07 a4 10 00 00 1a 00 00 00 fd 00 28 3c 4b
> 4b 11 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 53 4f 54 20 54 39 0a 20 20 20 20 20 00 00 00 fe
> 00 4d 4e 43 32 30 37 51 53 31 2d 31 0a 20 00 32
> ----------------
> Block 0, Base EDID:
> EDID Structure Version & Revision: 1.4
> Vendor & Product Identification:
> Manufacturer: CSO
> Model: 4608
> Serial Number: 231
> Made in: week 30 of 2023
> Basic Display Parameters & Features:
> Digital display
> Bits per primary color channel: 8
> DisplayPort interface
> Maximum image size: 27 cm x 18 cm
> Gamma: 2.20
> Supported color formats: RGB 4:4:4
> First detailed timing includes the native pixel format and preferred refr=
esh rate
> Display is continuous frequency
> Color Characteristics:
> Red : 0.6113, 0.3671
> Green: 0.3496, 0.5644
> Blue : 0.1474, 0.1064
> White: 0.3134, 0.3291
> Established Timings I & II: none
> Standard Timings: none
> Detailed Timing Descriptors:
> DTD 1: 1920x1200 60.000 Hz 8:5 74.100 kHz 163.020 MHz (263 mm x 164 mm)
> Hfront 48 Hsync 32 Hback 200 Hpol P
> Vfront 3 Vsync 6 Vback 26 Vpol N
> Display Range Limits:
> Monitor ranges (Bare Limits): 40-60 Hz V, 75-75 kHz H, max dotclock 170 M=
Hz
> Alphanumeric Data String: 'CSOT T9'
> Alphanumeric Data String: 'MNC207QS1-1'
> Checksum: 0x32
>
> 2. MNB601LS1-1
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 0e 77 00 11 00 00 00 00
> 00 22 01 04 95 1a 0e 78 03 a1 35 9b 5e 58 91 25
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 00 00 00 fd 00 28 3c 30
> 30 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 53 4f 54 20 54 39 0a 20 20 20 20 20 00 00 00 fe
> 00 4d 4e 42 36 30 31 4c 53 31 2d 31 0a 20 00 37
> ----------------
> Block 0, Base EDID:
> EDID Structure Version & Revision: 1.4
> Vendor & Product Identification:
> Manufacturer: CSW
> Model: 4352
> Made in: 2024
> Basic Display Parameters & Features:
> Digital display
> Bits per primary color channel: 6
> DisplayPort interface
> Maximum image size: 26 cm x 14 cm
> Gamma: 2.20
> Supported color formats: RGB 4:4:4
> First detailed timing includes the native pixel format and preferred refr=
esh rate
> Display is continuous frequency
> Color Characteristics:
> Red : 0.6074, 0.3691
> Green: 0.3437, 0.5673
> Blue : 0.1445, 0.1123
> White: 0.3134, 0.3291
> Established Timings I & II: none
> Standard Timings: none
> Detailed Timing Descriptors:
> DTD 1: 1366x768 60.001 Hz 683:384 48.480 kHz 76.890 MHz (256 mm x 144 mm)
> Hfront 48 Hsync 32 Hback 140 Hpol P
> Vfront 3 Vsync 6 Vback 31 Vpol N
> Display Range Limits:
> Monitor ranges (Bare Limits): 40-60 Hz V, 48-48 kHz H, max dotclock 80 MH=
z
> Alphanumeric Data String: 'CSOT T9'
> Alphanumeric Data String: 'MNB601LS1-1'
> Checksum: 0x37

OK. This made me look a little deeper. I believe that the three-letter
code is managed by UEFI and I found:

https://uefi.org/PNP_ID_List

..as far as I can tell "CSW" is actually correct for CSOT but "CSO"
was _not_. Looks as if CSO was supposed to be for "California
Institute of Technology" (Caltech). :(

We're probably OK with the recent work that Hsin-Yi did in commit
bf201127c1b8 ("drm/panel-edp: Match edp_panels with panel identity")
to match against the panel name even if Caltech does ship a "CSO"
0x1200 in the future since it looks like the string you added matches
the panel.

That being said, is there any chance that it's not too late and you
can get CSOT to fix the EDID on "MNC207QS1-1"? Can you also make sure
that they're aware of this and don't make the same mistake in the
future?


In any case, given this investigation and the EDID I'm going to say
that the panel you've added here is fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I've pushed your change to drm-misc-next:

a6325ad47bc8 drm/panel-edp: Add panel CSOT MNB601LS1-1

-Doug

