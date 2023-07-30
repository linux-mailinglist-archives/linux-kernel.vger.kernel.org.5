Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A56768932
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjG3WxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3WxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:53:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5CAB;
        Sun, 30 Jul 2023 15:53:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe1a35a135so5515959e87.1;
        Sun, 30 Jul 2023 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690757589; x=1691362389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LolaIywE6Sh5m79upv1Hlv7iJcp6yOQ3wePrb1ubGYo=;
        b=jTqShHh3AKaXKv+/TOf7Dw67nNE8EsUvCRjvuM8F9L7rnfNY2qpL1Q/maOoBmdqtab
         Q1qbNzNQq6ZqXcm/LzLenqy4sKr4vz3kR1wrDmMrmQifr8G+SEuHb3i3ArBT2VL7TLj6
         ZKfwz4Lz4ssg1H1ZlnnIDg7VZD+nbVRBNHzrfPlFVnw97Q0sMpavFJT65tdagB4NVqo6
         3OnApNsFLLk7DJWQwtePRfmgIw5tEhHz6xU5oGxAZtGNthrOaRCk2wTmFyyX9g7flkCW
         rrtIxgsT1dXHW3srqz+8ptSc0Q1eGoWuO4ae0Eng4UT7f3bHK0HP7U3d8EzezP5QOtzY
         nIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690757589; x=1691362389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LolaIywE6Sh5m79upv1Hlv7iJcp6yOQ3wePrb1ubGYo=;
        b=CU0vx1hVhCl1MK7FNjLB2lc8lr2KhldFlYtNNhSzsVt+qsTkDIrA8a7PfhwWUjEd9/
         lrajkzX7YjMqIrwpOiAxxzzyPinIIYtvj9BKLaKbGveD+rXJluwyA2k0AD3zxhjuEQ5m
         F/T8NqqG2iSEGcJuaN0rMM8V2pySAJRqJlpB9fL90dr+hufeBYtTSLYfcIY38LReSbOo
         pAVfE8tt6XmGCsVVfci510B05VgT4/de8WiM+90bmzLi5wvYLOQFI8TZP2L8iUp2tazP
         MhmoS7XFKrNFCf/V/MssUnU1RKMADG748v3FkdPMtX6yTPgHYk+WnSy05dsWL+u2dP2k
         rqFA==
X-Gm-Message-State: ABy/qLYm5F3k/xEugM06V4KSIPRnmzg9UeQ9afNhe1XHnPaF+rBLnnhv
        z1f1P6v/9gn6M29HBQswHhc=
X-Google-Smtp-Source: APBJJlFcCh/Jqh3WTePQM0jpaW7rqln031MmdUN+IobVOmTzYSo6PVlzPI/t5X0zqw0y9G+PCtE+Fw==
X-Received: by 2002:a19:ca5b:0:b0:4f8:710c:e2c7 with SMTP id h27-20020a19ca5b000000b004f8710ce2c7mr4263989lfj.33.1690757589451;
        Sun, 30 Jul 2023 15:53:09 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id v24-20020a1cf718000000b003fc05b89e5bsm9604089wmh.34.2023.07.30.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:53:08 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, wens@csie.org,
        samuel@sholland.org, ulf.hansson@linaro.org, mripard@kernel.org,
        Zhang Jianhua <chris.zjh@huawei.com>
Cc:     chris.zjh@huawei.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: sunxi-ng: Modify mismatched function name
Date:   Mon, 31 Jul 2023 00:53:07 +0200
Message-ID: <3174068.5fSG56mABF@jernej-laptop>
In-Reply-To: <20230722153107.2078179-1-chris.zjh@huawei.com>
References: <20230722153107.2078179-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 22. julij 2023 ob 17:31:07 CEST je Zhang Jianhua napisal(a):
> No functional modification involved.
> 
> drivers/clk/sunxi-ng/ccu_mmc_timing.c:54: warning: expecting prototype for
> sunxi_ccu_set_mmc_timing_mode(). Prototype was for
> sunxi_ccu_get_mmc_timing_mode() instead
> 
> Fixes: f6f64ed868d3 ("clk: sunxi-ng: Add interface to query or configure MMC
> timing modes.") Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>

Applied, thanks!

Best regards,
Jernej


