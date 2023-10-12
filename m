Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689097C6B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbjJLKok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbjJLKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:44:39 -0400
Received: from qs51p00im-qukt01072301.me.com (qs51p00im-qukt01072301.me.com [17.57.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C4B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1697107477;
        bh=yq1bB1i5jX+KR5ZvW1PeHQ3tn6oe1QEmig4Rs81s5Rk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=M0aZkX2C0YHEJP8NAXH9IYtTW4THutISzksYI1hNjjhgK5zfDTD7JsQBJtMliMXMG
         B1FVYna0EAIZUuWmBa/0fo0CoR7yaQ4T0B6E4BJNlDQ7O5rAZY5DIxiLkTVSFzBhmZ
         QSwllnEMKnkGA97kxf+O4mOGfSbn3d6Btp6BhOvKwHMbLiZAs2ZnoquaBxDxDPCj1X
         tcXkREtKoeMn/KzBlLG+LK+DD0w2hhXZhe7lUOeY19iFdXqu/owWeiOU8Svhxl/Eb5
         +VJW2xHv0ybrxKNQ2BKwUH2Xucq9iwy6Tiq1ZgkkGdftIBE9P7e3YO5Adql8p8Z8nV
         w+FPHov1pu48w==
Received: from fedora.fritz.box (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072301.me.com (Postfix) with ESMTPSA id CF145254012A;
        Thu, 12 Oct 2023 10:44:35 +0000 (UTC)
Date:   Thu, 12 Oct 2023 12:44:32 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] locking/lockdep: fix format-truncation
 compiler-warning
Message-ID: <ZSfOEHRkZAWaQr3U@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: R3R7EHdVMO0xJyjmohauPHRmxVbltBTd
X-Proofpoint-ORIG-GUID: R3R7EHdVMO0xJyjmohauPHRmxVbltBTd
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=935 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310120088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler: gcc x86_64 v13.2.1
Config: allyesconfig, "treat warnings as errors" unset

This fixes the following compiler-warnings emitted by GCC:
kernel/locking/lockdep_proc.c:438:32: Warning: Format specifier '%lld' may 
	be truncated when writing 1 to 17 bytes into a region 
	of size 15 [-Wformat-truncation=]
kernel/locking/lockdep_proc.c:438:31: Note: Format directive argument is 
	in the range [-9223372036854775, 9223372036854775]
kernel/locking/lockdep_proc.c:438:9: Note: 'snprintf' has output 
	between 5 and 22 bytes into a target of size 15

The longest s64 is "-9223372036854775808"-ish, which converted to the 
fixed-point float format is "-9223372036854775.80": 21 bytes, 
plus termination is another byte: 22. Therefore, a buffer size of 22 is
needed here.

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
---
 kernel/locking/lockdep_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 15fdc7fa5c68..e2bfb1db589d 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -440,7 +440,7 @@ static void snprint_time(char *buf, size_t bufsiz, s64 nr)
 
 static void seq_time(struct seq_file *m, s64 time)
 {
-	char num[15];
+	char num[22];
 
 	snprint_time(num, sizeof(num), time);
 	seq_printf(m, " %14s", num);
-- 
2.41.0

