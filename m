Return-Path: <linux-kernel+bounces-30480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B80831F32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA501F22FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD982E3F0;
	Thu, 18 Jan 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoS9gzWd"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F152C1A0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603311; cv=none; b=uiYeBD9NArmbemdYgWE4xUgHshye9PzlvtrHTWU3CKLtZfqY3rZkSPSsD5tLLlZ++YXIdoPnn998zQyUWOIFI1qlSkNB0wxX1fF70LIxYaaK/gAQ7UTSFcF0x6bCUXyloPlA4tHw+jUbqoTAg8zsimLzlchY2P+bQYjob7LsDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603311; c=relaxed/simple;
	bh=4OmQ1oubWOd7o519mJLdBFWYdcFLo4S+glxiLbr+tC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeykAfnhRTEKPtJdsa6eU6VYYGmYEhgWchntC4EoelALrhTGkfDAbQfbeyvT5MAwGkBtGSJ9NnP2WwArfPLBfeklDZn+zuhupYZIJU0Rl5GDy7OVv/99qvpsuhNcpAZdmpMgzNuLECS/VYfcGJ976ExpUNiZWYCY64PLiCLy2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoS9gzWd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3376555b756so8096f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705603306; x=1706208106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLpIkESB6PMuUI7s5uphN+gLKVT0TGYaYNk8rmcP/OU=;
        b=PoS9gzWd5PyzGkMDQnylWS07w736YnWl1GlffC9RHfbE40j9gTMO5xnZNY1sMzbw/T
         D+lbeapK+Pv/ugSNhXg0fJnmoxFg1AqHS+yiAya3o+aSM77vC2N0CciI45XZbTPFPWEo
         rMOc8HsVds2JEZx5SgGrCCv3vOa12VUjUJ4FirMX4rC8MAH4xMDqbA4G/qYderuQ+Fss
         ESYKGbgFIE+Alfn5Q26fSnPsrUOIB6AsFaFF928iwNv6ZP2nJabHHdMHpMLuOSyQGgN0
         0T0LkDk/69LnZ/lp24+aJObZni8Dly2N4J371z4yf9/QdPDHdff86OJQDicdV3w9HzZ+
         UT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603306; x=1706208106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLpIkESB6PMuUI7s5uphN+gLKVT0TGYaYNk8rmcP/OU=;
        b=l19ESiOijZp9D8505Qyz91cnyzJO+CC56UbbcmoTPBWfwKWuQs9yopgcNpH6PDd/Fp
         nEeNa94OPu4X3PcbIBVwNcva1mPHgkYBDMBxClbKnEYNmsjNZgboDY6EvrkGo047MLzA
         R7+OzGE9a7glTy4fWSDQs5yJAbZAVT/yNAvy7UqSPCSEAecE2YbztVAOs4YA5FoWQkLV
         pkDyWHBm04UpHhP8EezM4R3qJOZNx9GM5oJl5EqeoCxqbojEV+iRL4nauZVrRfSIE7ip
         Y+Z67rKdIu2OSxA934ooKLEjFz6ASl6KXBRnZ8+/YHjjm0+5aQ2AiD9d08nKRJJ9NO0B
         301g==
X-Gm-Message-State: AOJu0Yx+BZlcfhclimphC3gaA2ZXgpK/wM16JglkXuU0rJfR+Z++JegM
	9idn7ra1KgXelfI7Pq0nVcQ4c2WKdLp/Tv+ixK5VQ1scx0VEyRDnsvvbr1ySw2mAekCSMYuI6VP
	hEvvRnESSjbHSWC7w6kIQmJOgM0FIlACUR2gr
X-Google-Smtp-Source: AGHT+IGlfWOYCfBCaK1FjP2auhOpOqOg1vlBxYGWVIUNJkOMvIjFU8G8VwFJqM33pUZUiMhl2NsLXI2vNzgoPezzRKc=
X-Received: by 2002:a5d:53cd:0:b0:337:d346:bf4 with SMTP id
 a13-20020a5d53cd000000b00337d3460bf4mr580103wrw.5.1705603306339; Thu, 18 Jan
 2024 10:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAL3-=88exVfuL1Y-kvPNbsU+d-UTfDLFViWVObFLtbC4xueeA@mail.gmail.com>
 <20240118183546.418064-1-appsforartists@google.com>
