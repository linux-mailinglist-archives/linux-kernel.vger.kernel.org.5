Return-Path: <linux-kernel+bounces-114909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE82889303
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08436B2E203
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC02D3769;
	Mon, 25 Mar 2024 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3Q+RvvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC627DE03;
	Sun, 24 Mar 2024 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323572; cv=none; b=JMvoTOBWXSUzGUyICxV5/7X40K59gkxU3Y19Y/Pdvw8Wu/XdJqN5T3DbP5oBKCgMy30/O1s43PEY64j1jQ6Cj3bBHTMtkGhphC8bQeTL0pYy3HyNSSX5p/Za97r/9pMsOhpvs29RF+6RtNPT7wlMj2f4ZmT8su+gFw4fNHCYdbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323572; c=relaxed/simple;
	bh=haI25pQhwibAlMtUHP3+8VFUK+05ciCLNtXIXuVN0M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdSYkrmKYftV6AhdGw1f4HqijLrQPgpZpFzr/KgW79W/7KMdLhwAgQMDvwGKNrXjhsJjliIH2RckygSVrZPokORcD2+m+8OnVwWdVMvVPhuY4wmO8ulwbIKQpfJAqpuR3jh9enWf5u56ohFqKvGGtFMiZmH8nGPPXc4SY3P6FSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3Q+RvvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C2AC43394;
	Sun, 24 Mar 2024 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323571;
	bh=haI25pQhwibAlMtUHP3+8VFUK+05ciCLNtXIXuVN0M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3Q+RvvU4cEiN4bE3a9EKd+q+iOwZyc4WRuyKuNqlPr72H2l3pCw2f6FoKCqHMupt
	 TxTK/0Ylx3BMDyNwYezA2srqWVMCYSZA41vQQzEGYrOGUCgMgdzd+Vt5UeKdzwHMwf
	 wHx0Rue539CujF0vVplhxp83SHnIZUH7LOw6/3vK1B484ViylL5CT/QwHO/k6PN9Y/
	 jgb2VERJqsEPxtKXVTRz8IJ8kTCCyIHlfNetZp2uPzNOhC6FdnrC0YrFmxXJ5rd45R
	 L3qDjQLkNlb9yxnkgI95FQYF+VeUTKG8YxddqR8TfaLIyw96Sh9jDPFe+/I61t2Qld
	 tMD2/7yi9lbnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 278/317] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Sun, 24 Mar 2024 19:34:18 -0400
Message-ID: <20240324233458.1352854-279-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index b8f5bc19416d9..442579f087c7c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2515,7 +2515,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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


