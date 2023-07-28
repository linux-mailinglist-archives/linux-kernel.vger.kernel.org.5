Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D26766CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjG1MNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjG1MNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955230F3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:13:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3175d5ca8dbso1948466f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690546380; x=1691151180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRUzIO4Vo4g+PtLO6SQyyzON+7m5xxIEMpALWYcbvEM=;
        b=WfDGNxDrC/JrReJKtXf1+BBvpHrRk9ho095gkO/gI2a5m519813xFp8X+UJ7pkBhD8
         OR07uB2XRmK2yCgL8nbcuBSJHgVO7DETpmGFnlQ8yfY1rRfQ+9cFoXuDKMN7I85OX3uz
         LmNxGwpSoMHcka7Npfnb9GiqBV/yJ5dbA6UESgWrI2dk/uyDuyE1MB0W0NQAIs7LD3J6
         vIGg2BVONgbsWIuGejLJJomdhcyGPvU5Gs50bWJSHqpeRU4r/1ttopYQX4ykrvx8gl3i
         EeF6wdIyZtMYa8dD+Ynzur5IihM/yXjl8sdfzoCpD4NXHa32VQpQuopBQj0LY+PabZKo
         LRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690546380; x=1691151180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRUzIO4Vo4g+PtLO6SQyyzON+7m5xxIEMpALWYcbvEM=;
        b=Y4HFFLdGlAqCyGLYMwC80AZ2Jmr2vZrRgTrYzmilmhCXTsNguOoHtNRRYAedQ0xLzK
         v8RCSWSdVfCJ8b4qs2Kjbwxv6s1nuFDDZyOgDsr/Q70opxmej0Q/MvMll/cHqVkSQ1Hg
         qyjEBAihbuL6IYkfVVE+vYsCuQXdpvK0Y6u44HneaD4WrFxygRu+0wTqkCi4LTCUSiQ7
         KSZiV7JXR5j+3BN5zq0G2TjwqhWjGN5y9MCxUEPBfC0wv+BNgWT9D139jROwicWhe063
         JOW9pgDKpWpsBb3i23j7hMr0THzjXxW+MLPRqvlUhGp6V5ie5pSWf5dW/0hmK7kfliXu
         0KeA==
X-Gm-Message-State: ABy/qLaNJN7z3Y3Hxr8RBtqdnR9S90VDpuaEv8LPSabniTRMAdsRdJYT
        qDqWBCXavfoD6spgQz5I9loh0H3bUkToS/7QJkI=
X-Google-Smtp-Source: APBJJlGpG6BJkN6VYu/H0dpd5DaT0TWI1mxXDidUB1Zt5NbHSkNjjCSsVWFf0DcUsjnVwKQjvbwwOQ==
X-Received: by 2002:adf:e3c3:0:b0:316:fc63:dfed with SMTP id k3-20020adfe3c3000000b00316fc63dfedmr1499002wrm.39.1690546380394;
        Fri, 28 Jul 2023 05:13:00 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d5607000000b003143cb109d5sm4678721wrv.14.2023.07.28.05.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:12:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Finley Xiao <finley.xiao@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Diederik de Haas <didi.debian@cknow.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230724113622.12838-1-didi.debian@cknow.org>
References: <20230724113622.12838-1-didi.debian@cknow.org>
Subject: Re: [PATCH] nvmem: Kconfig: Fix typo "drive" -> "driver"
Message-Id: <169054637960.92416.4162123966763307418.b4-ty@linaro.org>
Date:   Fri, 28 Jul 2023 13:12:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 13:36:22 +0200, Diederik de Haas wrote:
> Fix typo where "driver" was meant instead of "drive".
> While at it, also capitalize "OTP".
> 
> 

Applied, thanks!

[1/1] nvmem: Kconfig: Fix typo "drive" -> "driver"
      commit: 9d53d595f688c9837e88a919229cc61a165c7b9e

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

