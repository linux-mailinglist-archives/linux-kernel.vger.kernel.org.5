Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3634E7E81F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjKJSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKJSsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:48:40 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D95125A32
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:06:56 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc385e90e2so24590155ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639560; x=1700244360;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOPr7WA48CNkb4Z7X3OUT0iM6kqe+sbIYsR+7oE9+DY=;
        b=i440yKDf/XflnmkM6soHwXrzIxwelKqQdwSPzNzYJq6ImywmeS16T6sDIoT0toZkNw
         8V7UyuYhxBCo56AfKK1P2IZeZxcLDrb+lwHnLiYfPMxw4i+0ZEDZnET7U3KFACYzQ+rR
         UEOd/aikuHmdGEpOGyxlXCvtwTq/zeeG/Nck/znsHIXjQVaFZERhrxRRUHHRCNu4jKZx
         HEuAvushv1cCu7r/CjZ3JdjcK/uAFtXl+NfH0ZkSfc8S5qZ/Di0n5nqzIAPzqCL8oSCq
         cvGHt7o+ywGzVURKiaTFZpnufv0E7KE1wg/2cbW+hzMvFngj7P08UgBm15Q5te99Tc7d
         eq2Q==
X-Gm-Message-State: AOJu0Ywex9sdRHJ+ekX3mnNxDIxf64L8WccxtG0Vufqgw0gpeVZSci8Y
        pH9TdvFQCb6i84xLgeqP77vPoxVfK6Qi6yh5AHKEh8CD8j45lkE=
X-Google-Smtp-Source: AGHT+IGfz9DB+i/oSfaVIXH1My/xEdMl1rBniQhcEOkHtI1QuMurFSzWNUY0jb+Mh+mJoqIdvHlcsYBYm1RmiQH/l/fs8pKoQLq+
MIME-Version: 1.0
X-Received: by 2002:a17:903:48c:b0:1cc:ec22:da2b with SMTP id
 jj12-20020a170903048c00b001ccec22da2bmr8212plb.3.1699639560713; Fri, 10 Nov
 2023 10:06:00 -0800 (PST)
Date:   Fri, 10 Nov 2023 10:06:00 -0800
In-Reply-To: <000000000000ade4f305fc36868f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000433d410609d02c38@google.com>
Subject: Re: [syzbot] Discardable change
From:   syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Discardable change
Author: yuran.pereira@hotmail.com

#syz test: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/usb/core/devio.c | 2 ++
 mm/page_table_check.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..22ae7babf46b 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -276,12 +276,14 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {
+			pr_info("==> if* vma_use_count %d\n", usbm->vma_use_count);
 			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
 			return -EAGAIN;
 		}
 	} else {
 		if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle,
 				      size)) {
+			pr_info("==> else* vma_use_count %d\n", usbm->vma_use_count);
 			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
 			return -EAGAIN;
 		}
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index af69c3c8f7c2..ef0fb410cf10 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -142,6 +142,8 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
+		pr_info("===> anon check_zero %d\n", atomic_read(&ptc->anon_map_count));
+		pr_info("===> fmap check_zero %d\n", atomic_read(&ptc->file_map_count));
 		BUG_ON(atomic_read(&ptc->anon_map_count));
 		BUG_ON(atomic_read(&ptc->file_map_count));
 		page_ext = page_ext_next(page_ext);
-- 
2.25.1

