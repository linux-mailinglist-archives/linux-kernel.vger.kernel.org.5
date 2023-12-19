Return-Path: <linux-kernel+bounces-5375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EC818A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664471F25F02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758E1CFB5;
	Tue, 19 Dec 2023 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxCD58sh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A91D53F;
	Tue, 19 Dec 2023 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so45257541fa.1;
        Tue, 19 Dec 2023 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702996302; x=1703601102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WyA9uR2so4rEGMydW8w1UnQ0pww6PlgrH3NKuDhjS1A=;
        b=dxCD58sh2AQdO3Iz7i3+dwj2fiPGBbAZy0taBxCU3GxPjT4hWqshC8dMyp3upN9lIC
         gvs5Gs0yIbgAHDejZVuVyj17vAcLYYYXxyeITY4mw1inm7cT9hDD5D493YzVbiGNTt4x
         BjWezEVuFqroj9luw5YRe37U7cr6xeezZhBr9rwHrfJXfg8evmWxcbjWdg1xnvQwm+4f
         /XKUizYtQE9WBoAYjdH6XkXnTC0awHgpz/sBU8nOwVf6a0Zr7v1bsZTuC7PWoR8ZJDFN
         rQhE04IgjhgvU463DaVXf3APOXcPaA3eZOnwWE4J/vrknEujYsAN95yGRt9AOMpW7qUK
         xyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996302; x=1703601102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyA9uR2so4rEGMydW8w1UnQ0pww6PlgrH3NKuDhjS1A=;
        b=ep94380giuez3zUhV6onY66+IdPA6ZVcLG1TdJAKe51mMh+1PCrrYX/VbpzL3GYS19
         jrKplEFCobT45jkkOBcUwboaMuHHvNuipD6Vs6I4OpDHZSJX87P1zQQvypUN6pM4IRLq
         MHfYxqZPHAXT23Zwuy0mOg/5WXAALGQmiblnkqQWJRY4DQuD6mKZS4uDjLguhDFDPvms
         BcmSYEWV8nn4zzDZRP0gwTw16HtEF8mF86JNyByDerlpfgIDNrLb6HM8vgtFT3+jdkGX
         piZz0TA3dKleIjfsxAV4EojaUbqKPpXUPBK06XzWovYgWatm8TylYlA8vqWk5F4EBq6k
         wRIA==
X-Gm-Message-State: AOJu0Yzulg/m/lAAktjbKc5fzeR4OazpiEOhJnMa8idU3xhAXyuY/LaX
	zyKL8FQ1kNgkWSBw9LfIDOg=
X-Google-Smtp-Source: AGHT+IHhHCyRsL72DRpdrORUD2XCeOSYWjCbvA6Qqs+EvG1GjQbAKWiShou4dtBv7zW1m7iDBOUN8w==
X-Received: by 2002:a2e:8746:0:b0:2cc:7019:4cee with SMTP id q6-20020a2e8746000000b002cc70194ceemr745805ljj.24.1702996301628;
        Tue, 19 Dec 2023 06:31:41 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9bd6000000b002cc710614besm784454ljj.0.2023.12.19.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:31:41 -0800 (PST)
Date: Tue, 19 Dec 2023 17:31:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: xiongxin <xiongxin@kylinos.cn>, Andy Shevchenko <andy@kernel.org>, 
	hoan@os.amperecomputing.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, 
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>

On Tue, Dec 19, 2023 at 04:17:16PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 19, 2023 at 11:14 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Tue, Dec 19, 2023 at 09:37:51AM +0800, xiongxin wrote:
> 
> ...
> 
> > Also note all the tags you've already got must be preserved on the
> > next patch revisions. One more time:
> 
> > Acked-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I recommend using `b4` for that.
> 
> it harvests tags from the email thread, so no need to care about
> possible misses.

AFAICS it doesn't pick up the tags from the previous revisions at
least if the new patch wasn't submitted as in-reply-to the prev one.
Just tested it on v3. b4 found my new ab-tag only and no yours rb-tag.
Did you mean something other than I thought you did?

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko

