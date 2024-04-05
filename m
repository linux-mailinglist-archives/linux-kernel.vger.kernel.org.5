Return-Path: <linux-kernel+bounces-133014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA0899D74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C231C22C56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9AF16D305;
	Fri,  5 Apr 2024 12:45:41 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F716190F;
	Fri,  5 Apr 2024 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321140; cv=none; b=cqoK3Vn3cthf4wgyVx+G16OhrKRJx26KsnVl11/vYV1Ah4joCuQM7grOI1QlEi0ILvF4wUFXGehS3/WXs3wq9UaPh7bh++LP24KvqmW+BBP2w3kuYQFnIGK4eK6I9/60xSIl4PZXxGh7JCHj/YPc9qpO9Bu9E1ixg38bv5H3W6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321140; c=relaxed/simple;
	bh=j7niycHsewkLOazgR0DVKBVw1hjefOkEoL7LF7COgjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBTFQJM+/WNdZn6WUYGKB4n1GmmqTq/SHlomuKdNKZrwfnXklisPQrDksOvTerWigIqlK2x9ydQWPl+wQF2imyGw/R2kZX0yheoLLv8/5TzEm1cz7Km/uFvwJ8ZuehBJzKyIBeePlYpL1780bQuCS+OKYyDnCuk8QZEnQ+e+fDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so2292956276.1;
        Fri, 05 Apr 2024 05:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321138; x=1712925938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdcVr7Wy695cSZ73yuRES73pueUgVfr2wxBNFBTwOGo=;
        b=JTc1SImGjelKkssF4JuXDdnJbuJvNS9xBqs6g4XbeX8YWinAySTcUjmjdryeRlhs8r
         JeO8LitqfhCBm/V5sGmp9WVnbQzb/akytI0uAGAVaYjCFQ0ONmkaIguyV2j2eiqDmvr8
         UwVx0Mf6Cy62jE8b6ho5rLNAksGgnTFxLbXbKajvXGd36FwyiEZPE4QUlggY5wr6Jeew
         KULjzF9nIFWZgtQ6KY+0q7lh6JsvYYawgIyVl1sXdP+IMypVb5ZYIgVc0wkaA07+tsg2
         H9+EshXj027uA2B/tvqOU8cHp76eqcAU+F1jPy18iqTm2Jo60pwcw9292rUS9kGWRytF
         suZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7XFpODefODsLrS9JL6NucrbIrEK9COrrOW178oK1nTcLlo0C3wvdVKeF1HhVEJZ8RMD5XIMfQTPNveLF2P8WiDN3fkRmSN4XufpdIzamHPiHKP5NWuAGUwlx4krT9UjYT8C6LYa9gsu6wIZt0Ueb07jwhIrhoXD1w/vcFrAKlr+WMbzTkOkmyRA4gNJ0D/GcKOSmu0p/Pi4pO+UzRnq2VPDbtgjEUIOpuleLdQhyMwtXIWG3mIM2Uo/WtwpH9O8HeQmG0ktt7SBUotOTY3CkdxS2LRz3zJHSye3mCm5awbFHqLxZ/G40kfgR4lv3Mq3L3jrzArpjGjAfy8o1NS/SgW702UsqPRsDtN7CyaOmmSOd0Vswp6c=
X-Gm-Message-State: AOJu0Yxbbg5oVaR0YSEttEbAHDP9mTAbqwpdANhTuiX3I4B6GTdZYIQx
	5MRJox1JVRQz+oyifoyPR4Lchey1IJlK97y85dbFw6zLURFj+yhm3265QuY5Kbw=
X-Google-Smtp-Source: AGHT+IGYPzylN5KlA3Jwu/5NAPCzU9sq7Lj5p0GGnvOX0mjegvjHrF0knBzTd+bX98KxfScxfvmliQ==
X-Received: by 2002:a25:a4c9:0:b0:dc7:423c:b8aa with SMTP id g67-20020a25a4c9000000b00dc7423cb8aamr1015353ybi.12.1712321138324;
        Fri, 05 Apr 2024 05:45:38 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id fs1-20020a0569020c0100b00dc73705ec59sm290041ybb.0.2024.04.05.05.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:45:38 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so2292937276.1;
        Fri, 05 Apr 2024 05:45:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUikQZ3ifbkWHIZBuTR6d3G/Bjqjuczg/ffLmGIc5w3jRFw9cXpL2DhlyJW14FuHrrLqHCTWg/TWMlsbZx5/LYgriFAoXA1+kAdXoZMB+bJzPLslOTLSRn4vL5XSie7/VLwP0a5zczlW5KqXYj5H/XFdI7EOT521L9QDF7OD6qMu7fSwyz/IZ6Gwz5PeaZlRLSDFKJzl6s1HgAnIA0mpDXuXJiTxa8kOaMbfuGv3QmOseHmmBz51JExyaL1Aw5QKz5Megg5/b3KCqNaHXmP64HBkSoAhskD4v8bvEOILFzGiQzFdjx9cH4rfPxqfw/UASjsgPz7DL38YLjJ0uFelQROfEIdCml3f2dQyeIJdnrKdqUpD9k/DxI=
X-Received: by 2002:a25:ad03:0:b0:db9:9537:2c39 with SMTP id
 y3-20020a25ad03000000b00db995372c39mr1198273ybi.2.1712321137914; Fri, 05 Apr
 2024 05:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712207606.git.ysato@users.sourceforge.jp> <f0e220fc338a3dac27f31d7ca871e2ceecad2874.1712207606.git.ysato@users.sourceforge.jp>
In-Reply-To: <f0e220fc338a3dac27f31d7ca871e2ceecad2874.1712207606.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 14:45:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZSFbfihn2udTW9ufK_+7i6y4FWT29bzCPS129Lgdrkw@mail.gmail.com>
Message-ID: <CAMuHMdUZSFbfihn2udTW9ufK_+7i6y4FWT29bzCPS129Lgdrkw@mail.gmail.com>
Subject: Re: [RESEND v7 34/37] sh: Add dtbs target support.
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

On Thu, Apr 4, 2024 at 7:16=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

My

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

on v6 is still valid.

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

