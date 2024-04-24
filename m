Return-Path: <linux-kernel+bounces-157809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A88B1690
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47B51C242C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258FB16EC17;
	Wed, 24 Apr 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBsmIf4y"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5D155A50;
	Wed, 24 Apr 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999293; cv=none; b=umIfA4pFS054D2q/d3SXcgrWTttWqJu6bLbGLjnNC+XrouA+ZurrDbqASRxvIMdNS/UkyuUuu+g1SJPtr6CGu4X9UB5lAqjevk5w1EByNMfk/g3IGeRmNuekGGhMV1Y26LjgxvvueZzaDNSd27erk94knceqfCTD9JKtz09O3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999293; c=relaxed/simple;
	bh=7ipSa9pxy7YATvV2EbSJiFp9LRQuJRKRYACV2RxwZeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7cXgCezay9moxs55Qeo22W3P4x/Wm80TN7aqM4bQaugx9h0zWgjgltSF2yhbY7R/Nl2w7I9EZuzkarvcfkyqAX2t6gFZ5AK+tqxXvdDRLZ9UIeb0U1tAHdfZDK4kNeExyIUkEMU8mr1/WJmMf6vXq+Iuh7/YhnojwhR/w6tCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WBsmIf4y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Fbnupmf5sC5cHjxw78S7V8xP62P+Monrj9W+p/bLWt8=; b=WBsmIf4y1ShgaLYKjS/ikx9Qb+
	HUcO/dwue3Iyq1bKfYVQxURMK63hgtQeNKz4QHqHvTG8vj2MC6+r2EOL7fq1UkxV5AIujgZnt1IHM
	5bSim8cRGxp5i4/gNiS5lY8VXp+lQQa5AJlHQvWE/twn05T/xThQQYfKQz6kzw82Bn2bh8x6UQrYx
	YS3cCLbJLQpH04nia9S9HZ2HunQUON4CnhjBoyIBQXO6QUdoCo/qA3wCYPXWROsishZwyc3fRdEbD
	uR/ZohjwQAOIDJx8pKW0xw/9zXagvXruUROTskOziPe3d9Rg0JJB1c4NsT65E+FJDMsF26iCr1N1F
	oxz9DuzQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlVq-00000006HlV-0hva;
	Wed, 24 Apr 2024 22:54:50 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	ziy@nvidia.com,
	linux-mm@kvack.org
Cc: fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 1/2] mm/huge_memory: skip invalid debugfs file entry for folio split
Date: Wed, 24 Apr 2024 15:54:48 -0700
Message-ID: <20240424225449.1498244-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424225449.1498244-1-mcgrof@kernel.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

If the file entry is too long we may easily end up going out of bounds
and crash after strsep() on sscanf(). To avoid this ensure we bound the
string to an expected length before we use sscanf() on it.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/huge_memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9e9879d2f501..8386d24a163e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3623,6 +3623,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 		char file_path[MAX_INPUT_BUF_SZ];
 		pgoff_t off_start = 0, off_end = 0;
 		size_t input_len = strlen(input_buf);
+		size_t max_left_over;
 
 		tok = strsep(&buf, ",");
 		if (tok) {
@@ -3632,6 +3633,14 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
+		max_left_over = MAX_INPUT_BUF_SZ - strlen(file_path);
+		if (!buf ||
+		    strnlen(buf, max_left_over) < 7 ||
+		    strnlen(buf, max_left_over) > max_left_over) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		ret = sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
 		if (ret != 2 && ret != 3) {
 			ret = -EINVAL;
-- 
2.43.0


