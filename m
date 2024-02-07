Return-Path: <linux-kernel+bounces-57308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13884D6D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0011F23D72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92831535D2;
	Wed,  7 Feb 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RskDEjDz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F8200BA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350370; cv=none; b=R67q59l9o7tEBmGHXx2IBLjvDQ13QDuO3Ers0vtPILeowyfSskyg5dAwZ3wV8Oq2P8j443Ce86tT1CmPLdZhUGP2jrTphUzP2avBLxAEmF5ZvjJCvZNMlE9oboHXwHh6FluG41BXdp0IVhQzKXjTjl9lBHPniED7juFbSI6H9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350370; c=relaxed/simple;
	bh=A2dMLCL0N8nSgdIq9wrTS7hQJhAGgTvpR/6aTe8uFIE=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cjarN2v1FcUn20u2QRzsNefI/w4bOnPjtXDuTNggmOlkOCdK4zAeVnRlpmrhax9u/0fHskbLfyTdHwVTg4s1Qzsf5l08RXuZSGxjm8lTItpJHbkbqSgUof/XaX93Cf8OLPk/gRgbbUUd4cGyWkWTlkii86afgBcldvjLwf1AwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RskDEjDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E73C433F1;
	Wed,  7 Feb 2024 23:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707350370;
	bh=A2dMLCL0N8nSgdIq9wrTS7hQJhAGgTvpR/6aTe8uFIE=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=RskDEjDzdZBhZa7SBbcC/31F5gD7ozdd58YpBawaxicaz/F/zARPTXGW9xcekssbm
	 LqpA1TA/KT8auYNR6HG7AyQh/ejCsWB/MmjvTF7hfwWXL/4THV1CF4RDZKZFFGu337
	 eFUtIWOr6VLSjkEB+WNaxOeucC4fFlUTVpQC252A=
Date: Wed, 7 Feb 2024 15:59:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <casper.li@mediatek.com>,
 <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
 <linux-mm@kvack.org>, <urezki@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] scripts/gdb/vmalloc: fix vmallocinfo error
Message-Id: <20240207155929.cc107bcc14b982789bdc9fab@linux-foundation.org>
In-Reply-To: <20240207155623.a943328ba0b77859246e0d9f@linux-foundation.org>
References: <20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com>
	<20240207155623.a943328ba0b77859246e0d9f@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 15:56:23 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> > [1] https://lore.kernel.org/linux-mm/20240102184633.748113-1-urezki@gmail.com/
> 
> vmap_area_list was removed by https://lkml.kernel.org/r/20240102184633.748113-6-urezki@gmail.com
> 
> So I think this patch is actually a fix against mm.git:mm-unstable's
> mm-vmalloc-remove-vmap_area_list.patch?
> 
> However this gdb function was probably probably broken earlier in that
> series, so perhaps this patch would be best staged as a predecessor to
> Ulad's vmalloc series.

ie, this:


From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: scripts/gdb/vmalloc: fix vmallocinfo error
Date: Wed, 7 Feb 2024 16:58:51 +0800

The patch series "Mitigate a vmap lock contention" removes vmap_area_list,
which will break the gdb vmallocinfo command:

(gdb) lx-vmallocinfo
Python Exception <class 'gdb.error'>: No symbol "vmap_area_list" in current context.
Error occurred in Python: No symbol "vmap_area_list" in current context.

So we can instead use vmap_nodes to iterate all vmallocinfo.

Link: https://lkml.kernel.org/r/20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Casper Li <casper.li@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/gdb/linux/vmalloc.py |   56 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 27 deletions(-)

--- a/scripts/gdb/linux/vmalloc.py~scripts-gdb-vmalloc-fix-vmallocinfo-error
+++ a/scripts/gdb/linux/vmalloc.py
@@ -29,32 +29,34 @@ class LxVmallocInfo(gdb.Command):
         if not constants.LX_CONFIG_MMU:
             raise gdb.GdbError("Requires MMU support")
 
-        vmap_area_list = gdb.parse_and_eval('vmap_area_list')
-        for vmap_area in lists.list_for_each_entry(vmap_area_list, vmap_area_ptr_type, "list"):
-            if not vmap_area['vm']:
-                gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
-                    vmap_area['va_end'] - vmap_area['va_start']))
-                continue
-            v = vmap_area['vm']
-            gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
-            if v['caller']:
-                gdb.write(" %s" % str(v['caller']).split(' ')[-1])
-            if v['nr_pages']:
-                gdb.write(" pages=%d" % v['nr_pages'])
-            if v['phys_addr']:
-                gdb.write(" phys=0x%x" % v['phys_addr'])
-            if v['flags'] & constants.LX_VM_IOREMAP:
-                gdb.write(" ioremap")
-            if v['flags'] & constants.LX_VM_ALLOC:
-                gdb.write(" vmalloc")
-            if v['flags'] & constants.LX_VM_MAP:
-                gdb.write(" vmap")
-            if v['flags'] & constants.LX_VM_USERMAP:
-                gdb.write(" user")
-            if v['flags'] & constants.LX_VM_DMA_COHERENT:
-                gdb.write(" dma-coherent")
-            if is_vmalloc_addr(v['pages']):
-                gdb.write(" vpages")
-            gdb.write("\n")
+        nr_vmap_nodes = gdb.parse_and_eval('nr_vmap_nodes')
+        for i in range(0, nr_vmap_nodes):
+            vn = gdb.parse_and_eval('&vmap_nodes[%d]' % i)
+            for vmap_area in lists.list_for_each_entry(vn['busy']['head'], vmap_area_ptr_type, "list"):
+                if not vmap_area['vm']:
+                    gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
+                        vmap_area['va_end'] - vmap_area['va_start']))
+                    continue
+                v = vmap_area['vm']
+                gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
+                if v['caller']:
+                    gdb.write(" %s" % str(v['caller']).split(' ')[-1])
+                if v['nr_pages']:
+                    gdb.write(" pages=%d" % v['nr_pages'])
+                if v['phys_addr']:
+                    gdb.write(" phys=0x%x" % v['phys_addr'])
+                if v['flags'] & constants.LX_VM_IOREMAP:
+                    gdb.write(" ioremap")
+                if v['flags'] & constants.LX_VM_ALLOC:
+                    gdb.write(" vmalloc")
+                if v['flags'] & constants.LX_VM_MAP:
+                    gdb.write(" vmap")
+                if v['flags'] & constants.LX_VM_USERMAP:
+                    gdb.write(" user")
+                if v['flags'] & constants.LX_VM_DMA_COHERENT:
+                    gdb.write(" dma-coherent")
+                if is_vmalloc_addr(v['pages']):
+                    gdb.write(" vpages")
+                gdb.write("\n")
 
 LxVmallocInfo()
_


