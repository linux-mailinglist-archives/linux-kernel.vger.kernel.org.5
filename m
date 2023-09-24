Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9197ACB87
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjIXTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjIXTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:02:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42F100
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401187f8071so35133785e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695582135; x=1696186935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkF7JgVYNaY5OfViOj6lUqtAlSrtAIr1kCOY4nY7GD0=;
        b=Y1GgWnz7gOJ126NUP7iyeG6mQlwLczFe4/W2XBdGOhPh0AGimZ3tVFq3wY918MgAm5
         TZhiXestE8mZi6PXgk9bFJYoEApA7p/AXkWpNrmgzuKo7hA5cNELCC2pdPVkevAzlhlA
         As4DsePH7Q8lZJHL1amdLDaYWS8lenphj1ROnl6t5dBP2YCR3gcyRUFUinAVl/MJD8ct
         WPluLcN4N13jAdzda62ZXH2wBjpWVcBGnn5uZjECdYetn1K14OsFgU1WmqTYx+uJQroM
         FHGwsUYHxMNrdMOMQ+6Rm8TEoy5GKKoidulN/h9X8ribKuxf7SivT/3VvCEARLC5qqai
         kOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695582135; x=1696186935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkF7JgVYNaY5OfViOj6lUqtAlSrtAIr1kCOY4nY7GD0=;
        b=bW3BySN19/UFHuDWgQkqokX6H9FEm4E0dGQejJsvpGY2bHVVOik0Hvu1eRXruT6s6E
         OwQJAgWEL84mq2W5ScAsy+FrQTFEkpfEON0Quc1P/FnUjlGKuoCjWjqiGi6cHbDJ0+uy
         BCmRtTdqwu5qL21sOOp0PcKPizcO0++oFdBwGGwhBc3OsDj5N4Icte92b2dgTPBJEyRE
         cicHTou4B735u6ptXBFwF8QHjKESwTzBxGs44lfL/Jhd017jqdjEFtPngbJYApH3m6Ua
         YX8fSkx4BLPMWWg8/2eqyRreMQhJcUWkF9Xj5yvOoyxrK68YxecLX7myRO+qjuo7SH+7
         1pdw==
X-Gm-Message-State: AOJu0YwjNmWLj2Hgwr4TptRcWVRwX2R089XxXcj2s8oH3kMR7CUgGHhE
        Up6Pb2HaUxigafbAU9hXHmAs0u3RNMyRrzYZu08=
X-Google-Smtp-Source: AGHT+IE1uI85L56oHH3QPSVU9vJPlnkEum73fpvA3cHNbJ8go10pyPAVzK9pV7nUNt+Ki07fuKSNvw==
X-Received: by 2002:a05:600c:364b:b0:3fe:d67d:5040 with SMTP id y11-20020a05600c364b00b003fed67d5040mr6265372wmq.5.1695582135387;
        Sun, 24 Sep 2023 12:02:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm12980507wmh.35.2023.09.24.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:02:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: apm: add missing space before {
Date:   Sun, 24 Sep 2023 21:02:02 +0200
Message-Id: <169558197844.54884.8026582954120562930.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705145934.293487-1-krzysztof.kozlowski@linaro.org>
References: <20230705145934.293487-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 05 Jul 2023 16:59:34 +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> 

Patches were waiting long enough on the lists. I assume there are no objections,
at least none were shared, and this just slipped through the cracks. I applied
to my tree for further soc pull request, but if anyone wants to take it
instead, let me know.

Applied, thanks!

[1/1] arm64: dts: apm: add missing space before {
      https://git.kernel.org/krzk/linux-dt/c/05521ef09891dfd0e0dbc0b37fcca0f15174e60e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
