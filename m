Return-Path: <linux-kernel+bounces-133012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE0899D65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D512D1C22C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F216D9BF;
	Fri,  5 Apr 2024 12:44:47 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E816C86D;
	Fri,  5 Apr 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321087; cv=none; b=vDagIAu3+Vn+j3Ih6XKo+lRuheMhvGCFWJb+7o2CTxl/TSzGXQR8t7MyrHm0MPCIFOjh1HtveHOzPEH4uJw4765tctwO03tnSqHeot3tL6tvk8s2RXBnLuw/08CqTu7v3jmnsZKmn5xEvOn8j+L6D82v6AuhgdKTAnntIaKzd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321087; c=relaxed/simple;
	bh=gkqjyS2Ov6lQQ+C8YB9XKcwnXXOKnIIdxCTPOpe9BR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNElmu26lQuWWrEMBwASMLXp+1rwQXkYeOK+3VfIXtmVDBmwYapuQW5HLICFkOmLcVOck3O71BgPQm5/+U0Uo4yEIolMQGTejU4Sh+azU/RtP6V6whg1t/u1uds3XaREInxi7p9nwGxd9f/BlIZ9B6hq7YQYFEeYroev3HygkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61461580403so22861547b3.2;
        Fri, 05 Apr 2024 05:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321082; x=1712925882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73KC80zFmtS9rJCbcCR2ges0599ShCvdMicVyQb7erI=;
        b=FXLqGkvlbO2d40hhj38qTjj2lDX4dYVV2VKkL+E/qJgnkbACNEserRNV2ZWPlerb2a
         PqZ1TzANfPyErJnqfDDx/w+bDFtUzKP44FQBwP34v1v1CWehdKy/6raprz9j4Pz1n1RI
         bDoHrdHdXWRnUuucm5WSoqQ33ZPV0ApI1AS3xZmnWlTm0H99v4MrQb4zRngQ3PHaErtx
         beHfSWt0lhvhthgR3rulk8XQirWdUDPPSZ/TINapgVPTaFYS3QiUtT5eFKc4P9KnOevS
         0+7cRYT4auOCwm5gUNOUZ+TKiA3pXn35VlDd+afGack+edwpLswRsn7DuPPvKpUXhAVA
         P+rw==
X-Forwarded-Encrypted: i=1; AJvYcCXwhNgk0wJlFz1NKPkqlssbR6+zIL11jrBWs4N7/xQpAp+d9ixK5wX3DfO6m6eUU8J3oq8qP4u1SqloGKOLzUva4iGMQj7tTqe2tYE698SctMrWCyFuCA/iEeeihGzLLQ0lobiej7j5kzB+uRw9gw5Iz0KHEiSVgIzn0tPwV2imDj8vZ+556WB//aDk0AUUlQ3+9b4Muy/KdLwj9yZCwNarTC8f+oHAE1r1CQdLSP1uerLbK0ULhkR36TAsoaXgTpchKgpzc2fefWhMueAyxSe4AlWfEiw5lgIE1f7Rzh+Es7qsfRffrddiBu8olGJDbY7D8tITh3kvwnMYFmm0cVHYlzNE4lSZ/zqchsj8GzyPBvEw2mcqNbs=
X-Gm-Message-State: AOJu0YxiA4e3nsRu0DKvTE+FjcjoN27Evee4wM4r9pzxuVoXYCHEJsAw
	Rtux7gIMslfNjMdcMYpr95RYJpi3qnJGX7hQ/iviv0evAN4tMaqgyqDKaj2wMao=
X-Google-Smtp-Source: AGHT+IFsxDA3em/YH1W9W/xcK3IKpNlOjLDrQXLWwtheoFreB+RdWe1toqtanc+ORkJtBMI14D1bQw==
X-Received: by 2002:a81:c209:0:b0:615:18f8:d32a with SMTP id z9-20020a81c209000000b0061518f8d32amr1115589ywc.36.1712321082662;
        Fri, 05 Apr 2024 05:44:42 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id y135-20020a81a18d000000b00609f4170662sm337706ywg.54.2024.04.05.05.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:44:42 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2176084276.1;
        Fri, 05 Apr 2024 05:44:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXp4GBqvQvngN9PeqozCuqskOG8yyCJw9bOPcjJ0U/UK5CDPuxv/mp/Qcasm5YnVcBeWsfpWfq/QWMg1bVIM9KSPjLkFndEEum8/N720+9D2lYnDYV6Whr8D2LANIG6HkgcZO43OaQwuggrW9hW5LEeLnMLxau9wFZhTJ4B/T3V1UWq94UJaFb+kcQWgaFuniRtlmiUQHiO89vYunmD5bMRtT5HbhIODiurObY+TFVOBlzkCNfwrlZPRL3/tyCSm+AHfQqn9T1Lh4LydO1lXxyEEUchIKYc5TK1kIMV036dLAqylB1nONqiMr1JTV9VW71dLKg5VOv1G3MIQ3u0xBTYDujLjuU1fzI1+PzFbVTxljm3iX8zlgQ=
X-Received: by 2002:a25:b049:0:b0:dda:aace:9665 with SMTP id
 e9-20020a25b049000000b00ddaaace9665mr1048383ybj.60.1712321081791; Fri, 05 Apr
 2024 05:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <7cffb0c041744b3c2e324f9908635a912dbb2436.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <7cffb0c041744b3c2e324f9908635a912dbb2436.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 14:44:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBNXJ6ATHYUftB4FFVw_JJ3p-sifZYAb7jUmok10tkbA@mail.gmail.com>
Message-ID: <CAMuHMdVBNXJ6ATHYUftB4FFVw_JJ3p-sifZYAb7jUmok10tkbA@mail.gmail.com>
Subject: Re: [RESEND v7 33/37] sh: j2_mimas_v2.dts update
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

On Thu, Apr 4, 2024 at 7:16=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

From my comments for v6:

Please enhance the one-line summary, e.g.

    sh: j2_mimas_v2: Update CPU compatible value

For the actual changes:
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

