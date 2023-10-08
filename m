Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591F7BCF53
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbjJHRGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:06:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082609F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 10:06:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c64a3c4912so2722768a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696784768; x=1697389568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nqNFicLmChhNvsLQV7hRq15LodE1T4vEvc1Jrz7PUE=;
        b=L0TxNufFJ28PNYnbTDlW8JYZug0+VINdkAENywU0sVEluA5eaY8p56UM2H6ONSSewX
         BefgBZc+S/sRjWgKbA5qTWbACLf4JhnH/gK8VlkswbOqL+avc5Zhn7R0WCAFlLyyIjXb
         HCc1iaaeefS9+CHIhOPt2ZBvwZgYonpkNOm2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784768; x=1697389568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nqNFicLmChhNvsLQV7hRq15LodE1T4vEvc1Jrz7PUE=;
        b=dAzduqMGIH8eGnOQHquHsXIqGRHOXodbih0Zfy1tDPJL0c9ecVQL4I47GG6c10EE1u
         aF/uF1Hv7bHY5FTecGJLnTMy5whGtMWvtfRDbJdNJNExRzGQcvA2uwzDE2GsPVYzrlCA
         XPHI3CWhAqAN2bcWcLg7DpsQcv7K1u1VSYFJBfAmmiqjurCxNFJaJ+1FgkcYOTtn6C9+
         rg1+XlOCLS1Yvq5lz1pGGt7d+mB3+pxA6IqXccbhVf53NbBAwj0ZNJqkOPZ52+nFx9rA
         7pISon5bRMv3Uluopx8d1v9+6YDD59E/P9HNokSmnZ+7cFT+/FUc9wbCIyFq0yliGUzA
         kckg==
X-Gm-Message-State: AOJu0Yw9K+o+QVet0Frqw58s5JHIFC0EJnS2KtbvWryZamYKeqZpWkiA
        sj4nx6WrVqA7cvO0cFSf4r2GFFzUX0HkyEW7++U=
X-Google-Smtp-Source: AGHT+IG2CL4VX7lW1hVP1JbsiQepUUABt/IJtOXBKKYge0GlWd1+Drv72rEVv1gvSoMI0PJ8SMz+qw==
X-Received: by 2002:a05:6870:e99a:b0:1d6:439d:d03e with SMTP id r26-20020a056870e99a00b001d6439dd03emr16299580oao.18.1696784768266;
        Sun, 08 Oct 2023 10:06:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020a638f45000000b0058901200bbbsm6729861pgn.40.2023.10.08.10.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:06:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Lukas Loidolt <e1634039@student.tuwien.ac.at>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] randstruct: Fix gcc-plugin performance mode to stay in group
Date:   Sun,  8 Oct 2023 10:05:56 -0700
Message-Id: <20231008170552.work.766-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=keescook@chromium.org;
 h=from:subject:message-id; bh=qv0SIpdVAd3ngaHncfIuud+zey9eeaZyOKuEy6jeorw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIuFzu7vTuSz+3VGO1JVCPh0ubAQljqhiucij9
 oLQjB3POL+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSLhcwAKCRCJcvTf3G3A
 JhOyD/0d8vIe30z382IYGDgIbm+R6DVIQhzHkNFDVHXPEMNVNNJ0UEcqT92bmfcVFEgsO7trUWc
 G2grf+7o60WseUEXUTIdxVtXAgn0rfpqwf4Gy942wFdBBeMgG+seMxmv7i9A+swhbETnQvK3CWF
 CLVAyreBEpDjOwr6sgxKag+zn79zZtYu2ZnUZ8VC7kJR02Cx7GRekWahCoLjojjWkViJ1E3L6Jb
 viPAoDn1ukpTK96MdHdBbYl61E2b61yfJKcn3O+qCRQahQ4617117WZwswKzlqGvU//6Gnzydnp
 1SyG0S5+rEia+QCmd2AZLNmhPEAhEtydF12bUE2HYmkcR+FuZaKExVbEGhQ8bm//dJLl2F5YIj7
 w9GdaLz4bxRAYAasP8iQz03jNQTNI05OOaZEZwEsDYMMKL5otxQzD4GFku3Ap1j+UBofndwK/bz
 +IIhuT1mq4hb230NybmGBZaQT+tMCwAkzYUGVKgIEVNObR8/L6D8rtVPApVE9KGAGYlpWfOa6Qj
 9HYM4uCYuG846NQdF4pbXS1tcmbQF3FR0vJvuFg02JZK1SFojNtWvNYKWUUO5+JbjBhAvQfncCu
 PunvqMXM8H5hwTfyq1UolEEjtNmlpYPF0nPBR7UdD6Nko9Yz5EYgq9+VNyN1kc2NULSyXl58XnD
 ITgKT3X FQTEXZWA==
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

The performance mode of the gcc-plugin randstruct was shuffling struct
members outside of the cache-line groups. Limit the range to the
specified group indexes.

Cc: linux-hardening@vger.kernel.org
Reported-by: Lukas Loidolt <e1634039@student.tuwien.ac.at>
Closes: https://lore.kernel.org/all/f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 951b74ba1b24..366395cab490 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -191,12 +191,14 @@ static void partition_struct(tree *fields, unsigned long length, struct partitio
 
 static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
 {
-	unsigned long i, x;
+	unsigned long i, x, index;
 	struct partition_group size_group[length];
 	unsigned long num_groups = 0;
 	unsigned long randnum;
 
 	partition_struct(newtree, length, (struct partition_group *)&size_group, &num_groups);
+
+	/* FIXME: this group shuffle is currently a no-op. */
 	for (i = num_groups - 1; i > 0; i--) {
 		struct partition_group tmp;
 		randnum = ranval(prng_state) % (i + 1);
@@ -206,11 +208,14 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
 	}
 
 	for (x = 0; x < num_groups; x++) {
-		for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
+		for (index = size_group[x].length - 1; index > 0; index--) {
 			tree tmp;
+
+			i = size_group[x].start + index;
 			if (DECL_BIT_FIELD_TYPE(newtree[i]))
 				continue;
-			randnum = ranval(prng_state) % (i + 1);
+			randnum = ranval(prng_state) % (index + 1);
+			randnum += size_group[x].start;
 			// we could handle this case differently if desired
 			if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
 				continue;
-- 
2.34.1

