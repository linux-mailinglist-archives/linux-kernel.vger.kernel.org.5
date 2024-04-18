Return-Path: <linux-kernel+bounces-150076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0558A9A04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A261E2834CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2D376E5;
	Thu, 18 Apr 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b//GCEdt"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350F182C5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444150; cv=none; b=g9StIa7vdADrLIcC6BCqNGubhkxj53MwHMOCb/JiDalEsI1O2pGe0CnTd3uoyRw57PRhxtl9alrE04Eysja3Lw1owQZ4jVpgUcqCVXb6RgmWnUBdw3KvCSBrC+StwQ1nAydORfRBNBWhnNis+fOiZW3LDft72Ur43uzi5A/ORzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444150; c=relaxed/simple;
	bh=TOLSWmROPUctreAiWOV8/wngPNKZrmt55Hzl+HJ+AQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZgB1i0qKTxrqGqDMZX9/uZY/D/0SxGX/9Ig92p3DR94kEtq9vLmwccvdMkxsnROFg0obrDEaGihrer/flT7IN/8YWRmokgxB50f+bnLId+PmMbrHWJpFAQBxA5h4EVYGXeErwahqdmNnKR42nY/Tt2wLyBMWxaEEwwA0LUj9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b//GCEdt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so527729a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713444148; x=1714048948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjyiiPiAkv5rvokumWXZAPoXDnVjIrqrUez8UsmrlCg=;
        b=b//GCEdth/O0meg34TaNzG11RkEBapvcuH95Wd4nCazdb2b1kbpL5uTBsenkreRBeD
         7cHmShgINUdaBOOmnXJ5z9PpxdnuG4SiaLCAG/UYamplSIKwpQ1rGnEYbERfs4R06OZH
         EZzj3f7T4xzaqnGGFFwHbsoUVFlBemS4fq1lc0Huxf04IVRgDZvm/eWh5oWm06DXso9/
         oJFTxufu42eJiQFQHmXvhtE6UVt/v8ObK01SEwITkbaOed1wXhCcnR325IykIYckBKQR
         oI9Lw7fXQ1HEZYGFCjTrs7VTzVWCkxIpEGY1gDYMxjtweY2JM8aUQVo3pv168VJyz3Th
         AmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444148; x=1714048948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjyiiPiAkv5rvokumWXZAPoXDnVjIrqrUez8UsmrlCg=;
        b=WGbKldAV72wcyq2YfkcCD0hCDVb1/4MFXjn5lrP1LJVYKoKP7vmYSzx7brzy3d85qT
         NJmBrjN6vkElQXHb91GTIiOae7HUXb0yMhWmEAozOayx7zn5IAmKD1I3Ve/yMB45oEoI
         yzM4zSOU9Y6SFRLeiTPxpkF9yF5GfEkVpIDRUyhgMtp966rfJXNtmXMmi6yhm7EEvLX9
         uuiZleabaKU36Te/9HkVyU3b+xOZ6cQ+eX7OGUrqdu5OfXN2+wVSY2cuH2BEstykTksG
         GSiqlK/825u2JXrlTfUyqc+JQ+XjsfT1p4BlU8296lz0ssYIfErct//My2yEyl8EI0av
         OExw==
X-Forwarded-Encrypted: i=1; AJvYcCX9q1TA40TJTMA6qzG5uN0eGoquHODJtSfi83FpVeNhZQAxS6IMUFNGKOpHqtjZXJy2lInSx9ZWM9Cb6q8AixvuW+yz1eoa1W8g7Dy0
X-Gm-Message-State: AOJu0YzRHG0hDVxETiISuHCZh+LOZvZBRYCdzYp/15kKR9iGHiTBrA3L
	6X87SD7rirQMe2RvpsFZXuZoMReFBPLCk5C0ZGT5rMxXh1LiqNIYEzZw2z7+Y8lDWfJCccRXtaz
	nqGq5DTK9fYgEZrlD4+rUgQ9Lfa0mEcj/3Up1MA==
X-Google-Smtp-Source: AGHT+IGClan6tr/ZL8MpS3S+9edq0bfrX40+Ta50u8JXc/vWo4bwg6v1YQDugB6MdCv6t4uzZZbEPhLLGpZg0tpzxpw=
X-Received: by 2002:a05:6a20:9152:b0:1aa:5ca9:c565 with SMTP id
 x18-20020a056a20915200b001aa5ca9c565mr3213189pzc.8.1713444147965; Thu, 18 Apr
 2024 05:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=V2J=Tth2zhpo-kPo4uvESt70mFneO2V6TV-haac0VZuQ@mail.gmail.com> <CACRpkdYtM=5jdQddCqRFgBRXvcJEjk1ULJNKKFz7jhhkGxV59Q@mail.gmail.com>
