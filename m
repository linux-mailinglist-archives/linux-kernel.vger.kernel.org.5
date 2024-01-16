Return-Path: <linux-kernel+bounces-27991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9782F8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F41F25E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B254139170;
	Tue, 16 Jan 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejm+Vxo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F31286BB;
	Tue, 16 Jan 2024 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434792; cv=none; b=gGLojrS/NtVx3X1HV6ubhc6dVOeyJhEMSbbcackchJhHGYsbh4tMJ6SERf0Bb4GUCfZZdrMEmbrvSW+Q0mbpeoNbELxB+vfTbHV1KsCWHxrNdO9S1rk3rFP2XJjht0X2udGE+OctqVGUHUC76EoKeIIgj/AEowxqnZeX7Q95oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434792; c=relaxed/simple;
	bh=KANHFBaqsOkmhse8jBTL8CuQiAWzvFMUgPyS2O7nW3M=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=uVz/TByFq9oKEmC0X/shux/wSAIEX7Gj4tuDudqqCrDqvU9fQUFIfrCgeWLVvxy6tgOJswatEUX7xfKXne9OVnQGEQvVROZloTylpWuwk4Xaf1jfZoVYu1TYnadlsTPOSSfK0F+L5URi7XZk0wJgSt26E/2tvbTGbtNyS/UoHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejm+Vxo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEA6C433C7;
	Tue, 16 Jan 2024 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434790;
	bh=KANHFBaqsOkmhse8jBTL8CuQiAWzvFMUgPyS2O7nW3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ejm+Vxo+pjc0iVRjxEFmfG1pah6NwFKzgyO3bCjK807mxofbMmgCyCxInpktxHpb/
	 8WzJE03gNkyspaoIneRc0b4bwgUcoh1kuI5N4/54QKv6Yvh+LAXjs3AZYZnONcHCsB
	 9AdTGwQWAAKbXRmHPCPAq1GqZTgsiy2bpBZjVHjKtLLHiczQVdbi+SjiS4NcpwVMBJ
	 6kECkdtTY0XUDi0PmpUjoFEa5TKRsDfWmFRbTAgZdfD5FOYlbbQrEdpt5vGkFYrrAc
	 qHFrXfmT8iqKXIAk6X8LwNo9yIOqYSlglJ96CNAToRtd4KqJxhtGQTR52VEY+QnRZS
	 /rwyT8qE4YevQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 079/104] block: prevent an integer overflow in bvec_try_merge_hw_page
Date: Tue, 16 Jan 2024 14:46:45 -0500
Message-ID: <20240116194908.253437-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3f034c374ad55773c12dd8f3c1607328e17c0072 ]

Reordered a check to avoid a possible overflow when adding len to bv_len.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20231204173419.782378-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..cef830adbc06 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -944,7 +944,7 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return bvec_try_merge_page(bv, page, len, offset, same_page);
 }
-- 
2.43.0


