Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A695792C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbjIERCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354283AbjIEKcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:32:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3203EE8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:32:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so23326055e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693909931; x=1694514731; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/OQBvJoch509LjspQeiUDjA39PXpbuvgijH49h9PaH4=;
        b=k9GGtYLyvj5q4I063wM41vfMsjSJvb8exsu+Jk0OQOXLwW6a4Tc0tDChWNEn827/EP
         gm1VOEHGmne1QCliKiOqC0Knwob6Ff9Jtr4Abi3OfUEWp+LkzQ+XCFx3sqt15Z6U4ZL0
         82SZFWYTU4b0dETSOm8atudHw8xeKWD/vSph1YIx2fVxfKJ8g0rWeTb0fwiWvo9dwdkr
         HZ2ILgTLd7kmq12X+XanwUKJS1w4MhacCLzVpv6zMTOPb+LxpyiRjKHQy5huX68jMH2D
         GpYewPHaEjAGHfxBjT7Fbwo1qRE7g0R/3NAHKQBELhGwNXTv7eHVMaBh8TqwOoHLlUPw
         7Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693909931; x=1694514731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OQBvJoch509LjspQeiUDjA39PXpbuvgijH49h9PaH4=;
        b=liSkhebfHMKjs9didpZiTTtAO9vtY6BuXWmT5FIO+MxzSla2YXL1ifzf4YP19Hj+YF
         in4ohIlzR05JvSyfPTCfbjIWqHk6nZQJ4MHV+cWgCyTBwtQGb0rDZPpFmBbD5BanKFUs
         62fD2M8Ai6mXM4V09DuJDizmjwSQTKyyxokdHPOprWVgqsCYFmdNFp1sY8KEqf2usBih
         7jHJ2DkQrWMkTTRDN6LvIDya5xI7D1Bpfvfo161Uoru71LqsDjObhYGgwDgos7TWUrV9
         h4odzjaWyTbEE75+z+HRYQuLWMv04m+JmLahv+twc4HVFDDFIeWUjNQ+Gsca+DSUXNSk
         EIQw==
X-Gm-Message-State: AOJu0YwKvXwV+SR4qc+Fb7vO1ThlnLO68dHfHLf1EbiMyPq5ZlDPcp2f
        IFzXS5yxcbWVyuERqSDOD9hwGg==
X-Google-Smtp-Source: AGHT+IEYlIuD3hm2wYNbYHvhWP97jISs6NsenOmr2XcKoguKkZOXo5z9CJuucBGE/1Kuq5gWR+1nnQ==
X-Received: by 2002:a05:600c:22d7:b0:3fc:114:c015 with SMTP id 23-20020a05600c22d700b003fc0114c015mr8218926wmg.39.1693909931598;
        Tue, 05 Sep 2023 03:32:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b00402c0a8a084sm11134162wms.17.2023.09.05.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:32:11 -0700 (PDT)
Date:   Tue, 5 Sep 2023 13:32:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] phy: sun4i-usb: Fix a W=1 compilation failure
Message-ID: <e1a5eea0-33a0-4a58-912a-9548d249ea5d@kadam.mountain>
References: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
 <20230904005855.658819b3@slackpad.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904005855.658819b3@slackpad.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:58:55AM +0100, Andre Przywara wrote:
> On Sun,  3 Sep 2023 12:11:06 +0200
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
> > With gcc 12.3.0, when this file is built, we get errors such as:
> > 
> > drivers/phy/allwinner/phy-sun4i-usb.c: In function ‘sun4i_usb_phy_probe’:
> > drivers/phy/allwinner/phy-sun4i-usb.c:790:52: error: ‘_vbus’ directive output may be truncated writing 5 bytes into a region of size between 2 and 12 [-Werror=format-truncation=]
> >   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
> >       |                                                    ^~~~~
> > drivers/phy/allwinner/phy-sun4i-usb.c:790:17: note: ‘snprintf’ output between 10 and 20 bytes into a destination of size 16
> >   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Because of the possible value of 'i', this can't be an issue in real world
> 
> Would using "u8 i;" help? After all currently there are only 4 PHYs
> max, and in general this isn't expected to be more than a "handful", so
> 8 bits should be plenty. An unsigned is better anyway.

Generally unsigned types are trickier and cause bugs.  I've blogged
about this before.  The title is a probably more negative than it should
have been.

https://staticthinking.wordpress.com/2022/06/01/unsigned-int-i-is-stupid/

My blog mentions u8 i.  I would say avoid that unless forced by an API.

> It leaves a bit of a bitter taste, though, as we shouldn't do this kind
> type tweaking, especially not to work around the compiler trying to be
> clever, but then not seeing the whole picture (that "i" is bounded by
> compile time constants not exceeding "4").

Yeah.  There is always the option of just ignoring the static checker
when it tells you to write bad code.

You don't have to even look at the *whole* picture to know that GCC is
wrong.  The BIT(i) would overflow if i is more than 31.

regards,
dan carpenter

