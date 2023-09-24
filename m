Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19D37ACB8C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjIXTCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIXTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:02:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE5FF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405361bb93bso47807555e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695582138; x=1696186938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOPMhTAVaQhtNbRhJ+PsIxV5cVPsXuHbP91ZaQJ9gxo=;
        b=OBpY8IajXqjvblAPJgepPkmTMtVOU/C213xwLpDbTcxexyZ8BRYUAYZ8Cn6DEFLp/g
         niUA84jbFejBSB6kTg8re+ePcXC4IVbmU/A8cbiwrLVXYrHVK7qyiBcciNM21NIhDCh7
         A8usDycbJCyOGY0mH2SdMTDUNrOmLTROu2qxmW64jxgMmbkRjD+HrPiLOj+QlK/TyN2a
         ZhfJVuCwASDSDWvuRjyFpNDFPt4gMH7/UXFyr4udHDAKsbElhNCmWOJslrdeMNh0wgjT
         1ftQQKZz2K8S9J9nlshca30YZu0aaXUq754T1g4Q8IQGA8JQXRiRlnROEq9ycxptRBG4
         blTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695582138; x=1696186938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOPMhTAVaQhtNbRhJ+PsIxV5cVPsXuHbP91ZaQJ9gxo=;
        b=ViGJ2cEfE2IsJjTk9kwsGW4AGH/yXF54L2Fydaw4Or4SvwGONONBQVx0dzARMPcGVP
         tBEOi47AMQZBfTD+dhz7vP35n6TDn/Aze/F/9/jZo+v6Ni1UFSwxZVP1y3hbyi2xMSL8
         7Ibc8rGQuTTmKR6iwiS3y9+S558JEikxsnw4sTtOXNSyvQZ1POet37Ur8cRADcHjIZUD
         Wv6UhE7iZ4HAr8Hwh98je4IEaKoPD3yY/cOKNqF9BwJjAb/1t/aQj1tRyRpi6tnQEQpl
         GyDOTkevTaN30ryaGVM0o6CZ9grbLy/H4Aoa/9Yq4VPuS4LdoZ4P5VcvJRrXKym9q87j
         4HHg==
X-Gm-Message-State: AOJu0YxwHs2eIbKmPBzficRkZg1FV48b2YMM04GyTtPe94yQUgITcEkY
        AoLs5az4eVlVVmI+1IiSEMD1kQ==
X-Google-Smtp-Source: AGHT+IEmxC7DNK1cPKwojQo+bnnfYksQDd/asx+g1dwyv2MBdy9FaZoVjFzI/eTmc0DfjWHmagy58A==
X-Received: by 2002:a05:600c:2215:b0:402:e68f:888c with SMTP id z21-20020a05600c221500b00402e68f888cmr3730981wml.7.1695582137890;
        Sun, 24 Sep 2023 12:02:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm12980507wmh.35.2023.09.24.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:02:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: marvell: minor whitespace cleanup around '='
Date:   Sun, 24 Sep 2023 21:02:04 +0200
Message-Id: <169558197846.54884.8305462270796090104.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702185301.44505-1-krzysztof.kozlowski@linaro.org>
References: <20230702185301.44505-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 02 Jul 2023 20:53:01 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> 

Patches were waiting long enough on the lists. I assume there are no objections,
at least none were shared, and this just slipped through the cracks. I applied
to my tree for further soc pull request, but if anyone wants to take it
instead, let me know.

Applied, thanks!

[1/1] arm64: dts: marvell: minor whitespace cleanup around '='
      https://git.kernel.org/krzk/linux-dt/c/12ca3ca8cf06d803b3690ef523ccf5ffd0b23a71

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
