Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A3279F300
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjIMUiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjIMUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:38:08 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB21BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:38:04 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 32609160494;
        Wed, 13 Sep 2023 20:38:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 0B01A2000E;
        Wed, 13 Sep 2023 20:38:00 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] checkpatch: Add a couple new alloc functions to alloc with multiplies check
Date:   Wed, 13 Sep 2023 13:37:52 -0700
Message-ID: <edb667e19211652a32ef6069159bb85dbc3bcdfc.1694636817.git.joe@perches.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694636817.git.joe@perches.com>
References: <cover.1694636817.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B01A2000E
X-Spam-Status: No, score=-0.10
X-Rspamd-Server: rspamout06
X-Stat-Signature: xjm5zefc7i1hfmefnuramsasuzznxpc6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18h5Wco8x/jTt4ifkNztuqruDZ97G4luyg=
X-HE-Tag: 1694637480-576201
X-HE-Meta: U2FsdGVkX1/qvO+5ATy0oC1xdPj7yURbZiZ6p1jLPhVLbglW7mKrqeVfYdqE5XaGFecjXtS4WwLrkIDeavUySJSiZFdh2oQoEcyXe6nHZ5soQD5lUgr7HdLmHWo5l2ad26LgFg1Z9LQMFh5noewE80KKrBLPHlaPaSr+uDl/nL3GnCsOb2gt4y8A4TrD41kRFgxUEj4aVbr5125fztpf9Zmp/pcQz3VjzESUWVLoT8Vf8H0VNTdQav3wTvDjmVp/jDQj8jwi//bB5hO15srBsQ1DlxY6B0xwAx0He0eoCzVgYndVq2a9AOcmxJt7eZcUAFAAOXwHB0sC9obPoCama+Jkf7n7U6/kXwDLUdzRaPIMWuhgJmujoEHZYnyrJV1BA/QBLNh34rK6BBcizbS0CXAXHzO2WQo1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc() and vzalloc() functions have now 2-factor multiplication
argument forms vmalloc_array() and vcalloc(), correspondingly.

Add alloc-with-multiplies checks for these new functions.

Simplify the original codes repeated else to use a hash.

Link: https://github.com/KSPP/linux/issues/342

Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/ZQCaO+tYycDxVLy7@work/
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 617f9e53bacdf..4cb248985eefc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -834,6 +834,16 @@ our %deprecated_apis = (
 #Create a search pattern for all these strings to speed up a loop below
 our $deprecated_apis_search = '(?:' . join('|', keys %deprecated_apis) . ')';
 
+our %alloc_with_multiply_apis = (
+	"kmalloc"		=> "kmalloc_array",
+	"kvmalloc"		=> "kvmalloc_array",
+	"vmalloc"		=> "vmalloc_array",
+	"kvzalloc"		=> "kvcalloc",
+	"kzalloc"		=> "kcalloc",
+	"vzalloc"		=> "vcalloc",
+);
+our $alloc_with_multiply_search = '(?:' . join('|', keys %alloc_with_multiply_apis) . ')';
+
 our $mode_perms_world_writable = qr{
 	S_IWUGO		|
 	S_IWOTH		|
@@ -7187,17 +7197,14 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
+# check for various allocs with multiplies that should use safer functions
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*($alloc_with_multiply_search)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
+			my $newfunc = $alloc_with_multiply_apis{$oldfunc};
 			my $a1 = $4;
 			my $a2 = $10;
-			my $newfunc = "kmalloc_array";
-			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
-			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
-			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
 			if ($a1 =~ /^sizeof\s*\S/) {
@@ -7213,7 +7220,7 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*($oldfunc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
 				}
 			}
 		}
-- 
2.41.0

