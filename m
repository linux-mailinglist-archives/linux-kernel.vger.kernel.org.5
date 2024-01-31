Return-Path: <linux-kernel+bounces-45507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CF18431A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD0A1F24488
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09BA36C;
	Wed, 31 Jan 2024 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RiF9AoCO"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284815C8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659336; cv=none; b=T9fZ0hJ7b0yhdgdD/fb+VSAnyylq882A4gcOFisell6nGLQ+M0N2p3veGkO8928Cg6iqBG+J9EArk/mQDxCmpiziseGJhUhg28sYkBRVZPb56WmXrdQsdUWHcBH5/RkCD911/EtKxDmf/1mC6ZOwUvV7K6PuLNkL9m4iwH4qaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659336; c=relaxed/simple;
	bh=ELB3rB3pTBAyVWgkgbBLwzuWJhChYKsQ8NutVLQX82k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIDzbPMClBG0AlUZd6WU4Uv4OMthVcEntUY3hkD8r3D3BEUCjIwry/szDSa3Z8hNjUlMsNBGbsMb0THEbOOJYUG3q4PCUZ/9rspcIPlSi32zAqyPMWOPKRA4uyNdtYFLXsSMsYPMJQtGEU27oJlK4L99OCMTSv7UmkKhqPMjZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RiF9AoCO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d057003864so19494681fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706659332; x=1707264132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ6gV8n3Hy2+6G1uDais5tZDUXuFFy3xqXRf85finO4=;
        b=RiF9AoCO9PbxvF7mIJO+OGM1hwIp4Aqn7tyovcmre0kdR9frryqz2gy1mfV9DF67t7
         wGGlX4RrI0EBu+hg8h1mZ1Mc/+sBukKcGA93xU1oQskflpRxqCnlL7CAkONIbMjy2Jxc
         qEcw1PJEO2PzhG0Hlo8gD+9daYtpbRhewwQbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706659332; x=1707264132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ6gV8n3Hy2+6G1uDais5tZDUXuFFy3xqXRf85finO4=;
        b=UmdrxZLphz6Ksz8N6TMs2Ao37r67ofh1oNc7/krMeSor/UNFzwFGE7U6g5oiX46aIx
         oFgEp8rKqL1gFcFGYJA/HAdlPsv6i3VdXAiTPDRULkHAOug4pCg0FTp7eLnc6S2TmtLW
         u4hnYf1gV1NjTL8kJ2ZJ4IDv35vXG6EKJSszZBe0+SZyYGVxHx2SDERseOnA70vxT1rQ
         sUOJTHlXLxwsxQRoY6oZYjmU9EbK4FcVZod3/DyCk3W1d5rsIvJEog/uhmHAyzjSq5CO
         HQwZXRVQqx1TBl7Z1XcUs6Hwj3hlKyK3PYsfntArnX5EmIdOWf0yvn0754S9AisL6QYT
         ruow==
X-Gm-Message-State: AOJu0Yx6/GjP4fa3ODOJOgvKqwNy4hm10xf3gHh2kdHa2wIr2SCPl7eM
	jzAOXQW25kdS4Olvfgn8WAEAQHtvOrOfQH5nLERQRXLMRG6n10nNxH7zxGm0UdlDCoeGJH0loRE
	=
X-Google-Smtp-Source: AGHT+IGaElmBRJl0UQ26lbB/R/sqE6O3Zf+xGSPmwYMUz6efRjxWkX1UM33uEeIec+t6YGiUxGnloQ==
X-Received: by 2002:a05:651c:3dc:b0:2cf:334d:b327 with SMTP id f28-20020a05651c03dc00b002cf334db327mr27123ljp.1.1706659332447;
        Tue, 30 Jan 2024 16:02:12 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id bm10-20020a0564020b0a00b0055f411d6014sm1098673edb.42.2024.01.30.16.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 16:02:12 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3392b12dd21so3134905f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:02:12 -0800 (PST)
X-Received: by 2002:a5d:680e:0:b0:33a:e828:c3e6 with SMTP id
 w14-20020a5d680e000000b0033ae828c3e6mr15698wru.30.1706659331581; Tue, 30 Jan
 2024 16:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com> <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
 <ZbA4VthTMPT7BSRo@google.com> <2024013059-poison-equation-81d1@gregkh>
In-Reply-To: <2024013059-poison-equation-81d1@gregkh>
From: Brian Norris <briannorris@chromium.org>
Date: Tue, 30 Jan 2024 16:01:57 -0800
X-Gmail-Original-Message-ID: <CA+ASDXM-m6U+JFvBSSHMxAf8Ct-T-pL8tmcHxHQjepdRFR-s1w@mail.gmail.com>
Message-ID: <CA+ASDXM-m6U+JFvBSSHMxAf8Ct-T-pL8tmcHxHQjepdRFR-s1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot modules
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, chrome-platform@lists.linux.dev, 
	Abhijit Gangurde <abhijit.gangurde@amd.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Nipun Gupta <nipun.gupta@amd.com>, 
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, Umang Jain <umang.jain@ideasonboard.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:51=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jan 23, 2024 at 02:06:14PM -0800, Brian Norris wrote:
> > "Don't you want to have a driver data or so associated with this?"
..
> But why limit yourself to 32bits now?  Why not make it 64?  It is going
> to be sent to userspace, so you have to be very careful about it.

Is that question related to the question I pasted/replied to, about
driver data? Or a new topic? Sorry if I'm misunderstanding.

Anyway, for the size of the tag field: I don't have a strong opinion.
But FWIW, they're coming from this project:

https://review.coreboot.org/plugins/gitiles/coreboot/+/269b23280f928510bcad=
d23182294e5b9dad11ec/payloads/libpayload/include/coreboot_tables.h#36

As you can see there, we're extremely far from exhausting 16 bits, let alon=
e 32.

Brian

