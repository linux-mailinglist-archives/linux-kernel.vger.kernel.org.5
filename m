Return-Path: <linux-kernel+bounces-40380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE183DF44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B181C2277D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613AA1DFC4;
	Fri, 26 Jan 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="JPsc2EQN"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5C1CA8E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288019; cv=none; b=jQey9WJUqiuCTD9r59SJ3uHP8ulhGt6oRLAllQBvrpQSPcbdQvVIPxod2LQudyh2XE/jkk7u0gfwM41RKqHaEoYX7jNr69VwF4F38dxB5EDL9vTE7lM0Beb7K8vCProDhXXVK24RJnCjeK84G+QNS8caoDMyyFSpLSLPnuEKpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288019; c=relaxed/simple;
	bh=GLHoAgN0WDNzZ/aExhvKQtnU54vP0hiTaSSU+vncRR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZsOnGRF0Z4wRc9CpA5qu1/Eb+lbGzHfNGp3mCPlXJIIMmUhOLIhjO240e4qsW7dvBY7fr4r1fXrjxuScpbUl8ME1Vbd+MiCYiBrCWJKYm14a3yLsoWJ7XfAVhgecMBvs0WtdY6Crh7Zqn845qGaHpJNUrxfJZr982P/nVlh+NVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=JPsc2EQN; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QGhZKq019589;
	Fri, 26 Jan 2024 16:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=9d5EG/UjfL0XrZpLrWZ9ABGs28w9fdnvwVF09Y3xcg0=;
 b=JPsc2EQNUmi5icUht4pY1NYKpI/7le0rATYkr9B7knj9wKHJLs9ND+4pWRQY68uJ/FtN
 Gy/NLvaFeyhG7l5ff6Tq679t7zCuZJ+V6NCp8JxXzsFn1RhsS7ik/uWCSANQ5Y/1FF7u
 /SIgzkXXR3dHh2VV9umrurEIup/Vla9mu29OvXlnbNOCLPFwq+Ts3aoyOI/GRCdXPPrI
 yw6ERdX4q5CSZmW1fUNBjGZcSWLHXxSsuADRO33gEmcJNgTDHam6bjaerQm9yLbVIeGB
 3pSXPdhHGg3BGueEr1O5f1rVc/KjnoxHhx1B5+ASg8jTjiBU+KigPvzvitDaexxR49vP sA== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vv5ddwa0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:48:45 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 9A60A80039D;
	Fri, 26 Jan 2024 16:48:44 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 75DB7800EF9;
	Fri, 26 Jan 2024 16:48:42 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id C222E3000059C; Fri, 26 Jan 2024 10:48:41 -0600 (CST)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH v3] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date: Fri, 26 Jan 2024 10:48:41 -0600
Message-Id: <20240126164841.170866-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lM1FwtgBsOfyjYjl2AfyZFj_O0Fc5pEn
X-Proofpoint-GUID: lM1FwtgBsOfyjYjl2AfyZFj_O0Fc5pEn
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401260124

When ident_pud_init() uses only gbpages to create identity maps, large
ranges of addresses not actually requested can be included in the
resulting table; a 4K request will map a full GB.  On UV systems, this
ends up including regions that will cause hardware to halt the system
if accessed (these are marked "reserved" by BIOS).  Even though code
does not actually make references to these addresses, including them
in an active map allows processor speculation into this region, which
is enough to trigger the system halt.

Instead of using gbpages for all memory regions, which can include
vast areas outside what's actually been requested, use them only when
map creation requests include the full GB page of space; descend to
using smaller 2M pages when only portions of a GB page are included in
the request.

No attempt is made to coalesce mapping requests. If a request requires
a map entry at the 2M (pmd) level, subsequent mapping requests within
the same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could have been combined to map a full
gbpage.  Existing usage starts with larger regions and then adds
smaller regions, so this should not have any great consequence.

The existing kernel option "nogbpages" would disallow use of
gbpages entirely and avoid this problem, but uses a lot of extra
memory for page tables that are not really needed.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---

v3: per Dave Hansen review, re-arrange changelog info,
    refactor code to use bool variable and split out conditions.

v2: per Dave Hansen review: Additional changelog info,
    moved pud_large() check earlier in the code, and
    improved the comment describing the conditions
    that restrict gbpage usage.
   
 arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..f50cc210a981 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
-- 
2.26.2


