Return-Path: <linux-kernel+bounces-155545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B48AF3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329791C23914
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F000D13CF90;
	Tue, 23 Apr 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ba/owpT7"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46DB13BACF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889192; cv=none; b=e3GC+tSuRSVhTE0fliFVUm8DK7W3hDN10kPuJ+0zTx6N12vP+kCNDvu9i3M1LFN4pqLzQaFmzSZTFUUkCB47uZeYwLxQW41JKOTdgMNRnw1bKdhW7OPHBPPtkdVuqua11TQYe8AGGsKYuSdUlLp/564LgkcX8nFkvSNG+kH7sGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889192; c=relaxed/simple;
	bh=vhXQuuHSSaOFXavGSQ9j+yaEKLO4j2yIeOyHVT2JTtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUbsAcQi1YqOmYG4mrpgFg3UPEtx8M2a8MbuxHNra7OC4I+mdYmB2CHhkP70HFH3cFVZHiXoBgHOtr15TQmczwXTxrwOMwk52YhqvvHzxurNMP2y4PHNYb2CcN9P0JR/BIrOlMumLv1IjACZdUlXsputw8MC+/YAyYu17Fir1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ba/owpT7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78ef9ce897bso392611785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713889186; x=1714493986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wanqofR/Nuk2X7+WPgVh3aZdwvGB0rIxPhS4chd4Kfw=;
        b=Ba/owpT7Dt8JcjbqE1GtMl9projVGwtkJOXZ8lrHY6yCwQyE1c56k6erhXeBBvANQ3
         W1m6GnqIYHpiPDuG7P0w5hnQZh90duch3MCsPIBlQv4UuyB1aHEbDoTVAgu4g3to6b4t
         xl+ixs2+HPThuhtsNHxINVBlfIng5DfANFzCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889186; x=1714493986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wanqofR/Nuk2X7+WPgVh3aZdwvGB0rIxPhS4chd4Kfw=;
        b=D1N7tMFr2R4vTBePzadd4TurQ4r5KhnksAU3SLGuv2exrFiwmPc38lU0elMc88cBUg
         VlKL8zI5bZArODPxQ42hCir19rXZYsvnrwsdNGe3EBCrBYMusTMEIMVvAtjlAIWp15B5
         0M1HfxF07zeibgVAZgaFiSglKKMK5GVd8a482Z4/QE6suEgsopmlVng5Pm704dU8++zp
         k+kNt/JHeQHk3AYRLg5csnNc+g+GRULtWutbEz1744KWUbQYGbMahKxuhilC3/hCih/N
         L6FpjtYoCFVbq1G1zPjtYav12LO05GYqiH1D8QTG1FilvlB0hyb7beFg9BJqEwYVhsV7
         3cvg==
X-Forwarded-Encrypted: i=1; AJvYcCVGO4uCIQVrTsiJdA4pwyeSLOZoIvLlMpBwTA+JmRJodiGno0IxzzLfE2k2SevFiNF+GbfANpCiUUvbldmPBXYK/AGpZwkEWKpD60od
X-Gm-Message-State: AOJu0YxODZBSxAChDNBpr3UErnyOAClSvpS0kKtWWctgipqi1eqYcn/3
	KuDdCCtGRzC/pWY5SY4El1c/DEzRXxQyrFOmTRLFiiUrKiWrCf/1AiuogRAmwSuUNTyUnGy5ba5
	KSGqW
X-Google-Smtp-Source: AGHT+IGPFz7VAIrCc3pyEBY4Kb3rGuG5tYlFsBGWIGnOgNW4AjS/3fqKyMVr773erYba9hiHuD/ksQ==
X-Received: by 2002:a05:620a:12ee:b0:78e:d214:59c4 with SMTP id f14-20020a05620a12ee00b0078ed21459c4mr15309021qkl.0.1713889186372;
        Tue, 23 Apr 2024 09:19:46 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a084a00b0078a04882ac2sm5332618qku.53.2024.04.23.09.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:19:45 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-439b1c72676so522701cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:19:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUs2hcsmLOCIvJw+o8jQvLiMY2fFddRWZlv3rJIa9f0PfrKSbS8rI4nxY/EtCsp84aSfZxOtKKNgWv9da6nSBeR0u4FaT2tY9YV0I6h
