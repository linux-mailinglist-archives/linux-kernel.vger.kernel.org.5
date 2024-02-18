Return-Path: <linux-kernel+bounces-70303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1FE8595CB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EA81C20D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E62FC1D;
	Sun, 18 Feb 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Njlk1OD0"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545D1078D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246247; cv=none; b=YAmxivRZG1IEHB8f+tJbCdhq5NAMAMJtnyUd1cKUOpaZU/ELZPzSZW2Mh8kafCshdFC8RGJpZ+PZFMtqdvjCh1paetTiXMBPXdRUsR3hid0DwV7U0dUdJk1XDBOH2Pll6or/XX1uHZxv1qUnIP/PM1t3DDf5z4k7SB6CQ/PWEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246247; c=relaxed/simple;
	bh=da1qu/r9stegXEm7ynAOlKBK2eKOnZ0EjDNsWTT4L0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqKjWeMY8G1zpfnncisEcf56o1DkGOZnO2JSzTsK6kFnXt/NFlDHxJlbJG0QMZ1E3tSEAqpV8HDtVrXImqELxvWG4BcIMoimFajaf0oL4Zs0nxvYI0jp4dEz5+d9A975CJRAcLXWZmAvIFMhjnJh4FEUePU1yKLIA5loh21ejZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Njlk1OD0; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708246243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AEljPih4VKEaedgdPxkR+QTAZVEHkgRl9SR5WXdN/js=;
	b=Njlk1OD0qYqxPkPOtxILtH6gC5FBCH55YfGbAwkVLzJv8DOR3Afi5Gl7doigiVCmVeWQ3i
	N92VXe+rl6TPn+I812AtuNGuFjL7llLIT/VEShOm7xQflwemEO3qeOwjGLdYTZV+AvmslC
	uYlKLV/sbWIRfdvhSWn6dX2snC8m69c=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mmap: Add case 9 in vma_merge()
Date: Sun, 18 Feb 2024 16:50:28 +0800
Message-Id: <20240218085028.3294332-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the prev vma exists and the end is less than the end of prev, we
can return NULL immediately. This reduces unnecessary operations.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8f176027583c..b738849321c0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -827,7 +827,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  *     ****             ****                   ****
  *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
- *    cannot merge    might become       might become
+ *    cannot merge 9  might become       might become
  *                    PPNNNNNNNNNN       PPPPPPPPPPCC
  *    mmap, brk or    case 4 below       case 5 below
  *    mremap move:
@@ -890,6 +890,9 @@ static struct vm_area_struct
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
+	if (prev && end < prev->vm_end) /* case 9 */
+		return NULL;
+
 	/* Does the input range span an existing VMA? (cases 5 - 8) */
 	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
 
-- 
2.25.1


