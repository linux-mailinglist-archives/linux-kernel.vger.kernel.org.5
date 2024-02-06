Return-Path: <linux-kernel+bounces-55588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B13984BE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2FC1F285F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C61B7F0;
	Tue,  6 Feb 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vA3VH49Y"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D31BF47
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250758; cv=none; b=h1600yFwLFB2RDFj+6P7CFVU4k0+fUJbpqweoL5Zk9nHQ6hSnp97kPxWFE1L2Tcm4uTFbPiEW1H+oLw2POEJXWIoqauAmZ9x78WPepP9CsJv0IVFcT/s1S3tdaa7q4l/i0pGfJCAS9TYCztCvpaRWGMe+Bkk6J9jHyG9AXMgVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250758; c=relaxed/simple;
	bh=X3Sg2AcjCoYlzGPQWL0/90G/r75mZK7+imgUhXh2xWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quC0XDuo7VOOVXkhKFs5DHQZ2uepxoD5xHJo8WuC6jF4l0AQKjt5QKKB6VmBPYi4IYDaa8KWUphS85Aym9QH37ZUmwtKpJU2l010KIuW9/h/c/lF2RUnocIb6kaR66Exir4BVH1ayyp7iI/9G28aJ7iUUZfInnAn5kCiamKDgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vA3VH49Y; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HS2DNqPoHrMr86/7fyMQRw3X2SfMSsS/w2jgXzblZj4=;
	b=vA3VH49YCcbP41sLGedvzTPAn2RynBfx0oSwhUmEScLf6JBSIVcYOlbbQtSrx3ASP3zNY2
	QbA4jIQAfA8EGNBrsQw7YFPAhjsPQRPuH18QPrjmH0NrFuOiswNii8I0E2VRhipLZCA6eZ
	3eBxPfmco1kleAeQooJV/izdzqViSac=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 7/7] bcachefs: add support for FS_IOC_GETSYSFSNAME
Date: Tue,  6 Feb 2024 15:18:55 -0500
Message-ID: <20240206201858.952303-8-kent.overstreet@linux.dev>
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 68e9a89e42bb..785438dbe7ef 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1947,6 +1947,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 	sb->s_time_min		= div_s64(S64_MIN, c->sb.time_units_per_sec) + 1;
 	sb->s_time_max		= div_s64(S64_MAX, c->sb.time_units_per_sec);
 	super_set_uuid(sb, c->sb.user_uuid.b, sizeof(c->sb.user_uuid));
+	snprintf(sb->s_sysfs_name, sizeof(sb->s_sysfs_name), "%pU", c->sb.user_uuid.b);
 	c->vfs_sb		= sb;
 	strscpy(sb->s_id, c->name, sizeof(sb->s_id));
 
-- 
2.43.0


