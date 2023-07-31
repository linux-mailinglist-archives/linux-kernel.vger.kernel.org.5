Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F362376923A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGaJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGaJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F6198A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso48114135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796822; x=1691401622;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxDsWVGn8/NwuT4OxCGgs3WFSadNfLfmBL1C6HxSVLg=;
        b=jP8t+EmdY/W4O3SmujOD845Q+ns9HxWJCNeYGg0MI3+yjrJK+5A3PYQ+0hTBw/kKuP
         6+je4MniZC0iq4binVCA6cfnBZ5+Odauwh1Z8UkXpqBUKDgouhXgBMK4ORM5egpPTLMP
         6wp8Uv8EduZXsZM3yR+yOGFh4T3NosJHzS8ZJORXddie58lS92dD0KUCEzzo+ZBOacuq
         FaCIU7G+GRR8BU9u2bMbzm5o6qstrsNPJKyICOQPCSX8DeeOdqRAbAeWaIjT1/XQod2y
         rrmlnfKb0kmsRwzbIONoeq02MaSfkac6ogTJBXZYw5Wp8XS1THsJqIRwM3IWb9LL0qiK
         u6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796822; x=1691401622;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxDsWVGn8/NwuT4OxCGgs3WFSadNfLfmBL1C6HxSVLg=;
        b=ZuuIFWkLdciIISpgQ/a97FiqncQEA5/SpVQESFj0XnZQY3NWunWzK+WQGODkIgiGa+
         snLDM3AZ/BwkHKh6Wt3/I2hAimZgp+DNj20R6srDXrooHTXf3Nf+Sz/7DtwqDmDN6PIV
         P77/TJftd2pzqvaSnSe1flq6b9KUcFUAy1dxj+jpvz9UMPLdkWP523ADzuFWoYM4hZtI
         0NEL2QsdkxgCVQyJyd93xZvGiZ0fQeijpmuepeHt3iYj3W30dr3yPZd/Oo0dUN/Lvfao
         xGfJi5c+qDxxkbh2U1MRO6Q5kNWl3tfdPyLHgwKOsPWg2gm+7f41RO9okz05cpijvzpA
         muUQ==
X-Gm-Message-State: ABy/qLZ+b2PdQ7gcnyhNd9OzxEBfofoCPMPvSAF+hpXCll8rRD8IupoH
        BxTZkpzrSfzFJUHZWGmW/HztiA==
X-Google-Smtp-Source: APBJJlFuGlL1NmqvGsLXjELI7YezZ6XW63R0SDXpX2GfbbX/iyB7Bw3CNl7zqXYoOtUVkfT80ZwTgA==
X-Received: by 2002:adf:f7d1:0:b0:317:61d8:3c7e with SMTP id a17-20020adff7d1000000b0031761d83c7emr8833827wrq.26.1690796822234;
        Mon, 31 Jul 2023 02:47:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm12556878wrs.53.2023.07.31.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:47:01 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230720114639.833436-1-huqiang.qin@amlogic.com>
References: <20230720114639.833436-1-huqiang.qin@amlogic.com>
Subject: Re: [PATCH V2] arm64: dts: Add gpio_intc node and pinctrl node for
 Amlogic C3 SoCs
Message-Id: <169079682106.186625.3975138620226263746.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:47:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Jul 2023 19:46:39 +0800, Huqiang Qin wrote:
> Add gpio interrupt controller device and pinctrl device.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[1/1] arm64: dts: Add gpio_intc node and pinctrl node for Amlogic C3 SoCs
      https://git.kernel.org/amlogic/c/cac34b2b3f5a9d4471a2660ec52599b6015bfc51

These changes has been applied on the intermediate git tree [1].

The v6.6/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

