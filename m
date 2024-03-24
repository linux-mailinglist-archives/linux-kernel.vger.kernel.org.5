Return-Path: <linux-kernel+bounces-116211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC454889D88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60ACE1F36ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AE43BDFD8;
	Mon, 25 Mar 2024 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLH4/u0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018717D229;
	Sun, 24 Mar 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323831; cv=none; b=dRo2JHNcJt3OXpXLoo8CrWly1P7pqzCYNWjdAupGPPF39nTDSNqEsk2Tod0HbfgvTONweIJD7GlaJaAvhE7NykxkblgCAfrROiyjRR+eTtqiZUtDfhva/xzqD6aHEuAvCW3VS0Y4g8a4YNAcRDJ5qKpRK4fp2u9vaT9EpYIV+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323831; c=relaxed/simple;
	bh=3KA8CrEYQnz4vWq8t8Ue7MOGPQ3DZuEOWH3hf2mDdfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFFDKoLTGtH01HKkKmdMK0Y89m7YfS0EZ0jF31gFZwyHkd0KA1vYDKeWKAHaOtHaHJqZkmx22V/D9lGu7ybWg4g4fYyeFatQBdwgRsjFamaQ7FhWgV2Ik2Xw4YZrlVWNKhF/eIKGcL6gNIWTHtKaoMcefixUOUkd9zuljyb8QOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLH4/u0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E265EC433C7;
	Sun, 24 Mar 2024 23:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323831;
	bh=3KA8CrEYQnz4vWq8t8Ue7MOGPQ3DZuEOWH3hf2mDdfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLH4/u0EZG0TUA2MWb0Q16nasABaT1i4OpSkESq8zKyd06vxRXL5k9nOG6dAAjO6M
	 lyY2Xi1ICdOvpCHMHqUpsZSHlJcVncFUa0nM+SIpa2sunyfyt2QPDzIrmYRrLfH3A+
	 +nrBtib0FM+0NwsM58doWXTuVUkHCSdXRR+X1gP8KppvdkWBGdV7yG8mXyhHHmeI3x
	 0Ihv3CDiSUyBRE8OBFJPzcGIj/UMDs18YRxV+8E6pmLPwX8gYAE9ksoxx8QqPC52oI
	 xFLrffsRL6Lwq6e0RM7drot84mZSB1M4MnrWmlf0GEzaiTLDK8ZA42IevgO/zGng+/
	 d9+ZzAWLA+Jig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 210/238] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Sun, 24 Mar 2024 19:39:58 -0400
Message-ID: <20240324234027.1354210-211-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 0252c0562dbc8..df645d127e401 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2516,7 +2516,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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


