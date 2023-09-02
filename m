Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4922C7908A0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjIBQGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIBQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:05:59 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Sep 2023 09:05:55 PDT
Received: from mx1.elvees.com (mx1.elvees.com [37.203.242.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1390
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=elvees.com; s=mx; c=simple/simple;
        t=1693669826; h=from:subject:to:date:message-id;
        bh=vbYC2iRx/P6skGaML7zVGae1Xvth8mpMiwxLuDO5wiM=;
        b=fu0B+6PEfJUlsZs1WiftHYBORXOo047eDEbHh019hfNBIP1d5w7HWUcJeeLCq4ohgDbTBCG6Ezq
        iGaBLmOHE5SHP15LKj//d7Svwt2tyY0fFfTcq1V7lY3ZUx5glBygX+Y8rm3Rrr5tCPbiDzk9XeoR7
        h+HZFhyy3tbcrGOxQd6lZoZh4DGoGtdrLqKg6diAwW/vE2T30bGIX5jclBJ1/2yQitgg2u6VDHGD/
        URQADjLGqFuPd3CaQ/kMADRaVJWA/jAmGIemWb9v5lvXag8eFIjF7E8WOP3NVs5mQ6QLNovfCTP5J
        2ROjmzjU03BTm7NsaRJwAC5/eW52DBKBXd5w==
From:   Anton Leontiev <aleontiev@elvees.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] checkpatch: Avoid warnings for numbered references with URL
Date:   Sat, 2 Sep 2023 18:50:05 +0300
Message-ID: <20230902155006.1561074-1-aleontiev@elvees.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mx1.elvees.com (192.168.65.4) To mx1.elvees.com
 (192.168.65.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numbered references is one of the most frequently used ways to link
external resources and them often exeed 75 chars. Add exception for
these lines.

Signed-off-by: Anton Leontiev <aleontiev@elvees.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..929574f43d4d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3270,6 +3270,8 @@ sub process {
 					# filename then :
 		      $line =~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i ||
 					# A Fixes:, link or signature tag line
+		      $line =~ /^\s*\[\d+\]\s+[a-z][\w\.\+\-]*:\/\/\S+/i ||
+					# reference with URL
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
-- 
2.41.0

