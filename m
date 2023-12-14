Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18218124D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442952AbjLNBzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLNBzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:55:54 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4867EB0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:56:00 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5e2cfece112so12394177b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702518959; x=1703123759; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXS16Jh4pIOzCXaU9yjoq8w+1VlIvNkLy1RXeo+6UJw=;
        b=zGVrky6vRrR9A6UnECwMf7Ze3LigZa6+FUTngO87HwmKlw7UfVMWJdZN71S2MTTC+W
         YFNHVB9D+mwb34cHqMhuRIvGJpBAwK3i2eEFbjQspC9I8auyLFHnQ8doY8zgT4VMIAOx
         Cx/S4Vcev8p1bLM1xjZ4oQRb/153yb6dejXl4KRWu7hRhVeJAws9jb1mAOEEeKjL0nUm
         n0PWP32aZURMFSR74xgLcjRLHmJxN9GHZPTklluCCSJzd3WCojJ5q8RjhRtCQn0MCfcQ
         C5LIpcDFGS/Z7Fg2Qvb72j661NJZXugnxWu2jdQXGFx8IygNBF34XkcIYwuY09QL2QEP
         Ip+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518959; x=1703123759;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXS16Jh4pIOzCXaU9yjoq8w+1VlIvNkLy1RXeo+6UJw=;
        b=FM2sRFAVaEX7CH4yepbcy+kFj/itIHKZL0b8tjqSSUPoKp5z+SRFo7L1upZztiiz/C
         VV2nYMNYcu6g21K2mY4j7nQYKtqk4O7fIVtVeMl/t/s1TvohMULQXI4DmjtHEnaV24w7
         jvNkDas8aj/2x+qwzDWFlnLezUbMROGBdXuVdyu5frlNtzRSuFnxj9pVYP5IR+Bu7eO0
         Z7aD9BTrdr/TIwUBrF+PU0j3joTcfHKTqhyIfiXw+bRE6Xf2nk1I5h/hwLWPFZOL1eZ/
         Ev/Mt+naJA/r99e/JTE7znYq3Fs7vsz/rUGpwhaNPbfeMFQJ5Zk6Ak0mGWzUB7ZvsWEa
         9y0g==
X-Gm-Message-State: AOJu0YzBKRKqK01T47SxVDdXg0UeeiCR6Zj41cLQ29vyF31fNYx83xeu
        Ett0cjrQg6S01J71J+fRNY0qhw==
X-Google-Smtp-Source: AGHT+IHYs5cilcDVUOrJUHpiP7G73AZjkSakO4l1hqIQvJu47TRWrJ3EvXIYBi50ZKS1fa90AufsyA==
X-Received: by 2002:a0d:c783:0:b0:5d7:1941:3557 with SMTP id j125-20020a0dc783000000b005d719413557mr7373865ywd.62.1702518959472;
        Wed, 13 Dec 2023 17:55:59 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q68-20020a818047000000b005d580a1fd70sm5094434ywf.75.2023.12.13.17.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:55:58 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 13 Dec 2023 17:55:46 -0800
