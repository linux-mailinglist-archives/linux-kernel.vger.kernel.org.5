Return-Path: <linux-kernel+bounces-91495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181FE87125B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177DD1C21348
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463717C69;
	Tue,  5 Mar 2024 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce4mchGP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD517BBE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602347; cv=none; b=DJOaSYcUAILBdltztosF0JUHu9GRQsiMu5YK6ZA7VldKRaBs+F6usQKKzRiCyNlEtFmDxDLbZ7wKGzOW+mEX03io2+SDtIqPMJAPMYragXaPNutuMrRB9NZ4bhrARgJdbdYFh3XjuVI5Jedt046hTw9TLxq+H88m7bgDQz06/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602347; c=relaxed/simple;
	bh=bxRsx33uG+tvI+0+/+zWPbOYYCoEwiBWojsOZtWnp/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TmGgoFFUmV+yscd/Z6eKtgFpJGM93E2+iKSzhMvuwUgVgq8z3/1jit9DR+GxGIsa+SFj8MaS8JURMJCKzErk7lST7s0Dz6KvInaOA82KUHEBT8t9aCI8VrCHIUnUwG/AtE55Qn0GFdLMdUJPuSnnRdVNZQ2ijO1TzzHumKBhgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce4mchGP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709602344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=i/7fD3ZNVp6TPhlanN5HBpulg6yBRQ6/2SajNxpxQMU=;
	b=ce4mchGPhtzjJLEd0tHKWT3SqkAIevXyNQ2ESqL83LKrHh2ClUzer4ZOZRc8/godFPtOZJ
	5yirt7YtpGhpvF9RTFAnvxHQVJUcC6y0+CrXoFpfQ0Abdr/dUZpLc3uq6ESzRx8rYHa+GU
	L527Mqr9vNAIveS7JBXxycX44fQUxAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-jFOecq4CM7O7pIByyYL5TA-1; Mon, 04 Mar 2024 20:32:17 -0500
X-MC-Unique: jFOecq4CM7O7pIByyYL5TA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 319E5862DC0;
	Tue,  5 Mar 2024 01:32:17 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B233492C1B;
	Tue,  5 Mar 2024 01:32:11 +0000 (UTC)
Date: Tue, 5 Mar 2024 09:32:26 +0800
From: Dave Young <dyoung@redhat.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] x86/kexec: do not update E820 kexec table for setup_data
Message-ID: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

crashkernel reservation failed on a Thinkpad t440s laptop recently,
Actually the memblock reservation succeeded, but later insert_resource()
failed.

Test step:
kexec load ->
	kexec reboot -> 
		check the crashkernel memory
		dmesg|grep "crashkernel reserved"; saw reserved suceeeded:
		0x00000000d0000000 - 0x00000000da000000
		grep Crash /proc/iomem: got nothing 

The background story is like below:
Currently E820 code reserves setup_data regions for both the current kernel
and the kexec kernel, and it will also insert them into resources list.
Before the kexec kernel reboot nobody passes the old setup_data, kexec only
passes SETUP_EFI and SETUP_IMA if needed.  Thus the old setup data memory
are not used at all. But due to old kernel updated the kexec e820 table
as well so kexec kernel see them as E820_TYPE_RESERVED_KERN regions, later
the old setup_data regions will be inserted into resources list in kexec
kernel by e820__reserve_resources().

Note, due to no setup_data passed in for those old regions they are not
early reserved (by function early_reserve_memory), crashkernel memblock
reservation will just regard them as usable memory and it could reserve
reserve crashkernel region overlaps with the old setup_data regions.

Just like the bug I noticed here, kdump insert_resource failed because
e820__reserve_resources added the overlapped chunks in /proc/iomem already.

Finally, looking at the code, the old setup_data regions are not used
at all as no setup_data passed in by the kexec boot loader. Although
something like SETUP_PCI etc could be needed, kexec should pass
the info as setup_data so that kexec kernel can take care of them.
This should be taken care of in other separate patches if needed.

Thus drop the useless buggy code here.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/e820.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

Index: linux/arch/x86/kernel/e820.c
===================================================================
--- linux.orig/arch/x86/kernel/e820.c
+++ linux/arch/x86/kernel/e820.c
@@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
 		pa_next = data->next;
 
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
-		/*
-		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
-		 * to be reserved.
-		 */
-		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
-			e820__range_update_kexec(pa_data,
-						 sizeof(*data) + data->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
 		if (data->type == SETUP_INDIRECT) {
 			len += data->len;
 			early_memunmap(data, sizeof(*data));
@@ -1036,12 +1026,9 @@ void __init e820__reserve_setup_data(voi
 
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
@@ -1049,7 +1036,6 @@ void __init e820__reserve_setup_data(voi
 	}
 
 	e820__update_table(e820_table);
-	e820__update_table(e820_table_kexec);
 
 	pr_info("extended physical RAM map:\n");
 	e820__print_table("reserve setup_data");


