Return-Path: <linux-kernel+bounces-115151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165A888D75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CFC1F2A4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992F303497;
	Mon, 25 Mar 2024 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxsCuMxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A028ECB8;
	Sun, 24 Mar 2024 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324168; cv=none; b=f2N8ntp+5KygwmvZM/clYMowsMJ1pSv9RDVt8uKmOPdtO6SzSrPpLcW/rmNIjeiVQdqOyDQeFXN1Tf+F4FyDzd03EPjcYL/LT+Nd5UBBs9m/Qn4Qu09KhuNdkBb3bBb5OYSrkKzDZbsYVd0PkO/3QKklL/m34dNOViXGL/w8uoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324168; c=relaxed/simple;
	bh=gMFzpn1jyb7rl/dKq/99t1tj5Qd5u5a6enc5p97cM3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REZrAhil+eK2GKWoQ2EIkdbjQ7f9iNueV4999AbSbny9rfqPsMEogefG5Ff54Qv8QnuI/9IhJhGu+7xdCjXFA8VGdXBhRMDPWmZVRAvzQO7tQ6aeZHFmO+C5KORe7v3l4m+6ICqAy1tC6tNYRBMrDLWtCBzYqlwG2fymBi6uGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxsCuMxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE60C433F1;
	Sun, 24 Mar 2024 23:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324168;
	bh=gMFzpn1jyb7rl/dKq/99t1tj5Qd5u5a6enc5p97cM3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxsCuMxywsjjIl018z6ny5TiM4mx3Jw7s4HXAa0sF5cYUe3TQyLGIFsLiPZdv/3Ut
	 szmOPc9TInVLn2Fl3lzwWFqbvHditzV9at3bxC0PY/eJBWWnj/QiWXiV6XCrntIRvh
	 zUpW59GgvySv3Vw6sQji3pOmQEHBvk9i1CDlO/MfKeHofl8nhHmEqIFvtggeczMK8I
	 i6UKhqvyXJXLi1/p5VemKtfq5iG7m06dwwCehPzHWQ6me/SjJZfPSOgHnQ/TdOcjhC
	 bydN39+a/7dI95HLTjplQyPOOdUn104pns1rYZ0hu0MzIRaS1agQnekqKIJsnubbJo
	 sVmzmovbP14Aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 161/183] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Sun, 24 Mar 2024 19:46:14 -0400
Message-ID: <20240324234638.1355609-162-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index e00ebda492198..171e643cf200e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2508,7 +2508,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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


