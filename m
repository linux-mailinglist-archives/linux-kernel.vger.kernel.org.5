Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5C7EE7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjKPTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKPTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:47:49 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4018D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:47:46 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7789aed0e46so72615785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700164065; x=1700768865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqcesqxyA1kvv/2F1OC3bKoVHXvqMNvAFBsyB+TI29o=;
        b=mhFZafV8jFXeupGptU28yorqMjSpiVhm8neJ2md6bbmPtoOBD4YocjycJET4AxsB3j
         v8QfsF+yFnKtfIwGr6LPHXiXgd8gbA3eGQq2gpKepysDkjjTEaaqf0cyfrWo8cynMRxK
         07Ocb5xqThhiPnpZa6CZUam90Ws/p9HgSEgNwQSXT7yKFpNV8LL8eSG/QcMAxnIOqUbZ
         ThdgLffeuPkySVULd0fE8WyVJqc2kLQ1SG8IvIhNw6uNbodkhnZJ5k0XboXg82RLaaDt
         1llYptTrViQiq9vhuzZDoHTl6TmY2xS/28bz/WyZ6rK67DTIdL9DUnW0klfvBNasXRf4
         83fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700164065; x=1700768865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqcesqxyA1kvv/2F1OC3bKoVHXvqMNvAFBsyB+TI29o=;
        b=KP2orS3f2yYN1VZyDE9xqeqnNhTUfy9riS5Nf9KfsCs5yr+m5SOko2ix5oEpWIFYF7
         /n/pfoCQrj6bpfDe1ENQomYBhkGY/7wPvAxxlR79eGAa7+6hdAaIkPs00BmveMO7n8Xa
         m9D7K3zbo+cux+Z336agZdSTRB+h3ZTGvFfV291ibSQtuExM4ENgPBSZ+uKfIrQuPIH4
         FaaacUCYfEygJGSP72HUMavC9OaXnNzIrXM3JuU5LWAzymBVh71VH84mzQ08UmCgQT3B
         ArHhkEU8wcmc04NF+cmW3oXTFpSekRNkwVD5JRiOlRCN7YFCbNQExmgfoJLLgEfLkYB7
         oVQQ==
X-Gm-Message-State: AOJu0Yyaafd7zV3D78S7hiIqwQ+6Yk1duJX3ikvKjOMlwhjZ/kzo8mba
        d6P4KnccQC1UsNXCcdt37LZ8yg==
X-Google-Smtp-Source: AGHT+IFGH/x/U3OVzPeKPDeRzZhWFEyT6GgnBwC+lO7YN4EHBBv6PZlzNnKZQsrVteq/CgcE7ugjuA==
X-Received: by 2002:a0c:e607:0:b0:658:49bb:f78f with SMTP id z7-20020a0ce607000000b0065849bbf78fmr10696124qvm.39.1700164065517;
        Thu, 16 Nov 2023 11:47:45 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.169])
        by smtp.gmail.com with ESMTPSA id j2-20020ad453a2000000b0066d32666a20sm26982qvv.71.2023.11.16.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:47:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: samsung: Fix kernel-doc comments
Date:   Thu, 16 Nov 2023 20:47:41 +0100
Message-Id: <170016405832.24538.746351880812245666.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109190925.2066-1-semen.protsenko@linaro.org>
References: <20231109190925.2066-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Nov 2023 13:09:24 -0600, Sam Protsenko wrote:
> Fix some issues found in kernel-doc comments in Samsung CCF framework.
> It makes scripts/kernel-doc happy, which can be checked with:
> 
>     $ find drivers/clk/samsung/ -name '*.[ch]' -exec \
>       scripts/kernel-doc -v -none {} \;
> 
> 
> [...]

Applied, thanks!

[1/2] clk: samsung: Fix kernel-doc comments
      https://git.kernel.org/krzk/linux/c/d1d53909bb5fbc9bf618ab78515fdbd5d6b691c6
[2/2] clk: samsung: Improve kernel-doc comments
      https://git.kernel.org/krzk/linux/c/5583e92be5c45448e6ea461e1780d46c17d14963

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