Subject: [PATCH] riscv: Fix module loading free order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-module_loading_fix-v1-1-da9b7c92ade5@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAKFgemUC/x2MQQqAIBAAvyJ7TkiNqL4SIaJbLZiGUgTh35OOM
 zDzQsZEmGFiLyS8KVMMFUTDwO4mbMjJVQbZSiWkUPyI7vKofTSOwqZXergytncdmkHIEWp4Jqz
 6n85LKR/ikY0OZAAAAA==
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702518957; l=4248;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=AGHOVl6+fAnfdvSS+mkS/6T3AqWPxNDKq2uwr8rys0g=;
 b=ru835i0uXHd7SNhF7jm+mG44Au3M+8+dIJkg5+UV1qqMV2fKp1Fv0KYVSpvrRe1n6akOhSLGG
 hP2gK1dE40bCgGPjBpU49KZ7wq+UarP0JiCE9KHHR++u0aRdIpdW2ge
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various changes to riscv module loading mainly in regards to freeing.
Also change iteration of relocation entries to a do-while loop since it
is guaranteed that there will be at least one entry in the linked list,
and the loop sets the curr_type value.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202312132019.iYGTwW0L-lkp@intel.com/
Closes: https://lore.kernel.org/r/202312130859.wnkuzVWY-lkp@intel.com/
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202312120044.wTI1Uyaa-lkp@intel.com/
---
 arch/riscv/kernel/module.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index aac019ed63b1..fc7ce101d9a5 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -633,15 +633,31 @@ process_accumulated_relocations(struct module *me,
 					  bucket_iter->bucket, node) {
 			buffer = 0;
 			location = rel_head_iter->location;
-			list_for_each_entry_safe(rel_entry_iter,
-						 rel_entry_iter_tmp,
-						 rel_head_iter->rel_entry,
-						 head) {
+			rel_entry_iter =
+				list_first_entry(rel_head_iter->rel_entry,
+						 typeof(*rel_entry_iter), head);
+			rel_entry_iter_tmp =
+				list_next_entry(rel_entry_iter, head);
+
+			/*
+			 * Iterate through all relocation entries that share
+			 * this location. This uses a do-while loop instead of
+			 * list_for_each_entry_safe since it is known that there
+			 * is at least one entry and curr_type needs to be the
+			 * value of the last entry when the loop exits.
+			 */
+			do {
 				curr_type = rel_entry_iter->type;
 				reloc_handlers[curr_type].reloc_handler(
 					me, &buffer, rel_entry_iter->value);
 				kfree(rel_entry_iter);
-			}
+
+				rel_entry_iter = rel_entry_iter_tmp;
+				rel_entry_iter_tmp = list_next_entry(rel_entry_iter_tmp, head);
+			} while (!list_entry_is_head(rel_entry_iter,
+						     rel_head_iter->rel_entry,
+						     head));
+
 			reloc_handlers[curr_type].accumulate_handler(
 				me, location, buffer);
 			kfree(rel_head_iter);
@@ -723,8 +739,8 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 
 			if (!bucket) {
 				kfree(entry);
-				kfree(rel_head);
 				kfree(rel_head->rel_entry);
+				kfree(rel_head);
 				return -ENOMEM;
 			}
 
@@ -741,12 +757,15 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 	return 0;
 }
 
-static unsigned int
-initialize_relocation_hashtable(unsigned int num_relocations,
-				struct hlist_head **relocation_hashtable)
+static u32 initialize_relocation_hashtable(unsigned int num_relocations,
+					   struct hlist_head **relocation_hashtable)
 {
 	/* Can safely assume that bits is not greater than sizeof(long) */
 	unsigned long hashtable_size = roundup_pow_of_two(num_relocations);
+	/*
+	 * When hashtable_size == 1, hashtable_bits == 0.
+	 * This is valid because the hashing algorithm returns 0 in this case.
+	 */
 	unsigned int hashtable_bits = ilog2(hashtable_size);
 
 	/*
@@ -760,10 +779,10 @@ initialize_relocation_hashtable(unsigned int num_relocations,
 	hashtable_size <<= should_double_size;
 
 	*relocation_hashtable = kmalloc_array(hashtable_size,
-					      sizeof(*relocation_hashtable),
+					      sizeof(**relocation_hashtable),
 					      GFP_KERNEL);
 	if (!*relocation_hashtable)
-		return -ENOMEM;
+		return 0;
 
 	__hash_init(*relocation_hashtable, hashtable_size);
 
@@ -789,8 +808,8 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	hashtable_bits = initialize_relocation_hashtable(num_relocations,
 							 &relocation_hashtable);
 
-	if (hashtable_bits < 0)
-		return hashtable_bits;
+	if (!relocation_hashtable)
+		return -ENOMEM;
 
 	INIT_LIST_HEAD(&used_buckets_list);
 

---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231213-module_loading_fix-3ac6d4ea8129
-- 
- Charlie

