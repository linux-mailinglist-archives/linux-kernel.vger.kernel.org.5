Return-Path: <linux-kernel+bounces-130359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C5897722
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A1A1F301BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48016EBFD;
	Wed,  3 Apr 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSKos1le"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791216EBE3;
	Wed,  3 Apr 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164828; cv=none; b=aKtlKLKTP1xr3k8ntN9yA+rZwoqI5MGWEEELIpz2bPbYH3WR8lGvQnC+S4GBuYwBJYpd4QsSIMjwgB4UuortuUpHWvgn+bMC7d1J24FA9JHRmNraCHseE1pB3Maam8FrcpSdwpuTnIGkvnnGDg0jOVlgcoPcR25DYox5K8GfFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164828; c=relaxed/simple;
	bh=YvoysbgI8D+7qRZicqyWd5EtAvQvJ/DbFBAkUAiOCCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE2LkDtXv/kxiJGlIuoVk73KxMfssS5IyW0i+NBDBpx8GyaO6lnbew8DTiZxCGBJjxD8CF6vj/qDQ9MaU3Srt2p+7WjUfkGIEhHhcpaDG2ccKHNN8T/Qci351mBJS3RPFCiMNtwDuPAOlbFLS232I6mzABgFOVEPGhy6Ik/oQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSKos1le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4825C43399;
	Wed,  3 Apr 2024 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164827;
	bh=YvoysbgI8D+7qRZicqyWd5EtAvQvJ/DbFBAkUAiOCCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSKos1lekvDVDmqvTJiATUJ9gyw6VL4NLh9wHZhJLzbP/6Z04v14k4nqL9gov1FPr
	 tAZtcYZRq5ihDa3FhfEgwQwy0800WiJpOChytR5JWch+3pzFfD4VjC3QMWR56/OxF6
	 ac7O9VzaG4IZ0jjGyNK5SmMUZW5mS6uQ5IR57l/xfQRObtds4SpaAWzrbZdJ32yoek
	 wN+FXkOvlLzi4DF9nlWzuYZnJqdBrdoeBwG+FSWh9zMjbS0eXu8XXddtPYF1MYSVJz
	 mbmSX2iXcdA2gIHHwTMdXqy9pM0LHUG6nsO8TZagfumT4TJg1v+J7Oe2trgR2HQEx+
	 4q53eqq4ToyJQ==
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
Subject: [PATCH AUTOSEL 5.4 2/6] usb: storage: sddr55: fix sloppy typing in sddr55_{read|write}_data()
Date: Wed,  3 Apr 2024 13:20:18 -0400
Message-ID: <20240403172026.353926-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172026.353926-1-sashal@kernel.org>
References: <20240403172026.353926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index c8a988d2cfdd3..18eb681da1d5a 100644
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


