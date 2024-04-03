Return-Path: <linux-kernel+bounces-130326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE78976CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80DA1F2F780
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC4815F3E8;
	Wed,  3 Apr 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4J3pXvH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484F15382D;
	Wed,  3 Apr 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164752; cv=none; b=Khk43NEkBiHU4R7gf2J+9K0oeoAYWYg1miGEeN1XR07FZnc77M/vCUG1P/V6xjKZGrOc1ceOt9NYX7OqNjoD7Fd7XhW70lC1YDWhuxpxiMhJju1KvvBGwQLyjyyjpRPaP+TGLSimCtgLbWub323yxBxGiYLXAB0/G9i7glFXs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164752; c=relaxed/simple;
	bh=eH6n/XrrBzShozVSMmjhzduWadISNU3nrGIZ3CDYUjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nklatk1OxDj/YOgWMY/0aeOd3iga/y76jWAI5X+PFECt002hdBgJJZJG+O4fdE/UZnBxedrFPJhS5JBLjb6FnRbhhM7nx6j1wB4MGkCr0qlCo3+8RS3o7P8t2ME8Fa5wh7CYFW/0dgbfd63PwnZ2yieigxErTb1IsoenkGtImio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4J3pXvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94EFC433F1;
	Wed,  3 Apr 2024 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164751;
	bh=eH6n/XrrBzShozVSMmjhzduWadISNU3nrGIZ3CDYUjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4J3pXvHIbwxi7a2uV67ynx4/MbvF0rRaZSvvhq2KiJtubMSubh+kPsszhSZZtY+F
	 btQBslG3B2chB97rWpe+QmYV4L9y9ld89ZbaEBJCU6/BFYqZTFhJaJq7yS6MSfJ5Ck
	 bZVaF01K4RSdL1a4E61fgqgAGSGpy0zY8dTzGiTzJ0kgqeCxfGo3PbJp0X9JwkSTYX
	 FwPsSfvuYbfFuuEbJbFUKhTz6slgAMLPN48n0yuCuHcyKfIzAduwHp0j0tKAsojwmj
	 21A41SV0X+r4QuxyI+5kTfR8/0PxnlqkNR6IeFc6wBKog+FB9XjYfDyhyUs00Nyiyh
	 80RXFY4XO2RfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karina Yankevich <k.yankevich@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH AUTOSEL 6.1 02/15] usb: storage: sddr55: fix sloppy typing in sddr55_{read|write}_data()
Date: Wed,  3 Apr 2024 13:18:46 -0400
Message-ID: <20240403171909.345570-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Karina Yankevich <k.yankevich@omp.ru>

[ Upstream commit d6429a3555fb29f380c5841a12f5ac3f7444af03 ]

In sddr55_{read|write}_data(), the address variables are needlessly typed
as *unsigned long* -- which is 32-bit type on the 32-bit arches and 64-bit
type on the 64-bit arches; those variables' value should fit into just 3
command bytes and consists of 10-bit block # (or at least the max block #
seems to be 1023) and 4-/5-bit page # within a block, so 32-bit *unsigned*
*int* type should be more than enough...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

[Sergey: rewrote the patch subject/description]

Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/4c9485f2-0bfc-591b-bfe7-2059289b554e@omp.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/sddr55.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index 15dc25801cdcc..0aa079405d23c 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -196,7 +196,7 @@ static int sddr55_read_data(struct us_data *us,
 	unsigned char *buffer;
 
 	unsigned int pba;
-	unsigned long address;
+	unsigned int address;
 
 	unsigned short pages;
 	unsigned int len, offset;
@@ -316,7 +316,7 @@ static int sddr55_write_data(struct us_data *us,
 
 	unsigned int pba;
 	unsigned int new_pba;
-	unsigned long address;
+	unsigned int address;
 
 	unsigned short pages;
 	int i;
-- 
2.43.0


