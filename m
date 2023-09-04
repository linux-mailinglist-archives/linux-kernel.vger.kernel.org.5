Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF2791C56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353396AbjIDSIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350546AbjIDSIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:08:14 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D53113E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:08:11 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34ca1bcb48fso5242445ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693850890; x=1694455690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr3sV+XQtYagsN7Oqrbp+58+EQW5Ic/xyDIjYG4JLi4=;
        b=wu0/UY692LRIqexHVpewnKeH3ODnHZPiZarbI9nRtFjwhqZWEorAW2YMIjHDL70FF9
         KeHeSJ9YelYck0j8A9FZ5+D60L9SGX4enUT3KCuvbpMLEvwUt2bMxvpXLG2F65PKXu4O
         vS6pf8RdiFlW0pJDsMvLokkTXqoncECmwO9os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693850890; x=1694455690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zr3sV+XQtYagsN7Oqrbp+58+EQW5Ic/xyDIjYG4JLi4=;
        b=NkROKVMY4V3TjVw/cs4hwp4/Kn03rR9VFymr42dMRzuGgAziMCFphbDtnl3Da2cx1I
         XXiqQASvHt7pgfIF9WWXKcjDyRXocWNBS1rg3qWzwl3PE6wx/vc1bdraON/X3rX0aHLW
         WI86tqG7zAFFLbcFvW8BdW2E0H0scKf+D3CtYsGxP+TV86rGilGVBKOma6UnBLBjXt1r
         jeygtjH+T6/ozueg44ENnceVSoea/cjxttUokyWUeQ5PJmxY+56DdhQ3DUBecFvPEbIE
         oEd/S1Atu03lAkAfmZI5kuWr90HRigjr2jLbjlBDOgBLwt71AsHlRVWOMtGegMeqVK1e
         E0/g==
X-Gm-Message-State: AOJu0YwEca4WzbpAlqH/RDM6IjE8jzo3cGmnScM7ut1Z+KQyRRelmnJj
        NsJtXTR+o+r2e1VE26UiYyjSuwbP6K48UyXNLKg=
X-Google-Smtp-Source: AGHT+IFbD+DaAQ3YbgG2+T0I0C6EZ5+DKMrgMuUdKzBowVD9B/0AeNCAjrN71tih8W71+pJaIVm+PA==
X-Received: by 2002:a92:d90b:0:b0:34c:e5c2:918b with SMTP id s11-20020a92d90b000000b0034ce5c2918bmr11118950iln.13.1693850890063;
        Mon, 04 Sep 2023 11:08:10 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id g15-20020a02b70f000000b0042bb13cb80fsm3520216jam.120.2023.09.04.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 11:08:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        stable@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
Date:   Mon,  4 Sep 2023 18:08:04 +0000
Message-ID: <20230904180806.1002832-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unsafe to dump vmalloc area information when trying to do so from
some contexts. Add a safer trylock version of the same function to do a
best-effort VMA finding and use it from vmalloc_dump_obj().

[applied test robot feedback on unused function fix.]
[applied Uladzislau feedback on locking.]

Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
Cc: stable@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/vmalloc.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..2c6a0e2ff404 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
-	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+	const void *caller;
+	struct vm_struct *vm;
+	struct vmap_area *va;
+	unsigned long addr;
+	unsigned int nr_pages;
 
-	vm = find_vm_area(objp);
-	if (!vm)
+	if (!spin_trylock(&vmap_area_lock))
+		return false;
+	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
+	if (!va) {
+		spin_unlock(&vmap_area_lock);
 		return false;
+	}
+
+	vm = va->vm;
+	if (!vm) {
+		spin_unlock(&vmap_area_lock);
+		return false;
+	}
+	addr = (unsigned long)vm->addr;
+	caller = vm->caller;
+	nr_pages = vm->nr_pages;
+	spin_unlock(&vmap_area_lock);
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
+		nr_pages, addr, caller);
 	return true;
 }
 #endif
-- 
2.42.0.283.g2d96d420d3-goog

