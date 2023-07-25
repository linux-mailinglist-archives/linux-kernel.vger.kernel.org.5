Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702F0760CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjGYIXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGYIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:23:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9310C8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:23:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3159d75606dso3845710f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690273414; x=1690878214;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3YuZbvg+OCFvU708D8FTuMOoHLfL1FWWTkGies6dD4=;
        b=D5mUngfDo2XKTj+Uz9oI22nFW53r8sWy7Q+Neh3296NMM1y/QSgHNGBXEw9EbTG2TT
         113et3GlxvlHdwFC170J53xGnpBn8ObwmMnWcq1vXXHYwnu8Fur69qKowjlFTBDDw0cZ
         PywvuH1vfqW8PMhoiL5dUPMsQ0vWJgFyA8LmQOSvCIY1f8MA8BI7opkqHcj0MYISS7Ew
         7Y9pxOM3IhFNgWpcMxElMWYf6COTnIGCMiz78b5GSjGwFg+FM6ePE00o8yCH9gCqnP2w
         TFq4yc4vMv+JZR17EnKJv1gV25ZHtxkZpdTOwEpTOshUqwWhoKZU7+ndxXo3LOkQh5e6
         N06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273414; x=1690878214;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3YuZbvg+OCFvU708D8FTuMOoHLfL1FWWTkGies6dD4=;
        b=Z/lVe10VwkQUF4QGrsW3vBzMyVg2bLSGFCVGW+UGBffgJlCOJT040WIfNYeUnuNIcI
         7+nXo0Df2hCqRBAYucNxBOy//zosPLeoQ7YFAXux6ptENwugZ16ibflE0Ugyo8Fy5sKQ
         JuSr6kOvv9I/RBVVnJ47VetZpD1lBvQNYiA66lO3PjwxFI5VUfRGU3bDwuEHHm2h1cMV
         LtfRtPtakusYxOaiDZPRJ4KV2ede1buMhQTKv44qFimgdiNeXLijA9/dqs7ppkr8KJju
         LDIORXjSNx/ejD055LnkKr2DqUshfmZuaRemfhOa2CHacnXBQmoQ1ayBsGRKgtgG1Eze
         wg0w==
X-Gm-Message-State: ABy/qLajRUmje7ZShlr01KRbAmahS6U7UCeYY3LbOKBRMWP7H2Y4TZNv
        WpDvmT8yG1D6Ox9aCIWPbQ7ekZOrWw7Fw8g+VkQ=
X-Google-Smtp-Source: APBJJlGzN2HplLtgv5Bdm/Cp2oTxtskZITNmsTRd7cf9Gf9BvTF2MGF8gF3zSDm4d3YkaRH1/OCCRA==
X-Received: by 2002:adf:eed1:0:b0:315:9021:6dc3 with SMTP id a17-20020adfeed1000000b0031590216dc3mr8448722wrp.27.1690273414237;
        Tue, 25 Jul 2023 01:23:34 -0700 (PDT)
Received: from [127.0.1.1] ([82.78.74.213])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b003141e629cb6sm15502308wro.101.2023.07.25.01.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:23:32 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <ac8bd50c41b84f244bb0ec94e8aed25c513c9037.1688760152.git.christophe.jaillet@wanadoo.fr>
References: <ac8bd50c41b84f244bb0ec94e8aed25c513c9037.1688760152.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: imx: clk-gpr-mux: Simplify .determine_rate()
Message-Id: <169027341205.2409621.151301055489452408.b4-ty@linaro.org>
Date:   Tue, 25 Jul 2023 11:23:32 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 22:02:48 +0200, Christophe JAILLET wrote:
> imx_clk_gpr_mux_determine_rate() is the same as __clk_mux_determine_rate(),
> so use the latter to save some LoC.
> 
> 

Applied, thanks!

[1/1] clk: imx: clk-gpr-mux: Simplify .determine_rate()
      commit: 2deed4cda3b76bcb8be2533f5bd07803b1bfa452

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

