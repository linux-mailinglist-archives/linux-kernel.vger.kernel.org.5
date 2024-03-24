Return-Path: <linux-kernel+bounces-115549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F0A889C55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C051F2BD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3AC24BC05;
	Mon, 25 Mar 2024 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXuERLwZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD321EFE4A;
	Sun, 24 Mar 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321052; cv=none; b=eOl0E6/dxAX6HCrCk5YVne1wSubbnrnOCWiMLdLx4Wfa12VY9uIdcUcLWeubyA2kXHy+FUr7nXv99qsX1to9za0oaPt9fjmpTMK5uVH31c3Ebp7eQtCj16aojvUesaYlTQVPW+MOHiPSbo/E+M3VD+f2oOoaH49H9GD2DK0XuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321052; c=relaxed/simple;
	bh=xa7ePW4ady5XdO1D6A2FpWznMZhwdTOySy8uwauuTIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUFBceVl9CS9JuXuKIM60lM4D8fwxr1kNoNsHqpJcsvojShdTvOfUml8GTuY7drjW5M0pN5xFjYvPM8QYlohONQCuV64Qsv2jxI2Bf8e6RnneV4iE2a9r39rqgRbdzMmx/jAIuMrmYW2MXKTPp1Pd5Ft5najJSI1Fy6oWOIQJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXuERLwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF20C43390;
	Sun, 24 Mar 2024 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321051;
	bh=xa7ePW4ady5XdO1D6A2FpWznMZhwdTOySy8uwauuTIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXuERLwZ71WhlTD1CIyMlbVVZD3ikuUOY774ypWG8F7EjZtihK5HjRO9gmCdrVwcw
	 Zx9Zb8q0sUQEa9UXnXnqPvKp/EVd0izAEBU978coMlzQYYHWWUmJ2irzYZPYnCp0x3
	 NkVl52rCCAkBvWaHfjDd3mfFlVVRmoYEu8AbRZT8OJ5PRTKM2a4f2oQD+4RVvnS9rR
	 BIp1woG9HilUfcJ0AJ8rdIijiaq0p5t+a1yViXJWPkOJACEcUqKGbZOwwdqkgjheyX
	 4ln8PIFWV6R2Qsgn3KFerKWl2xsQbHVQA5JduTtGmbYuYxEgj7X0TWM+Rm3nTeeT0N
	 96tknUyIF0chw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 614/713] bcachefs: fix simulateously upgrading & downgrading
Date: Sun, 24 Mar 2024 18:45:40 -0400
Message-ID: <20240324224720.1345309-615-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kent Overstreet <kent.overstreet@linux.dev>

commit e7999235e6c437b99fad03d8301a4341be0d2bb5 upstream.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/bcachefs/super-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 6405cc1d651fd..c925dc5742fa4 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -1085,13 +1085,22 @@ bool bch2_check_version_downgrade(struct bch_fs *c)
 	/*
 	 * Downgrade, if superblock is at a higher version than currently
 	 * supported:
+	 *
+	 * c->sb will be checked before we write the superblock, so update it as
+	 * well:
 	 */
-	if (BCH_SB_VERSION_UPGRADE_COMPLETE(c->disk_sb.sb) > bcachefs_metadata_version_current)
+	if (BCH_SB_VERSION_UPGRADE_COMPLETE(c->disk_sb.sb) > bcachefs_metadata_version_current) {
 		SET_BCH_SB_VERSION_UPGRADE_COMPLETE(c->disk_sb.sb, bcachefs_metadata_version_current);
-	if (c->sb.version > bcachefs_metadata_version_current)
+		c->sb.version_upgrade_complete = bcachefs_metadata_version_current;
+	}
+	if (c->sb.version > bcachefs_metadata_version_current) {
 		c->disk_sb.sb->version = cpu_to_le16(bcachefs_metadata_version_current);
-	if (c->sb.version_min > bcachefs_metadata_version_current)
+		c->sb.version = bcachefs_metadata_version_current;
+	}
+	if (c->sb.version_min > bcachefs_metadata_version_current) {
 		c->disk_sb.sb->version_min = cpu_to_le16(bcachefs_metadata_version_current);
+		c->sb.version_min = bcachefs_metadata_version_current;
+	}
 	c->disk_sb.sb->compat[0] &= cpu_to_le64((1ULL << BCH_COMPAT_NR) - 1);
 	return ret;
 }
-- 
2.43.0


