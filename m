Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0257E08AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbjKCTCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKCTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:02:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031A6BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:02:02 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3IlS9m025788;
        Fri, 3 Nov 2023 19:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=fWctpsPV3PH/7sLW4j6O5J5E8Yl+oUi96i/KVhJR+g8=;
 b=Y6wJlKjpkHD8kbOPFPNSt0/VmmKgObJTIBnjqq/KLDxwc+FbXJ2bXfVbw271p43Bys1t
 kCaNc7bpB4SPCvy6TATjg52abxeKoQG2mRqNus7ReXkbPgJDAT5EfUfLiisrre1G+TOj
 cMh0EAwOFLEEM3yvSnAOM+k38pZxHo1LsvWU5+q/eUDXbtdHflQ4SmGQUiMCl5wW8xuv
 mA0gsNw3zMkKEuDw2FsNh8191SrcjaQgyoKLM+p1N3Lx8NlN66Zg9Rg+nUH24DcSQuoc
 b5UdVuS05POo7aeHjUemQKaQ+LSIUbQafpIJ+BrPgymaiIoVphzixAvntc8ye7Zw6GQX nA== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3u54v6s1r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 19:01:20 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4A7651317B;
        Fri,  3 Nov 2023 19:01:19 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id AB4A480E713;
        Fri,  3 Nov 2023 19:01:08 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 20D90302F47FB; Fri,  3 Nov 2023 14:01:08 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH v2] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date:   Fri,  3 Nov 2023 14:01:08 -0500
Message-Id: <20231103190108.184817-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qaegrJ8pxD5nlpULjEzqJp2JfCpzm-Fm
X-Proofpoint-GUID: qaegrJ8pxD5nlpULjEzqJp2JfCpzm-Fm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030159
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

