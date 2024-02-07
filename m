Return-Path: <linux-kernel+bounces-57306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820C84D6CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A51F23513
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6120335;
	Wed,  7 Feb 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AP9MSno1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD31EB2B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350185; cv=none; b=McUAKk2BlT0FgtZ/DKMcTtfm/LOlR44SjcRIUskApORqjBUhe4/Qps8DJxqzS6+RRu+2Eq98jBhTpmxSlcUtBBxHSUFdO510TI2m8N6pkAJpYgmYopjOVcPF/eMB6G5xL22VleIjFSwudOcGhUDFOTb0xsnWoExUipkcjzUaWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350185; c=relaxed/simple;
	bh=olXKOEtFICuarB+A1Plr5Q6pk9xJ3SBVVYmbulfIKPw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=foACUT5XOsZPnDZZeukp9LuJeHPaSx3b2bvUuqiqwq6hxAzpS1WD1dy1fBsDojLNU7PLO1tAksUkvuELn+2grcrg/gw3HQmiMfuDVjrWJZr6FBneAXjIZu5EAUPbjnUp/mPq7CD/paFaGflgQxLFbrhaZDsXDCjinGcJkTk1s7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AP9MSno1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B93AC433F1;
	Wed,  7 Feb 2024 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707350185;
	bh=olXKOEtFICuarB+A1Plr5Q6pk9xJ3SBVVYmbulfIKPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AP9MSno1xVJ7P5OcbiS3b8nLGkGyrV5wo314dvJCWaT2KIpEdrvqLt/o+Eb3lTMLF
	 TyipGNpYwzssX6qnz2ncIymRZKejRRCYpTn6iFnhumkH/ZvSbfUFgfpk6XKrm6jm02
	 JAEBRE+AZbMQGC6pFShPhx7GsjWPsYsaBOdXDAik=
Date: Wed, 7 Feb 2024 15:56:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
 <qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>, <urezki@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, "Uladzislau Rezki (Sony)"
 <urezki@gmail.com>
Subject: Re: [PATCH] scripts/gdb/vmalloc: fix vmallocinfo error
Message-Id: <20240207155623.a943328ba0b77859246e0d9f@linux-foundation.org>
In-Reply-To: <20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com>
References: <20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 16:58:51 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:

> We met the gdb vmallocinfo issue as following.
> 
> (gdb) lx-vmallocinfo
> Python Exception <class 'gdb.error'>: No symbol "vmap_area_list" in current context.
> Error occurred in Python: No symbol "vmap_area_list" in current context.
> 
> Since Mitigate a vmap lock contention patchset [1], we
> remove the vmap_area_list.

I don't think that's correct?

> We need to use vmap_nodes to iterate all vmallocinfo.
> 
> [1] https://lore.kernel.org/linux-mm/20240102184633.748113-1-urezki@gmail.com/

vmap_area_list was removed by https://lkml.kernel.org/r/20240102184633.748113-6-urezki@gmail.com

So I think this patch is actually a fix against mm.git:mm-unstable's
mm-vmalloc-remove-vmap_area_list.patch?

However this gdb function was probably probably broken earlier in that
series, so perhaps this patch would be best staged as a predecessor to
Ulad's vmalloc series.

> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Cc: Casper Li <casper.li@mediatek.com>
> ---
>  scripts/gdb/linux/vmalloc.py | 56 +++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/scripts/gdb/linux/vmalloc.py b/scripts/gdb/linux/vmalloc.py
> index d3c8a0274d1e..803f17371052 100644
> --- a/scripts/gdb/linux/vmalloc.py
> +++ b/scripts/gdb/linux/vmalloc.py
> @@ -29,32 +29,34 @@ class LxVmallocInfo(gdb.Command):
>          if not constants.LX_CONFIG_MMU:
>              raise gdb.GdbError("Requires MMU support")
>  
> -        vmap_area_list = gdb.parse_and_eval('vmap_area_list')
> -        for vmap_area in lists.list_for_each_entry(vmap_area_list, vmap_area_ptr_type, "list"):
> -            if not vmap_area['vm']:
> -                gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
> -                    vmap_area['va_end'] - vmap_area['va_start']))
> -                continue
> -            v = vmap_area['vm']
> -            gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
> -            if v['caller']:
> -                gdb.write(" %s" % str(v['caller']).split(' ')[-1])
> -            if v['nr_pages']:
> -                gdb.write(" pages=%d" % v['nr_pages'])
> -            if v['phys_addr']:
> -                gdb.write(" phys=0x%x" % v['phys_addr'])
> -            if v['flags'] & constants.LX_VM_IOREMAP:
> -                gdb.write(" ioremap")
> -            if v['flags'] & constants.LX_VM_ALLOC:
> -                gdb.write(" vmalloc")
> -            if v['flags'] & constants.LX_VM_MAP:
> -                gdb.write(" vmap")
> -            if v['flags'] & constants.LX_VM_USERMAP:
> -                gdb.write(" user")
> -            if v['flags'] & constants.LX_VM_DMA_COHERENT:
> -                gdb.write(" dma-coherent")
> -            if is_vmalloc_addr(v['pages']):
> -                gdb.write(" vpages")
> -            gdb.write("\n")
> +        nr_vmap_nodes = gdb.parse_and_eval('nr_vmap_nodes')
> +        for i in range(0, nr_vmap_nodes):
> +            vn = gdb.parse_and_eval('&vmap_nodes[%d]' % i)
> +            for vmap_area in lists.list_for_each_entry(vn['busy']['head'], vmap_area_ptr_type, "list"):
> +                if not vmap_area['vm']:
> +                    gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
> +                        vmap_area['va_end'] - vmap_area['va_start']))
> +                    continue
> +                v = vmap_area['vm']
> +                gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
> +                if v['caller']:
> +                    gdb.write(" %s" % str(v['caller']).split(' ')[-1])
> +                if v['nr_pages']:
> +                    gdb.write(" pages=%d" % v['nr_pages'])
> +                if v['phys_addr']:
> +                    gdb.write(" phys=0x%x" % v['phys_addr'])
> +                if v['flags'] & constants.LX_VM_IOREMAP:
> +                    gdb.write(" ioremap")
> +                if v['flags'] & constants.LX_VM_ALLOC:
> +                    gdb.write(" vmalloc")
> +                if v['flags'] & constants.LX_VM_MAP:
> +                    gdb.write(" vmap")
> +                if v['flags'] & constants.LX_VM_USERMAP:
> +                    gdb.write(" user")
> +                if v['flags'] & constants.LX_VM_DMA_COHERENT:
> +                    gdb.write(" dma-coherent")
> +                if is_vmalloc_addr(v['pages']):
> +                    gdb.write(" vpages")
> +                gdb.write("\n")
>  
>  LxVmallocInfo()
> -- 
> 2.18.0

