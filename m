Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97AD77B634
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjHNKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjHNKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:11:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEA171F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:11:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so38365735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692007865; x=1692612665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TcrCIKHTmaelivXm5tJOqwQfnbwJsTfWCqqVzifvaY=;
        b=qvM6n5R3PsB9N5APOdoqqSc6/Hr6IfuOzXBjrGfMblnQ44KbDdh7i09qhHGRq5Axqt
         ef7Ij/tziKY/QQ55x69iuS/wccMVrcay+Gp3HJioxj2nRRJXeS/gF2FnWZipbO42nfy6
         KzxV0UY3i4C3Y17jQpsmpmfRLVggp903zy//kE1UT3xHuC/c8NndFAlkh97H+mlDKxyS
         u9MBMZSt+4AOZpPCl4GRfCDEkLVF/Ptg7WtC1qEDMDS/bQ7oGKSHlqW+oyQB7Yne1eiq
         /hXk4Q6vEWvVe0OB2O5D8O2SerYqHsaqctjIlzRqyKB4V0P+UVAKpUXp5JxHWH3dlkfS
         klVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692007865; x=1692612665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TcrCIKHTmaelivXm5tJOqwQfnbwJsTfWCqqVzifvaY=;
        b=jXxigt+4fwGxHwMJeBpk1r3BX6jy+/ba4g74U6I8G5UcqpEDZu21+BfagMvjbOMpx9
         1HY/5zBLo0Lf7eGjX6m8l9PJwXhoxZu0vp7F8Ao9uXn60DU0CHi/EAgkGAlDE0eg5R6D
         QXKOlQ8zFlL9IQBUl4YhcZvsbOHf6yoYVvagsVyZzCgp2NFQtWTsEjfM3YU2QXIwfbDz
         gMUx2pp/nuKhmJXU1JgyQrnNhIP/oqv0JDyUOakNPtHGPoWR2viSVM0FRlcr8QMXxNZp
         44a4Bveo4JzMjt2QEwTewJsrNLSWeYRoQ2RjNVmnTgWH2btWsOzQVp3yixMTy9hcI/Wo
         f/yg==
X-Gm-Message-State: AOJu0YwJHJ6XvbhvFWL+SaZ8NaaujJmDzgNczcn1N0OkXCsU5cfg3WOe
        P/iaLrYmNQ8JnUmDqWha34LJyw==
X-Google-Smtp-Source: AGHT+IHaKzKqwuHoAPI714LcqSkOGAT5pHN1eCF2DxjAZ0E9BhudZJYx+MSdCGmRUMJmBw9VrK3Qjg==
X-Received: by 2002:a7b:ce08:0:b0:3fe:19cf:93ca with SMTP id m8-20020a7bce08000000b003fe19cf93camr7297351wmc.8.1692007865250;
        Mon, 14 Aug 2023 03:11:05 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm16750396wmd.19.2023.08.14.03.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:11:04 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] clk: imx: add audio clock mux driver
Date:   Mon, 14 Aug 2023 13:10:03 +0300
Message-Id: <169200755845.527063.15808665958303223878.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1690260984-25744-1-git-send-email-shengjiu.wang@nxp.com>
References: <1690260984-25744-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 12:56:22 +0800, Shengjiu Wang wrote:
> The Audio Clock Mux (ACM) is a collection of control registers
> and multiplexers that are used to route the audio source clocks
> to the audio peripherals on i.MX8QXP, i.MX8QM, i.MX8DXL
> 
> Shengjiu Wang (2):
>   dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
>   clk: imx: imx8: add audio clock mux driver
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
      commit: a70cd8cdf7492006b547f46cc365eed79d331323
[2/2] clk: imx: imx8: add audio clock mux driver
      commit: d3a0946d7ac9ad844a196f0f2af696fde6b0728d

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
