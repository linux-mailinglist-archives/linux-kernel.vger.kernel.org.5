Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8678927D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjHYXms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjHYXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:42:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4228173F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:42:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cb845f2f2so20780327b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693006928; x=1693611728;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xTd0pTstiRhUDqJtUofYBE2z2kJSDJQFF7iReicbrQU=;
        b=w1XqNyk/ALuiHYSKx5SAcadeYRAt6KoXfOM7Okj4w1lIGsPMQkl6gB2f35knvkvSK7
         Km7S7WJZQz4X5Erj6IqLtnwv6m29CmCNZzwM7HjnWGC7XRErP44Zfp8z2ofOdfTrfCSM
         j2TfEkeADl78CLBwEnLVGva2JM3XMLpz8SElwIsNnbYpj+4xD7O3ov88QJ6RjB1Xcnv5
         fL8Hyc+sOgGBFYxmugAKuusuFpaeTcvrxgBho/Mw91KFvau9spK8Cpy3QlvUtIAUV4X3
         0mkLx0Qm1TB9+M6B2nveUo4JAms6gzoyjDsR4gNnETsmb2Oft/K7SYMCgS/tPqPFmfY8
         hgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006928; x=1693611728;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTd0pTstiRhUDqJtUofYBE2z2kJSDJQFF7iReicbrQU=;
        b=eW3ECUuQFSwvp7GS4/yYttWTUZ8bAI3FzezV8z5mT7Jk2ffGI0QsL00BPbu24tEn/V
         r9SGOeu1v3FzpH0+9Ico+Xceny4SHwOjIlo7S2zZBbZA5VNP1VbFjjsAKratY3VbSs0k
         8EcmnL3ZVRunwXgc4n+fyDrsoeKNaxyjznSvyn0FwH8SJbo1sWSUwZqzptxg+CQe+4eH
         vXPe0BhHoNcutcj98K1d22Hsq9EERw0t5BBLH7irJa/S5b+oywGS9tQ+xZ/zF532EbBX
         QkYP5qDqlFKmIozPrLRoaPeOONawhhJyU7IKbUeJjhyEa/2wqXLreTc+0qTgNSp3CBg+
         Pg5g==
X-Gm-Message-State: AOJu0YzXpcCV6YSwmZMciDwNCiHhf9PCH633H6JsqA4AwPm41ZrZ1Fd4
        5cDS/qQKo5Ch7WBjCX0cLVFi018wQw==
X-Google-Smtp-Source: AGHT+IFO9IwsKgSvW6JTlPKE1WHMEGqy2Fd3gU8oqRIPyjU7f91FtzhTIL0hbuq5iATjJo939fCjkcsy9Ls=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:4739:860d:b144:6102])
 (user=yabinc job=sendgmr) by 2002:a81:ae41:0:b0:565:9e73:f937 with SMTP id
 g1-20020a81ae41000000b005659e73f937mr503711ywk.4.1693006928162; Fri, 25 Aug
 2023 16:42:08 -0700 (PDT)
Date:   Fri, 25 Aug 2023 16:42:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230825234204.1885083-1-yabinc@google.com>
Subject: [PATCH] coresight: ete: Enable iomem access
From:   Yabin Cui <yabinc@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices, sysreg access to ETE may be disabled, while
iomem access is still usable.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7e307022303a..de14aa55af63 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1079,8 +1079,9 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 	 * with MMIO. But we cannot touch the OSLK until we are
 	 * sure this is an ETM. So rely only on the TRCDEVARCH.
 	 */
-	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH) {
-		pr_warn_once("TRCDEVARCH doesn't match ETMv4 architecture\n");
+	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH &&
+		(devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETE_ARCH) {
+		pr_warn_once("TRCDEVARCH doesn't match ETMv4/ETE architecture\n");
 		return false;
 	}
 
-- 
2.42.0.rc1.204.g551eb34607-goog

