Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D477B632
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHNKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbjHNKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:11:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143310D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:10:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so37356275e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692007850; x=1692612650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESVhtHoMLjpXOh7/9of5EXSKLVqOfUmeEpUAt6YEbDk=;
        b=ugbzJGCHzCqnyNCVJ9AEJgSO4wFcS2K/tJY0TUtVVrrYd1YFLE3qXOv0MlLIgXTZVB
         QSyJ7RSa+r8S4kW3SkekG9EWAPUz/FTqQkJXJ32FVR5hTHmA5m4iXN/4HeZf3B67JJGU
         j5RKW/uLqbsVY0JTxKCQIUsbSZXqvjHymXYU0ApOjlN09CTtTM7o1EsAq9df40ayR/gL
         NyoWEuibfG0/nbthmkvaWcZLSQrvGVWfMbTn+1E0TTfEyXgjflRUpIUx/CipCOskR7rm
         UZGWZJLHuzQf1sfwS5uxY93zjQt5km0HBE0WuxgosCyk6cdaXvIGV9cFxI0Ko83Xpkbr
         M9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692007850; x=1692612650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESVhtHoMLjpXOh7/9of5EXSKLVqOfUmeEpUAt6YEbDk=;
        b=JlpOmRlf7W3PjLjP/XymSDAZD9yo9RWQWIsnBS1NPG39aBiiACUtz6KjR2xgzJP0nj
         Cm9gQIZ0kbTvJ/uE3qV2FgoVdxdRXZJBwV/erBhlgbZSYmeYugPrkVcTZhWbynL9GrrH
         U2gP+N0P435ZraNxH4SMSD36SmD7CVh/OdJotYkH33x/AUQEcGXmQdJ9zvQM4/y1k24w
         oGE89/7lvRtaaeW1yTFeYYBnsl9O/UeSn3vFX77a1Ro52ym6kuz9in/d7Z6AOZjmh0mX
         XrL1OVeOxYcdG7f2/Zy2Viu7u9ckqsydWue4R25tPTZShbH28IF0YHks65+HYMf0k1a5
         uskg==
X-Gm-Message-State: AOJu0Yyu5LqlWnwdWp8EghsIczdg2EcqRGylS4jgJ7Q0UMSm6MuakMUN
        /8jNLakYqH6tpzpssUz00pkWGA==
X-Google-Smtp-Source: AGHT+IHr7ubyVfhrrz0Cla5qo9gl0Y6s4v7dNlJWWF2mrQmHybIpVpMUq2sIq64MgDp9YflZck6Fzw==
X-Received: by 2002:a1c:7717:0:b0:3fb:dbd0:a7ea with SMTP id t23-20020a1c7717000000b003fbdbd0a7eamr7212142wmi.37.1692007849752;
        Mon, 14 Aug 2023 03:10:49 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm16750396wmd.19.2023.08.14.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:10:49 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] clk: sunxi: sun9i-mmc: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Aug 2023 13:09:58 +0300
Message-Id: <169200755842.527063.8434968913073327760.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 14:53:01 +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied, thanks!

[08/13] clk: imx: clk-imx8qxp-lpcg: Convert to devm_platform_ioremap_resource()
        commit: 94945b23133db0b698ffe764d8a82593906d1e74

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
