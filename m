Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C17DD704
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjJaUXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJaUXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:23:45 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75629E4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:23:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2f5aed39cso3682975b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698783820; x=1699388620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAl1Hg4JRuGCSI5hrrAD0peIOWwe7ctUsvKwLVEKWuM=;
        b=Ww5RToF8tPdI/7bdA8sT3SxBJVtExcczZ1YfrahMteF7mwBKNU1wN2YMGCt/uBLGqv
         PC6cs+e5aXLLOlKt+jMHrWl7u07bqW5f/6lPWnkw+gYbO5/hkradHBtSB4qmgYDqg5tl
         sVgcPEdaIz/kGPJHEoqD0Cv+Dpnq+FmD+F0I6uA2PRLtFP7PxQrAsgpEWDJZU4Ylp0xT
         m0TuSwy3D2q/w8X+oei6d4UqCAgR7tussYn6sjrXlik27O4MeJsZkaDWiKBobhnK2tuz
         BKd401R8i50AP8LGHVYGPSHef6/p9evuZtobljnWS4uX3A8gGJBrfT2RQmVlDXxm0Gad
         AkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698783820; x=1699388620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAl1Hg4JRuGCSI5hrrAD0peIOWwe7ctUsvKwLVEKWuM=;
        b=h3qPo9ynDdoSzs8wbCRMV4TintVC2ZiwRGyaeTw29DImdOIIDClFsQIiRxkiR6iwI1
         V9F6lPWVMp3GWXlPQPIHIVt8Veg6FCXlUvSmMvMBWhXFGrecWwaEbbhy9mA4nOrv7IyZ
         ucVQDceuTUHDP4//8qyBujqoXVuAytepTFsJQAI+XKTzX3GjpwJnnXhu3zIPWkQcILUA
         /9OfZzb5IGybWh7lVZN0oPbjI7OvUB5OFn6YU1M3314EdpI+oq0AZRzceMLTKraltoco
         W/z9jsOvhanIOA+Rzp9KhRPLRRamdid/l808s68uQMf3dyfZn9uzsJ4GVcNmRFj2pDUG
         0a+A==
X-Gm-Message-State: AOJu0YyA8KebjVlWOr+xY+IV0N/Ze2U7IST8+At5hnacRlkD+QP5K1fZ
        YTxnilQT40ngQJ1Hng2OyVSRutZ6NfgsFzOElNk=
X-Google-Smtp-Source: AGHT+IEt7qAE2Ka+HQ0x4uZ6Au8f4gm1teKJ49wlOFD/ShxnaQl9zyzTD4bTYRvzDxZM0PpRFJ0X0w==
X-Received: by 2002:a05:6808:22a3:b0:3b5:6467:8cf5 with SMTP id bo35-20020a05680822a300b003b564678cf5mr2916382oib.54.1698783819996;
        Tue, 31 Oct 2023 13:23:39 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id qr7-20020a05620a390700b007788bb0ab8esm806628qkn.19.2023.10.31.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 13:23:39 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] scripts/gdb/vmalloc: disable on no-MMU
Date:   Tue, 31 Oct 2023 16:22:36 -0400
Message-ID: <20231031202235.2655333-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmap_area does not exist on no-MMU, therefore the GDB scripts fail to
load:

Traceback (most recent call last):
  File "<...>/vmlinux-gdb.py", line 51, in <module>
    import linux.vmalloc
  File "<...>/scripts/gdb/linux/vmalloc.py", line 14, in <module>
    vmap_area_ptr_type = vmap_area_type.get_type().pointer()
                         ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<...>/scripts/gdb/linux/utils.py", line 28, in get_type
    self._type = gdb.lookup_type(self._name)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
gdb.error: No struct type named vmap_area.

To fix this, disable the command and add an informative error message if
CONFIG_MMU is not defined, following the example of lx-slabinfo.

Fixes: 852622bf3616 ("scripts/gdb/vmalloc: add vmallocinfo support")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 scripts/gdb/linux/constants.py.in | 1 +
 scripts/gdb/linux/vmalloc.py      | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index e3517d4ab8ec..b5ba9682fc6b 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -157,3 +157,4 @@ LX_CONFIG(CONFIG_STACKDEPOT)
 LX_CONFIG(CONFIG_PAGE_OWNER)
 LX_CONFIG(CONFIG_SLUB_DEBUG)
 LX_CONFIG(CONFIG_SLAB_FREELIST_HARDENED)
+LX_CONFIG(CONFIG_MMU)
diff --git a/scripts/gdb/linux/vmalloc.py b/scripts/gdb/linux/vmalloc.py
index 48e4a4fae7bb..d3c8a0274d1e 100644
--- a/scripts/gdb/linux/vmalloc.py
+++ b/scripts/gdb/linux/vmalloc.py
@@ -10,8 +10,9 @@ import gdb
 import re
 from linux import lists, utils, stackdepot, constants, mm
 
-vmap_area_type = utils.CachedType('struct vmap_area')
-vmap_area_ptr_type = vmap_area_type.get_type().pointer()
+if constants.LX_CONFIG_MMU:
+    vmap_area_type = utils.CachedType('struct vmap_area')
+    vmap_area_ptr_type = vmap_area_type.get_type().pointer()
 
 def is_vmalloc_addr(x):
     pg_ops = mm.page_ops().ops
@@ -25,6 +26,9 @@ class LxVmallocInfo(gdb.Command):
         super(LxVmallocInfo, self).__init__("lx-vmallocinfo", gdb.COMMAND_DATA)
 
     def invoke(self, arg, from_tty):
+        if not constants.LX_CONFIG_MMU:
+            raise gdb.GdbError("Requires MMU support")
+
         vmap_area_list = gdb.parse_and_eval('vmap_area_list')
         for vmap_area in lists.list_for_each_entry(vmap_area_list, vmap_area_ptr_type, "list"):
             if not vmap_area['vm']:
-- 
2.42.0

