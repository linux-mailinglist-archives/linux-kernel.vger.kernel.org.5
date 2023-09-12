Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3342979D71E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjILREK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjILREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:04:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84060110;
        Tue, 12 Sep 2023 10:04:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72235C433C7;
        Tue, 12 Sep 2023 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694538244;
        bh=TlF+LlVr0+p7G1whWSyXl90KqhYFGDWhgyj2gIcU/UA=;
        h=Date:From:To:Cc:Subject:From;
        b=mhyHO6vYRr7rhv+o8basUZBhSTzBB4vdH6hmy+KBgxrmwlYgAjUCSw35UYWqItxqp
         6SlXtJLx0HLyia+1rx/xqSRi8StgbgCULhVSCctmqlPsgho4RWgFJLr9bmDgEd2jwi
         aZn7VbUvKMA6FuO8/8Tpg2xWOT6wSlvFoq1CR2kPROwfzZJ1mtqVoMxlYUPJXrWC8M
         f6+ThE0PycZMlMFCxqRBspH1cyR4CGAmzfEJPQlH9Fr+DEReN4rIf7Q/XVPImt3QdC
         me4bRCbcwp3g3/R/99U2OK7Srf/f1+hhSMTJZBo3RsyVNJcm4/G2gmLia5eMXx6bdt
         +a/1AVA+kiCBQ==
Date:   Tue, 12 Sep 2023 11:04:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] checkpatch: add a couple new alloc functions to alloc
 with multiplies check
Message-ID: <ZQCaO+tYycDxVLy7@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc() and vzalloc() functions have now 2-factor multiplication
argument forms vmalloc_array() and vcalloc(), correspondingly.

Add alloc-with-multiplies checks for these new functions.

Link: https://github.com/KSPP/linux/issues/342
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..45265d0eee1b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7207,17 +7207,19 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
+# check for (kv|k|v)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/vmalloc_array/kvcalloc/kcalloc/vcalloc
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,?/) {
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
 			my $newfunc = "kmalloc_array";
 			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
+			$newfunc = "vmalloc_array" if ($oldfunc eq "vmalloc");
 			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
 			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
+			$newfunc = "vcalloc" if ($oldfunc eq "vzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
 			if ($a1 =~ /^sizeof\s*\S/) {
@@ -7233,7 +7235,7 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
 				}
 			}
 		}
-- 
2.34.1

