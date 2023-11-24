Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAB7F70B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjKXKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:02:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A6B1B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:02:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54aecf9270fso710190a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1700820165; x=1701424965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5csYTmQGy3z4bAN0r6APXLt4Snp34nfDUTEQWBMPna8=;
        b=eT6N0vV/25xW0STSQSwWJZJcribg6eck6GHIB2CYleCPMMT2cvL/mymnnf793gS/oC
         /KELBbjFxEb0weamm5hVYuzF7Xf5IrzuZkYDphZJnjO+4jyhY1VzotjDE625vpHc3TNY
         0IAGRt5Hw3Y941QaG7UbdX9GiQ2KlfAllM8ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820165; x=1701424965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5csYTmQGy3z4bAN0r6APXLt4Snp34nfDUTEQWBMPna8=;
        b=c+IxOHmukuEYOKtULVDqRyR97f30/R/RELf6kghEyw6GSFFDhCEssJujcu0LsXb4D6
         mzZOhGZKCSOOUiRMawoHoLjWiOKvDzcGRTmEOBnHujZIYl4/f4HX5l3nAYDK33sIRn4w
         ksHHOcVNXxfe5IqJsqFxtqesSQEaJyV77cIxfeNcn3emWB0uekr13L6m5XuxP0Yyf0Rn
         knYRWVNGd7yhzC6dBSZwaqBA/uxqV3qlHcFcuw4bon3+fjBCs/DDeClCbWuXmlHLtpmN
         24vNZ54DmQ/C73+GaMsFPRQG9XUfOEJnmOtdkPo1GAVoJpFSkiDZqWjAagkfdBCNOmxx
         nBVw==
X-Gm-Message-State: AOJu0YxlkIQ/PG6Y8hm7fPnp73W++BNxg5ESkuzCXHr5rVkH7QqI45cI
        buDCImgyr7pDAQDE8xJFtuvS6D1bzNHz0js49Z9QpA==
X-Google-Smtp-Source: AGHT+IEQhr8vTHKYV1CC4+1sE3VpHU6n5sVo3sIi2W3tqIz7X8brK06exgxjIqL9O1SqVQ9+tr1wgw==
X-Received: by 2002:a17:906:3a87:b0:a03:24d9:12ce with SMTP id y7-20020a1709063a8700b00a0324d912cemr1665021ejd.63.1700820165499;
        Fri, 24 Nov 2023 02:02:45 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:7c18:b9c9:f303:f6bb])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b00a0290da4a50sm1863015ejb.186.2023.11.24.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:02:44 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>, Scott Wood <oss@buserror.net>,
        Timur Tabi <timur@freescale.com>,
        Zhicheng Fan <b32736@freescale.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix typo in code comment
Date:   Fri, 24 Nov 2023 11:02:37 +0100
Message-ID: <20231124100241.660374-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/singals/signals/

Fixes: 04e358d896a7 ("powerpc/85xx: Add Quicc Engine support for p1025rdb")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index ec9f60fbebc7..e0cec670d8db 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -76,7 +76,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 			/* P1025 has pins muxed for QE and other functions. To
 			* enable QE UEC mode, we need to set bit QE0 for UCC1
 			* in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
-			* and QE12 for QE MII management singals in PMUXCR
+			* and QE12 for QE MII management signals in PMUXCR
 			* register.
 			*/
 				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
-- 
2.42.0