In-Reply-To: <CACRpkdYtM=5jdQddCqRFgBRXvcJEjk1ULJNKKFz7jhhkGxV59Q@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Thu, 18 Apr 2024 20:42:16 +0800
Message-ID: <CAHwB_NLfaQWhFSbZ2ASmYgXJaVOTrjac3F0hyCJdwTTo-zHJrQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/panel: boe-tv101wum-nl6: Support for BOE
 nv110wum-l60 MIPI-DSI panel
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, sam@ravnborg.org, neil.armstrong@linaro.org, 
	daniel@ffwll.ch, airlied@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Linus Walleij <linus.walleij@linaro.org> =E4=BA=8E2024=E5=B9=B44=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 16:25=E5=86=99=E9=81=93=EF=BC=9A

>
> On Thu, Apr 11, 2024 at 9:40=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> > On Wed, Apr 10, 2024 at 12:15=E2=80=AFAM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in ni=
cely
> > > with the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new
> > > compatible with panel specific config.
> >
> > I guess we have the same question we've had with this driver in the
> > past: do we add more tables here, or do we break this out into a
> > separate driver like we ended up doing with "ili9882t". I guess the
> > question is: what is the display controller used with this panel and
> > is it the same (or nearly the same) display controller as other panels
> > in this driver or is it a completely different display controller.
> > Maybe you could provide this information in the commit message to help
> > reviewers understand.
>
> I think at a minimum we need to split out any identifiable display contro=
llers
> to their own drivers.
>
> Then what developers see is that the code sequence is very similar
> between two completely different display controllers so they have this
> urge to shoehorn several displays into the same driver for this
> reason.
>
> The latter is not good code reuse, what we need to do here is to split
> out a sequencing library, like if we had
> drivers/gpu/drm/panel/cmd-seqence-lib.c|.h with a bool Kconfig and
> some helpful symbols to do the same seqences in different drivers,
> so the same order can be obtained in different display controller
> drivers that would be great.
>
> I'm thinking something along the line of
>
> panel_seq_exit_sleep_mode(unsigned int delay_after_exit_sleep,
>     u8 *cmd_seq_after_exit_sleep,
>     unsigned int delay_after_cmd_seq,
>     unsigned int delay_after_set_display_on);
>
> That will call mipi_dsi_dcs_exit_sleep_mode(), delay, send
> command sequence, delay, call mipi_dsi_dcs_set_display_on()
> and delay where any delay can be 0.
>
> This achieves the same goal without messing up the whole place,
> but requires some tinkering with how to pass a sequence the right
> way etc.
>
> Are Google & partners interested in the job? ;)
>
> Yours,
> Linus Walleij

I learned from himax that even if the same controller is used with
different glasses, the corresponding parameters are not fixed.

For example: _INIT_DCS_CMD(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00),

even in the group initial code, the same register will be loaded with
parameters twice.

 example is the same=E2=80=9C0xB4=E2=80=9D , but the specific implementatio=
n functions
are also different.
_INIT_DCS_CMD(0xB4, 0x35, 0x35, 0x43, 0x43, 0x35, 0x35, 0x30, 0x7A,
0x30, 0x7A, 0x01, 0x9D),
 . .
 . .
_INIT_DCS_CMD(0xB4, 0x03, 0xFF, 0xF8),

So assuming that the registers of the two screens is the same now,
it cannot be set as a common parameter.
Otherwise, it may be a bit troublesome for the maintainers.

If necessary, I can break out starry_himax83102_j02, boe_nv110wum and
ivo_t109nw41
as separate driver. Then add some define to these registers.

#define HX83102_SETPOWER 0xb1
#define HX83102_SETDISP 0xb2
#define HX83102_SETCYC 0xb4
#define HX83102_SETEXTC 0xb9
#define HX83102_SETMIPI 0xba
#define HX83102_SETVDC 0xbc
#define HX83102_SETBANK 0xbd
#define HX83102_SETPTBA 0xbf
#define HX83102_SETSTBA 0xc0
#define HX83102_SETTCON 0xc7
#define HX83102_SETRAMDMY 0xc8
#define HX83102_SETPWM 0xc9
#define HX83102_SETCLOCK 0xcb
#define HX83102_SETPANEL 0xcc
#define HX83102_SETCASCADE 0xd0
#define HX83102_SETPCTRL 0xd1
#define HX83102_SETGIP0 0xd3
#define HX83102_SETGIP1 0xd5
#define HX83102_SETGIP3 0xd8
#define HX83102_SETTP1 0xe7
#define HX83102_SETSPCCMD 0xe9

Thanks=EF=BC=81

