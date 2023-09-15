Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007F87A279D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjIOUEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbjIOUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:04:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF82211E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:04:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so2310158b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808243; x=1695413043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBuZz+BdckpJHOm1ZISAhTef4sCi4HSxGN+vf0MxAr8=;
        b=lMqXZr9zTLxsy5KQL5G498j4MM23oTudzH5Bwlq5wwkOAbVDRL/RGT4JJxIYIko/gG
         7drOLMhs7FKyly+iCDy92tYvrgHYidKzvNeskOffC/7GJDLaL5ok2aGnYzJmd6qViPXz
         6S3oIX4Tf1Ht2ZjC00eRsxvIofGY5lv3KlJ1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808243; x=1695413043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBuZz+BdckpJHOm1ZISAhTef4sCi4HSxGN+vf0MxAr8=;
        b=cna9tzlxHTt0H/2zEvCPDF/r0JYQZT+hqEaBHAmVN/b94Dr/V7mpwBDCtQnqDAYDKO
         ozHM06c8qdzGLUcqT9Xw5W/QxikxBIcv+P9h87wkAPf9nqVm/bwd+3YtR/kLOotgvSvt
         8XxPk5ko/5rFbObKf5BuryBnrAvXT0fzQ1nLOk9Lc3dtQdeHeIL72/mrm3Zy1rv7NpDY
         6K8xbOuZVX7qR3Eqw4ikDpiiYzE6KjP5/1exeaT1uxcfo/zG987SxZse+/IIqmTKALpE
         pqB5xnO0ndN+Jhh1dDswdFpkMOQ09n/udfkBFZHGnkRGuFXtVBeJoVagURWKqSRWpbv8
         W/Nw==
X-Gm-Message-State: AOJu0YxZTSZFf4ag2jhZwk9ZsboVe9UpLURzQ4Sbc9p0PJtpD2CAeU5A
        kEIXjffavrI+oSmbEImhZl/RMA==
X-Google-Smtp-Source: AGHT+IHRUYTJjIKllYHBewMbpKQsYsoD6C28ob0Nn4eDxpBQYKIGmGp4tJnxthVcYLQpU9tsohhP2w==
X-Received: by 2002:aa7:88c8:0:b0:690:15c7:60d8 with SMTP id k8-20020aa788c8000000b0069015c760d8mr3508557pff.22.1694808242750;
        Fri, 15 Sep 2023 13:04:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k15-20020aa792cf000000b0068a3f861b24sm3312716pfa.195.2023.09.15.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:04:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] dm: Annotate struct dm_stat with __counted_by
Date:   Fri, 15 Sep 2023 13:04:01 -0700
Message-Id: <20230915200400.never.585-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hh6/l0ERrceykgj05rTGEqoGv9O3N3l11v+m7r5kK6w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLiwjAee1aCYWRgESmBPvaP+ZPywLMQavQYy6
 K1opOJdk7yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4sAAKCRCJcvTf3G3A
 JmEyD/9Nw4qdkEPs0CMpZYH9PJm4rFd+PH9nRC+v78Gfq/aOca9MZMGgAsVTNZVVLy3P6KBjD2m
 mtmN77g1YZHJHCVzbdUI0UvlIfsuR086YpqaUWYp7+Q7hZfHkyCcKKrUFceRRDruDxkNaUOsNN2
 IzNy4s/CR4vogKkDt+GZ1M4KjWCNednV7pIbc7OTZ7oDfmLZSemK//MribH6UwbwstZZ/IbuMuy
 aeNZcS/1An4v4h1P+RuIKViYXbrMbIVTWpvGjOIbLasIYjcKoW9pSlewMy33Z139w9b2WMNcLGN
 01cMC9t6y0j1p4xe4bkCrA0JEvmLH5zv+rMOGyLuvyeaG6u2Y41oqm+FNy5fEZOI3Neo6HIqjrW
 8dQ4XaWrwKCWR6rc2vzr2N6EFCxh7FMrjtAvMQo4HoYMuzYpp+4owygZiP1XptuqamDfXDnhjTf
 d79h5FKJzmmzKtPa7y41OC7rFq2Hk7JciHa8JTHI3cw1D4J5VvcDE1ZlMq+Cxpi9QK4ImW7tWhS
 DrKAuYb0nA6Npm4thazac1wWwsCnAmJf6MLJqBrJfE1yYX4s3Tr2XuB22ABIm6T4hfpag6YFrbQ
 NiOsSHMZ6+N3PeHEo1lrusu22nve1JOWkpcUnxD7lJ3kW3pdEnfUXewlmUjhQFSa9tdp54xnhT6
 5iS4QDJ ir8mttuw==
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

As found with Coccinelle[1], add __counted_by for struct dm_stat.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index db2d997a6c18..bdc14ec99814 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -56,7 +56,7 @@ struct dm_stat {
 	size_t percpu_alloc_size;
 	size_t histogram_alloc_size;
 	struct dm_stat_percpu *stat_percpu[NR_CPUS];
-	struct dm_stat_shared stat_shared[];
+	struct dm_stat_shared stat_shared[] __counted_by(n_entries);
 };
 
 #define STAT_PRECISE_TIMESTAMPS		1
-- 
2.34.1

