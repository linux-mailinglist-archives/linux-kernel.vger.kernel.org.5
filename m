Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB18C77173E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 01:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHFXQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 19:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 19:16:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDADF4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 16:16:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so6125808e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691363776; x=1691968576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEbIB04Iy3FmDryo9/HW6q1xbIuRl/P3QhBN14yV5sg=;
        b=q5/30O30q4Bup1+Nynv0E/0oPlPnyiyZAJMEQLopNYUDrkqh6wUXcfRIibwjceqtiq
         5XD0GDNC4EUWsDhgoqccCkptC6CZRzhqbjApu3BBjDZQkAj+b4lu6Ybi0saI7Qj3tAIw
         6lVFfHRaT5ApkR3AsJTaWarE7dpHpXG25az1hHh03pHXDYM3z6iu60sddloDJEPBUJHU
         2FcEYHi2R47NBQG3xlD0xiFokEnCKHAanzT7kpZa2J1iPEMT9DA6p3J0uXFNbUUYLIPM
         G76zlS2clXd2vfbPdrMB7nlm4gUi3/UGaSGOBcoG6bAYi4t9ghNZSng2U8MqYq9CYEXT
         Xxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691363776; x=1691968576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEbIB04Iy3FmDryo9/HW6q1xbIuRl/P3QhBN14yV5sg=;
        b=YUO+1sb+JCXaMG0Y9ZREaQOYW44ziMRpc4/bADe/A9J6pH8zb39MLRjQBDauQJ6CQ9
         RYl8cyNktu94ugHs1CpZR+dx9YGpnD61/cr+TpJwXbWM42ibzy3q78HrbKznrYkwIuQS
         goTxhCUv4/UaU94r3sxNgxDQGufY/tSbHrE7VsfaNmVqyylipHl8YUFsleXbtAVQHshQ
         VSaud2Faj7H1tIViP/JmU3wQsKVKIa3xG83LJpoif42HqTbavP6r42nTZ86aea1XdEbD
         9Y3/KlZNDpOp7bdziGK6Ooa4KU8FWG+Odvp9LARJln9LDOoq42zzhXlYkTHkDSmdaubk
         qCfA==
X-Gm-Message-State: AOJu0YxZp5YZdMBF75zgCWnF3Zz8zIypGJCMhjAhONUAf+/LhOSNrYzi
        1QPNH8UdspeggZYsn0K4NXc=
X-Google-Smtp-Source: AGHT+IGQbjNV9d6hSYsijupuW3EegD/POMMX6qQqj7V7KTAqW0tWlh5mx2ysU9V/bUZXqEXVRxiYPQ==
X-Received: by 2002:a05:6512:401b:b0:4fd:c785:58b with SMTP id br27-20020a056512401b00b004fdc785058bmr5022776lfb.4.1691363776275;
        Sun, 06 Aug 2023 16:16:16 -0700 (PDT)
Received: from f.. (cst-prg-21-219.cust.vodafone.cz. [46.135.21.219])
        by smtp.gmail.com with ESMTPSA id bt16-20020a0564020a5000b005226f9d6055sm4337575edb.61.2023.08.06.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 16:16:15 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm: move dummy_vm_ops out of a header
Date:   Mon,  7 Aug 2023 01:16:11 +0200
Message-Id: <20230806231611.1395735-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise the kernel ends up with multiple copies:
$ nm vmlinux | grep dummy_vm_ops
ffffffff81e4ea00 d dummy_vm_ops.2
ffffffff81e11760 d dummy_vm_ops.254
ffffffff81e406e0 d dummy_vm_ops.4
ffffffff81e3c780 d dummy_vm_ops.7

While here prefix it with vma_.

[if someone has better ideas where to put it, please move it]

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/mm.h | 6 +++---
 mm/init-mm.c       | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..14898e76bbf1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -756,17 +756,17 @@ static inline void vma_mark_detached(struct vm_area_struct *vma,
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+
 /*
  * WARNING: vma_init does not initialize vma->vm_lock.
  * Use vm_area_alloc()/vm_area_free() if vma needs locking.
  */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
-	static const struct vm_operations_struct dummy_vm_ops = {};
-
 	memset(vma, 0, sizeof(*vma));
 	vma->vm_mm = mm;
-	vma->vm_ops = &dummy_vm_ops;
+	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
 	vma_numab_state_init(vma);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index efa97b57acfd..cfd367822cdd 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -17,6 +17,8 @@
 #define INIT_MM_CONTEXT(name)
 #endif
 
+const struct vm_operations_struct vma_dummy_vm_ops;
+
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
  * at the end of the structure, the size of which depends on the maximum CPU
-- 
2.39.2

