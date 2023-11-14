Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A75B7EB37F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjKNP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKNP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:26:51 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E35124
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:26:48 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77891f362cfso474031685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699975607; x=1700580407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7F8QgjG6LQI/HDtH6YsJ8pzu6k42g4LGlXjrIxXLCg=;
        b=vd+Ic96Csx85sJu/M1HPsJIDkVkkZiDB5e7uauOUL+rFLjxmWH6BOGPBwhITNARXhP
         F7wcNagTf9xnBKXqnQnNsD2aJH5UxkpHGXoJs7PkE/CEM40b2Eh6/+YaQIn+MOLoTPQU
         MRjIpIYNfx3aQPrYeHurWL1u4rfh1o7sAvpZnsHvH6M81LOicWvJTUNbLeSZxLfWa4A0
         SXtAgLjAQnzUi4+yw+Fmo+A9A7lb1KIAHJ7lE5Laz4cBDEipVucyTYGp0VfVxcVXLRj5
         HAF64XvvEHn2uQuvC1n3PO/wjDi0nL0mhy3kwZXl6HbEUH48ikurAo+M3gQlfqKLaYRj
         sQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975607; x=1700580407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7F8QgjG6LQI/HDtH6YsJ8pzu6k42g4LGlXjrIxXLCg=;
        b=JBhskjVYPCzNAnJct4+hOUbhmdQcfMU5dM0Kj8XknMnmLZ4cxS6lc/pRw6hRPe3H8P
         mEyFFhxW7AuMeQTZVr5LPb8a6eq4biXY61AFcCFRqaxnFFaxpE+yfO2ts10VZlKwKIBm
         xyFPNKn0nFgJqZo7qFOSr4RapG2jaa/dHOV7t9kr9dhIUH3D2oS2ulM+lK9kui5T1657
         xicuhfv4bqH3QJYrPFXAVmdi3D0MljWCbo6QJhbmS+OjmJ6nhq4c/VO+3XM0fzWaFHZ4
         NC1OdGSNDH/UjHnRnZ+iWqdu+HtvyA5DUbbD5/Qv5K4oiHWItKPWC46SB7JImETQ4z2D
         II3w==
X-Gm-Message-State: AOJu0YxWT0AbRm0c80Wv4D3YnONWHwhocXlV6vhp1xtSxrEj5jjtlphj
        Kl8Q6KvNrzPIRsXcyk3cZ+PSkA==
X-Google-Smtp-Source: AGHT+IF0Wl1kVxFaBCj1GO4wI262SpQaQZD4Ao8J20Z3un2G8Y7PMNcnaECfZqEqkeoPrGFuvA2i3Q==
X-Received: by 2002:a05:620a:4712:b0:76e:f90d:85d1 with SMTP id bs18-20020a05620a471200b0076ef90d85d1mr4028598qkb.26.1699975607743;
        Tue, 14 Nov 2023 07:26:47 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a29c300b0076efaec147csm2716087qkp.45.2023.11.14.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:26:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231027040338.63088-1-jaewon02.kim@samsung.com>
References: <CGME20231027040435epcas2p4628f9c61d4622ed4c4b62edc4486e2d1@epcas2p4.samsung.com>
 <20231027040338.63088-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH] arm64: dts: exynos: add gpio-key node for
 exynosautov9-sadk
Message-Id: <169997560713.7305.9969596641933403889.b4-ty@linaro.org>
Date:   Tue, 14 Nov 2023 16:26:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Oct 2023 13:03:37 +0900, Jaewon Kim wrote:
> ExynosAutov9 SADK board has 3 keys to test external GPIO interrupt.
> To support this, add 3 gpio-key(Wakeup, Volume Down, Volume Up) node.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: add gpio-key node for exynosautov9-sadk
      https://git.kernel.org/krzk/linux/c/6479f40a10f773d712f645c3d7bc2ffd5904aa6c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

