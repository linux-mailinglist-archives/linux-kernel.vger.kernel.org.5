Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64887F008D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjKRPwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjKRPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:11 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7626BD71;
        Sat, 18 Nov 2023 07:51:20 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c8bc1ea998so8916957b3.0;
        Sat, 18 Nov 2023 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322678; x=1700927478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQERxgfSt89Kdhgk7cTMKz26OCMV2gzbBEX6BC+o/Hk=;
        b=YUwjoHQ5DP+OyTDVhE+0ai4t07Rh6sz1nx/RGU2cioED3f31OpbpPBwTPXNtQq3Nr5
         fOWht3OTsYOA0xs0/1LdlwGyCdbVOWp/lwda84iwF6Ly5qjB3XWU8bc5Cwdteq49byLi
         sct6wV78F/DqLxVxSzLQZdgvQSm9KgmtRTpqKmrH2LJ7/EDRMt4/f/l/QCpMDnusidnF
         uomKLDcRQMWx6lG5kpWQv4iDOqnns1govW+N4F3TOCaNidRczrYDsSFOuMlXaS4+5mih
         WrcLnluP+Gog8zCec9UqY7muw2Ih5vqE3/aic0PJ+muLmK9Yc5jNGHx8FSTvoHwpDCBv
         DjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322678; x=1700927478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQERxgfSt89Kdhgk7cTMKz26OCMV2gzbBEX6BC+o/Hk=;
        b=RtXQGtRFDejaZwVDWMaOUQf4XRbp9d3M8SdIE7t8lK+NhR1s4axR0UfW+tLfztH/0k
         4UPUlC2SodDnKTHLakfdHaHZBs/rOc3GlEhXkByfhQbx0bs7wdry08sccJXaeePyQDln
         MzDqjzthYW2T4c7iPqpYBFS7KJDDq+rcRwAFzwf48XKmpfpjnV2sD3+rRJJxr5ketYEo
         c0XFFFeMDeMDG+5iO39YpDYHZY8nd9jKzfqQqXWeHcnZbS/q0UjVtv7JBDSlvfo/B4G4
         AH0xfnVLnCmqIWq+dlY8UvVxhvs/uWkToFm/X3gszQ6Xpt9IJd23O65htrV/4fRGZCwq
         7csw==
X-Gm-Message-State: AOJu0YyJgNThU54dj8hNR357cS7gbfscu9e4jnLuwLt0SObrkFcaBBBO
        YbMmHUtuGiycOL69cPjqid0qSWm0GrWdAMf4
X-Google-Smtp-Source: AGHT+IH7rmTBSRsPV0fOGx1t31H5ZAiIc/BxfQWuRrGTYf06psszklrLQZsiS+6t49QhgKineu2Y7A==
X-Received: by 2002:a0d:eb51:0:b0:5a8:250f:687c with SMTP id u78-20020a0deb51000000b005a8250f687cmr1514575ywe.15.1700322678534;
        Sat, 18 Nov 2023 07:51:18 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id o81-20020a817354000000b005869cf151ebsm1159023ywc.144.2023.11.18.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:18 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 06/34] sparc: fix opencoded find_and_set_bit() in alloc_msi()
Date:   Sat, 18 Nov 2023 07:50:37 -0800
Message-Id: <20231118155105.25678-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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
2.39.2

