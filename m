Return-Path: <linux-kernel+bounces-114665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AB888C89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557E6B2A4AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562AA2B0A6F;
	Sun, 24 Mar 2024 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igon312l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C32236D1C;
	Sun, 24 Mar 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322308; cv=none; b=cuo8fwF363b6mTIU9FNC+SHE3NysxDyChW32ngS55263rLsaDXxuU1ItM5YThSO8aAJeefRtA4ORUTXaUmJiy3lzQHlDXV8WOj1CCEMLPr/0epjsEqwGRvvAiVwQcqxxuTnLvxZM2zfb0aOVfxhXh5mECyF3mxm80TrzdIur5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322308; c=relaxed/simple;
	bh=pe5hIO3xWI9TK9yQ2KjLqytV+CTZ6O7lgmoKx49laOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkgiZEFSBDOmCbseDDRQijxogSTfLWao1GnDFxJ0Xn3JtsxAeYfpRMsY2iaHd2rPdmraO9Wtu/tVq3b3MkRtuFK+THMgK02jqLz3wBxY0IFbxfIsHJ8uQd4BTTDVJWyd0F5FUNXunbO7VaGehgdewELUPapUq5cg4qK12lcgJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igon312l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B70C43399;
	Sun, 24 Mar 2024 23:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322307;
	bh=pe5hIO3xWI9TK9yQ2KjLqytV+CTZ6O7lgmoKx49laOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Igon312lzxnHOAAv86XzizwN15td4wmJq5kY6cm1+z1r/PBmSS85ym/13Ue6fZ1C4
	 OZMMLFh8QjZzpkJFPKu6TMTFoxFzpg/+ftVfqvR1ybxySyTIvGyw9TewmR9p0fy5zy
	 vw0jPQKgniHtINVblaDMBabmiNDAN3nKECtrZn70fTrfcpEAma8Cw4mMua3kdRN3es
	 TIrounmrmEDXR1fICos2ovQWQIerqhqrq6FP6jWS8L/Xn5wIV/3PC7FZ4x1yzvswcM
	 27yuLRe6EYRHCHZezYkhaStbT9dCB1YCc+g7djVz9CRZuC327DnZnEnemlvMzmthKs
	 lu1y8j3PLPJ4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 390/451] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Sun, 24 Mar 2024 19:11:06 -0400
Message-ID: <20240324231207.1351418-391-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 981d2bfcf9a5b..9e30ef2b6eb8c 100644
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


