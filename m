Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C866801C69
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjLBLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLBLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:18:55 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDE318C;
        Sat,  2 Dec 2023 03:19:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50be9e6427dso263849e87.1;
        Sat, 02 Dec 2023 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701515940; x=1702120740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ168aVq5QXOtHooxbH+odPbZ9pENqVHXwP/aZSJoxY=;
        b=YeVnEhLbgyDw3B1XXHHKA8yp6osJqjS6IR1AHUCfiKPszypzFQ+bKI1Y0IXI0Xha5n
         R0o7bQDcyc0mbhq2i/KnfP7wYJpmoX6q2oztruhfFr3qD/4WziQTKW/6/xexXKYhcASd
         nl9bgaDbkrUOzhWPg+bA1dhfZjK8wqP+Nxv8NDLrNsG8NdKU1WYRtMbSs9pwsiJ19MYL
         n+ZIrIyPHg4X92OGTHMg/nSP+bEociJObRA5VoQ+TP9oDKMhyJ2P9Bek4aD8HozjUcdk
         61yFU6NqdOmefVywLIA7aH1dE6/B4l5ZZOfrrBdzheFry7lIx6IrdeDQWyUT5fcITsRi
         L/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701515940; x=1702120740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ168aVq5QXOtHooxbH+odPbZ9pENqVHXwP/aZSJoxY=;
        b=p1wUj96fQmmKy/hnmFU+p9s/pNc49imNS4KxjxdEW6uNJQ/E+N/oKoTe7KAkT6grpW
         pclyd8aupC8Fmj4U3W08eJnXdG1YVRMBs7pm8rEg63iIwhGo2c+F1oZWkiqvus7ajx1o
         AJueupfmwPcWM0SZRGPJrlBnfznFygc0hvMVqOvucdy5DGU9G1JNNhBerIxMD322/4Ra
         zmRL+w4jYES+8U5Ux/+kCM2i16UlZemtHBtJdRRZnvA94Ae5coW9p+OWwPJ6sNRZJ/7I
         heCuty4ZN5iUJncHgPRrc+0JDihqza7q4KHVak2OiY2bHrHFBfuBdeBOoVpRVBpoy/FT
         OhLQ==
X-Gm-Message-State: AOJu0YweiEk7sphsTYLeFeHDlLA163IuTM5ga8rpz6elOnjY/HAdBhaD
        XQ1hbsrHFC0SCx5nTb/sYcU=
X-Google-Smtp-Source: AGHT+IErfZeBgQvhH6+UfukRjO2daCpV0/rvJfCL6UgL0+RAW9RuRhKB9V2J64iiN5h4LjG9319TsQ==
X-Received: by 2002:ac2:5e63:0:b0:50b:d764:8024 with SMTP id a3-20020ac25e63000000b0050bd7648024mr1399573lfr.87.1701515939941;
        Sat, 02 Dec 2023 03:18:59 -0800 (PST)
Received: from localhost ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id z10-20020a19f70a000000b0050bc4ed121dsm692406lfe.254.2023.12.02.03.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 03:18:59 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/mm_init.c: Extend init unavailable range doc info
Date:   Sat,  2 Dec 2023 14:18:52 +0300
Message-ID: <20231202111855.18392-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides of the already described reasons the pages backended memory holes
might present due to having non-memory regions covered by the contiguous
flatmem mapping. Add such note to the init_unavailable_range() method kdoc
in order to point out to one more reason of having the function executed
for such regions.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Link: https://lore.kernel.org/linux-mips/20231122182419.30633-6-fancer.lancer@gmail.com/
Changelog v2:
- The holes in the memory are actually justified by having the flatmem
  mapping model. Change the patch and the log accordingly. (@Mike)
---
 mm/mm_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..824bf53e8253 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -796,6 +796,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
  * - physical memory bank size is not necessarily the exact multiple of the
  *   arbitrary section size
  * - early reserved memory may not be listed in memblock.memory
+ * - non-memory regions covered by the contigious flatmem mapping
  * - memory layouts defined with memmap= kernel parameter may not align
  *   nicely with memmap sections
  *
-- 
2.42.1

