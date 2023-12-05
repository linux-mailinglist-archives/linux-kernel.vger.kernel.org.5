Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195E805EAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjLETeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLETeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:34:18 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB36AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:34:23 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a051:433:f7fa:99b4])
        by andre.telenet-ops.be with bizsmtp
        id JjaH2B00d0xLcQm01jaHy0; Tue, 05 Dec 2023 20:34:20 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1rAbB6-00B6ne-TW;
        Tue, 05 Dec 2023 20:34:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1rAbBR-002zxt-FN;
        Tue, 05 Dec 2023 20:34:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Louis Peens <louis.peens@corigine.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Simon Horman <horms@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] checkpatch: Also accept commit ids with 13-40 chars of sha1
Date:   Tue,  5 Dec 2023 20:34:16 +0100
Message-Id: <62f82b0308de05f5aab913392049af15d53c777d.1701804489.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/dev-tools/checkpatch.rst says:

  **GIT_COMMIT_ID**
    The proper way to reference a commit id is:
    commit <12+ chars of sha1> ("<title line>")

However, scripts/checkpatch.pl has two different checks: one warning
check accepting 12 characters exactly:

    # Check Fixes: styles is correct
    Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")'

and a second error check accepting 12-40 characters:

    # Check for git id commit length and improperly formed commit descriptions
    # A correctly formed commit description is:
    #    commit <SHA-1 hash length 12+ chars> ("Complete commit subject")
    Please use git commit description style 'commit <12+ chars of sha1>

Hence patches containing commit ids with more than 12 characters are
flagged by checkpatch, and sometimes rejected by maintainers or
reviewers.

Fix this by aligning the first check with the second check, and with the
documentation.

Fixes: bd17e036b495bebb ("checkpatch: warn for non-standard fixes tag style")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Perhaps the time is ripe to increase the minimum from 12 to 16 chars
(in a follow-up patch)?

Running git-unique-abbrev[1] on a tree containing v6.7-rc3 and all
stable releases gives:

    12000853 objects
     4: 12000853 / 65536
     5: 12000717 / 1048423
     6: 6130888 / 2703295
     7: 525025 / 260563
     8: 33736 / 16861
     9: 2106 / 1053
    10: 160 / 80
    11: 10 / 5
    12: 0 / 0
    21cf4d54d3c702ac20c6747fa6d4f64dee07dd11
    21cf4d54d3ced8a3e752030e483d72997721076d
    8a048bbf89528d45c604aed68f7e0f0ef957067d
    8a048bbf895b1359e4a33b779ea6d7386cfe4de2
    d3ac4e475103c4364ecb47a6a55c114d7c42a014
    d3ac4e47510ec0753ebe1e418a334ad202784aa8
    d597639e2036f04f0226761e2d818b31f2db7820
    d597639e203a100156501df8a0756fd09573e2de
    ef91b6e893a00d903400f8e1303efc4d52b710af
    ef91b6e893afc4c4ca488453ea9f19ced5fa5861

12000853 is still smaller than sqrt(16^12) = 16777216, but the safety
margin is getting smaller.  E.g. my main work tree already contains
almost 18M objects.  Hence the Birthday Paradox states that collisions
of 12 char sha1 values are imminent.

Note that we standardized on 12 chars in commit d311cd44545f2f69
("checkpatch: add test for commit id formatting style in commit log") in
v3.17.  For comparison, running git-unique-abbrev on a tree with all
(upstream + stable) releases from that era gives:

    4052307 objects
     4: 4052307 / 65536
     5: 3966948 / 940963
     6: 869691 / 417363
     7: 61208 / 30523
     8: 3979 / 1989
     9: 258 / 129
    10: 24 / 12
    11: 6 / 3
    12: 0 / 0
    21cf4d54d3c702ac20c6747fa6d4f64dee07dd11
    21cf4d54d3ced8a3e752030e483d72997721076d
    d597639e2036f04f0226761e2d818b31f2db7820
    d597639e203a100156501df8a0756fd09573e2de
    ef91b6e893a00d903400f8e1303efc4d52b710af
    ef91b6e893afc4c4ca488453ea9f19ced5fa5861

So the number of objects increased threefold during the last 9 years.

Thanks for your comments!

[1] https://blog.cuviper.com/2013/11/10/how-short-can-git-abbreviate/
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda1128aa9..a4e178a68f6d1d5f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3209,7 +3209,7 @@ sub process {
 				$tag_case = 0 if $tag eq "Fixes:";
 				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
 
-				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
+				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12,40}$/i);
 				$id_case = 0 if ($orig_commit !~ /[A-F]/);
 
 				# Always strip leading/trailing parens then double quotes if existing
@@ -3226,7 +3226,7 @@ sub process {
 			if ($ctitle ne $title || $tag_case || $tag_space ||
 			    $id_length || $id_case || !$title_has_quotes) {
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
 				}
-- 
2.34.1

