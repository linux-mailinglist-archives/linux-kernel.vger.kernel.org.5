Return-Path: <linux-kernel+bounces-133150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E9899F93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6311E2841C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DF216D32D;
	Fri,  5 Apr 2024 14:27:47 +0000 (UTC)
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D416D318;
	Fri,  5 Apr 2024 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327266; cv=none; b=nCjVEGPGRp8CDWnDa5m21wvI0sv/BAN5Rwlmx4v1TLJkX+u5dJogxHgyxu70EpC1hTYd6GwmDRimzQeI3YgRpXvaZyGMkcSrDxjrbJjjoQAmi0/IxjkeqG/2jV5ToFZt///XgsbyA9vAPW4IavBFfUlMfDqD0+sTcg2CTYBdqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327266; c=relaxed/simple;
	bh=txEEOwGjitw5rYbE/djW7+ZIv3gDGXm7WfJRnMoiIpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lC5PA6t0dEz9Qe9B0/6A+EfvB85FUtV9Aj0vz31vylYOHroDwJXPt1fXkGhkWeVesp7+lBunadSSYmX/qPbTgV8i1ZXfT+HfGgtzp1YyT72hUSQifgUeunKyvCd4vFMiowr5X+zpCfGEo/bCtJOkihULJcmdBtgDh9NSJWYSrAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5a9ec68784cso630986eaf.2;
        Fri, 05 Apr 2024 07:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327264; x=1712932064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PocJzIJm9BmbxkIOP3QKpq0ppKs7IoB/uMDxWflb82Q=;
        b=Ej0LcxuzAzpqLtxsBDs5INfO0bVTvSutmGch2FeGi4aH1gUgVd7Om+65NdgukYI2Jx
         LvHanbFp9LoqY0NBnoKIhBD/mA14jqQ5kpwLvzrbdta2Os9SrxJ6FvjothH/xJF2jQWY
         ant4amW0MoUoM2Rb7AAmFnFsKc5M+89ZdMSip5hFeSBfbOWVLMPKLbKHNDo9ZmjZ3pXq
         oVuQll8urXmCSzDVUejFuXZxn7yyPkW3ts30Gc7DHfEEvtyxFCtQICCzhp5vgDc9Eh2T
         zL10TFlO8kPvJvR3Gqu7E4hqFNeEv+hqrUERN829yRs/UgA0flL6FirlYTHjzjG/wFCa
         40nA==
X-Forwarded-Encrypted: i=1; AJvYcCUEsLCt6GAsPxamr3GPvD0Bi6/RE60k+pncQoArtURGpH94Xo4ylaNPZebgnKT0LuLVPrMIgl4gPoORARSB0fAui3+nxNCwPf2dSNyKNdUz4aZtAzrTfnPbtGDbFIelVCUTEkyilTf2/82jHkPyFpJGQzFNuTZOm6tPxValcV4jhBuWjBe5TvTNMyn0axxKvky92otKiPNHnn9xoqeyoj+/KjoYU8xxm2jl8XWCh/KlTlQSGES3TYzwsvvnunKK6YPr70SjOH+ii/eQqBp6qCu1gvR29E7AedQ5Uxu0SPVraeLGprCVbax+F7LQtWOC/D+6C0dYwmropJJbP7wQ4+ifFWen2uUmhlzF+9+oBGrZoiOD/O9Dr2M=
X-Gm-Message-State: AOJu0YzliBBMMdH5OU0mGt2056PuEb+J8BmrAZEPYPbg+iTwNC+I0req
	jQHJafjzzarLa6ZZXlZ+25J0YVWqIZh5k4bIHcUyKshYfjrDr6oqhN79LKh+JEDLyg==
X-Google-Smtp-Source: AGHT+IG33HrZubBpzY8CpjRIQwVD80jMhPy2dSPTMGLUVGxGflRdQJ0BZwQCntKNtwbopvefvVBfOQ==
X-Received: by 2002:a0d:c845:0:b0:610:ca8b:9a1a with SMTP id k66-20020a0dc845000000b00610ca8b9a1amr1164098ywd.46.1712320862179;
        Fri, 05 Apr 2024 05:41:02 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id jw1-20020a05690c74c100b006144dd11472sm331431ywb.83.2024.04.05.05.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:41:02 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso2067042276.0;
        Fri, 05 Apr 2024 05:41:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0xJzsjm2isj8Cc+w+NQb30rBTV98QfS4Uo5wL6Sr0oiul+gz+xIigjwnQ8P6Hv4wksmkydeB6mzO+9oMQPmPq7BnWrD6FVyoUurMotxGzeXkyp8FQ94Z6cKYTwS2g/vzAlrYTtkYV7ThBiZU03NlEbeUw74VWdoAQM4r8WeQHHDWkL1HDyV6D3UHz6WatyOjpv93Mf5OlXEn5I+1xVEr5Sq3BnGNmowDyfTEVpA9n0PM3tzJny1j+CCgVqm5AoYJNDDB/DxAbHmjf5R9cY0Fjbxina0zMeRKHDsCtKlb9GrztaU04qKbWhTFtknnQiqPJGdSdQMnQSwtaV5aa7b5hB9XkL0uohwER8VgW3t7MjkrVEv73TTQ=
X-Received: by 2002:a05:6902:c06:b0:dcf:56c5:4298 with SMTP id
 fs6-20020a0569020c0600b00dcf56c54298mr1422009ybb.12.1712320861884; Fri, 05
 Apr 2024 05:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <1db8627e4ca50b9d2d27e95d245518cac1cd62dc.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <1db8627e4ca50b9d2d27e95d245518cac1cd62dc.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 14:40:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnioh8er_xDvEY8ny9TgEyfb9AR-p2paS7D4OrbKykvg@mail.gmail.com>
Message-ID: <CAMuHMdWnioh8er_xDvEY8ny9TgEyfb9AR-p2paS7D4OrbKykvg@mail.gmail.com>
Subject: Re: [RESEND v7 13/37] dt-bindings: clock: sh7750-cpg: Add
 renesas,sh7750-cpg header.
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

Thanks for the update!

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> SH7750 CPG Clock output define.

(from my comments on v6) Please improve the patch description.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> index 000000000000..04c10b0834ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml

The actual bindings LGTM.

> +examples:
> +  - |
> +    #include <dt-bindings/clock/sh7750-cpg.h>
> +    cpg: clock-controller@ffc00000 {
> +        #clock-cells =3D <1>;
> +        #power-domain-cells =3D <0>;
> +        compatible =3D "renesas,sh7751r-cpg";
> +        clocks =3D <&extal>;
> +        clock-names =3D "extal";
> +        reg =3D <0xffc00000 20>, <0xfe0a0000 16>;
> +        reg-names =3D "FRQCR", "CLKSTP00";
> +        renesas,mode =3D <0>;
> +    };

Please read
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-=
properties-in-device-node

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

