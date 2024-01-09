Return-Path: <linux-kernel+bounces-20212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85E827BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79372B22916
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712E39E;
	Tue,  9 Jan 2024 00:27:29 +0000 (UTC)
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1878191
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTPS
	id MwQLrilTOGAIJMzwErFEuj; Tue, 09 Jan 2024 00:25:50 +0000
Received: from webber.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id MzwDrA0jx0nMNMzwDrMW0D; Tue, 09 Jan 2024 00:25:50 +0000
X-Authority-Analysis: v=2.4 cv=Qcx1A+Xv c=1 sm=1 tr=0 ts=659c928e
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=RPJ6JBhKAAAA:8
 a=QQdngafKVaWhNDnW0jYA:9 a=fa_un-3J20JGBB2Tu-mn:22
From: Andreas Dilger <adilger@dilger.ca>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2] checkpatch: ignore deleted lines for comment context
Date: Mon,  8 Jan 2024 17:25:36 -0700
Message-Id: <20240109002536.56695-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIKe30+Lirkkrd59KOXxg9WzvL+y/mNDg5+p+ivw9SvC8yMdV8ASfGNtiTxRsGGh3F75Tt5629nnzfW8tibOpsJG72aqp+wpqZw7VjelHKP9v3zt3NyN
 Os6KOiFg1EBfBG5hbukFB2jOtAp05+CfsIvcDTTK2YfF1UUE1QxBFj7Q2iZBGlnXYQHKzxnMhLvcWub+KhG1OOE2Dd5se1GAwwG+MYSuAmUUL7LwNUN6sEnw
 1+dFAxrbyKsX5/fUisSBWDTriXUmpWnpjaCe5fDZkLA4v5PAZTeZ5q9WlZZnV0B3

Don't consider lines being removed by a patch as part of the context.
Otherwise, false "WARNING: memory barrier without comment" and similar
warnings can be reported when a comment exists on the previous line.

For example, a change like below was previously incorrectly flagged:

	/* matched by smp_store_release() in some_function() */
 -	if (smp_load_acquire(&list->tail) == head))
 +	if (smp_load_acquire(&list->tail) == head) && flags == 0)

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
  V1 -> V2: don't include extra debugging in 'warn' line

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..316a65354718 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1973,6 +1973,7 @@ sub ctx_locate_comment {
 	for (my $linenr = $first_line; $linenr < $end_line; $linenr++) {
 		my $line = $rawlines[$linenr - 1];
 		#warn "           $line\n";
+		next if ($line =~ /^-/); # ignore lines removed by patch
 		if ($linenr == $first_line and $line =~ m@^.\s*\*@) {
 			$in_comment = 1;
 		}
-- 
2.25.1


