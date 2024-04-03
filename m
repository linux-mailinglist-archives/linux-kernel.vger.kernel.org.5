Return-Path: <linux-kernel+bounces-130275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46E8976D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1987B26D0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC915382F;
	Wed,  3 Apr 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6P8eJXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749D152E18;
	Wed,  3 Apr 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164618; cv=none; b=F4Ggoc/bwRaD/nY/VcUkTxxVQA6+sRIuyFtKtj7K76sAakXIl2Ml4nwhE8h5WOit5f33L6AueZk1P1hqcUbeE5mVuVLn1wlziY6DI5WOzqpzAlC3bCHuT56qp2IibE4NbW9cvBX1iNoRcBGSp/BV7YFTfVyEylLDdqUCY+8U8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164618; c=relaxed/simple;
	bh=eH6n/XrrBzShozVSMmjhzduWadISNU3nrGIZ3CDYUjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ob1srrOqWBtCX57fJiC2DPh0urfWa2gCT4J1aDy7s+YXZ+bRU3tfCUQbQb+DSBndpvuMVmdxAdrRJKhZUROwCsdtv+7wK7Eu35aeweGOmJ+zEm1Uae7Go1HlYB9Cx8kAaWLsVEff2EADVGcAcpOFiNo1M45L/YkSdFWoEXEP3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6P8eJXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC7BC43390;
	Wed,  3 Apr 2024 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164618;
	bh=eH6n/XrrBzShozVSMmjhzduWadISNU3nrGIZ3CDYUjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6P8eJXE+SwVOWAzmioX0cUqXe1PUbnObn17dt88nRHYBGedO6Fdqr5CEW8UaLsa3
	 CvfUHO3mtnFfCH5PlMmIncw3yPnGXfaFGn+qRshJvhdOApnTwibHfEhoOB1v4foyxW
	 CiO/3VhmIzRlv5Za1Se1q36kZCQco/DzYk0Qln7X4McL51KclYBpBrWiXes9Dv9w8t
	 zs4Be3+M2JYOkdkAYdd/rjRHi17+J/ELIpr5JXB+SXSAgIM3DxitZTDjnYs79GygTN
	 xXlerlrzIK4zNbD0nqoGGLG+5zZq0Ckmu0eOpXFLoTzBX1AurG3cLSOEnJ8uabxMV+
	 DnzsAFMP9/F4Q==
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
Subject: [PATCH AUTOSEL 6.8 02/28] usb: storage: sddr55: fix sloppy typing in sddr55_{read|write}_data()
Date: Wed,  3 Apr 2024 13:16:04 -0400
Message-ID: <20240403171656.335224-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
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


