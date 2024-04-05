Return-Path: <linux-kernel+bounces-133063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A73D899E44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7021C22EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E516D4F4;
	Fri,  5 Apr 2024 13:25:51 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913416D4C7;
	Fri,  5 Apr 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323550; cv=none; b=ENeMzW+oDPoUcrD58f/RxCmTmWH1A0lXCTyNPTLMJGDgIxBblrFYn9Ah9nIskdojbsKawD/lTZiK/zufOCashZqsErTjWEdp7MLE78aAS5bN7miPEhxM6xxvSWdh79uFQjNjtVenmlLYYvU8LkH0HP+4hiaSOtd6UfIFFlJ6eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323550; c=relaxed/simple;
	bh=293GVfFo/UrwVaxem8QbPurukB9UNXuXn3FEZwFnetc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzSeFEmdukYHgvBZDeVqwiSorWUh6PbVJh4QOBW3xkgs7FeFki/ApODMuzcTAN0PUDkM+euqYdFo9QO0gyM7tISdZdHukNZJWMhJvIj+/qeYGS7jySx44IOo0J5kJeLBZ8fQ0aBRIWB3Y1iukBN09Hn1+znoAV4OAoRGOjd6bdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6152be7c58bso22956547b3.0;
        Fri, 05 Apr 2024 06:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712323545; x=1712928345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwsDRonjbPICxZMNgS8aH3ZFFLUCLJm1C0DAdV/AdRA=;
        b=dEdzG/HbTj5MIZ0OthXT/2hJdX7v6TS18qvJ7wKhzZ8aTF0PR27/IvqOGCUE2s2SbZ
         OpTAlXHFu6KuAR5tXowyI/qvLq80lN2Sf79E3aeMUWWNfC5l4vlzcJK+5fzrSkgACIvA
         1Ij+28z01oNVFKY2goBIGaradLVbvvYt7wm343OuiMWB/GJziyD2U7irar59v/vsAev8
         amfE5Giu2gjZKKuIxFKC/Z6chGCtpDxv+FbMHENCpgrFs6eJrtiuAmrHnilgNlGATNx/
         wEQdl8PvNbnsoe+8gBA7Sm/O0YkHf8GJIYy8PySOIckG2vDeVaai4lDxCugZS4wdeyAg
         oPpA==
X-Forwarded-Encrypted: i=1; AJvYcCUUS0anNQXYKpuheIkDjpcD42EzNldJiCDiVTSV0X4DWryHoNDpKORxMynl2d3+Ffb9b3OsL0H2vRR6V2qNFFlIX4hFrsN7xE9c6NcJrShJy9eFRsWDh7kkr/t0CJjry/JJdUAN1YonFOI0cAn1P60GOsI1Saf8z/dG5vcaeklGYoVa8HSjOFW4P4pAFDCIFh04dJfpVFjS1kJk/wXv691Hs6Qenz8gFPe7Un12R33i07w7XCnN4J+Mc4hBgJ+hs4jxGl3yUnyj3IzyNvkaOxqaWLGMNLDfmdVRcEsWPl9e24YfaPRPmLUqYlvL+6Bcg36azbtdfU3tniL+DYweWrLtiA0/kycm9iaFtIIAc6TjlwV4fPY718A=
X-Gm-Message-State: AOJu0YzczAnkoOQ2VptjHKldB9ft43u0Vf9/JCdqR9YNABFOS1c6qdO2
	Bdex3fhK64jGdOe3Xnf2fMMGn7Es/k9bTJGOhgMAkY9oukzk6+J8gH11mXCZi2Y=
