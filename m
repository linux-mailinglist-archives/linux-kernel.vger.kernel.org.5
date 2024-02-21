Return-Path: <linux-kernel+bounces-74555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C385D5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742471C22A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF682381A8;
	Wed, 21 Feb 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Oi6z7vhJ"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614620DC5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512298; cv=none; b=APwo/Gwv1WbevbwIaxJSFYi97sM4W//cR8w0S6VgmuP1+YxVRz9dNe8JSXo/kryDC8sZvLfPd40p7XRZw9Tgb0KIKMMY9qwadJ9xTSiTf5r9fHIcfa9wewSU0DUxzMOECons0FUJoW8x7h65bY0m2VmSrgY1I1bRrUbXOAuJRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512298; c=relaxed/simple;
	bh=ghhI+nFDhm0hnOFhmWeoRf94hHK/gPArrHEfJeQ/EBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YdfLR8iD5lPmueli5XEe+a6/vnZJr/FaP9CnVFQhKBkoAe3yNIZW3PigZ5Q6r2LzDU5ZIeimeyoLdbUpJpysRTs9nrxPo5A0eVHsvoyy0+TG3QxKvdu4cWNTOOJSFf4M2gkRIWEOpHqx3XqJkGc5h4yvI31qnpsNNtCb7+DABgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Oi6z7vhJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 30210240027
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1708512288; bh=ghhI+nFDhm0hnOFhmWeoRf94hHK/gPArrHEfJeQ/EBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Oi6z7vhJIUx+/QyafXRCdMFngP+BSIvcY4JjGHxacW4b1sOP3E3NwYU4dNHaI9ezt
	 f/P1ez3QdLHnQV1U2citr8UM1vMw+UDavSuJ7VN8u0sYt8h0TbREiEPUMg2pmG/hcp
	 jLKaQsRSsX/FoRwaRxSsMC2J8Xgx9xa1BEypPPVdlt6ImkK6CTYmglfVATfDWtTYdp
	 x3HHNmftGJP6VJMQffun7ragIxowbF3Na86f8ukyd8lNmDRlSjg+5KK3pDEGwiwd/N
	 5SPbgaN+rjV9ouUlLFRwu6pAz4RG4ZcyPgQVT9cpgfBiQkVZVVpbRG7XkNGsDsLKUS
	 iqPuJTJxV+EEg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TftFV4nPvz6twm;
	Wed, 21 Feb 2024 11:44:46 +0100 (CET)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: ntfs3@lists.linux.dev,
	almaz.alexandrovich@paragon-software.com,
	chris2553@googlemail.com,
	regressions@leemhuis.info,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2] fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS
Date: Wed, 21 Feb 2024 10:43:58 +0000
Message-Id: <20240221104358.2290969-1-shiftee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_NTFS3_LZX_XPRESS is not set then we get the following:
fs/ntfs3/frecord.c:2460:16: error: unused variable ‘i_size’

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>

Fixes: 4fd6c08a16d7 ("fs/ntfs3: Use i_size_read and i_size_write")
Tested-by: Chris Clayton <chris2553@googlemail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3b42938a9d3b..7f27382e0ce2 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
-	loff_t i_size = i_size_read(&ni->vfs_inode);
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
@@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		err = -EOPNOTSUPP;
 		goto out1;
 #else
+		loff_t i_size = i_size_read(&ni->vfs_inode);
 		u32 frame_bits = ni_ext_compress_bits(ni);
 		u64 frame64 = frame_vbo >> frame_bits;
 		u64 frames, vbo_data;

base-commit: 9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8
-- 
2.39.2


