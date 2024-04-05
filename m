Return-Path: <linux-kernel+bounces-133117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29C899F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4206C1C21962
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72116E899;
	Fri,  5 Apr 2024 14:10:16 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBF16E895;
	Fri,  5 Apr 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326215; cv=none; b=YxPX8FTaUr7aEum4zmolp1NXgjHlkYkZKUonLPcF4CAZmIY1Wr0tQWvAh6qDUpCuc3aqdBM4trutLlPMTDecEj71R6fFOVv2lAsvlGazwNUr66huZ8diTeoCmxAO25wjuorRm5xU2MFUhpVfgXu9zYdxYpdL1oYHB1iCywv+FlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326215; c=relaxed/simple;
	bh=UhWkJrz23rKLc2rFOHT1xk+suq4P0R7Fe6anIWJ5btE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BG8kONHYPMshE2RImnJSk5JlghRwTpzRXRc1GYrmKyNaayno9prR/pQXvG7oNT6SC05XJLF2CF3fz20dl3Pmx7+CnqR7mPMLRd7SGwzolkW7RrSwBbe4owdN0Xe/ajhy17Fi+V/9IIF/XlPeAOUSKL9WLlMh1g1HS3WsBvL4IRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6151d2489b4so24101067b3.0;
        Fri, 05 Apr 2024 07:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326212; x=1712931012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo5dazFCTOKvFVcPPNzGvqZjg5emzEStKUearWVqE/4=;
        b=smdZ4x4tSobCG7/AJB5NXCw4gj5Km1mPaySy2IcZA1wu9jYPko//VYA2ThdRPwanvA
         MC1Z4Y3VGv4hECxKJs5DjkR9zFKaiZ9agYgKaDxmXlG8YTWDklPv1cyo9TyNpY5HMQ4X
         elPVHuE4gcC0iqoatpXNO3Cgcx6rcpryFpdjOkRWgmsvI8+f72itOeKWid9q/mszdiDL
         KbGb2lUXSxvndo2LiNJ0Tjev1lJ2U0AfLVPnbkWKWCgmu/WAV9g5wW8NVPlhzFTBtnLb
         EaMj5oqSBRQ80ahEs9js7XJCbkMEk4kXQP8IPKM8TRDitOsHpyeANnXCIIYR4MIxXFae
         BD5g==
X-Forwarded-Encrypted: i=1; AJvYcCUnEuPbaOhRQLIvz56UXaXLOxm4jTwf7T6UngwMHp0zVfhpgPMHyle0bQilYUihq0RISIyz9Gzetfvw1/KrYIPptj6GLpDJspNfZOZeZVtlTJB//1UhLOt+diBGLCyWnzVMJ/lBYs3i59xFa+fnQDih1wiF+HuaKXFDM51zAs9yC53TfQchHWh5EbdwCtMHY8yLxk058HsQle5SsBRPUDAVK73+YJuIUgfeot4Qmxb5E/Np43Mg/PwCGMqhvGQCWuj0r65axXoptjutoJL39T4UY9CK3qUCHfvn/gGmZE50miEu5vNNFY2T1XvQwYlQtmwDuYaLNM1++keLG8Fd3DytCzu18/wrzrREdDaZzl/HWLwHZ8CyrpU=
X-Gm-Message-State: AOJu0YwvxaRCIEVT/zVCfalDAmhBHItiMr88lLhGODcta3p0TFh2+iQj
	CEkjDd7PpAQVHy1jAsq/Dc4UX2ZBZ2yztd0CcKFzfUYRlC3DRRzKgQffP5ZBkno=
X-Google-Smtp-Source: AGHT+IEP7v2FRtp6YWsKqFOWKu6GX9ebD3Ahe7HH5QN4FxWDZZBjjTw+UOh4HM5EFGxMk02CQuTa9g==
X-Received: by 2002:a81:6086:0:b0:615:31a9:83c4 with SMTP id u128-20020a816086000000b0061531a983c4mr1461190ywb.6.1712326212430;
        Fri, 05 Apr 2024 07:10:12 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g68-20020a81a947000000b00617cf273030sm278771ywh.82.2024.04.05.07.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:10:12 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbed0710c74so2090306276.1;
        Fri, 05 Apr 2024 07:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3fJz6nL6cfIkiiG2ayy4RzOL2AldXVQJNoWYlsKDVgAtte9df/fQnzkurcNyjffaQcLcVhA4S1/tqOhyVS2GRh9SMU3sq26i9hekbCg8LNZa2J2H19KcNi+QjtS4guCcvsC6EmAOhRTNph3MwMjcW4zIDz07Z/QtLxLEM44PNeYAzb46Rxb4ly9UgBSzbCmTCXncx3LF1b2/hUCFUppVW/F1GSw94xx9lz9e5W4oDlinEzLdQtblFs+70X5XVeg++4X/Cn2saVSIvQHiLNc3YZm/B0juNwDEmxP/9DnGyNbTLbnNw292Jz7ufjJaDT19U4QMqhLE/udNFZ3IudIG2sCDaTB/GMUU5Fgghru5p6JAvKVqw6i0=
X-Received: by 2002:a5b:b8f:0:b0:dc6:dd80:430e with SMTP id
 l15-20020a5b0b8f000000b00dc6dd80430emr1385717ybq.27.1712325790915; Fri, 05
 Apr 2024 07:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <f3af315d575fbec431bad9bfaf9790450ab31ad9.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <f3af315d575fbec431bad9bfaf9790450ab31ad9.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 16:02:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1vhCZ+mCKB27N57N7atLdxSmEUV8RWJf7uiZkfUvG0A@mail.gmail.com>
Message-ID: <CAMuHMdU1vhCZ+mCKB27N57N7atLdxSmEUV8RWJf7uiZkfUvG0A@mail.gmail.com>
Subject: Re: [RESEND v7 21/37] dt-bindings: serial: renesas,scif: Add scif-sh7751.
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
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Add Renesas SH7751 SCIF.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - renesas,scif-r7s72100     # RZ/A1H
> +              - renesas,scif-sh7751       # SH7751
>            - const: renesas,scif           # generic SCIF compatible UART
>
>        - items:


If this is applied after "[PATCH v2 2/2] dt-bindings: serial:
renesas,scif: Validate 'interrupts' and 'interrupt-names'"[1], an extra
"- renesas,scif-sh7751" line should be added to the 4-interrupt section
(below "- renesas,scif-r7s72100").

[1] https://lore.kernel.org/all/20240307114217.34784-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com/

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

