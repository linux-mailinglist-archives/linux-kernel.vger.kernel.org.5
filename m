Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729F37ACB89
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjIXTCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIXTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:02:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CBCE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405361bb93bso47807425e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695582136; x=1696186936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUzOQBeCN4IpbMK/sHUfcetB/ZJh3VTgOU3FNKUFPZc=;
        b=UP7pFHFaZzK/RJD1Ts7yD/WHBoTud6Ckl2qmM4N2D1OnHW7w9P50UYCSBYbRpcn3Bw
         IF6fH/eTvSKu2lduv+fGAHeiovCVMlYBfeJBkSTfWizZTRzMrY0SX2bcsM503CRSaQ9J
         ajpdlEJL7MYfCokw8O9skqzPCIWFucMLCp5QAi33BrI+ASC2CtDHHwN1I81zYzmIQBEZ
         0niCFoF5TilHqyD5GV1CPRwMlNxp7pXkaXdn7W0pCXoxPrbrstE4sNiPal4nJnco6GOJ
         V9CIoRleQ8Yg1IHnw4/ywZaOKiWc0uFdxGb2H4FGbTiS2McJcVe0aqlATKviOtBNP2Lj
         /GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695582136; x=1696186936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUzOQBeCN4IpbMK/sHUfcetB/ZJh3VTgOU3FNKUFPZc=;
        b=mBK6eqaBjmZs23yaZGcoXdrAUFNXoqKV79GtIsyHVE6I7LOFNwv2FLL56OybE0z/fQ
         qAq4OMfdL/7ikEJ1+LcaHhnOwsqnbXx7Zdgq2kEQyHqA9xywgnF1+72nZCgbNOTqfF4M
         vjiTTDKCverIB6wTqhwcOknEsQBisaV9cAyFrz5aLLVh0aP1Xiw6Rl+GCnTtyD+bo6zT
         4VkwqGR0Cdr7CGnHzJvis3MMDSym4HaFGCXaFo8GC+wBqqHUPf7fNAnSpz9+CMSXiya6
         8MmaSHhSfPbcEc0iAKo+aqRsSVVpRh9PUZVr2hFTJwBOnYNGe2qiMuDa0ZQdeLRCa4Rt
         QqVw==
X-Gm-Message-State: AOJu0YxErQ3+Fwccgv7IOkXIwPNGSSp2URYnoX51/FOT6X9rUt0pc1ZY
        OUcQunaypTYUwuzvE1YXDKiaUQ==
X-Google-Smtp-Source: AGHT+IE0W/VyhNcb5eTQUWd45FjQDZrEaC8N1D0ehhWMDrCyWxbqXd7bkOhDt4WSM5K8sLPL9ecc5Q==
X-Received: by 2002:a7b:cd07:0:b0:401:c52c:5ed9 with SMTP id f7-20020a7bcd07000000b00401c52c5ed9mr3923561wmj.32.1695582136635;
        Sun, 24 Sep 2023 12:02:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm12980507wmh.35.2023.09.24.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:02:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: bitmain: lowercase unit addresses
Date:   Sun, 24 Sep 2023 21:02:03 +0200
Message-Id: <169558197843.54884.11610729516749489406.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712074611.35952-1-krzysztof.kozlowski@linaro.org>
References: <20230712074611.35952-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 12 Jul 2023 09:46:11 +0200, Krzysztof Kozlowski wrote:
> Unit addresses are expected to be lower case.  Pointed also by W=1
> builds:
> 
>   Warning (simple_bus_reg): /soc/serial@5801A000: simple-bus unit address format error, expected "5801a000"
> 
> 

Patches were waiting long enough on the lists. I assume there are no objections,
at least none were shared, and this just slipped through the cracks. I applied
to my tree for further soc pull request, but if anyone wants to take it
instead, let me know.

Applied, thanks!

[1/1] arm64: dts: bitmain: lowercase unit addresses
      https://git.kernel.org/krzk/linux-dt/c/0b137caaaab462debb1cd342cdc0df307e301bfc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
