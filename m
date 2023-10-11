Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05C57C5D77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJKTOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJKTOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:14:21 -0400
Received: from qs51p00im-qukt01080102.me.com (qs51p00im-qukt01080102.me.com [17.57.155.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A45C8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1697051659;
        bh=Yt9FRATELcFyOe7YzufzD3h35YavtSY/IkLeUwwrWtA=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=snd+ZFo7e3+tLsd/UsGRX4e4R6uA2NUV6AiQhHlGDqvddbFHtyZvtpMmSbYEWw1Fv
         83R2gWgBIHPm8fa+1sMzawveK1QcoUv2vukiBhxg3RH+QY5kgjOsUMR/ytLunSTF5D
         wBq/9Nhx3BLk8ageBllxKJgIpdISZQtkAzkNnhV1SoVkeNRQwOHQ62HyiHV1J3YZxg
         Hj2nr86dz8MAPPzjaMHQXv3eRyYSW5W1+keW180P66bu+G6mXJMFGyazeaaHC5kSOu
         HlcJxgfDiJzxc0TFHwOR4YRv4izTU48eJDFicis9naokDD358ga7BasKs7R6x43o7f
         tHLWs3RZF1wdw==
Received: from fedora.fritz.box (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080102.me.com (Postfix) with ESMTPSA id 1B3291CC00FF;
        Wed, 11 Oct 2023 19:14:17 +0000 (UTC)
Date:   Wed, 11 Oct 2023 21:14:15 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/lockdep: fix format-truncation compiler-warning
Message-ID: <ZSb0B+9otHhd8jCp@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: WxoFQ0PqCK9AMrj-kC9b4XBl4d77970q
X-Proofpoint-GUID: WxoFQ0PqCK9AMrj-kC9b4XBl4d77970q
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=996
 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310110170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler: gcc x86_64 v13.2.1
Config: allyesconfig, "treat warnings as errors" unset

This fixes a warning emitted by gcc, stating the output may be
truncated. The fix included increasing the buffer size to the one
denoted by gcc.

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

