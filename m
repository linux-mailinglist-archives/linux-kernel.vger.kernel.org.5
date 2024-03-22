Return-Path: <linux-kernel+bounces-110934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964F78865EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D243B1C234E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A08BE8;
	Fri, 22 Mar 2024 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJSBP2Y0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06479EF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084508; cv=none; b=eX1ZYZsDsyjov7rF2Nqdvx2+yh+eUNm1WgXDT/TGjbhfTiemaLq/gQDezZfDVj+HfnMnFZubuv/QpcueT4kHHlnl9wECJ7IXujKPGozV736r9TcKZSKTZyLjnKmoVwmIVJnUvz9OBDKljc8n4rgMQrXBV3IGiBZm0W9tlbfsZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084508; c=relaxed/simple;
	bh=ED76UqVGcFvZasm2GIsXkwJoehFzFT5sGjprEmiOfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aoC9FVwXbff+wGfqTzOs2QBYXg55qP/9VxS56Brqtx+sYYsfUoEf9h+lLb39BVHXiPTMuSBrLfOAfMr6V8JmiNb9bWjbMoWr00kHJUk9apZF6GwcDDfvgx1o1tuGYXIa80UitedaYj3UmrzeYM3V+Pbt8/crtJMD0x42bsD1akw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJSBP2Y0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XN7aKzLGzOynIr0BudMXIoLSM7riB5hVf4BhIx/IKms=;
	b=VJSBP2Y0Uz35slEYdnBfWZzR/wMBbGWuON7GulnU0GynLfhcANrtoCP3wU83uMlaI9lQ99
	6ncX55ytiJvwCVRLueKlr3s0rhD2irckLxJT9qkQ9TR6tWTpyY5avuWmkyuulDoNeOTHYr
	HwTm/vqOHxNwDkln/L3yFbeSEsvYmcM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-s20SBmZqMCmRz5AOcn013Q-1; Fri,
 22 Mar 2024 01:14:59 -0400
X-MC-Unique: s20SBmZqMCmRz5AOcn013Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16080380662A;
	Fri, 22 Mar 2024 05:14:59 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 714921C060A4;
	Fri, 22 Mar 2024 05:14:53 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:15:08 +0800
From: Dave Young <dyoung@redhat.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"Huang, Kai" <kai.huang@intel.com>, Jiri Bohac <jbohac@suse.cz>
Subject: [PATCH V3] x86/kexec: do not update E820 kexec table for setup_data
Message-ID: <Zf0T3HCG-790K-pZ@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

crashkernel reservation failed on a Thinkpad t440s laptop recently. 
Actually the memblock reservation succeeded, but later insert_resource()
failed.

Test steps:
kexec load -> /* make sure add crashkernel param eg. crashkernel=160M */
    kexec reboot -> 
        dmesg|grep "crashkernel reserved";
            crashkernel memory range like below reserved successfully:
            0x00000000d0000000 - 0x00000000da000000
        But no such "Crash kernel" region in /proc/iomem

The background story is like below:

Currently E820 code reserves setup_data regions for both the current
kernel and the kexec kernel, and it inserts them into the resources list.
Before the kexec kernel reboots nobody passes the old setup_data, and
kexec only passes fresh SETUP_EFI/SETUP_IMA/SETUP_RNG_SEED if needed.
Thus the old setup data memory is not used at all.

Due to old kernel updates the kexec e820 table as well so kexec kernel
sees them as E820_TYPE_RESERVED_KERN regions, and later the old setup_data
regions are inserted into resources list in the kexec kernel by
e820__reserve_resources().

Note, due to no setup_data is passed in for those old regions they are not
early reserved (by function early_reserve_memory), and the crashkernel
memblock reservation will just treat them as usable memory and it could
reserve the crashkernel region which overlaps with the old setup_data
regions. And just like the bug I noticed here, kdump insert_resource
failed because e820__reserve_resources has added the overlapped chunks
in /proc/iomem already.

Finally, looking at the code, the old setup_data regions are not used
at all as no setup_data is passed in by the kexec boot loader. Although
something like SETUP_PCI etc could be needed, kexec should pass
the info as new setup_data so that kexec kernel can take care of them.
This should be taken care of in other separate patches if needed.

Thus drop the useless buggy code here.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
V3: Rebase to latest mainline [Jiri Bohac]
V2: changelog grammar fixes [suggestions from Huang Kai]
 arch/x86/kernel/e820.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

Index: linux/arch/x86/kernel/e820.c
===================================================================
--- linux.orig/arch/x86/kernel/e820.c
+++ linux/arch/x86/kernel/e820.c
@@ -1016,17 +1016,6 @@ void __init e820__reserve_setup_data(voi
 
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
-		/*
-		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
-		 * kexec and do not need to be reserved.
-		 */
-		if (data->type != SETUP_EFI &&
-		    data->type != SETUP_IMA &&
-		    data->type != SETUP_RNG_SEED)
-			e820__range_update_kexec(pa_data,
-						 sizeof(*data) + data->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
 		if (data->type == SETUP_INDIRECT) {
 			len += data->len;
 			early_memunmap(data, sizeof(*data));
@@ -1038,12 +1027,9 @@ void __init e820__reserve_setup_data(voi
 
 			indirect = (struct setup_indirect *)data->data;
 
-			if (indirect->type != SETUP_INDIRECT) {
+			if (indirect->type != SETUP_INDIRECT)
 				e820__range_update(indirect->addr, indirect->len,
 						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-				e820__range_update_kexec(indirect->addr, indirect->len,
-							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			}
 		}
 
 		pa_data = pa_next;
@@ -1051,7 +1037,6 @@ void __init e820__reserve_setup_data(voi
 	}
 
 	e820__update_table(e820_table);
-	e820__update_table(e820_table_kexec);
 
 	pr_info("extended physical RAM map:\n");
 	e820__print_table("reserve setup_data");


