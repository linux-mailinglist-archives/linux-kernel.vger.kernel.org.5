Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964647D2DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJWJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJWJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:10:03 -0400
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1877A98;
        Mon, 23 Oct 2023 02:10:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.V5qfj36_1698052195;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V5qfj36_1698052195)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 17:09:56 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Darren Hart" <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "=?UTF-8?B?bWFpbnRhaW5lcjpYODYgQVJDSElURUNUVVJFIDMyLUJJVCBBTkQgNjQtQklU?=" 
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "=?UTF-8?B?bW9kZXJhdGVkIGxpc3Q6WEVOIEhZUEVSVklTT1IgWDg2?=" 
        <xen-devel@lists.xenproject.org>,
        "=?UTF-8?B?b3BlbiBsaXN0Olg4NiBQTEFURk9STSBEUklWRVJTIC0gQVJDSA==?=" 
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH 1/2] x86/xen/pvh: Set up percpu for stack canary in 32-bit kernel entry
Date:   Mon, 23 Oct 2023 17:09:38 +0800
Message-Id: <90df6cf5674241a85ac7dfe0a1558f1fd025cc17.1698051454.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1698051454.git.houwenlong.hwl@antgroup.com>
References: <cover.1698051454.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a 32-bit SMP kernel, the stack canary is a percpu variable accessed
as %fs:__stack_chk_guard. However, the ABI for PVH entry does not
specify the %fs register state. It currently works because the initial
%fs register is 0x10 for QEMU, which is the same as $PVH_DS_SEL.
%However, for added safety, the percpu should be set up explicitly
%before calling xen_prepare_pvh(), which accesses the stack canary.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/platform/pvh/head.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a05ab83..cee4dadf5344 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -121,6 +121,10 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 
 	ljmp $PVH_CS_SEL, $1f
 1:
+	/* Set percpu for stack canary. */
+	mov $PVH_DS_SEL,%eax
+	mov %eax, %fs
+
 	call xen_prepare_pvh
 	mov $_pa(pvh_bootparams), %esi
 
-- 
2.31.1