In-Reply-To: <20240118183546.418064-1-appsforartists@google.com>
From: Brenton Simpson <appsforartists@google.com>
Date: Thu, 18 Jan 2024 10:41:31 -0800
Message-ID: <CAAL3-=-RCJvc0=3Ren+zJ8jBPSwO9RKqfzXYrTKXK_2TJy0BcA@mail.gmail.com>
Subject: Re: [PATCH] Input: xpad - add Lenovo Legion Go controllers
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Cameron Gutman <aicommander@gmail.com>, Erica Taylor <rickytaylor26@gmail.com>, 
	Ismael Ferreras Morezuelas <swyterzone@gmail.com>, Jonathan Frederick <doublej472@gmail.com>, 
	Matthias Benkmann <matthias.benkmann@gmail.com>, Matthias Berndt <matthias_berndt@gmx.de>, nate@yocom.org, 
	Sam Lantinga <slouken@libsdl.org>, Vicki Pfau <vi@endrift.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A bunch of internal wrangling and one holiday codefreeze later, my git
alias has finally been enabled for send-email.

Sorry for the hassle, and thanks for your help.

On Thu, Jan 18, 2024 at 10:35=E2=80=AFAM Brenton Simpson
<appsforartists@google.com> wrote:
>
> The Lenovo Legion Go is a handheld gaming system, similar to a Steam Deck=
.
> It has a gamepad (including rear paddles), 3 gyroscopes, a trackpad,
> volume buttons, a power button, and 2 LED ring lights.
>
> The Legion Go firmware presents these controls as a USB hub with various
> devices attached.  In its default state, the gamepad is presented as an
> Xbox controller connected to this hub.  (By holding a combination of
> buttons, it can be changed to use the older DirectInput API.)
>
> This patch teaches the existing Xbox controller module `xpad` to bind to
> the controller in the Legion Go, which enables support for the:
>
> - directional pad,
> - analog sticks (including clicks),
> - X, Y, A, B,
> - start and select (or menu and capture),
> - shoulder buttons, and
> - rumble.
>
> The trackpad, touchscreen, volume controls, and power button are already
> supported via existing kernel modules.  Two of the face buttons, the
> gyroscopes, rear paddles, and LEDs are not.
>
> After this patch lands, the Legion Go will be mostly functional in Linux,
> out-of-the-box.  The various components of the USB hub can be synthesized
> into a single logical controller (including the additional buttons) in
> userspace with [Handheld Daemon](https://github.com/hhd-dev/hhd), which
> makes the Go fully functional.
>
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> ---
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.=
c
> index f5c21565bb3c..ecfcea8740a0 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -127,6 +127,7 @@ static const struct xpad_device {
>         u8 mapping;
>         u8 xtype;
>  } xpad_device[] =3D {
> +       { 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYP=
E_XBOX360 },
>         { 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 =
},
>         { 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
>         { 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
> @@ -459,6 +460,7 @@ static const signed short xpad_btn_paddles[] =3D {
>
>  static const struct usb_device_id xpad_table[] =3D {
>         { USB_INTERFACE_INFO('X', 'B', 0) },    /* Xbox USB-IF not-approv=
ed class */
> +       XPAD_XBOX360_VENDOR(0x17ef),            /* Lenovo */
>         XPAD_XBOX360_VENDOR(0x0079),            /* GPD Win 2 controller *=
/
>         XPAD_XBOX360_VENDOR(0x03eb),            /* Wooting Keyboards (Leg=
acy) */
>         XPAD_XBOXONE_VENDOR(0x03f0),            /* HP HyperX Xbox One con=
trollers */
> --
> 2.43.0.275.g3460e3d667-goog
>

