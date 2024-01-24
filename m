Return-Path: <linux-kernel+bounces-37445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB683B024
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3048E1F27D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE447F7F2;
	Wed, 24 Jan 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IUCzHBS9"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E186122
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117820; cv=none; b=oCgE4+bJJZt0Lr2YmvxH4kGYQnBL4iTuXskw0U2JTlwwE9JHNYc+LgyD/B/6V7q+prlhCQMBZ6MyU/FVTO6j6iIe6crvd1Hn5M3vQDn9yDENuol76KvR9Tm9fxw2slMUtCz9SBDxEWRuGL4ZGon2aLQ3/6qyjBFFS4HbNXXAQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117820; c=relaxed/simple;
	bh=vh7NFfbRQEjBaiedUfRq09BGrOJdW2SC+u167MN0luo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFnvpwTJ8Qsb9LW/gIPZZZuukKolbOq8P/m16kNui20+JBaJWNa1QvgwMxoxQqlLnJh1nnQI5YhJitoDMASGbBi4qZIbUyhzvz1rG39EGa/Q+jGQrpHU+tOpQujVXoE3+IEt1kiSVFOFLn2N+Hxl1z6hZEmvEz8kV01VEfKoH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IUCzHBS9; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OGTiDK004107;
	Wed, 24 Jan 2024 17:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=Krg2dCFaEEPhLZ1AkCCiTfx8ExylrpoCrTzDz+LXO6g=;
 b=IUCzHBS9jwsKFANgIKa9x64SM8uQBb0tKUoKZFtbQMYlQKlkCOuiVgDVl9UVH4YCsQ0j
 HDtG6M3stlHQpwS7S/eVNHQ5Gx+fP71maGxw5+55BilFPH1eBPpH4KPCgo9DIKW4YbKC
 lynJJiH+76ZO80fL23W2Tuf4UYCZaDi82l6CCNoNIH4tO9F6ATTxnb1eqOtgPs2NNsWU
 KUXoTBAKR3lTaQSHHEVjAEjN3vdPH6m7FgmXw8QsqKgC5UieuV5IqMRCkxKsbhClb52K
 NzIGVkGTuegGU7WHfydLpBjviZKN/cgkGHxLXS3Bqb7n5BKXzey85ec7yXhNgxe/1ll0 2A== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vtybkcgaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 17:36:14 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id C519A132D4;
	Wed, 24 Jan 2024 17:36:12 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id DB5908014C9;
	Wed, 24 Jan 2024 17:36:11 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 2C2D330000BA5; Wed, 24 Jan 2024 11:36:11 -0600 (CST)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [repost PATCH v2] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date: Wed, 24 Jan 2024 11:36:11 -0600
Message-Id: <20240124173611.451057-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7UtMskBRxSzfvtFQZ8fsOYrlxKPeNGMY
X-Proofpoint-GUID: 7UtMskBRxSzfvtFQZ8fsOYrlxKPeNGMY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_07,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401240128

Instead of using gbpages for all memory regions, which can include
vast areas outside what's actually been requested, use them only when
map creation requests include the full GB page of space; descend to
using smaller 2M pages when only portions of a GB page are included in
the request.

No attempt is made to coalesce mapping requests. If a request requires
a map entry at the 2M (pmd) level, subsequent mapping requests within
the same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could theoretically have been combined to
map a full gbpage.  Existing usage starts with larger regions and then
adds smaller regions, so this should not have any great consequence.

When gbpages are used exclusively to create identity maps, large
ranges of addresses not actually requested can be included in the
resulting table.  On UV systems, this ends up including regions that
will cause hardware to halt the system if accessed (these are marked
"reserved" by BIOS).  Even though code does not actually make
references to these addresses, including them in an active map allows
processor speculation into this region, which is enough to trigger the
system halt.

The kernel option "nogbpages" will disallow use of gbpages entirely
and avoid this problem, but uses a lot of extra memory for page tables
that are not really needed.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
repost: no changes except for this note.  V2 got no replies.

v2: per Dave Hanson review: Additional changelog info,
    moved pud_large() check earlier in the code, and
    improved the comment describing the conditions
    that restrict gbpage usage.
   
 arch/x86/mm/ident_map.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..5c88c3a7d12a 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -31,13 +31,23 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
 
-			if (pud_present(*pud))
-				continue;
+		/*
+		 * To be eligible to use a gbpage:
+		 *   - gbpages must be enabled
+		 *   - addr must be gb aligned (start of region)
+		 *   - next must be gb aligned (end of region)
+		 *   - PUD must be empty (nothing already mapped in this region)
+		 */
+		if (info->direct_gbpages
+		    && !(addr & ~PUD_MASK)
+		    && !(next & ~PUD_MASK)
+		    && !pud_present(*pud)) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
-- 
2.26.2


