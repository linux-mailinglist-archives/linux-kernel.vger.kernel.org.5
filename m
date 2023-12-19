Return-Path: <linux-kernel+bounces-4950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03F818442
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015E71F25C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB913AF9;
	Tue, 19 Dec 2023 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/J0LlmT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC87134B3;
	Tue, 19 Dec 2023 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33666946422so1808165f8f.1;
        Tue, 19 Dec 2023 01:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702977584; x=1703582384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJNp9yeNZ97nM/HUHnMmpgjxWu53eT5NeGP30O/0tLM=;
        b=A/J0LlmTFkhR+QXs9M3Epf5Clexxg9nkiTXJyiX7jfsTPebW1SNTFV3d97T9d3wqLk
         pSYINeTrkPlfOnwD8YoUrrg3yp+++pP9CFcjIkXIq4A1j/U/u08hAVjrwAIDNyokvk9L
         4AOQFq8++stLQdrD+XPyTvl5w07IacpqLyblnkCeQJ4wqAa0zZTr8ge/6Rdewuh2i+g4
         QYYaBFT1Un8He+G0wXHeHfaqPa65ArwS64qzr9+fykqIE6P5cbW8Uyik2K7oYM2toiS/
         YAO4imnLxJt5+Wxh/z3O8YVnOpz8ldOFFPdnpFf4JfZGX1oJexlcEmjyL62nHBdPpR8C
         koEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977584; x=1703582384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJNp9yeNZ97nM/HUHnMmpgjxWu53eT5NeGP30O/0tLM=;
        b=AL9MaaiNWPhSyP6VxTyzfoJDeWxFuBifEOT6S5zr9TPxEm8AGW+kllyrZ/0urRE6tm
         75qUkf95iIRhsnsUwJJjVF8rixUIkXosN/Cgz0d/aAbFLKK8PIlQII8NsNdzUyvEpBQZ
         s8xOiSy1r6H0SZtPx9/c1Qa5Hl+kGw3yjiAvUUnPUJCU/qYIjR9pBdcd7qS827gI6Lsb
         NGabX7+Sjvc4IrSuyclNLaaEl/UHK0RkvBpibivLOSwW0/94m36Z59lMQHAprjLh5a96
         vVeIgXQo+HFM2E5Dg8EtZc9502Zr3L2tLi2amkX4EbX5Brr5VDiu/cbMil4S4JtCK5gp
         Snbg==
X-Gm-Message-State: AOJu0Yw3ezSfahGGNbpiW+/K5beYtF/LCC/99N45Z2RoccmFygJSYXbn
	iN0LiB+MXZ3a9zuJENdAd94=
X-Google-Smtp-Source: AGHT+IHBKpyIgCZ/ffy+71iAWlyWgokkMBqRjUMcaNNnylwDmM1AnJXVaQ+nW0M0OGj3TLGN9bFTag==
X-Received: by 2002:adf:e4d0:0:b0:336:5c87:16ba with SMTP id v16-20020adfe4d0000000b003365c8716bamr2910116wrm.93.1702977584082;
        Tue, 19 Dec 2023 01:19:44 -0800 (PST)
Received: from eichest-laptop ([178.197.203.28])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0033671314440sm1418779wrx.3.2023.12.19.01.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:19:43 -0800 (PST)
Date: Tue, 19 Dec 2023 10:19:41 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <ZYFfzei3SJSts5E/@eichest-laptop>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
 <20231219081117.GA3479@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219081117.GA3479@debian>

On Tue, Dec 19, 2023 at 09:11:17AM +0100, Dimitri Fedrau wrote:

> I could add the init sequence for the 88Q2221 PHY. Then you could test
> it on your side. Would this be helpful to you ? Did you already have the
> chance to test the patch ?

Unfortunately I haven't had time to test it yet. I will try to do it on
Thursday, otherwise sadly it will be next year.

> You are right, but I would propose to stick to the reference init
> sequence and make sure the PHYs works with our code and then work on
> optimizing the code. We still can remove and/or document parts of it.

I am not sure that it will be accepted by the maintainers if you use a
lot of registers that are not documented. For this reason, keeping it to
a minimum might increase the chances of it being accepted.

> Are you trying with the patch I provided or your own code ? If you use
> my patch you should wait until V3, because I found some problems with
> it. Switching from 1000Mbit/s to 100Mbit/s in autonegotiation mode doesn't
> work. I could fix it but the fix touches some code already upstreamed. So
> I tried to push parts of it yesterday. I forgot to cc you, just used the
> get_maintainer script. I will add you to the cc list. Until then you can
> look it up here: 20231218221814.69304-2-dima.fedrau@gmail.com

I used my own code so far but I will try again with your patches. Maybe
send this and the other patches as a whole series so that it gets clear
why you need the changes as Andrew wrote.

Regards,
Stefan

