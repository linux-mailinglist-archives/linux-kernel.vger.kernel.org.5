Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F7E79F678
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjINBl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjINBl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:41:57 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831D1BD0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:41:52 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 700E5C0ED3;
        Thu, 14 Sep 2023 01:41:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 5D9EB2E;
        Thu, 14 Sep 2023 01:41:49 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] checkpatch: Add a couple new alloc functions to alloc with multiplies check
Date:   Wed, 13 Sep 2023 18:41:47 -0700
Message-ID: <edb667e19211652a32ef6069159bb85dbc3bcdff.1694636817.git.joe@perches.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694636817.git.joe@perches.com>
References: <cover.1694636817.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5D9EB2E
X-Stat-Signature: 64s9gkepqudbxw6q3mhphyrgas9f9n5t
X-Spam-Status: No, score=-0.10
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18IvTadWSku2lXX3mRrqjmkVKInnXd5ObY=
X-HE-Tag: 1694655709-754970
X-HE-Meta: U2FsdGVkX19X7SO++FS+W2npsmESX/N4ji5Hvf5FkffJk2a+F5sr6Seerxk2h/QrGsEp/dT0+m/PmAb5NJWRwzXCXepqEA5EU/0lwQ5vGHwm0EaxssmdkOAgluSsGKt3aQs1K8103KB1GsrGqv5+aqf/EZG47D2bBSEMtWRgT7eI7VB4NrCXeIMphtKkjixY/R7gwn5iO3Y0FTVMqhdOGPzOKZV5FlkwX/9F11R6Hw/zxmxUhl59h/phR7UyejZOdj7G/8jGBkv+uH3xsZRSVQGEna3ZUDg8V9KSAtoq0HDq798lGjM9h2XU3yMu4QA/Gfka0VIjz4vl7pG7MGXOJJt+Pi9W9b69DSNyiVMnKFOGiNERcVp2l5oXOmvtOYOiddOKVo8WLEosNjeWfuuQYx1nP8Mb2WX5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc() and vzalloc() functions have now 2-factor multiplication
argument forms vmalloc_array() and vcalloc(), correspondingly.

Add alloc-with-multiplies checks for these new functions.

Simplify the original codes repeated else to use a hash.

Link: https://github.com/KSPP/linux/issues/342

Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/ZQCaO+tYycDxVLy7@work/
Signed-off-by: Joe Perches <joe@perches.com>
---

v2: Fix search because vmalloc functions don't take a 3rd argument

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
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*($alloc_with_multiply_search)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/) {
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

