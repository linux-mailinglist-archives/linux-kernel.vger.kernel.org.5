Return-Path: <linux-kernel+bounces-114416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D184C888FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C231F2B45A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730F5176FA1;
	Sun, 24 Mar 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVv3K7Oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D886155749;
	Sun, 24 Mar 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321833; cv=none; b=ueMKhc5dOzZsiHLEpdKcnbQWypJe2OInxaWHA3mrybQS+cNmoIciWRuTv2c5Dn2vBechfx1qQFzGLKSg4TsBg1CuQS+ZsmbLMwet4gRsx4KSxNA/h1Hh7Ez5MQ+C4OtnVUQgTTgipIX+SUdcnnZWf2jGSgSk8mF5qRgTMdp265U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321833; c=relaxed/simple;
	bh=pR61DMqp2sHAArlHOnPe8VQRVUud4+7/SaeB+zSCfKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq3kUo7Z/XApduFgGIiTZjBdr4ZTC8GfYhaVJFxDr8usPjHtoD2iBSHGWEH+SAbZmp8zZkC+OLXK8SirSNoNSooWeO1JMnTM/LCqCyjB/vlLyPYlI5128GFLP4IeKTeLLHEgQJ+rGvFNY7ReYLhjzCWhv0esda+HLcHJWbQlmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVv3K7Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E8EC43399;
	Sun, 24 Mar 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321830;
	bh=pR61DMqp2sHAArlHOnPe8VQRVUud4+7/SaeB+zSCfKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVv3K7Oqw8PVl9TEW+ASqIyhaZFzjmVOeI1WBsdXUbJxuImffHlZoN8Yy9UJ/JCOA
	 PlkYyuPoflF2ss/28u0vx8gOHZyH4bgiOoBqn07Ci0KhL/SwjgeqwTpCcrNrhR2isj
	 qzAjforBVUxiOj6kh7PgR1TwQAvrlIMZfSaYTQC9LCPa5m5Pp1xvdbO+F+sUsTQ25d
	 ENqrz/Z8IdrorjYRhs59EW91YOLxRpwPEG7m/MqNOTaxHNc8NWngS65nSuZfZXj9D5
	 q3t+ABkNfk7fRW8joRoAotUTQ4g+4mkzICiBYeT88obem+fq8GEeDB5+zrzYo7KCXz
	 1CFBrpf3AhiJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 559/638] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Sun, 24 Mar 2024 18:59:56 -0400
Message-ID: <20240324230116.1348576-560-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 0e6a92f67c8a94707f7bb27ac29e2bdf3e7c167d ]

The if (c >= 20 && c <= 0x3f) test added in commit 7a99565f8732 is
wrong.  20 is DC4 in ascii and it makes no sense to consider that as the
bottom limit. Instead, it should be 0x20 as in the other test in
the commit above. This is supposed to NOT change anything as we handle
interesting 20-0x20 asciis far before this if.

So for sakeness, change to 0x20 (which is SPACE).

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Fixes: 7a99565f8732 ("vt: ignore csi sequences with intermediate characters.")
Cc: Martin Hostettler <textshell@uchuujin.de>
Link: https://lore.kernel.org/all/ZaP45QY2WEsDqoxg@neutronstar.dyndns.org/
Tested-by: Helge Deller <deller@gmx.de> # parisc STI console
Link: https://lore.kernel.org/r/20240122110401.7289-4-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5c47f77804f0f..9bf3ac3dc1f09 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2469,7 +2469,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		}
 		return;
 	case EScsiignore:
-		if (c >= 20 && c <= 0x3f)
+		if (c >= 0x20 && c <= 0x3f)
 			return;
 		vc->vc_state = ESnormal;
 		return;
-- 
2.43.0


