Return-Path: <linux-kernel+bounces-80326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A806862D73
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63071F21C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260141B96E;
	Sun, 25 Feb 2024 22:51:56 +0000 (UTC)
Received: from hydra.ck.polsl.pl (hydra.ck.polsl.pl [157.158.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DBDDDF
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.158.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901515; cv=none; b=i9M2IhBZFzel5Cv6WWKisn2NXG7js71KWGk+7Uoe3buQUsePfV8aGuhLZhjk3Oc6gJGl4S1PMG7/5bG5iY123rQr4jWL6vL2bAiOBqaGQXvkzx1+guySvBLLngAHpeIgR3Cp0/kG5khQ2yBAYL3JZ1zsTo83L7CIb4EOe1+dmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901515; c=relaxed/simple;
	bh=MmSI0khVFn94+4xziUkxD5/d0qrrljJdspJHlFz5rNU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b9+C2LGxXI/X7OLVYFu/lHXMOnjJXW0Bp4VfCOTZkpYPHifkcQXXs7D8C0kGbvFvMbJiP+zB65N9itIYNpjMY86ms5QZYiySLD/ITWglX0c7WOoe0a+OzDhAIGAdCSWLI41e/82J6ryfcSF17SYxN24Tqh6ff2WbHuOZ39U82Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zonk.pl; spf=pass smtp.mailfrom=zonk.pl; arc=none smtp.client-ip=157.158.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zonk.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zonk.pl
Received: from hydra.ck.polsl.pl (localhost [127.0.0.1])
	by hydra.ck.polsl.pl (8.17.1/8.17.1) with ESMTPS id 41PMpRrp006987
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:51:27 +0100
Date: Sun, 25 Feb 2024 23:51:27 +0100
From: Adam Osuchowski <adwol@zonk.pl>
To: linux-kernel@vger.kernel.org
Subject: seq_file_path() invocations and backslash escaping
Message-ID: <f306fe7e-487e-4995-8386-6cbe9eb465a0@zonk.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--60E5o0XT1ebBAEahD7ZK"
Content-Disposition: inline


----60E5o0XT1ebBAEahD7ZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

seq_file_path() invocations in several places have not specified proper
characters set to escape. It leads to potentially ambiguous content in
/proc/<pid>/maps, /proc/<pid>/smaps /proc/<pid>/numa_maps, and also in
/proc/mdstat files. In corner cases contents of these files may be unparseable
in correct way and may give invalid results (non-existing paths).

The reason is that if any of sensitive characters (space, TAB, NL, etc.) are
escaped as octal using backslash character (ASCII 0x5C), the backslash itself
should be escaped as well.

Find attached a patch for this issue.

Additionally, paths in contents of /proc/<pid>/{,s}maps files may have
" (deleted)" string appended to them to indicate that path is non-existing.
Maybe one should consider escaping space in paths in this files to distinguish
non-existing path case from case when real path name ends with " (deleted)"
string. Of course, then space in this suffix must not be escaped, only path
part.

Regards,
Adam

----60E5o0XT1ebBAEahD7ZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="seq_file_path-escaping_backslash.patch"

--- a/fs/proc/task_mmu.c	2024-01-15 18:57:06.000000000 +0100
+++ b/fs/proc/task_mmu.c	2024-02-25 21:53:39.825517588 +0100
@@ -296,7 +296,7 @@
 		if (anon_name)
 			seq_printf(m, "[anon_shmem:%s]", anon_name->name);
 		else
-			seq_file_path(m, file, "\n");
+			seq_file_path(m, file, "\n\\");
 		goto done;
 	}
 
@@ -1967,7 +1967,7 @@
 
 	if (file) {
 		seq_puts(m, " file=");
-		seq_file_path(m, file, "\n\t= ");
+		seq_file_path(m, file, "\n\t= \\");
 	} else if (vma_is_initial_heap(vma)) {
 		seq_puts(m, " heap");
 	} else if (vma_is_initial_stack(vma)) {
--- a/drivers/md/md-bitmap.c	2024-01-15 18:57:06.000000000 +0100
+++ b/drivers/md/md-bitmap.c	2024-02-25 21:52:31.974675003 +0100
@@ -2115,7 +2115,7 @@
 		   chunk_kb ? "KB" : "B");
 	if (bitmap->storage.file) {
 		seq_printf(seq, ", file: ");
-		seq_file_path(seq, bitmap->storage.file, " \t\n");
+		seq_file_path(seq, bitmap->storage.file, " \t\n\\");
 	}
 
 	seq_printf(seq, "\n");

----60E5o0XT1ebBAEahD7ZK--

