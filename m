Return-Path: <linux-kernel+bounces-133090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AB7899EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7491F2309C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F416D9C3;
	Fri,  5 Apr 2024 13:44:51 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD159B45;
	Fri,  5 Apr 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324691; cv=none; b=qDhguc994hfgBNnCOuoj/bvpTWBBia1O5uzJulXXX0lvMjBMqZqF/qqvpJn3MsA2AyHCNajdVxoW2SseFJLFFtZi0gy1JJaKN1QCDV4Q4NggKACDpAoSN/nWg86dfh1i7sBcW8/7UBJrvkO3GLvpGOG7WVY7QxqTYV1nVmGkVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324691; c=relaxed/simple;
	bh=xva1i4UV7vLLzjuJ78eFep+KhLy6yugVjTmbsoR/THE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWu2yenVR8WywDLGbI8ruTuZ4jri+1Uk2ZpCrzG2R3dTIkQW6bOg0dQsX6r6SeH708fnvmpOihoenbX0JK6Sh0c6oyXv64YuMoCoZEcDCeuGdh5H3EjGzfW7joCHnFGxh8TQLUBHpOK9ytZ6gUpe68TyjcPUws9dO0anQK+vlZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61495e769bdso20601567b3.0;
        Fri, 05 Apr 2024 06:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712324687; x=1712929487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmgVg+1Qt1l7Val4LNuCcTFJSMT3ZujIhIoVP0zBFgM=;
        b=MbEOsctzP05UopA1uaFoAj8BmDdf9l3kOBd/wixV+izSbXZ14bT8Knh0Q697aeUBZH
         JLS0d0PAQqFKJrAd4rVGx1wgAuaePJGXhhODrq2NnmDhmaQLMCmA9dSuI91i+V3AhFrd
         JG8RxnH8KEpm29Q1aYVig27FXb8xFP++2SADpfKyUTNjryxdqv36rCkfBZrlV7Y4B8q3
         SX0yzhEOs5l16LYKFw9jcODqm5qccloC7ZHQYTneMBhCvo+mc2HWpo8Dti+oBHD501aK
         dD9NSMavr43e8nKcmWNdx6xzKbL+tZe2K4Up98cAyVe/fa4FjdsYWabkOqPlS6XldqdD
         91kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNQqOyfSgBrj7mPPRG5lxoqJchqbKU9f9vJRf3lDzmR7+X1dJ4z0RJ6NkqWX7g2eS1H3zKUvtP541nW8gdXXNRqFJzr+ir7eteRCpTg4DjF1lfa/yVtkCvTp1cVL1bpokEioE8SNBtXGG7Q3IEHry7gsoTh7KX1ozlM2D+yeYBKKUF0eAczbBmpNDUoMfn5bRdPQsIuh0evlHUzbayRil8rxCUhwE5S5QkzJ+hLIcM90k78dzJZvNO3IfYpOfFiQC/D7oltSXaOEquGltbqfWVzSXtxNUyaq5it9syqw/86oQErJ3D6XYpTZC7FI2jgN3dlTlsCsCsZiF5Pd95YEn2SDBVBatyMxDQJIiVnt2y/9bVaJiCsY0=
X-Gm-Message-State: AOJu0Yx/jh1Klvo7IoqDhD1fsdpg8ZP8sL0fo2KKeicWfNFPGTYSjFKZ
	2/qW4k0JiDlLphYqpx7yjLElda6wustYRpUxNXgmCONhkBgsuEg0/qFAST41RtU=
X-Google-Smtp-Source: AGHT+IGryuA94LE/eSXrxoIJvHMzfoXO/BOd4G4bBFVPpkH3DKKQDijLJcZynHrVvv2SFpn7Kx85jQ==
X-Received: by 2002:a0d:e8c8:0:b0:610:f5db:697f with SMTP id r191-20020a0de8c8000000b00610f5db697fmr1265803ywe.11.1712324686820;
        Fri, 05 Apr 2024 06:44:46 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id m28-20020a81ae1c000000b0060a28132b21sm353732ywh.106.2024.04.05.06.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 06:44:46 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso2384236276.1;
        Fri, 05 Apr 2024 06:44:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV41T4WqMg2Yw6UHY16yorygqThCKEtkkDtHn9m9kwmTODivrNJJQJCERBUqHL4qPF4+cpRYAHsN8MNSA0jnkIHQ4nQhXzjRZ4T/vD6sg4z451zWXVgWLtqbkdj+efTVZy3Fqp+fl5WlEQctd/i1h+O82lWDgrIVKhy+uWe+a9r5Vzmpliah8ebSfjlIROtb4c9QZjRboMfTxkBeBxvYo7CW0NPxC2dIlb62yVRGLpmNbMwZJ2OH+ZO9WcQuClprMKacsUtKGnLcFuZOlZgIobF6CDugCJ+rYXUZ9Hhoiqw1YdUzw1WGhgLtvIaaOmLDzjzdtuxjoCu3pae21zeMsEPT3EJRqmFX9js1nKEjtxM47VBqz7fMpE=
X-Received: by 2002:a25:9a05:0:b0:dcf:4793:9a25 with SMTP id
 x5-20020a259a05000000b00dcf47939a25mr1436501ybn.44.1712324686416; Fri, 05 Apr
 2024 06:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <3c2937039026fdb827709b2584528aca263f2668.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <3c2937039026fdb827709b2584528aca263f2668.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 15:44:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXetO4FJhL3rByXWS=vevkvNgbgevzTZgDFjh-F3TMb2A@mail.gmail.com>
Message-ID: <CAMuHMdXetO4FJhL3rByXWS=vevkvNgbgevzTZgDFjh-F3TMb2A@mail.gmail.com>
Subject: Re: [RESEND v7 28/37] dt-bindings: soc: renesas: sh: Add SH7751 based target
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

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/renesas/sh.yaml

> +  compatible:
> +    oneOf:

As adding more SoCs is expected, having oneOf from the start is fine.

> +      - description: SH7751R based platform
> +        items:
> +          - enum:
> +              - renesas,rts7751r2d      # Renesas SH4 2D graphics board
> +              - iodata,landisk          # LANDISK HDL-U
> +              - iodata,usl-5p           # USL-5P
> +          - const: renesas,sh7751r

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

