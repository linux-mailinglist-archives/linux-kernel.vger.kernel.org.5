Return-Path: <linux-kernel+bounces-155212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEAF8AE6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A4F1C22DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041E135A7D;
	Tue, 23 Apr 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/hUVOUk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CB13541B;
	Tue, 23 Apr 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876383; cv=none; b=KDXCNTE5VI+Lt4se33bCeNgPEhxLl6xie+wv6181IrXdflaz/38f/LNdM4pzW8SGi4LR4J2Jvwnu0VS67feSPIlTAJanh4Frdhcihzdm/u9uI97e6CjJXaVmR6ETU6Hp3uy00ryARprFcyOt3ZMVOUI70JA40sfqC3iGJE69qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876383; c=relaxed/simple;
	bh=WQNcgBK3/wz8IFQsAtME63HekOEmuN0zL+F7dVzOncM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9CZfV1o2FpxoQwsp9VVb3WJCxtqcZWG/cM5ZRlMZ/ASHmfU7Pfhibm2AO/7tu/N93eVgSfdfdd+eGe7Xy4rv648PmpPQnxW1PFqj84zge8FDuF3fWh/zjBcQK0P6sTJoGGY6axPXBWX3JkEynYtGIJhC9sfCZL3G4UbOchyscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/hUVOUk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DMimUcvNohsu8/S5/GBiRhv4MLCQ2GHo7sDNhJEiGnI=; b=s/hUVOUkeFsqpV3hLcFTvTXpKn
	fTC9hbU77vXKzIrOcHBVmQ4ERQUsPsku0UcXA/KNsCzIwZhVLRlSn+QoA5LolIRHUHVqWB9nfjbuG
	TJ6uDlNQBRPhZvDQ/M0LjwWjOa9UifGXnZi6StIUVplNnA+Y6OdUyEWF4+oI/SsPmVBVg/cShCsOa
	y6fJ2rxj/8ACNDO7d2I06Rnrqki6ITl0ZQqNGE/VM05YrtMhVpnM6FZvLcltuuuGYUPzgc/iXwgnp
	9B6rJ+aNGKg/J92dRJ1VMnfXm5ttSMXNDMwFmES3qfqQz5VTXe1ORdlSF8Yd6pCDr/5ZyOcFFTnuW
	oxJj704Q==;
Received: from [2001:4bb8:188:6493:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFXQ-0000000HUPv-1Smp;
	Tue, 23 Apr 2024 12:46:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <christian@brauner.io>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] xfs: don't call xfs_file_open from xfs_dir_open
Date: Tue, 23 Apr 2024 14:46:08 +0200
Message-Id: <20240423124608.537794-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423124608.537794-1-hch@lst.de>
References: <20240423124608.537794-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Directories do not support direct I/O and thus no non-blocking direct
I/O either.  Open code the shutdown check and call to generic_file_open
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4415d0f3bbc51b..2ce302b4885f53 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1243,7 +1243,9 @@ xfs_dir_open(
 	unsigned int	mode;
 	int		error;
 
-	error = xfs_file_open(inode, file);
+	if (xfs_is_shutdown(ip->i_mount))
+		return -EIO;
+	error = generic_file_open(inode, file);
 	if (error)
 		return error;
 
-- 
2.39.2


