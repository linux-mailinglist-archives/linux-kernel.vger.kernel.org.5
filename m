Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D067DD6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbjJaTr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjJaTr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:47:56 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C2F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:47:53 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VJ2QE7028066;
        Tue, 31 Oct 2023 19:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=fuoe8SHo17mdtUlOr2e06tNTUEKZlOmQh+uTt7gFLoo=;
 b=H6OnVwfuMvF1bflLWi/LVg/pQ4DoGnEkwtHFUVZa1fUswxiMClHfR5tgM1n8YfmtvrHo
 epjMIv9DTt9jdqRzHXcqw14fommPpZLclmgoxIMMytvSiKP20edeqG1INYFxNgE7t02G
 hbfs5fPIfAXSTmz0pUPyDAuVcV/wDpjK+YdzFrmPTnIBuo3xkG3AgRikjKH6+z0T/HOB
 vf2U2oPqrUzigdXrRs3z06/nd2lyZFEABXRizLK+813VWoAhBUc8UsX/HhHlJemOakng
 VPOjGD8GCOYtKyEswiY7D/UbxHP+MQ2z4Y1VVrc5Vp9ziEYQaCIlQDglM7QMWk2i6O3y Gg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3u342n3h8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 19:46:59 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1AB95131AD;
        Tue, 31 Oct 2023 19:46:59 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 01E8C812BA6;
        Tue, 31 Oct 2023 19:46:56 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 4EC79302F47FB; Tue, 31 Oct 2023 14:46:56 -0500 (CDT)
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
Date:   Tue, 31 Oct 2023 14:46:56 -0500
Message-Id: <20231031194656.2046316-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zYutFqCVYG13dDDpz8FmPBW9utMrKl0C
X-Proofpoint-ORIG-GUID: zYutFqCVYG13dDDpz8FmPBW9utMrKl0C
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_06,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310159
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

[HPE only, 3rd version.  Nobody noticed that I had typoed "x68"
instead of "x86" in the subject line!  Glad I caught it.  But mostly,
incorporated Uwe's and Dimitri's suggestions.  Need to test with the
change to make sure it still works, though.]

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

