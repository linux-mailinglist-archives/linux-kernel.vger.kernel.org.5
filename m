Return-Path: <linux-kernel+bounces-130342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB5C8976FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC37C297517
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A620216C421;
	Wed,  3 Apr 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDAd3IQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647216ABEB;
	Wed,  3 Apr 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164788; cv=none; b=O8Mc2YPRqLSwP5TEyEL8wFxQ1hgkCCwUE6A4AL18wMAm/++0oXkPm8JdRAbD4pTP9wbjh8/dKi/k+53KxFxjjT7bxDvtt6Aw4iIYuW2cylp1Vy5aHJIGIKIfRhnT0TJkNH/wHiXzVsir8Cm4dFI28Bf8UcvGI+8EyqtKQXk4q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164788; c=relaxed/simple;
	bh=eH6n/XrrBzShozVSMmjhzduWadISNU3nrGIZ3CDYUjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joo7WJvq+5jEHoLRHzGNGtN0eVJDjINlPBGQM7K+KNcV/NEtthhKecvkeBYQsHaZXAD25a6LbIltwIWPtyO5DG5MbkZNChCSzURsX/nMvwwiFvgMTABEkAtqavN3HhSEkrxrlfqIzQN4Lw2mVxObR7vU07G7i0Ri5QeaO51GMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDAd3IQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5BAC43143;
	Wed,  3 Apr 2024 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164787;
	bh=eH6n/XrrBzShozVSMmjhzduWadISNU3nrGIZ3CDYUjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDAd3IQ//xSnNqGA7gs27Rx05ExbnjpiPR9bUf/9hI0M8o872UPgccehK/V/rfmqx
	 7a4ZmYN6lao9q/X05wi79o2Qv8pFD+F4cW0BHuEgNcqTWQu1HMSivTUvdQwwYkQgTe
	 TBDadPCjdX+uXiQcPzwLrIVXx3UdJ5ASoCsbivWuWy8eMPvXsnlre6t/3iF3NUXJJe
	 tPe2rx8bgRPD7e8vpwdZb0gMlS6QlUyjDC+PTAblOgTM0TsI1f5AngkbuCGScs4XFb
	 ZLJ2ZkXkPy8+sigBqyCpkvBrUOqr0Piy8ZW8EvjGtUJYXNaVjJa/jyQyDjQrTLcuE8
	 gLp/jlUSvgg0g==
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
Subject: [PATCH AUTOSEL 5.15 2/8] usb: storage: sddr55: fix sloppy typing in sddr55_{read|write}_data()
Date: Wed,  3 Apr 2024 13:19:35 -0400
Message-ID: <20240403171945.350716-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171945.350716-1-sashal@kernel.org>
References: <20240403171945.350716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


