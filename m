Return-Path: <linux-kernel+bounces-71692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5485A911
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6AA280E39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B7640BEF;
	Mon, 19 Feb 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eGG+DMSH"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DD40BE7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360720; cv=none; b=DlOgvsl16uUo6AYtpIw1yPixpJysGNBGL4vrXm01rsYvbJZnvXL9di+rEo69T59EPAc9kQkzaq3JdeMVKwJRVxR3A7H0qwkboh1GJ6/r6IPR0JbDJ3KWlesycrk5oRzLXb2ZrEI7A71hhm5UsNZ1wiLkR0vgpsvqLkn8iyreo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360720; c=relaxed/simple;
	bh=s8tcLLrPKnv2gOx0hNQB4HKkkcMNLXHXgTSYcSr4sN4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=lUOv1hzG/KkxZaeXRsuj+vqppqs3DARM391qt+uyZIIf+H/D8RHIvSLDwwIlhHGWikOUVgRg4TOxS8MXLCkT5PzWRMEZiZ74hvWlb4ZZK9PWogLmVpxQVh5tZGYg/K6wIEwF2X9SEYwHxtrNoKD8Y4SvyxJCX2mu8KizdNY+bFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eGG+DMSH; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708360408; bh=ZGHZEFqQm5ii069pXVu8uHpEdaTRPxHpvYKhXylSm+0=;
	h=From:To:Cc:Subject:Date;
	b=eGG+DMSHWO06hi6ZqHXrWeVLlKhCA5w6DM5Yi1r7wKNab+l+IhwV1IvBBUbl3cxTy
	 +c/G9xvjhwGuKDU5kvtyFCVP6vmSlmXmRg8+ZqCmIQfdp8fwko4P+mJD1p6hWfssOJ
	 xF0LurIezIr+gR2IlXvUOFyvlg4EyKysq0v0Ku30=
Received: from cyy-pc.lan ([120.41.143.226])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 84D282EB; Tue, 20 Feb 2024 00:33:13 +0800
X-QQ-mid: xmsmtpt1708360393txzobnay0
Message-ID: <tencent_594131AD216D8DE97CCC8265DA5D8E45B808@qq.com>
X-QQ-XMAILINFO: NQJsl5QovJ//eLvw2JJgdmcwPOSJL1qkd4HHS1NZK4NGT7s7HUUx1M4MXyn4pG
	 Ag2mmtS5aUgluorgeFA6d5Eo+BrrTdEbQm3neq2qggX7OctTbVnFKNMoFwpecGUdz1NIeYfSCMrC
	 djfCcPr0FnxxHf0NTCrptE+QqzRXi0zTNDBud8pp6TVdKzthgTWFlzOaIJhZ6v7c0d6Nq+pZorQy
	 rtDhoEMeRXsc5lGgP3HMAoPRhpymE5l2+Y2R0VdY+oTsKNUYo4FpJ4YqUXCU0kUrWEM5iTOBfKBV
	 Paek32e1h8//B3LMqYQz1jHONeM2/UHtV5U2hI0gFKa942L1PIeJMkK6Ao+ZpJLBQ686HieMRgEm
	 cg4fkhcPuF4oHUutK98VSA3ceJ9WC4n8bblHfJ4wfyDWsSSkYmxWwUOUwiygUGIrt47hpUXhPaBo
	 UOa4nYGjAhEzX5xx/JtOx6X72UaQgHg4XjOKYqTcRf88/XzvA9cOXlzR91UNaITIaad/Txuw7PrV
	 RCiW5dBVS3m2NrMimZO2/22WJEnjUvylMH5yBUcyhdnY3viPI7eGiVxpD04xTnTSGXrS3aU//E6P
	 4d2GGDz1hSX3NF/0dt4Zb0XHsLm++qIgx1y5E0ZmLxHEPu/oNHcEAHCEM8SRkFpV+hvRpue5xXav
	 iWEwpdRpViJ6C2Os2c8I4HD8MLAgdKidk1v43jAmU5a++qIPcabZRxGAHG3jeseedrUWHaPi9jGv
	 ED0PLQRt9IbE2SPTyeQK+gmJ2WMdSegjeHM/MpcfIN6qCvl6udHUVR+LG83iLydv+11aaf8G+r+W
	 Tx8LSvPCiCzOXz71ZK5f/5+IlHxZUWLUhZA14OEK38jNF66vFoHGw/UvfBkpWQjTdjeSbXK2aL3y
	 orfNKD51/jVgmcp/s3rLuNti2TnDWgapl9VW7HjycQkqcHPl4P/JxIpHHxQcyg2C9rBsVBRcgyHx
	 00bgd5Z119/AW2UFGdd8BG5uKR3OrV3XJEt4JZSAiwbwfOeVdrsw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly
Date: Tue, 20 Feb 2024 00:32:09 +0800
X-OQ-MSGID: <20240219163209.2285719-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commit dbfbda3bd6bf("riscv: mm: update T-Head memory type
definitions") missed a `<` for bit shifting, result in bit[61] does not set
in _PAGE_NOCACHE_THEAD and leaves bit[0] set instead. This patch get this
fixed.

Link: https://lore.kernel.org/linux-riscv/20230912072510.2510-1-jszhang@kernel.org/ [1]

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/include/asm/pgtable-64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index b42017d76924..b99bd66107a6 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -136,7 +136,7 @@ enum napot_cont_order {
  * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
  */
 #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
+#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
 #define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
 #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
 
-- 
2.43.0


