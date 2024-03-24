Return-Path: <linux-kernel+bounces-113940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440CB888EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745101C2B1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D61218536;
	Sun, 24 Mar 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtYp27w3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51C14B060;
	Sun, 24 Mar 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321059; cv=none; b=gcd4l0R9qF8tTNyJyPfRQk2nROGs2RxknqZBikPZa5XJnGyRM4/QU4fn79LWV9Nv1BkiG6a3G/qP/6+sCoPTZd72OkGM60gvpN7QY+0kkrPPuQ5/e8T/lTFwWkiW4K3m/nUfmwGUG5ueDn+6RY+2z8wbrCkgas6EsugB8Y32THA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321059; c=relaxed/simple;
	bh=pFIIlrZbJ15cWdRVN9XchhUl6r/wmivpKBhy4sGA2fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zbd3Cu1fFAHxBC3qSTNkZnTRU2Xzy96z2T7up6NMzD/hK42D3YvsyncbeAjC4vl2B4u/S7eAXcDk5FDBHfPlVdWXZH0uqTUv5rfrlvyv4kY04xZugf2fJY+2fBkwta/I53Ld60oVUdADCsFtOBmrEI3/u28C/iIev2QHFTkKZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtYp27w3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C90C433C7;
	Sun, 24 Mar 2024 22:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321059;
	bh=pFIIlrZbJ15cWdRVN9XchhUl6r/wmivpKBhy4sGA2fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtYp27w3xmjLRlPHsdgr0zWHgvfCRgCxFP8831RrKosAW4PVF1X6MrSO3MI4KaFWA
	 U+8H/bRLQZVaXpusHQky4ouEo/+DmdwLMBQXOecZUlbG6ETiSShzLuv6BiYxP0ZNLl
	 UBQgUBKSoLDs52sl2ETy5v3luVbry94wxScLRB9W8BvcOQFVB+g4K4kSKIvHmZ4DLL
	 7aGc47UIZSV7GpB6loZ/zGZw+rpLH9Xtr7V0PAKNd+5dRndsz1IL++tfbJ/mDVun7P
	 PJGs2QxSbm1xfWrbe2yg5rG/pAoFSidBCIPuA23PKhML6tDRGJARpNlGoTUWeKvZ5P
	 ePBsuwjY3lXFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 623/713] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Sun, 24 Mar 2024 18:45:49 -0400
Message-ID: <20240324224720.1345309-624-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 156efda7c80d6..6617d3a8e84c9 100644
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


