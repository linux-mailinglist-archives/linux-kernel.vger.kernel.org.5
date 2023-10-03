Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88987B74CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJCXZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjJCXZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:25:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A1AA6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:25:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692c02adeefso1114597b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375516; x=1696980316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WklzNBegPgB5uEE+/qy7qfvk7e8XBByJu1huJ3exKM8=;
        b=ktHr7mrBoOPg3ka7pz2js6pvB4rAKVf1iaLj+EGNax3ASTc8p6stvVbNKPcFPdi+Sx
         zNjLEIZuQniYAjuyicNUknDkeY8uqicSGDwAs+tBtdn3ihqzWDcV5cS8vBiHBH6sDTs5
         ahz2Ven8cFUKH0orHCrAUTILjNaGbySNCHAm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375516; x=1696980316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WklzNBegPgB5uEE+/qy7qfvk7e8XBByJu1huJ3exKM8=;
        b=M1GE3X+AlmRZ4Yg264w4D+lObZaXg5ktHv7DIojoZzDR4qizuN0sG1HTlFmLs3FMaJ
         h+y9MajXrx8W1FsgEKcOoWTHmySjjl6CJDTu1bCTTcz+FRnhCmS9RoZO2P14T7oTR/jN
         2isTaWtpAUoJQtAtkgNb6qWDGHM4r7dxPvDW9gVriGeOuhA39uco6SESlSHkPdW0qjmV
         wUrK8GjHr5/LQm7pYe6XLjpMlJOKbyRFQDLzecUbigdo4dGkRzr32ONojzsuxZZcugLI
         hDe3X9y6SCS0JqBnxoP/9/iHWZkTFrblr1kE+4iJEns/qEK2OyBZQg7uYojMuwQllvhZ
         NHAQ==
X-Gm-Message-State: AOJu0YyKBqm4G+OmgaPE0kFMdQxBP53pOR9C0SZMba5WrWDWtZ2ymIow
        vMZPURdwt61aaLuWsWxlPJlgWg==
X-Google-Smtp-Source: AGHT+IFl++NjbnmUViIRhL35xEk4qT1W55vhw9500eQEtSz35fzgRPo8LMRfK60rOfBTWrFsvpIK1Q==
X-Received: by 2002:a05:6a00:1592:b0:68f:cf6f:e212 with SMTP id u18-20020a056a00159200b0068fcf6fe212mr945019pfk.20.1696375516672;
        Tue, 03 Oct 2023 16:25:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b0068fece22469sm1911902pfo.4.2023.10.03.16.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:25:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Smart <james.smart@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by
Date:   Tue,  3 Oct 2023 16:25:11 -0700
Message-Id: <20231003232511.work.459-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ByABuAYNlIfLs+7c20JDBpw/8yvTeM5CPvmgxbAXfYw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKLXpRHdUq+lFLSfO9gJWqiFNgTu8fSB9J2BJ
 zZ8tvEohwaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyi1wAKCRCJcvTf3G3A
 JgoeEACsVLmbCD8bMb+riXBw2TqwsW891pJ49jgwyOXsxUB/C3ZZ7ENjEQN6LGSkaLdqYzfmWwi
 YDaW6EbTBn5KcSU1Hw4F1S2hC/yfbryopBQFy7UUPJ1h97vHG1WklXODb15HTcpXnqdzPEExmFI
 2XHy7Ynrdw038ZEWiX437eAzH5XQ6D+7IiuBD6qIBDzeXsD6/bfd+vuujGpp7IhVhhhDuEKxeW8
 xte4TTr+fKEK5gpyPsViXn0Om67AzEfyUzWP9jm56AzQ44uFSs/BaIvbDhk4pCkaExfdjsLn1hr
 TnQLubChT6GFHgF1ibh3aQbAWU8JvDFhf0hfOjFO3HaLF0QpoAzjTyfC0LJjZq90mWYCsbujmT2
 fB2KG03D9y3Zx8RiEvhC51j18hMf+2VF7qoFhtccckeg48gvmFTFgwUtuXwiM1xQB1YfThnFj+o
 DH71gvobUcMNBsnE3QIGtog5q6ctnfm3DnLqskdz/HRisn521b6p8EHKrt2f7Ue1x5XfYDQc5dG
 bog1lOJ/LORrJEZs/cd6yndXzT6vd7boBB5i51/cwGXbSlSA/qTBo4c1Qlhv0U8pJPplNY5ZSx2
 jyZXfX8030a4B+JGxqoaiUJjYqySNBjwHDUPVdQA0BmeUkDgeQ3HHlTErvAlLJMwAf9s3Sk+VXC
 d4vCaB3 AqjDvhAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nvmet_fc_tgt_queue.

Cc: James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1ab6601fdd5c..0fa2d658cdeb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -146,7 +146,7 @@ struct nvmet_fc_tgt_queue {
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
 	struct rcu_head			rcu;
-	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
+	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize); /* array of fcp_iods */
 } __aligned(sizeof(unsigned long long));
 
 struct nvmet_fc_hostport {
-- 
2.34.1

