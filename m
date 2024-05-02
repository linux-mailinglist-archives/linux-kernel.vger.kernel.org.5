Return-Path: <linux-kernel+bounces-166739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93B8B9EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D356D1F21362
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94E15E5A9;
	Thu,  2 May 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G7NblL1m"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043D155350
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668043; cv=none; b=i4Q8H6nR8J0DuZnNWdVCw+wYttpPFEZFEaPw/pQlf2Pi3fIDvQNUredrcqqrHLLKU/2zPKQgXibQbAIKv0d71Hg6m2mE+uWhXjO3exURYXmpwpw65VZLACuMpl5xAhVuRiwMve79xzRi70r3NK20TvdCv7+gyCpJR6p4QetT5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668043; c=relaxed/simple;
	bh=JJ6xElQROq30eGOr6yoVclASvNmxW6Cqvb72A7j2l2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze/cJ1VMlLWcLZd7Mv/cqea7XmGmvYb7XwUaMG5ENJFX5mROSrYZ0OrJ2VCJxAatag8YjRaW1zoAqdHKNsEvza15p58EgbL4LXhf8baYGekb0T1eh8zQEG+kySzxZ6D5NDm6IHkb0xowta/IJF406FaAHmjLn/7Ihx32wqU42n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G7NblL1m; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78ecd752a7cso565346185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714668036; x=1715272836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEnee6ah2poDn5i64PbPAXVhct8y7uUBex4L7IT1hm0=;
        b=G7NblL1muyRYenc2QU3Nd3UXZQBG8DvJt4TFmpc/A18AgQaekgXwLImYcQ/UsdHppx
         GnwFanceOOlDOMgPxh08mrzUYuiKmtX2VnMBt9YGfhOImsskFZVnS18slGJHbpDXPmrL
         VWrZS5HrPXomeLMnorywno/2nR+9+8c8qoIOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714668036; x=1715272836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEnee6ah2poDn5i64PbPAXVhct8y7uUBex4L7IT1hm0=;
        b=d8W2026jLfexlrSzTpDbzHCRZjNUje60us93Dv0Qisz/uLhEkweyTG0f7vK3riApHG
         U0u3lpjwiExDjMMmEdPXo6D66WEs1qQEOQ1CMQPiSO9bora/AZZwyyaGAfeLqwqsbFSr
         0SFRRf9nngKEVdiWnvBtsGorroAdV/ZzZS6Q9hKjPrdITD4iCM1Bh34PmL6LEwVL0thD
         cztp8JL1sJahho1Cqyc5BHkB2iXVWkqAb8CnmCZSCwJEJSZbBsdlVQMaquhYLQBcxG2t
         tnrHOpc3B0cHlY4hnlS+98NyhLBPe5mj1y9P1VBOtTOlL9ohYflixA7TzQVjkmwLHD9R
         op/g==
X-Forwarded-Encrypted: i=1; AJvYcCW2iGJPsmlAtzN18nQxQGYUD94avzEUtvhSUW2T9yoL0xb6DoXSQEkZHCAZuUpLLFs2J8uCy5nT4XQWimNnKGar3+9gQEZfywjKG9Kh
X-Gm-Message-State: AOJu0YzlXHbMjcgHlq/W/k5Qn+lUM/QffAGKhjuBG7psANau3norGKct
	sOu5F6iB/MouVETcXZZNnlDj7KgVs8CCsLkJbHXJIDNZNogBuI5f+cHFEZnSZ7H/rPe8HT4qZKU
	=
X-Google-Smtp-Source: AGHT+IHNMQA3pPiVfLRcNitJbKkUNO6SP0BZCQbwQP6iV8aiwmuNUaWw7zyIyv5qeK8tz154SlwMRg==
X-Received: by 2002:a05:620a:f93:b0:790:fbaa:55da with SMTP id b19-20020a05620a0f9300b00790fbaa55damr114505qkn.45.1714668035515;
        Thu, 02 May 2024 09:40:35 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b00790f74b3814sm490314qkb.82.2024.05.02.09.40.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 09:40:32 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-439b1c72676so831cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:40:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL9hjBMShx0NUKzHagWD/ItBtVA7JJZY9eLsFCjALxjIWfOCxzSUnqjQjg1KZRizUQq6TMlzOMUtzVNpacJXvJrKQZ/ElO2So48ruE
X-Received: by 2002:a05:622a:190d:b0:437:b631:b8fb with SMTP id
 d75a77b69052e-43caa5b67b6mr4063341cf.26.1714668032250; Thu, 02 May 2024
 09:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org>
 <20240501084109.v3.7.Ib5030ab5cd41b4e08b1958bd7e51571725723008@changeid> <CACRpkdYiND3uLAbFqyGEYgi5+ycOTYoncmSYGTsYtTZ7Ox=4DQ@mail.gmail.com>
