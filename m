Return-Path: <linux-kernel+bounces-111773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA78870CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECB11F21FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124835820C;
	Fri, 22 Mar 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Ip4ViCWf"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50D57876;
	Fri, 22 Mar 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124562; cv=none; b=tkADdNLz/hxZynMV7dQvTCSY0g1D8fJr/OmSeKv0XkbVQJTL0hJwLCKwSyT5/+yUOJwIsJeSUg/1g9vPTly8lkye6lrO0KfeiZYrGd1pfnIlyKEKQl2HRj2UfCigFdCDwk62GhJyEmVvvUxTqw/jxDR8xDIs4Q7KlgEu88HFAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124562; c=relaxed/simple;
	bh=MAE8WIHU9ta7n4x/BR5+OwfH/AdkCJB+DKep9CrSiJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WU6L7jKXUFPk3aDOtkKkN3SfREgFK7IAXzX05wqAG+e7t+dZBoyBj/lo7jXik4/6Y+yThKCQm2HQU/cWaRue7VlMa9LO+L7zBzOGBCOWtvuuty/3eL8sLZte9+R/RzIT9KcQK3APyysYM3vdffFN7Y68A4XOdd4367rIUVTu3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Ip4ViCWf; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDWoAc020466;
	Fri, 22 Mar 2024 16:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=UkvndrBpowbSq2m7Khs+/6kDy0TN1ypmmFxO26zOD98=;
 b=Ip4ViCWf/re1gFk8m+T/teZhgpZs46nWSlanj0dgUdQM+i3bi6ofXxeEhI0whQMxJQxP
 55CHzRjLhQqxA9Fvv1CyvB30sh1I72nWJ6f7ZvvMl/jTYYvaZGKQWTxRd0Q8NOqPjuBx
 PLMShfMn/BGNilt7LHzLs4T10FIRDOfLkEK2XyW+oI9LSDxTX4x3YnR93LpO2AgNqkn0
 w7pxLQKU8ERnIBwQXSvOoWGwZLvH67X22uDS1/dg4nrsUT/48KTmYTZxHIOyMR5D7e6m
 JS1ZILLydV4+/XXoNiNjuMSVcdANOybSJcJW3R3fl/bVabV8uKdxiywkBRNnD6L7mlqW Ow== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x183dbayg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 16:21:57 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EC9B68059E3;
	Fri, 22 Mar 2024 16:21:55 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id DA6E9808350;
	Fri, 22 Mar 2024 16:21:51 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id A1A6B3000059D; Fri, 22 Mar 2024 11:21:35 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps except on UV platform.
Date: Fri, 22 Mar 2024 11:21:35 -0500
Message-Id: <20240322162135.3984233-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
X-Proofpoint-GUID: oYOSRYdA2RlWrO_MVfNl-dLggOq7mrmq
X-Proofpoint-ORIG-GUID: oYOSRYdA2RlWrO_MVfNl-dLggOq7mrmq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220117

Some systems have ACPI tables that don't include everything that needs
to be mapped for a successful kexec.  These systems rely on identity
maps that include the full gigabyte surrounding any smaller region
requested for kexec success.  Without this, they fail to kexec and end
up doing a full firmware reboot.

So, reduce the use of GB pages only on systems where this is known to
be necessary (specifically, UV systems).

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
Reported-by: Pavin Joseph <me@pavinjoseph.com>
Closes: https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
---
 arch/x86/include/asm/init.h        |  1 +
 arch/x86/kernel/machine_kexec_64.c |  3 +++
 arch/x86/mm/ident_map.c            | 13 +++++++------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index cc9ccf61b6bd..4ae843e8fefb 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -10,6 +10,7 @@ struct x86_mapping_info {
 	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
 	unsigned long offset;		 /* ident mapping offset */
 	bool direct_gbpages;		 /* PUD level 1GB page support */
+	bool direct_gbpages_always;	 /* use 1GB pages exclusively */
 	unsigned long kernpg_flag;	 /* kernel pagetable flag override */
 };
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..1e1c6633bbec 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/uv/uv.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -212,6 +213,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 
 	if (direct_gbpages)
 		info.direct_gbpages = true;
+	if (!is_uv_system())
+		info.direct_gbpages_always = true;
 
 	for (i = 0; i < nr_pfn_mapped; i++) {
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index a204a332c71f..8039498b9713 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -39,12 +39,13 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		/* Is using a gbpage allowed? */
 		use_gbpage = info->direct_gbpages;
 
-		/* Don't use gbpage if it maps more than the requested region. */
-		/* at the begining: */
-		use_gbpage &= ((addr & ~PUD_MASK) == 0);
-		/* ... or at the end: */
-		use_gbpage &= ((next & ~PUD_MASK) == 0);
-
+		if (!info->direct_gbpages_always) {
+			/* Don't use gbpage if it maps more than the requested region. */
+			/* at the beginning: */
+			use_gbpage &= ((addr & ~PUD_MASK) == 0);
+			/* ... or at the end: */
+			use_gbpage &= ((next & ~PUD_MASK) == 0);
+		}
 		/* Never overwrite existing mappings */
 		use_gbpage &= !pud_present(*pud);
 
-- 
2.26.2


