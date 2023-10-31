Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A17DD6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjJaT7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjJaT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:59:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4879C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:59:21 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VDWgBN009110;
        Tue, 31 Oct 2023 19:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=EAVA3QRBlRTCAPL3OoZCRFS0+fakGmgPKSgrygqN48U=;
 b=XgT75fG5L/rBas6c+JjW0rq1lXfkzWq8/aHHzdixH4i5d+/tG3mSYNwUNbYj743lDHxE
 N+qp49qrj6jqS86e+WYCpB47d2W03W7bw3YcZT3pE+kGTixm+NvvJuN/+jRucPAz1e1T
 HXhBt/7aJexSzOmW1n1odyd4bQvsv9+6GOqmO3AjcgC+FkIphHGWErDZ7BiueC5j+0tX
 ZdcKhAuhc0Jc8grHmXAc8fxi3Gp4Bp5LKSEszzLhPHeKFBMn7KLx/CXU4+VTTz/Hm65R
 G6HkiHRLkOkA2+/Z97nbaym+4SmOtlQ8Gca0Rg7zS/rLIFFYHnWwfLy4+Vyjw9JGYV5+ nw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3u3215dp62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 19:58:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D283080046F;
        Tue, 31 Oct 2023 19:58:53 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A5E0E80805C;
        Tue, 31 Oct 2023 19:58:49 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 8C2DA302F47FB; Tue, 31 Oct 2023 14:50:49 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>, rja_direct@groups.int.hpe.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date:   Tue, 31 Oct 2023 14:50:49 -0500
Message-Id: <20231031195049.2075561-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LLvxAdC1Hr9Rd9kgWXiVGW3GalB_IM5z
X-Proofpoint-ORIG-GUID: LLvxAdC1Hr9Rd9kgWXiVGW3GalB_IM5z
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_07,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310162
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using gbpages for all memory regions, use them only when
map creation requests include the full GB page of space; descend to
using smaller 2M pages when only portions of a GB page are requested.

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

Please ignore previous send with internal message.  Thanks.

 arch/x86/mm/ident_map.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..b63a1ffcfe9f 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -31,18 +31,26 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
+		/*
+		 * if gbpages allowed, this entry not yet present, and
+		 * the full gbpage range is requested (both ends are
+		 * correctly aligned), create a gbpage.
+		 */
+		if (info->direct_gbpages
+		    && !pud_present(*pud)
+		    && !(addr & ~PUD_MASK)
+		    && !(next & ~PUD_MASK)) {
 			pud_t pudval;
 
-			if (pud_present(*pud))
-				continue;
-
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
 		}
 
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
+
 		if (pud_present(*pud)) {
 			pmd = pmd_offset(pud, 0);
 			ident_pmd_init(info, pmd, addr, next);
-- 
2.26.2

