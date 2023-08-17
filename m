Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B1E77F5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350498AbjHQLum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350574AbjHQLuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:50:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD34B2684;
        Thu, 17 Aug 2023 04:50:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76d84238f01so9217685a.2;
        Thu, 17 Aug 2023 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273029; x=1692877829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ+Zsa4ZEmXdPvbwBr1YPTSACyU/1n0KQUOcgncJE3w=;
        b=HZzLgdBA/8SEH50ZDj3oHEfSFPvocgYVgAv3TuTxssfPb3/V0hh2OR1DIM66EfLcfa
         UsjSiTEaZaFFhTXX1vyZiQkrq6XmAO6RAYHIr6zdpHG3q3rcNi5pe30IMjGet3b6rhQT
         3S2dXX++c+KVUybFLXY48nq11UI1IM0xiJMFUoa6wLIr4FEap6oUSgPS3ey6UorOrVn4
         6N+NP5pwhNx1Q3n+fkuVVr+Wyvu3YLHZ0O6he9h9/4l8XR7K71XLGptWppEIqIIYtX5W
         AZSdhcvTaX6ZFP5TPnYCRMAgupPqC+b531pzr9911ZikH6L1SDIJZzKqzx1OXvdBqcWN
         fZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273029; x=1692877829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ+Zsa4ZEmXdPvbwBr1YPTSACyU/1n0KQUOcgncJE3w=;
        b=IOeDavWKwBi8zdNbazhi5c0cTxg5qNK7TWyWlSr6dCWo+tQhHLhshSil/ZhNPcnCSg
         A1a0mQrk0ldyZlgkrBmAeMUQmjBWmBl9L27hLrYDbTydjRtiN1oLkcD7rrCL8wJRWIVM
         LYGIDsWJHTd/1/oRttnuYkQUgfu+HpZccoRK593lTuKmqFhL6fmeolkg1UrQmEDVV/+9
         O4Y67YhyYXSIA4Co0rU19tBahoz+e/LLoDVRFQ5C7Li+CI4jtmw68hzA9251VmLdBZq3
         5l6hZOLNU3xfnEfpnPWjGDUZESDrR8pZm5lRbPAFuimxtHDhS1H5GOPSjB+NE2sZPlmg
         nCrA==
X-Gm-Message-State: AOJu0Yyt3CeAOq9xWywLzeOdzeMethfXW618dofxfreGGYwgmRexoqNd
        S510uAc0pZ9Bg0JSxuUHsAjDpXrP7vQ=
X-Google-Smtp-Source: AGHT+IFbiQSKDSe4gTLJ2bWwz6IBwKBkogxP7lD8diDOPyUlxXuZx7qBz9naiNHemQYMcPnCfjJYFQ==
X-Received: by 2002:a05:620a:2986:b0:76c:b8b0:769d with SMTP id r6-20020a05620a298600b0076cb8b0769dmr6603385qkp.39.1692273029121;
        Thu, 17 Aug 2023 04:50:29 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b0040ff387de83sm5142149qtn.45.2023.08.17.04.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 04:50:28 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/4] arch/powerpc/configs/*_defconfig cleanup
Date:   Thu, 17 Aug 2023 07:50:14 -0400
Message-ID: <20230817115017.35663-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230817115017.35663-1-twoerner@gmail.com>
References: <20230817115017.35663-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CONFIG_IP_NF_TARGET_CLUSTERIP as it was removed in commit 9db5d918e2c0
("netfilter: ip_tables: remove clusterip target").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 1034aeabdd6c..eaf3273372a9 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -183,7 +183,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-- 
2.41.0.327.gaa9166bcc0ba

