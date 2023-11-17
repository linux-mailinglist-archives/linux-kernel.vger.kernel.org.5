Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4A7EEDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbjKQIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbjKQItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:49:35 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89769D5E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:49:30 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5844bc378feso860394eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700210970; x=1700815770; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rbv+r+ppwEUPn8ow9+hXf/8JayiuTVDgUStT51BtKzU=;
        b=DjqnuM7wzaKU4qq/EF17jReQbbqhfmsY1s7m3+fBngTvVjCo2jj/7sMRJsPHvsN1+1
         q+P1AZIYF1qMfanCF75/QWmcS2sdA9DCrGaqD04yEAn5W1kkF8ZX94tKZkSHzu+CMm/D
         7Sys/F/lGykDFJfJjDCPP66+/nEsL15dnoLBRr8R3+llDJUoQPQJZ28FUMfdNJIF2VE1
         hOvQaQ6QW2Z6mmOcQgfySCkYA5BZGyRbr6+WhXO3XIQNU1bfps8W/KiH2vrDOffblDkR
         AbAB0nru+H50F9gtG84Y8kE8uTKH72BLQ71iCSgVuh5en2SivxOGDhFWroOURO2RhnCH
         3UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700210970; x=1700815770;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rbv+r+ppwEUPn8ow9+hXf/8JayiuTVDgUStT51BtKzU=;
        b=uVeEbhuxnMlYpj7KtwUY2BoqYx431Ijhz0exEyv7vDLl/B7JO3JVjjHxCM5qf453VH
         o5MyBbn8rpBdjq4eded9CwpxwJagaed105xI02wSVFhmcrp9flbDF/3XYjbDiJFQmfTi
         XZ1bCEQ1Y3YeUay02EsWyLKve8b5EZ5Q3qKqwEJqwqmZoX+g3QTli81PhSyuVFgvTQZh
         Arp+/uKuyhup5t49zgW1Ch+iobnttLFxER19lcOWUEf7T9vfePeaftA6ktyAe4NzQwJ2
         IFu4nC5zwiEHLOF39ZyNcyLBr20gYlOzd1xFxIOIpuooX+fT0fje+naLWG0Ri1jDqyOt
         PQxw==
X-Gm-Message-State: AOJu0YwAAKjfvAoBRZXTGEU2daiXnQy02uAElTfjfI3ECULDEg0ZrXGc
        wGLDreJcnjFx4KmX9dzVV1886A==
X-Google-Smtp-Source: AGHT+IHbLLanJXF1s064IWXZYvm0+1EUT3rkvAWo2dTcspQO2Su78NjgMtsNLGqxMrA/EwETi6VzuA==
X-Received: by 2002:a4a:9205:0:b0:589:df75:2d83 with SMTP id f5-20020a4a9205000000b00589df752d83mr16733953ooh.1.1700210969734;
        Fri, 17 Nov 2023 00:49:29 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v4-20020a4a5a04000000b00587947707aasm239258ooa.4.2023.11.17.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:49:28 -0800 (PST)
Date:   Fri, 17 Nov 2023 00:49:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        =?ISO-8859-15?Q?Jos=E9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] mm: fix oops when filemap_map_pmd() without prealloc_pte
Message-ID: <6ed0c50c-78ef-0719-b3c5-60c0c010431c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reports oops in lockdep's __lock_acquire(), called from
__pte_offset_map_lock() called from filemap_map_pages(); or when I run
the repro, the oops comes in pmd_install(), called from filemap_map_pmd()
called from filemap_map_pages(), just before the __pte_offset_map_lock().

The problem is that filemap_map_pmd() has been assuming that when it
finds pmd_none(), a page table has already been prepared in prealloc_pte;
and indeed do_fault_around() has been careful to preallocate one there,
when it finds pmd_none(): but what if *pmd became none in between?

My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made
it easy for *pmd to be cleared while servicing a page fault; but even
before those, a huge *pmd might be zapped while a fault is serviced.

The difference in symptomatic stack traces comes from the "memory model"
in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
models that is strict, and will oops on the NULL prealloc_pte; in other
models, it will construct a bogus value to be populated into *pmd, then
__pte_offset_map_lock() oops when trying to access split ptlock pointer
(or some other symptom in normal case of ptlock embedded not pointer).

Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@google.com/
Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekkarinen@foxhound.fi/
Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>    [5.12+]
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9710f43a89ac..3d4dae9d1070 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3371,7 +3371,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 		}
 	}
 
-	if (pmd_none(*vmf->pmd))
+	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
 		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
 	return false;
-- 
2.35.3
