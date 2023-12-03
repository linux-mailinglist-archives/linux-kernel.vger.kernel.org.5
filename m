Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA058026D0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjLCTdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjLCTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:16 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9401F0;
        Sun,  3 Dec 2023 11:33:21 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so1566870276.2;
        Sun, 03 Dec 2023 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632000; x=1702236800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+CgZGx7o2SgzheWRYAbpuUQwUH8enIkMUK0Oggm6bw=;
        b=J0M6+tm+DaCNHdYTrh0ptcwdLTw9w/kLF9uAH8lKc3DF7e96jyormK6djUn8LgNFIc
         TeGT8xmBmRd/7i7eUJD7yCi54toYZIkwobI4wPrXTfc/+9Obj3LNnx5VnbM+UNl0Q2GT
         IItRWCCZnM3LCSW9ifaoCgtP1RzF+yGhw30oVFHcRwHoVPZrl12dvSSVwg53cBJGys0X
         bwv9WOJcFzTFRp9MdPclEOfMDEJOcebxuC649eD0lHrx9HnHi22aTxLXzluJcQ2iKM1m
         b5ztqeBPMwTs9+A6mgiwrcinxtPyADXVfo2HBjgmZwfalalqKs2GZ0vEEreS2Dp5niNU
         kgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632000; x=1702236800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+CgZGx7o2SgzheWRYAbpuUQwUH8enIkMUK0Oggm6bw=;
        b=lQxkYhYpvbzIffi1vv+jgXbAkC4mdaMujKoyT7xWNpfrzYfuztYESV6iPZJG/pMyxj
         k5UrfPxF5cgGmHunVZVrqy7vIrW/HrCD8HDbdAagP3Ri+38473247ToM/Il7zXfSTUKi
         oOYFlC0VBDdZvpfx2SBwvLqbAoiSxClLtLkiJjG24KfYPMdOXZou7hRhOk1nPzlPSFJ+
         b2AR9hG6dirhLZfvW7/AwwP+Rj+eQYydwl8i/gbmVqRotYUsrvDMUp5vvI/OHBXT5P1D
         NyDw+nH+wrXU0foJi34n/iqg2rSxmklnQyXElt0Fq9aVMLfbDGoqFADY1tB2Iyr1eigs
         2Yzw==
X-Gm-Message-State: AOJu0Yx9/B2bIthTmaHr2xuadUbdQZgL9efk1gF6Vmt82jkATJCNtgoD
        a+/gd8sznFmiIXRDo/rPfVUagLplfvqqLQ==
X-Google-Smtp-Source: AGHT+IHTqJlnQR3Jy2+h/2RvhlTgtmqXc2S5nmM8tNBnVYDVFwZOnhmoLx4weMnx/hcoenLLWnHT6w==
X-Received: by 2002:a25:4dd7:0:b0:db4:25b7:5f8b with SMTP id a206-20020a254dd7000000b00db425b75f8bmr22569000ybb.63.1701632000036;
        Sun, 03 Dec 2023 11:33:20 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id h11-20020a255f4b000000b00db54cf1383esm1757494ybm.10.2023.12.03.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:19 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Yury Norov <yury.norov@gmail.com>, sparclinux@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 07/35] sparc: fix opencoded find_and_set_bit() in alloc_msi()
Date:   Sun,  3 Dec 2023 11:32:39 -0800
Message-Id: <20231203193307.542794-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_msi() opencodes find_and_clear_bit(). Switch it to using the
dedicated function, and make an nice one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/sparc/kernel/pci_msi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index fc7402948b7b..91105c788d1d 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -96,14 +96,9 @@ static u32 pick_msiq(struct pci_pbm_info *pbm)
 
 static int alloc_msi(struct pci_pbm_info *pbm)
 {
-	int i;
-
-	for (i = 0; i < pbm->msi_num; i++) {
-		if (!test_and_set_bit(i, pbm->msi_bitmap))
-			return i + pbm->msi_first;
-	}
+	int i = find_and_set_bit(pbm->msi_bitmap, pbm->msi_num);
 
-	return -ENOENT;
+	return i < pbm->msi_num ? i + pbm->msi_first : -ENOENT;
 }
 
 static void free_msi(struct pci_pbm_info *pbm, int msi_num)
-- 
2.40.1

