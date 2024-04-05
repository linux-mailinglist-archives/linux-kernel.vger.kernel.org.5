Return-Path: <linux-kernel+bounces-132996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD624899D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11791C21F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F116DEAC;
	Fri,  5 Apr 2024 12:32:13 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450316DEA5;
	Fri,  5 Apr 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320332; cv=none; b=oin4xQYxqoesX1p7kEm88v1LcIh7REm/H1Rzpb9u+5UluRhArQVu0C6F+EwJ4U5jRNnSUQA5wFLx+QDL2gItMyysVApvupI2zBKHch2nkVx9Qe3zwHJRr294onE7ngZYvGsvxvzuo7ktMiwi1BHNkjXxsUkwxu4NmzDKUeCOCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320332; c=relaxed/simple;
	bh=RB1Wd/l8LoElaNdtvFRK6lkrvSeTO+EqCHYvOY2uo9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vcd53BblRdWhkH3/OY2IylBbqdArQoDEDQAU89QBqfVv7YYdWsINkBCHusfKJcP3zgsQdZ2CCr85kOcRGLKq4Aw9se/dtPDwa1lwgpJqEJZXS/2eeMzDv2PUpKSeP7dzunik+V5eB0QO5QZVfX5OsvxsbEI7/fJu/cmUEWwciws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc71031680so2104444276.2;
        Fri, 05 Apr 2024 05:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320328; x=1712925128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bPulDFyqKcNHOqZbTas5oGwjflVlb0IvXxADWNRbac=;
        b=MPlvI2s8USkd0KUwDLyzT+44IipyacqoM3eSrOXEnaE+gq/5eri1jvCAFInTymt60z
         REU/Xv5JsI4t7qr17Xnw+FIDmUxaLz7gsDwdCATDwL4saADckMYtHthVLdhZjH4WnVkI
         HNmDc5maAvcDHpP8QIc+gi4SIJ7qQHSvwOpCpAw14M34yvFCdM4lTsL//m/wELHt3DrF
         xCzxk0tHygg8yKgui6SNjP9VEBw9MCjbiZR9HYwoxG9s1tsg1f3UKX2ja26i2NdU7l6K
         IF6LPaov4qX7thKBssjGWuISdK8f4InaEyHqbsyt6dnrBeG3EEVVFTShBlccg7+s9F3F
         AZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL5nURRwxemR+6FpvigBrmySRwBvKpTecJEy/+pr7a/EPAndTOjR1HayG/9Cwqlxk1bQHM9EH6lT/rfRGBLnCz1SSwBQ03t9FaEezpmkYkReHuLJhfU93oj3ltN6sRC0VvGpnpDpeqITVL8H3noqnNYVa7xvMWbD8HbQA0geo9wf9XXi30uxCvWsVdrgft6rHgcKw/6kreLrVOWUp0Zj7Ww+cJNduKmoj9PlChpSP6qyq+Yvwt4/i9VTAbDYg1js+vlRnsdYmQaXBe2BEK6VrEXkOIVoX48ghA6ij+LwxKLjzxYsUo9NLl9GydVMZRYi0SIQA0UqQ8fDy/6FdrKGj7Qx59s7lf0Ovu443QwAKZhY05OJRpi2g=
X-Gm-Message-State: AOJu0YzEmVMQJ17wtrOGRxANtnDxvTZ4n3IIxa58hBJWlw07SqnqyyIe
	Vhmkx6r/UINMq4po4OpwPVcvZiW/5XlcYCRpEU6lwQK/5/+1wIQOtr6wJq+Az4k=
X-Google-Smtp-Source: AGHT+IGgevHEpkwMOS5F8pl4dvxc5ZuXVYL1BPsil8rGe3AWrEo/ncgGoEdKh0U9XNWHI/dLAToN5Q==
X-Received: by 2002:a5b:ac6:0:b0:dc6:d457:ac92 with SMTP id a6-20020a5b0ac6000000b00dc6d457ac92mr984772ybr.31.1712320327715;
        Fri, 05 Apr 2024 05:32:07 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id h4-20020a25b184000000b00dcf35be9f51sm284055ybj.24.2024.04.05.05.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:32:07 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6151d2489b4so23214527b3.0;
        Fri, 05 Apr 2024 05:32:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCCz7fA2Scgs08FC+THMGTgCJv9gl18fLbu1NXBD3XzOowX1J9JcPetsrnxejSXGejHF+zEgnxKFVCryqhlpXFJLiq8yL9Ok95qeT9dVG16h9hICUfo2sOC80D4xpJv5saikGuc+5vBPGB+DmhdCAI044MiNxsoco8Ipre4i6/Er5NMsFq5TejWgZ2ESX8iTy19C+7OO8WOuJHYlCQwAujhrufjL8tccWpg7TajjzsOoIJty+1t8QPiM4CJwBktcNvAvplAFecd2lTEZ8bE1bpEpqLs9jcitN5ETCzEYTVp5luw4SM0BwiTPXmMp8SZwD8F/oGc02IUWHwYVhgsbMX3G+BhIwkQGWfTox/izi0nC6dt/xETRw=
X-Received: by 2002:a5b:4ca:0:b0:dcd:19ba:10df with SMTP id
 u10-20020a5b04ca000000b00dcd19ba10dfmr1040280ybp.56.1712320326217; Fri, 05
 Apr 2024 05:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <4ac65d0f311e890c1ca92bf057c70954ec7ac351.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <4ac65d0f311e890c1ca92bf057c70954ec7ac351.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 14:31:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvL0fWGrn+KNDvXcioYnY-=3WmGtcdFkC82L7tL__+wA@mail.gmail.com>
Message-ID: <CAMuHMdXvL0fWGrn+KNDvXcioYnY-=3WmGtcdFkC82L7tL__+wA@mail.gmail.com>
Subject: Re: [RESEND v7 09/37] dt-binding: Add compatible SH7750 SoC
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
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

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

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