X-Google-Smtp-Source: AGHT+IEJxZb/rvHnivt2/Jn9TqdtHD/x5Ql7tE5dwjxcPx/0mDN6PRNnVkmhOeixXnU+C0BePO+7eA==
X-Received: by 2002:a0d:e287:0:b0:615:9a1:602b with SMTP id l129-20020a0de287000000b0061509a1602bmr1190969ywe.44.1712323544943;
        Fri, 05 Apr 2024 06:25:44 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id by14-20020a05690c082e00b006152dd9f93esm344482ywb.132.2024.04.05.06.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 06:25:44 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dd161eb03afso2056354276.0;
        Fri, 05 Apr 2024 06:25:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQYAaMx2yKHFoAQQ6nMerI6WyIx7BilOj0Cl58TpLjIFcpvZAboe+vcRpjKsgKv3Jd3NseFwy6nu55nG+u5RjMpAvT4NBbuAk5wQr2VwLkJD6ad1l1/fHL09i4GMd9D6ieAH9MhEseMDC3DhsUddKOoehu8UyUjcAAqEIh2FQMvLP8+CWh1j9JtvG8eWlakd4kPKAiLlz/pKJDPW16IvUhvsEuCgt4HApJYxMyR8ds3/0bQPbev58vtnspMmUvXPpZtLL4s0/tBSBJAdmfBfUO+6uAsC44caCc3MSrHZ6MIpsLfsEFJjJQUBddri/xlp5IgODcDL6KdIV3eR6lHfcQy0mu8948zKqc29WamvGdPo4eLMTpWWg=
X-Received: by 2002:a05:6902:220b:b0:dd1:37ff:696 with SMTP id
 dm11-20020a056902220b00b00dd137ff0696mr1555021ybb.59.1712323543740; Fri, 05
 Apr 2024 06:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <dac98a697c8e850054f984964af62a209f241c83.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <dac98a697c8e850054f984964af62a209f241c83.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 15:25:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRLwv1c+L0DP_jRJh6_=-oTQJWOcYCzYqowW8tyOJK2A@mail.gmail.com>
Message-ID: <CAMuHMdVRLwv1c+L0DP_jRJh6_=-oTQJWOcYCzYqowW8tyOJK2A@mail.gmail.com>
Subject: Re: [RESEND v7 23/37] dt-bindings: display: sm501 register definition helper
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Javier Martinez Canillas <javierm@redhat.com>, Guo Ren <guoren@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Anup Patel <apatel@ventanamicro.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

Thanks for your patch!

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Miscellaneous Timing and Miscellaneous Control registers definition.

Please do not put raw register value definitions into DT bindings.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- /dev/null
> +++ b/include/dt-bindings/display/sm501.h

> +/* Miscellaneous timing */
> +#define SM501_MISC_TIMING_EX_HOLD_0    0
> +#define SM501_MISC_TIMING_EX_HOLD_16   1
> +#define SM501_MISC_TIMING_EX_HOLD_32   2
> +#define SM501_MISC_TIMING_EX_HOLD_48   3
> +#define SM501_MISC_TIMING_EX_HOLD_64   4
> +#define SM501_MISC_TIMING_EX_HOLD_80   5
> +#define SM501_MISC_TIMING_EX_HOLD_96   6
> +#define SM501_MISC_TIMING_EX_HOLD_112  7
> +#define SM501_MISC_TIMING_EX_HOLD_128  8
> +#define SM501_MISC_TIMING_EX_HOLD_144  9
> +#define SM501_MISC_TIMING_EX_HOLD_160  10
> +#define SM501_MISC_TIMING_EX_HOLD_176  11
> +#define SM501_MISC_TIMING_EX_HOLD_192  12
> +#define SM501_MISC_TIMING_EX_HOLD_208  13
> +#define SM501_MISC_TIMING_EX_HOLD_224  14
> +#define SM501_MISC_TIMING_EX_HOLD_240  15

E.g. these are used by the (not very descriptive) "ex" property:

     ex:
       $ref: /schemas/types.yaml#/definitions/uint32
       description: Extend bus holding time.

Please instead use an enum for the actual holding time ([ 0, 16, 32,
..]) in the DT bindings, and convert from actual holding time to
register value in the driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

