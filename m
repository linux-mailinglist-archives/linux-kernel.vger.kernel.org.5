Return-Path: <linux-kernel+bounces-94120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B4873A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CFB2359E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24613BAC2;
	Wed,  6 Mar 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LbLQvkPy"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38A13A89A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737555; cv=none; b=nPjLFQBjacWOuc++Wh2A6ECxcmZRrJoIb+GdhTsApClNEmmXufDnjQwLZaLQZxeqNjsG4pwbouY1F4n895W68RDKL7LKa7xFZXBxa2Quh++zBjiq1MsAXfviPOQwz2qrNackGfRFNciM1nDBWfUM9CFCApe7nsfEDESj2jtqVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737555; c=relaxed/simple;
	bh=TEL7jZMgML85VNjr4PtxvsHiPMSN5+DPoz2ZgxK9Hjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKiX4GO8gNfV9WB9iX+yfuBVnvOn1Q4NrfKBdZMKgSNwBH+t58Hd1YWapBjLxjrWWyGLKFXpTVlChlqeodaz7G3wCw1PEHhOaYOVNTdwoOLA5b/PEfKOJZI8X0kZd58VmG4HwtZ8Ll918YgjOJndcIfygwCOFvNe/L/2+B3yZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LbLQvkPy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7884114feb8so17961585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709737550; x=1710342350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEL7jZMgML85VNjr4PtxvsHiPMSN5+DPoz2ZgxK9Hjw=;
        b=LbLQvkPyi+hFbR1vjou4iqpI/CgNN8PolM61A129B3fxHlHAKB0X6EinGjD/vIu8Th
         kbi2VSJs4XXlKPOTw4buObevCW2+IiPo9ZaTmhbxuwG84oK+qgaufSRf7JXOHZJhBd/7
         WMOnanwEE0YFvOnPkxmLdq/eWDTKhIsryKSQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737550; x=1710342350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEL7jZMgML85VNjr4PtxvsHiPMSN5+DPoz2ZgxK9Hjw=;
        b=hN1Bn0TbJsL4YkbJp+b7Cc21MefO6QQbMywFueYMNvwEDyumsyJ/yqrXrChsvVg/KO
         eQUVKFzDYP4PNX/8stgdMhl9n0oUgtTRUz8IPTFH4/ZIKNijDXqd83t0mj7fHnBRdzBa
         MI8YUnmuya/P9BL3/GNKW/VlTElCGNZajA/ujjrsUif6xCH2GmDEPYYSdmt4LxlYBmS7
         YJI7+0+do1TRsKo13OetU93h9udceulCJfas7Iiy1YhzL+rkg9NCIFrteOu3Nc83qbK9
         TwthYSrt+jC0RIIyLp6OeHSBeZEHAETeV3EAOHKcxvz+0YhjiY69PF/rjHtf6wKcH42I
         Sekg==
X-Forwarded-Encrypted: i=1; AJvYcCWp9PcFLw9wW6ETms2ueIhb2ODUNbPM42N560+TBUrnqkDFbpP0/p9dw+k/tXaiI830GhKruFCUtQxBX6y5Cik2u9nebVlg6Gs5jEER
X-Gm-Message-State: AOJu0YxlrptWoGCTwmYTSv0siQuybJdTDi3FFS9Ev98rcZjOyKatx0Wq
	gbgaU5r6FzETqA4fObKyzvSokXwMQ0p4BHSW0/nRVc4LUnA3ybqtCIXRwzMeKo57QQ0VK1gyOAy
	SX6h/
X-Google-Smtp-Source: AGHT+IF28ZLimK95FrjKT8id/I+22cQFQ21mA7sHe71y4Z0ONQFXV15uxDeSsFs4IWbFxUDWiZuy6w==
X-Received: by 2002:a05:620a:47a8:b0:788:2b0e:a78e with SMTP id dt40-20020a05620a47a800b007882b0ea78emr5341641qkb.74.1709737549607;
        Wed, 06 Mar 2024 07:05:49 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id vv24-20020a05620a563800b0078821ab6668sm4019621qkn.34.2024.03.06.07.05.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:05:49 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42ee0c326e8so267711cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:05:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjh82sCCXeKJgrsDSXx2zYOvL53Xlfy9SLJW28HOj3g6E29+n9q95yyTy/ynmIMbwbr9OUqZNCNYN3ZtxAowp5QQDCJctQVfvi/gre
X-Received: by 2002:a05:622a:118e:b0:42f:a3c:2d46 with SMTP id
 m14-20020a05622a118e00b0042f0a3c2d46mr275703qtk.7.1709737547815; Wed, 06 Mar
 2024 07:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
 <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de>
In-Reply-To: <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 07:05:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VSFEFPzFhvMKwc7D3NBgnDq9qRp6eN1stSuhBCi_HoMQ@mail.gmail.com>
Message-ID: <CAD=FV=VSFEFPzFhvMKwc7D3NBgnDq9qRp6eN1stSuhBCi_HoMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/udl: Add ARGB8888 as a format
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Sean Paul <sean@poorly.run>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 6, 2024 at 4:07=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Hi,
>
> sorry that I did not see the patch before.
>
> Am 27.02.24 um 23:19 schrieb Douglas Anderson:
> > Even though the UDL driver converts to RGB565 internally (see
> > pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> > compatibility. Let's add ARGB8888 to that list.
>
> We had a heated discussion about the emulation of color formats. It was
> decided that XRGB8888 is the only format to support; and that's only
> because legacy userspace sometimes expects it. Adding other formats to
> the list should not be done easily.

Sorry! I wasn't aware of the previous discussion and nobody had
brought it up till now. As discussed on #dri-devel IRC, I've posted a
revert:

https://lore.kernel.org/r/20240306063721.1.I4a32475190334e1fa4eef4700ecd278=
7a43c94b5@changeid


> > This makes UDL devices work on ChromeOS again after commit
> > c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> > commit things were "working" because we'd silently treat the ARGB8888
> > that ChromeOS wanted as XRGB8888.
>
> This problem has been caused by userspace. Why can it not be fixed there?

I guess the one argument I could make is that the kernel isn't
supposed to break userspace. Before the extra format validation patch,
AKA commit c91acda3a380 ("drm/gem: Check for valid formats"),
userspace worked. Now it doesn't.

That being said, one can certainly argue that userspace was working in
the past simply due to relying on a bug. ...and in such a case fixing
the bug in userspace is preferred.

I don't personally know _how_ to fix userspace but it feels like it
should be possible.


> And udl is just one driver. Any other driver without ARGB8888, such as
> simpledrm or ofdrm, would be affected. Do these work?

It's the ChromeOS compositor. I can totally believe that those drivers
don't work. In this case, though, those drivers aren't needed by a USB
peripheral that someone might plug in. ;-)


-Doug

