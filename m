Return-Path: <linux-kernel+bounces-32811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B85836062
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95E61C2350F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F23B293;
	Mon, 22 Jan 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqyCgZkw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59293B1A4;
	Mon, 22 Jan 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921453; cv=none; b=CaaVhDocCJRH/RpNwPyyEG9CFctFk3qvRdJV2bxJeBln3af9YLTQyNUHmQGANDbck1igfFdtXEcGJGaD8TyHTkn/ut3nz1eRM+k6AaUnjMqW0czTe6zBMzksRpzi21W7TJK0NCFycjITzbomM+H4JPff/fh8tbkEN2rc1m1Eix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921453; c=relaxed/simple;
	bh=JLskyX1cYZHzZMmvuU1LzSTACKKk6cE/XiYsShkR8C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irCrynFUlg8QgKyj4OF8t5JkK7c8V5v3HmeVjefiM1T3u2M2hCHd2WWEjY/Q0ILgSI1OPRCjpCZzMfoqunYDKyGGremCLgauf4wuoLFwSaPagRx4kXDPypF4hUKdN2ySHSM3xTA6vxkKupvo1pnS9SmnRJ5hLmbRqxa/uveAv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqyCgZkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE5C43390;
	Mon, 22 Jan 2024 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921453;
	bh=JLskyX1cYZHzZMmvuU1LzSTACKKk6cE/XiYsShkR8C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqyCgZkwhckIuGyFSgPr0H8RhlwHOvwpomqyHYlJ086H/gRH2ZLi11uJBVplQpxve
	 ERsH3wKPPFck7Vd3lSz+6beyA4HtwvAsdQWW4TrdGk15KWoe94AI65ZpnMB/Y8BAiP
	 786ShJam/o4E3sKV15NPjWVmSs0GgUPQGFFGpBjPStBQwzwzkhiLctMPAhH6jD/L2y
	 sq/Xdg27C0eum2MeqUnvT2i3woDN9tyrG3Mj/eG9KTXf/4w112A0A5xGvicxmhg0Po
	 igKqDDRIpXFY92MxtqNqI+tssQ5gmnFx2YWPaE28in9e7h6ekURJFbIthcvkvXgYRo
	 kROsnKLOWleyw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>
Subject: [PATCH v2 03/47] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Mon, 22 Jan 2024 12:03:17 +0100
Message-ID: <20240122110401.7289-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if (c >= 20 && c <= 0x3f) test added in commit 7a99565f8732 is
wrong.  20 is DC4 in ascii and it makes no sense to consider that as the
bottom limit. Instead, it should be 0x20 as in the other test in
the commit above. This is supposed to NOT change anything as we handle
interesting 20-0x20 asciis far before this if.

So for sakeness, change to 0x20 (which is SPACE).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 7a99565f8732 ("vt: ignore csi sequences with intermediate characters.")
Cc: Martin Hostettler <textshell@uchuujin.de>
Link: https://lore.kernel.org/all/ZaP45QY2WEsDqoxg@neutronstar.dyndns.org/
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3f3f7c216819..55ce6cdecbca 100644
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


