Return-Path: <linux-kernel+bounces-109313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39E88177C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706831F22BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB55085952;
	Wed, 20 Mar 2024 18:47:50 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0785282
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960470; cv=none; b=eQ+UR/b+pEx396LgvvfrCPH8VBLrxpkOSan5UOhyfYKLgXSJwYlUHNfWdOERU0SEayJ7sGknd6Mn/7NYhXRptbwczYpfU+tfCcmucqHek4e10+kzMSo/tc8hyUKETBXLATC+nAxG1e8TPcBtr6YJsbpmmwoXiU9m3Kbx/16iRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960470; c=relaxed/simple;
	bh=wEjY393WFSzEeWiwjkl/GFZDH84R1QcgM4sHjnLfaQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caZm1KAOF35LbhftrX+mXNtGpNMAjz6IPw5HpqiYSNMuWKp+LtdWC6/WyngW4XY+TAutoM8zzsg+O350J+/lzlCEtypule4EJbeVZ/Gqetb3IJs2oT/YCF+c5UlJOPqn+uFN7CBIrBunQsC5Mb1CNWDKjimkmaqAqlnOsTmXTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id B7686402D4;
	Wed, 20 Mar 2024 20:39:26 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rn0qU-0001dW-1Z;
	Wed, 20 Mar 2024 20:39:26 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] xz: Optimize for-loop conditions in the BCJ decoders
Date: Wed, 20 Mar 2024 20:38:40 +0200
Message-ID: <20240320183846.19475-8-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320183846.19475-1-lasse.collin@tukaani.org>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilers cannot optimize the addition "i + 4" away since theoretically
it could overflow.

Reviewed-by: Jia Tan <jiat0218@gmail.com>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/xz/xz_dec_bcj.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index ab9237ed6db8..e0b4bf4999c0 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -161,7 +161,9 @@ static size_t bcj_powerpc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t instr;
 
-	for (i = 0; i + 4 <= size; i += 4) {
+	size &= ~(size_t)3;
+
+	for (i = 0; i < size; i += 4) {
 		instr = get_unaligned_be32(buf + i);
 		if ((instr & 0xFC000003) == 0x48000001) {
 			instr &= 0x03FFFFFC;
@@ -218,7 +220,9 @@ static size_t bcj_ia64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	/* Instruction normalized with bit_res for easier manipulation */
 	uint64_t norm;
 
-	for (i = 0; i + 16 <= size; i += 16) {
+	size &= ~(size_t)15;
+
+	for (i = 0; i < size; i += 16) {
 		mask = branch_table[buf[i] & 0x1F];
 		for (slot = 0, bit_pos = 5; slot < 3; ++slot, bit_pos += 41) {
 			if (((mask >> slot) & 1) == 0)
@@ -266,7 +270,9 @@ static size_t bcj_arm(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t addr;
 
-	for (i = 0; i + 4 <= size; i += 4) {
+	size &= ~(size_t)3;
+
+	for (i = 0; i < size; i += 4) {
 		if (buf[i + 3] == 0xEB) {
 			addr = (uint32_t)buf[i] | ((uint32_t)buf[i + 1] << 8)
 					| ((uint32_t)buf[i + 2] << 16);
@@ -289,7 +295,12 @@ static size_t bcj_armthumb(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t addr;
 
-	for (i = 0; i + 4 <= size; i += 2) {
+	if (size < 4)
+		return 0;
+
+	size -= 4;
+
+	for (i = 0; i <= size; i += 2) {
 		if ((buf[i + 1] & 0xF8) == 0xF0
 				&& (buf[i + 3] & 0xF8) == 0xF8) {
 			addr = (((uint32_t)buf[i + 1] & 0x07) << 19)
@@ -317,7 +328,9 @@ static size_t bcj_sparc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t instr;
 
-	for (i = 0; i + 4 <= size; i += 4) {
+	size &= ~(size_t)3;
+
+	for (i = 0; i < size; i += 4) {
 		instr = get_unaligned_be32(buf + i);
 		if ((instr >> 22) == 0x100 || (instr >> 22) == 0x1FF) {
 			instr <<= 2;
-- 
2.44.0


