Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B347583AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjGRRnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGRRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:43:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302010FC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:43:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so55921525e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689702192; x=1692294192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98ERLGEzzFsSGM5kWcXTpFq/KRJ2f5sxbyycdksneCo=;
        b=YYm8PUxAVR223qq2FGu7rlknrk0r+PwaSRnJClvpTpXDLBU17aO8J6lCfNRUEE4C7V
         9ebMljIfMH/fHHANYn+Kxqh3Mw3nq5KvtYn3PKH0b5m1R2a9Ep0YI2NJqSiRtS8uCOFT
         AKX2y3mOVAbGo9g++6hCqomP+nekoCFFg1VYSOFD2IDDO7y06Ahgr3idr6Csh3Y1TZlD
         +YZs+XV9oKK2I/wesJ1DQd8pUhXeZZ3Af1lW7JvaHJGKj/ohhDYGnNxlr3WBH4VXDx8c
         5TAtVsmDeVCGkyp/oZi/A964+NeZvdSiyNkPMB/sDU9WTRV1NeUzs2ITnP/4lKNKGrcZ
         lhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702192; x=1692294192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98ERLGEzzFsSGM5kWcXTpFq/KRJ2f5sxbyycdksneCo=;
        b=kWWNv2aUGQG5vOTYqYwGs5bFNCLl6fbk1X/XaY5b8qzTfsya6yCTwKaAwPlOu7KS7/
         Yl+fgh8gt6gQgQ9wXRXRrxviuWfHg0HwtMGEY7EZTkbgIatNLTRlUN/dswYvf7G8OX2A
         /ggDzIa8F18cV5G5KEm+kO6b4B26tfVOJq/CGxwDLOpy8jSHzOc3VIWzUdVBGNtWrWVX
         +EM7rM8OE88q3IpbVjkWaLcxMp8jxGeGC6mF2J1yN/gKFsmyL5tjVI8X/bBrcj4nCcNc
         fSkq0ReW2Q37C3c1YrJL3DZmehUaLbw5s0FVXseb3aLv58ONd40Z3dLf4XTdi7Dy0LqF
         AY2Q==
X-Gm-Message-State: ABy/qLZuCmMlhqDVIWGVBwNMreW7OmPt11BrtqQULPNXvS3wL7/nv0jX
        E0hpeT8Me5lSbRAX3D9p4AtPKQ==
X-Google-Smtp-Source: APBJJlHyMltQW8ciWBdPi/f4EOTqO9ZS9c26e5KDJ8Qq+syvkgJ09AZ87262Y9A/jo9xrK8GYhDuVw==
X-Received: by 2002:a05:600c:ac8:b0:3fc:6b:15d4 with SMTP id c8-20020a05600c0ac800b003fc006b15d4mr2658444wmr.27.1689702192236;
        Tue, 18 Jul 2023 10:43:12 -0700 (PDT)
Received: from 1.. ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d6345000000b003143b14848dsm2951442wrw.102.2023.07.18.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:43:11 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v5] mtd: spi-nor: Correct flags for Winbond w25q128
Date:   Tue, 18 Jul 2023 20:43:06 +0300
Message-Id: <168970217897.7924.10145147121934448003.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718-spi-nor-winbond-w25q128-v5-1-a73653ee46c3@linaro.org>
References: <20230718-spi-nor-winbond-w25q128-v5-1-a73653ee46c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=610; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=yycelzf1xRPrlA4DjYfbz/GMcmdf2Vty6uB2xU9GFBw=; b=owGbwMvMwMXoHervvrRX5CXjabUkhpRt5zV5ePc9n3OFQV3i+da0ixGMHXt+7jgqN6Hj24Z61 Vql1DD/TkZjFgZGLgZZMUUWWSetU+f5TuTGyf67DzOIlQlkCgMXpwBMxCGSg2F1Z5l7nyNjsEFZ 7qUz0nEFgbNaMg1KYxckd1SuLlc+qN02abPGc7GetmOart22S1U0m07NOJcr+8j8pxATg4DJr4K s4kNaEjEnHxw/XLvovliKT2D9tIlFAe5hdyt7FVkvMTPMzk4Ktv12OjxW/q6xbza3q4lH2DHBHQ 3P74ppFv27GSfccS9VUS1jReKh2ac/mIjumO/u9S5NZ/aX9D8zL7YyK7ybuajy9c56vjMcKzMf/ Eo5eMefqS14fbrIb35Zi0srngpuWrKqwuurkO2dS3X6Mqcl6wSNJqTx2k0Obrr3yvtCcQ/H270z VWUq/uRtbH5nZRi0cJ/SC4HFM1+lreVOK/A/FOE1oXoCAA==
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 13:56:11 +0200, Linus Walleij wrote:
> The Winbond "w25q128" (actual vendor name W25Q128JV) has
> exactly the same flags as the sibling device "w25q128jv".
> The devices both require unlocking to enable write access.
> 
> The actual product naming between devices vs the Linux
> strings in winbond.c:
> 
> [...]

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/1] mtd: spi-nor: Correct flags for Winbond w25q128
      https://git.kernel.org/mtd/c/83e824a4a595

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
