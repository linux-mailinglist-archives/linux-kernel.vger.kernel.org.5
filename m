Return-Path: <linux-kernel+bounces-113503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B625E8884D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD0D1F22A23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942691BAC25;
	Sun, 24 Mar 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEbDOclj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159C13D632;
	Sun, 24 Mar 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320304; cv=none; b=JmqaFj8HxTBB+qL6QdoaNY6vxI2HxXWYiKdxRn1ojAcMj0+8f47lyxlDDD8QDiWkI0XE1TJ7kHx6xSdpBjFwyC77HZqYgn6Z4K2kXePogzsqCsl/2/rs4FFeOlS4TvQBX0FRLj/CkMIGvaJam+sB9AW0I5EWo4ync4NdfhHt+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320304; c=relaxed/simple;
	bh=rCzH/9eFRR/LiouFouEjFUiAqjFrdvhNcvyhCFeN2sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyz9JVC4tjFAdnqaIjR+QMTqR9PZuvAv1gqcVYfAQ2Xs4F57UZG40+4syHxXYnyH+ZTYjjrsg7eJ9Gb+2klz3pgkWAiZJAeYpFl7yqD2sTDSnF+I+DSuN6X/AdvkRIs0N0BcuXHDAJF2jYxAfDUMCQ5X10DvI1nOR+Wpdd1lyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEbDOclj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26B3C433C7;
	Sun, 24 Mar 2024 22:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320304;
	bh=rCzH/9eFRR/LiouFouEjFUiAqjFrdvhNcvyhCFeN2sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEbDOclj3obkIBF5SzTiiHSetrAHH+MMhP88mBPSpnZh+5QuTxpvxSvNz7k6EBYgM
	 xDTvk34flxJEb4PV+ucxZ/8y4xnOkZoeZKroTpPwhfxy2/FC3RawKAfXlM0c97ae3d
	 kcswDkbKf0h5EASC8QDVx2aNdZXHPyuH4z/8LF39hLzGnYaHZauFDjt7uw9AKhFAcH
	 oeQ1wPrEAsY/18z/HOoEtxYIRveXi6d/mmfR4wj1g9+bPVyS2p5x67jSfK1sadtRkK
	 X7ApTCZRzTm/XnsdG8kZmEbA5a/9BGizttYFc6chAhf3FnKEDVqQqyxFyM1XJ28AXt
	 rfiC7V9gUSsqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 612/715] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Sun, 24 Mar 2024 18:33:11 -0400
Message-ID: <20240324223455.1342824-613-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 38a765eadbe2b..52e6ca1ba21df 100644
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