In-Reply-To: <CACRpkdYiND3uLAbFqyGEYgi5+ycOTYoncmSYGTsYtTZ7Ox=4DQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 2 May 2024 09:40:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U59+au4Sfi5xdxmCAEaAVq7YguM2FjkyF+OYX16ydW4w@mail.gmail.com>
Message-ID: <CAD=FV=U59+au4Sfi5xdxmCAEaAVq7YguM2FjkyF+OYX16ydW4w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] drm/panel: boe-tv101wum-nl6: Don't use a table for
 initting panels
To: Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Joel Selvaraj <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 2, 2024 at 6:42=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Wed, May 1, 2024 at 5:43=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> > Consensus on the mailing lists is that panels shouldn't use a table of
> > init commands but should instead use init functions. With the recently
> > introduced mipi_dsi_dcs_write_seq_multi() this is not only clean/easy
> > but also saves space. Measuring before/after this change:
> >
> > $ scripts/bloat-o-meter \
> >   .../before/panel-boe-tv101wum-nl6.ko \
> >   .../after/panel-boe-tv101wum-nl6.ko
> > add/remove: 14/8 grow/shrink: 0/1 up/down: 27062/-31433 (-4371)
> > Function                                     old     new   delta
> > inx_hj110iz_init                               -    7040   +7040
> > boe_tv110c9m_init                              -    6440   +6440
> > boe_init                                       -    5916   +5916
> > starry_qfh032011_53g_init                      -    1944   +1944
> > starry_himax83102_j02_init                     -    1228   +1228
> > inx_hj110iz_init.d                             -    1040   +1040
> > boe_tv110c9m_init.d                            -     982    +982
> > auo_b101uan08_3_init                           -     944    +944
> > boe_init.d                                     -     580    +580
> > starry_himax83102_j02_init.d                   -     512    +512
> > starry_qfh032011_53g_init.d                    -     180    +180
> > auo_kd101n80_45na_init                         -     172    +172
> > auo_b101uan08_3_init.d                         -      82     +82
> > auo_kd101n80_45na_init.d                       -       2      +2
> > auo_kd101n80_45na_init_cmd                   144       -    -144
> > boe_panel_prepare                            592     440    -152
> > auo_b101uan08_3_init_cmd                    1056       -   -1056
> > starry_himax83102_j02_init_cmd              1392       -   -1392
> > starry_qfh032011_53g_init_cmd               2256       -   -2256
> > .compoundliteral                            3393       -   -3393
> > boe_init_cmd                                7008       -   -7008
> > boe_tv110c9m_init_cmd                       7656       -   -7656
> > inx_hj110iz_init_cmd                        8376       -   -8376
> > Total: Before=3D37297, After=3D32926, chg -11.72%
> >
> > Let's do the conversion.
> >
> > Since we're touching all the tables, let's also convert hex numbers to
> > lower case as per kernel conventions.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Wow that's a *VERY* nice patch.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!


> The metrics surprisingly reports more compact object code,
> I wasn't expecting this, but it's nice.

I think it has to do with the design of the table structure in this
driver. Each "struct panel_init_cmd" was 24-bytes big. That means that
to represent one 1-byte sequence we needed 24 bytes + 1 bytes cmd + 1
byte seq =3D 26 bytes. Lots of overhead for 2 bytes of content. The old
table stuff could certainly have been made _a lot_ less overhead, but
since it wasn't then it also wasn't hard to be better than it with it
via the new style.

FWIW, it also wouldn't be terribly hard to save a tiny bit more space
with the new style if we wanted. It gets a little ugly, but it doesn't
affect callers of the macro. Specifically, if you assume people aren't
going to pass more than 256-byte sequences, you could stuff the length
in the data:

 #define mipi_dsi_dcs_write_seq_multi(ctx, cmd, seq...)                  \
-       do {                                                            \
-               static const u8 d[] =3D { cmd, seq };                     \
-               mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
+       do { \
+               static const u8 d[] =3D { \
+                       (sizeof((u8[]){seq})/sizeof(u8)) + 1, cmd, seq }; \
+               mipi_dsi_dcs_write_buffer_multi(ctx, d); \
        } while (0)


..and then snag the length out of the first byte of the data in
mipi_dsi_dcs_write_buffer_multi(). If you do this, you actually get
another 10% space savings on this driver. :-P

add/remove: 0/0 grow/shrink: 7/7 up/down: 1140/-4560 (-3420)
Function                                     old     new   delta
inx_hj110iz_init.d                          1040    1385    +345
boe_tv110c9m_init.d                          982    1297    +315
boe_init.d                                   580     870    +290
starry_qfh032011_53g_init.d                  180     271     +91
starry_himax83102_j02_init.d                 512     568     +56
auo_b101uan08_3_init.d                        82     123     +41
auo_kd101n80_45na_init.d                       2       4      +2
auo_kd101n80_45na_init                       172     164      -8
auo_b101uan08_3_init                         944     780    -164
starry_himax83102_j02_init                  1228    1004    -224
starry_qfh032011_53g_init                   1944    1580    -364
boe_init                                    5916    4756   -1160
boe_tv110c9m_init                           6440    5180   -1260
inx_hj110iz_init                            7040    5660   -1380
Total: Before=3D32906, After=3D29486, chg -10.39%

I feel like people would balk at that, though...

-Doug

