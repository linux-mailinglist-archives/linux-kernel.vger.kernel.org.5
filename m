Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895127C8C44
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJMR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjJMR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:27:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E837C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:27:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249A7C433C7;
        Fri, 13 Oct 2023 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697218061;
        bh=IqG7fB9OIevVVYlNJDTPsuNDiAKmn7qxXQ6S04F0f9I=;
        h=From:To:Cc:Subject:Date:From;
        b=FYnKJKOeLDQaw9BflvX/fL1cuQZX3yDHwUZTbDqScRU03j+bANaZ67QMTfv2FAHhy
         Ob3O/5STX2G98t+S2I1Gf8FL8CU7Cc08S5ZSGd7Wp9o3Q8yyhBPvI1tpTD+79FsTMr
         fJhyARVdhf9zKcJkRzTP1TxDQS+++zqh/Q3bx7OdTRil2aibml8Y7t67HcWodRY/jt
         p5B1v5pi+H3mh0N0xVsclHvJZPpo6nkxzTNu9zVOQSR+7HmqybufWaAKgEBkrUwcCc
         WEg0kHrFH86+Mu4/xTk9DBp8t59LP9XJ5lANxdBCixqqqoSlLoAmS8CFq9qQCvTwXW
         BAqfq/0cel0AA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: avoid warning about Possible repeated word: 'Google'
Date:   Fri, 13 Oct 2023 10:27:39 -0700
Message-ID: <20231013172739.1113964-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot stack traces often come with the following line:

 Hardware name: Google Google Compute Engine/Google Compute Engine...

This generates the repeated word warning from checkpatch.
It hit 49 times in the last 6 months in networking
(false-positive rate of 0.34%). Mute the warning for "Google",
there's no other word which comes close to being this clear
cut false-positive in our traffic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: apw@canonical.com
CC: joe@perches.com
CC: dwaipayanray1@gmail.com
CC: lukas.bulwahn@gmail.com
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..c99f8f93cb4c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3524,6 +3524,8 @@ sub process {
 
 				next if (lc($first) ne lc($second));
 				next if ($first eq 'long');
+				# syzbot reports contain "Hardware name: Google Google Compute Engine"
+				next if ($first eq 'Google');
 
 				# check for character before and after the word matches
 				my $start_char = '';
-- 
2.41.0

