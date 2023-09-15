Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C257A279C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbjIOUEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIOUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:04:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762A211E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:04:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb2e9ebcdso2112185b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808249; x=1695413049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsjobygTJTSQG68McAspsAEHf2Z4NWVTVTdDWk+Khno=;
        b=KoTE1quKYXTxUzzR2DMXFf/VWipLYTTHWXcfGX80N2k/ae/kNjorndOs6pxEim+F03
         Mfjz/qpjjsfeZjgmLxFAFz94ZxHf6hJVvLaSMZIcmD1+lmIuKVx4vRssWYVySNmtRYd8
         1l/kZ12MEperk6cF9QP0NWNVma1kccQE6q2WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808249; x=1695413049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsjobygTJTSQG68McAspsAEHf2Z4NWVTVTdDWk+Khno=;
        b=RfRUKWMd8PmlUw3C8W7uyVRf7jdtR8fUfliIiHvIsjmZ4CcopuClumMS4xrAkw3Bcg
         fMQPBXyAnMq5gc0FUQA0DWPs6usmIXQjDoe3K4oRp5ZSuyRBZvlykVUrt8ciNiPt0nGM
         BapCGlO6Gm0JsgbAIDk1U4OQ1mpvGYBE19BvE9KSvhd5bSKHV8m+z4/apavh76HG6Kw4
         9HX96zuGTc149Bc4O4h5NRQM99XG47zvwIViE1Z0VVnN0lbSHis6iqYPC+a1uqgMLK92
         oGPbVuTAOrAPAC8/UpcN/FH6dpjo1eCx9yiLASzbLWkFsWvWS4kzii9RfZw9mcfiGAUj
         egeg==
X-Gm-Message-State: AOJu0YwaV4YJp1NCt5UZk9pe8RSCZi7jX6NK0hyiZaAyH5tWP53P3MvD
        xxmO5/8cy4FhU23zr68ru776WQ==
X-Google-Smtp-Source: AGHT+IH4sLF8pnQUwMmvWkR2rN5ygHn9iSUnz/1ZVPT8sYwTtd14gWeZ3e+qyvEyDiGNHRPzG6Rx1Q==
X-Received: by 2002:a05:6a00:1882:b0:68b:f3a4:ff6b with SMTP id x2-20020a056a00188200b0068bf3a4ff6bmr3034695pfh.9.1694808249669;
        Fri, 15 Sep 2023 13:04:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0067b643b814csm3342707pfo.6.2023.09.15.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:04:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] dm: Annotate struct dm_bio_prison with __counted_by
Date:   Fri, 15 Sep 2023 13:04:08 -0700
Message-Id: <20230915200407.never.611-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VvKOCdO6PY/NRn1of9dfjjBTN1ZCPOIIRKyzCXPi3Xs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLi3mSrPQ2k1ngorCbl4cZDSbvlJ0xPRobTs8
 GueuwSV7kWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4twAKCRCJcvTf3G3A
 JtYGEACyVAHf3GVlw2Xkm6VuFB0xT82MYq4INcuJ+itoZaCrenWb3tCwhY+fkcq72HKGx/1b+Pv
 OErce1wHcbokBfk0DlDKQjpwTDQ30Gf5+HVA0pmgtzw+RCZpIaLZJlOwEEQCpEPlny0qSUK0yaI
 a1yOASH1d+H1/d9KHywGNJM163u97BQe/p66EQPbo3zI5lr9hfB3USLebN3whqkMloLEf/C/YKx
 mQhVgPhBYsk4XQDWg2qaUl/tPWEreLsObc5Ph5PPVD6lGYBAthn5H4yEqa5aL1Oi1Dcd+k0lmPm
 /otgAB97W1ZqTCSLxt53qsC/0r7xDwRZjAvSAkr9syY7RXz/3ALTkIhufMhLlhyrhWO/GyqE1QT
 lb1UTLNeBeXKoaEkiUartdD4xgOObsF3xCEyX5gIvcSVORT+kGYdd7JcsReF/6zy6db+bj22DwY
 2BEEgGV673w8FiKlgNdKvDLTeSO7JXALYRZAXEA9acesISfNFIXsG0nVje0xKQddBijW1EvXBdG
 H3BJrXpWLA6sppNr8YNdgcYczeF1AsmcHZbr1bjN/p4XGobHkFcsET0KbH1xxp2g2FQfJB0Bfvp
 xT8heKvTGaxyjqe3dVxh3q0znd6p8eHowg2vMIMMimkErAmjMwbC/7t3mSopit/jjHuI7TiZG1g
 iseMwLp rJU4WzBg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct dm_bio_prison.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-bio-prison-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-bio-prison-v1.c b/drivers/md/dm-bio-prison-v1.c
index 92afdca760ae..9ab32abe5ed4 100644
--- a/drivers/md/dm-bio-prison-v1.c
+++ b/drivers/md/dm-bio-prison-v1.c
@@ -26,7 +26,7 @@ struct prison_region {
 struct dm_bio_prison {
 	mempool_t cell_pool;
 	unsigned int num_locks;
-	struct prison_region regions[];
+	struct prison_region regions[] __counted_by(num_locks);
 };
 
 static struct kmem_cache *_cell_cache;
-- 
2.34.1