X-Received: by 2002:ac8:4053:0:b0:437:9875:9671 with SMTP id
 j19-20020ac84053000000b0043798759671mr278456qtl.0.1713889184337; Tue, 23 Apr
 2024 09:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=V2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKouB2mDB+NZug@mail.gmail.com> <CAHwB_NJsDsTc=gjP8TJ+6ipo10uMYFLmuf+tKGVgxnznhuAcUQ@mail.gmail.com>
In-Reply-To: <CAHwB_NJsDsTc=gjP8TJ+6ipo10uMYFLmuf+tKGVgxnznhuAcUQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Apr 2024 09:19:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGDbNvAMjzWSOvxybGikQcvW9JsRtbxHVg8_97YPEQCA@mail.gmail.com>
Message-ID: <CAD=FV=UGDbNvAMjzWSOvxybGikQcvW9JsRtbxHVg8_97YPEQCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 2:37=E2=80=AFAM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> > > +static int starry_init_cmd(struct hx83102 *ctx)
> > > +{
> > > +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> > > +
> > > +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x21=
, 0x55, 0x00);
> > > +
> > > +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2C, 0xB5, 0xB=
5, 0x31, 0xF1, 0x31, 0xD7, 0x2F,
> > > +                                                 0x36, 0x36, 0x36, 0=
x36, 0x1A, 0x8B, 0x11, 0x65, 0x00, 0x88, 0xFA, 0xFF,
> > > +                                                 0xFF, 0x8F, 0xFF, 0=
x08, 0x74, 0x33);
> >
> > I know this is a sticking point between Linus W. and me, but I'm
> > really not a fan of all the hardcoded function calls since it bloats
> > the code so much. I think we need to stick with something more table
> > based at least for the majority of the commands. If I understand
> > correctly, Linus was OK w/ something table based as long as it was in
> > common code [1]. I think he also wanted the "delay" out of the table,
> > but since those always seem to be at the beginning or the end it seems
> > like we could still have the majority of the code as table based. Do
> > you want to make an attempt at that? If not I can try to find some
> > time to write up a patch in the next week or so.
>
> Do you mean not add "delay" in the table?  However, the delay
> required by each panel may be different. How should this be handled?

In the case of the "himax-hx83102" driver, it looks as if all the
delays are at the beginning or end of the init sequence. That means
you could just make those extra parameters that are set per-panel and
you're back to having a simple sequence without delays.

If you had panels that needed delays in a more complicated way, you
could keep the per-panel functions but just make the bulk of the
function calls apply a sequence. For instance:

static int my_panel_init_cmd(...)
{
  ret =3D mipi_dsi_dcs_write_cmd_seq(dsi, my_panel_init_cmd_seq);
  if (ret)
    return ret;
  mdelay(100);
  ret =3D mipi_dsi_dcs_write(dsi, ...);
  if (ret)
    return ret;
  mdelay(50);
  ret =3D mipi_dsi_dcs_write_cmd_seq(dsi, ...);
  if (ret)
    return ret;
}

The vast majority of the work is still table driven so it doesn't
bloat the code, but you don't have the "delay" in the command sequence
since Linus didn't like it. I think something like the above would
make Linus happy and I'd be OK w/ it as well. Ideally you should still
make your command sequence as easy to understand as possible, kind of
like how we did with _INIT_SWITCH_PAGE_CMD() in
"panel-ilitek-ili9882t.c"

As part of this, you'd have to add a patch to create
mipi_dsi_dcs_write_cmd_seq(), but hopefully that shouldn't be too
complicated?


> It would be great if you could help provide a patch. Thank you so much.

Sure, I can, though maybe you want to give it a shot with the above descrip=
tion?

-Doug

