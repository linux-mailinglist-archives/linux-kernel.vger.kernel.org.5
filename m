Return-Path: <linux-kernel+bounces-29934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8183155E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCE128254A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335381F939;
	Thu, 18 Jan 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjKqr4Wp"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108411F5FF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568572; cv=none; b=LEJ8pkTn+lJHyqEo6eCmeHKHqJHUeC4iULXMQWGhGBXZdL/QSpeC6uA5PC6mCKF8bWDuzLIpCRCy2RAU4LeAiA3oZyiOu2LDjGUDiaQpLaYbC9ObAdSdhSA5z5kx4Vf/AHfxfnw1aF98+5RiEvBayukveTQ7aVefXGf1t27zSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568572; c=relaxed/simple;
	bh=SCN0DITGtEyCZhxC49TDM4ZSpawE8A7q3RwTS/XCbr8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=kcuZ3bp7o0M9j8jHzCfzE7X5pzGYIfBiIwJLvbMK3quD+X6vQuaycfHKyrVwozuAEHpy53ewa9KCpcJpNeFM7+zNTFUHB4HJqkjjn5AIPdzOKLS7BESgeUGcdOp5LBYfQEPU3Mdn2GKhMkugRynRnztzEMeQpych3M7fOymDNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjKqr4Wp; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc21ad8266fso2616036276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705568570; x=1706173370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCN0DITGtEyCZhxC49TDM4ZSpawE8A7q3RwTS/XCbr8=;
        b=tjKqr4Wp3MTKqMI8HpTbDsdCOEqchltQaxJIHP3vQ8GkgvV7XarMFuuDjDma5xoJEn
         N+yFA/Ql8LpYoMORnuVavo9VBXWpy0W8dhYIhVhyLiA9dsvMmA5XHGJIWhXJ8lUa5WQa
         ghq0a25523UkDCPU2xCs+XrRh4dDC0BZz4BXL948yPp0+ASRnVMNHsI3BVNsvRGwVJGu
         UHscNNQix0L0JN2JdJP+F05fb0isQj2s5F13PKFUZCAFckvCIHKNHsesjZAS6oWuFVdc
         MEuQgi5jIJi+VlpXcsSoRYqopf/wEsrw7C7kHhYXPVYJAPbHuc+/lyvjaHno6WVeDmZd
         dKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705568570; x=1706173370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCN0DITGtEyCZhxC49TDM4ZSpawE8A7q3RwTS/XCbr8=;
        b=UNfbDm6NZ53wGvFib4M5Sdy6sYhQra1R6VuD9pxbGesoma3fT25rdVoSHOBMETDyDP
         kFdZ1IMR7HIuAFcLoN9v7sGTdHc6Y2edaFRG+U0DPZYokRYyg11eeXo1CqiCVbgMIBfF
         8C8zAvN8uTL0bYAH0YsB8UQC1oP3rDD1nIak2KI3GLRAi9VU2MMhX1pBT0NWoMDRo9XA
         HpuA0Z8fuvSv0c96V93RTw4bsGkCPMRbhrf1zmkYpo3aJmAUnGu8TUB7JMQCq0MXoWtX
         5WYnEXs7idBl/pqSnI2j4f4lcnr8FdI4f7UlzSwoxQebfccJAurBgEhrVyTlgu8Xi4Tm
         rDQw==
X-Gm-Message-State: AOJu0YzRWxElk84Ybupgjn9WugmtKV928apsXz4pJ0ViKcksxdNSOM3W
	WVEepYxXOOM+pW/Fl6urZ5OFM9yZNhXwwTObvZMfRBYFx3lVFUZNdZvcm9CghAwzwJgTVURJ1uM
	HNpnh9o3+GoXIPN6+o+v4Qf6BN7TXF8VZIP5cHA==
X-Google-Smtp-Source: AGHT+IFn0oNGpUtohUkixMpPda/cInzk0oTl2IZ0jSG7AXNDnpGJ5BZW+dJrWH4qJl2XVKHeIoh+tuR35SB/+3L7MMY=
X-Received: by 2002:a25:4842:0:b0:dc2:1e21:eeec with SMTP id
 v63-20020a254842000000b00dc21e21eeecmr322545yba.106.1705568569626; Thu, 18
 Jan 2024 01:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221021181016.14740-1-ansuelsmth@gmail.com> <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
 <63531543.050a0220.b6bf5.284d@mx.google.com> <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
 <6357240c.170a0220.999b2.23d6@mx.google.com> <CACRpkdb4iqazgVerHCPU0VqZKYoB5kJeDSaL+ek67L=2Txem-A@mail.gmail.com>
 <65a7d352.050a0220.ee5cf.f69f@mx.google.com> <65a85cf3.df0a0220.9615c.a798@mx.google.com>
In-Reply-To: <65a85cf3.df0a0220.9615c.a798@mx.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 Jan 2024 10:02:37 +0100
Message-ID: <CACRpkdYNhUxFMOGPx-yrgUji03w0K5fRmVFFWW0MfDH1ZeBnxQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-qcom: fix support for ipq806x
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, Arnd Bergmann <arnd@arndb.de>, 
	Ard Biesheuvel <ardb@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Nick Hawkins <nick.hawkins@hpe.com>, John Crispin <john@phrozen.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:04=E2=80=AFAM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:

> Some followup on this... I manage to enable DEBUG_LL and can have debug
> output from the decompressor...

Yeah that is helpful!

> From what I can see fdt_check_mem_start is not called at all...
>
> What I'm using with kernel config are:
> CONFIG_ARM_APPENDED_DTB=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> And a downstream patch that mangle all the atags and takes only the
> cmdline one.
>
> The load and entry point is:
> 0x42208000
>
> With the current setup I have this (I also added some debug log that
> print what is actually passed to do decompress
>
> DTB:0x42AED270 (0x00008BA7)
> Uncompressing Linux...
> 40208000
> 4220F10C done, booting the kernel.
>
> Where 40208000 is the value of output_start and 4220F10C is input_data.
>
> And I think this confirm that it's getting loaded in the wrong position
> actually in reserved memory... But how this is possible??? Hope can
> someone help me in this since I wasted the entire day with this and
> didn't manage to make any progress... aside from having fun with the
> head.S assembly code.

I have no idea how this happens, but when I boot images I do
it using fastboot like this:

fastboot --base 40200000 --cmdline "console=3DttyMSM0,115200,n8" boot zImag=
e

So I definitely hammer it to boot from 0x40200000 (+0x8000).

Yours,
Linus Walleij

