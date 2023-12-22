Return-Path: <linux-kernel+bounces-10107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A56381D052
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A220CB225DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D633CC8;
	Fri, 22 Dec 2023 23:07:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A033097
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=whamcloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=whamcloud.com
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id GfVArIIFY8jpTGoadrOChJ; Fri, 22 Dec 2023 23:05:59 +0000
Received: from webber.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id GoacrzergnCF0GoadrjvQr; Fri, 22 Dec 2023 23:05:59 +0000
X-Authority-Analysis: v=2.4 cv=MPFzJeVl c=1 sm=1 tr=0 ts=65861657
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=RPJ6JBhKAAAA:8
 a=QQdngafKVaWhNDnW0jYA:9 a=fa_un-3J20JGBB2Tu-mn:22
From: Andreas Dilger <adilger@whamcloud.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] checkpatch: ignore deleted lines for comment context
Date: Fri, 22 Dec 2023 16:05:51 -0700
Message-Id: <20231222230551.95425-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJ+nw+A3RIq9Nviphi8Lmbm/LniUxcWSmxHj7nAxk7Yg/DY9xehba5ZZGJcrjBLSf1O+W0boGzaRJ6m1a2Db2+WqiXzyzE5gZfO2VbJz1Ys4uaGliWRr
 9kPwX1frgOsVoyKHF1KA/i1wawuWvGVUxUtWxwDhyQ2sTeHJQ61zu93aZR+6+p98GK4wZkakOJT5zYEcVyhz0iKfLE3vFFDRDnzo3bNrl3JTM5CMacmSwm2Y
 b0d287H/yA7+CI/MZyjRKgpiPMe62V9/WQRry6EbWbcj+FaHaGFKW8y5MiGGn6SS

From: Andreas Dilger <adilger@dilger.ca>

Don't consider lines being removed by a patch as part of a comment.
Otherwise, false "WARNING: memory barrier without comment" and similar
issues can be reported when a comment does exist on the previous line.

For example, a change like below was previously incorrectly flagged:

	/* matched by smp_store_release() in some_function() */
 -	if (smp_load_acquire(&list->tail) == head))
 +	if (smp_load_acquire(&list->tail) == head) && flags == 0)

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..272e30b8adbe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1972,7 +1972,8 @@ sub ctx_locate_comment {
 	$current_comment = '';
 	for (my $linenr = $first_line; $linenr < $end_line; $linenr++) {
 		my $line = $rawlines[$linenr - 1];
-		#warn "           $line\n";
+		#warn "LINE($linenr): $line\n";
+		next if ($line =~ /^-/); # ignore lines removed by patch
 		if ($linenr == $first_line and $line =~ m@^.\s*\*@) {
 			$in_comment = 1;
 		}
-- 
2.25.1


