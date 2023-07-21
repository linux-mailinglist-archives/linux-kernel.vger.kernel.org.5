Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D075C71B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGUMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjGUMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:47:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3B3A84
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:47:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8ad907ba4so11519585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689943633; x=1690548433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4/eRoqwSAGdi8LJemKHI/V1OYM9+swXufBrZM0hUXk=;
        b=yFN3/VyHs01yi924BoKQA3rrgUaD/Hl40Ot0j1gpDRx8j29mKVke8EQvqAdLCaQK4M
         6f/l8ErfCvpGw5LQz/pZ3hjukF7r4W5iVON++Vf79UYo0WmTMnAYbYiGEycqWmdA12ex
         TciPBsADja5tXbs8y9Uz4bmZ6M34xoiPNRlaF/Wyhku9Dpx5XcuSndO5MIyTelSDWo7m
         spITXGKc6NN1OMKi7e+1/XE78Lstba3baS5pBazCY6r8aa2wCN3jPKZMNhWZo3GnhTCf
         QNhdJWhkXOmC7Cpyj8PoynwM48Px4H3uYHPxtug+Cc/QpumNbJ52USlirX5bijsDp2Bn
         jpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943633; x=1690548433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4/eRoqwSAGdi8LJemKHI/V1OYM9+swXufBrZM0hUXk=;
        b=ceFDLzazaNMqQXP/IB7aulBTQtZ5xreG9RHTQ2Ik/8rJdXDBoVBrNSVsb5O1vkOE6S
         Sb06FqSHhYheGgtFAT/GVjfE4wK/H7/CZ7slxkOYJMm1HbhIEhjPPxhe0SIpGj4YHhHC
         4h7ypdCd3fpBjBSLDet1I2bjaHsy89Ud2PKDagTSiHmEqrtO5Gnrdm3pfwKE1K77HL6O
         12cHSuKquu1PmDIIjxHHIbZn8yBvBf/2N13sn+NyY9Wvg1MRBCbX/D5FWy2T91yt6RkM
         jMsvawUzmgirD9cO9bkkAEvGMAELL5KSxGpmuuWs8C8Z9IRLC6urYIYLM+OpMwu7nKXH
         hicQ==
X-Gm-Message-State: ABy/qLYJ+6Qb5ZQp5GTLVAkIHjUPflAoiryHseqHS7eIyUxBviGTG1ay
        POut+thG1/O85671m4m+ghqzC/SLJEH0jPxxBg==
X-Google-Smtp-Source: APBJJlEVBYU2bNbC3uokjbALDALmMS2/XNNHqv6ry6lL/rTHYP0iAZpZI/LXnzDkoB4IkkGjt0gAsA==
X-Received: by 2002:a17:903:110c:b0:1b8:525a:f685 with SMTP id n12-20020a170903110c00b001b8525af685mr1631050plh.37.1689943633295;
        Fri, 21 Jul 2023 05:47:13 -0700 (PDT)
Received: from localhost.localdomain ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001b8b2fb52d4sm3369828plb.203.2023.07.21.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:47:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
Date:   Fri, 21 Jul 2023 18:16:34 +0530
Message-Id: <20230721124634.63612-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
References: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dev_pm_domain_attach_by_name() returns NULL, then 0 will be passed to
PTR_ERR() as reported by the smatch warning below:

drivers/opp/core.c:2456 _opp_attach_genpd() warn: passing zero to 'PTR_ERR'

Fix it by checking for the non-NULL virt_dev pointer before passing it to
PTR_ERR. Otherwise return -ENODEV.

Fixes: 4ea9496cbc95 ("opp: Fix error check in dev_pm_opp_attach_genpd()")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 98633ccd170a..ae359ed6a161 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2377,7 +2377,7 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
 		if (IS_ERR_OR_NULL(virt_dev)) {
-			ret = PTR_ERR(virt_dev) ? : -ENODEV;
+			ret = virt_dev ? PTR_ERR(virt_dev) : -ENODEV;
 			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
 			goto err;
 		}
-- 
2.25.1

