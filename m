Return-Path: <linux-kernel+bounces-49333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DD8468C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E78B1C21237
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8825482E2;
	Fri,  2 Feb 2024 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNcB9rBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92A482CA;
	Fri,  2 Feb 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856998; cv=none; b=t8CMOHToJNj10I7fLFUHSuhnPsMAp97DLlL31F0Ln3AQmGkyMIgzgFRGlG23/JeqzH50+BFcmyFOD+bSKG53lKSIRE8otsSObQn3AGoJ2aLwq7ZPgmrpSOxWbPQDaqyuxdWD+dn6nBMg6FOsoG+tGbjEjEwTE/IPVj+GENvci+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856998; c=relaxed/simple;
	bh=6UXhr7Um6o27JtU1FYPkbandRU53JbY5Vx7820lgPtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iap8SAcHBlz4+r1pKA4pAMy5n8//SI2moQgttmFAAb2q9XuOQVBO19I7KL72Jb1VXbbpeIEUX53idGQ/OmtXL9QjNoW5pmjHfUjhmtst2AisaAfYcngGHJb1bDEqVYlEfT43bLKep58kEJLPBVRunSa53NgjFL2nuXk5Vx5zihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNcB9rBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84317C433C7;
	Fri,  2 Feb 2024 06:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856997;
	bh=6UXhr7Um6o27JtU1FYPkbandRU53JbY5Vx7820lgPtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNcB9rBMdt2/bzWjEIv48297aN92UMaLGhsgrEldMtKrkB6v9X6dJYFgsKHT1ZQjC
	 H6STC1iuvWrOxp0oc/AGH8j9HXJ4yKl5+5XusRZMwsaWxqs6gAVaQjh0rJx/fWLVo0
	 g6Nrxe/cFIaXjdpJy7ugxJRu+JFBOYpzp9VHUwl20dR8jYexv3PzFX7BbFGQDMQZFw
	 UmyG2kMQv0myvrVaqLheIQb7T7rhvd0PHZH9k9DI/FqSAy6VBHqmasRlbKEofm6Xxc
	 2FGyIh3pYQoLqauteqk/HyN+qhkhcPzklQxcaR/0rCwPmV7DOSxamr14a4o6wdBPmj
	 PrVOdWqL++xjw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 17/22] tty: vt: handle CSI+[ inside preexisting switch-case
Date: Fri,  2 Feb 2024 07:56:03 +0100
Message-ID: <20240202065608.14019-18-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_con_trol()'s ESsquare case, there is already a switch (c). It is
preceded by an 'if (c == '[')'. Despite this 'if' handles a state
transition and not a modifier, move it as one of the switch cases. This
makes all the 'c' decision making more obvious there.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e1cbe966bc84..4d020a9967a2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2603,11 +2603,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			vc->vc_par[vc->vc_npar] = 0;
 		vc->vc_npar = 0;
 		vc->vc_state = ESgetpars;
-		if (c == '[') { /* Function key */
-			vc->vc_state=ESfunckey;
-			return;
-		}
 		switch (c) {
+		case '[': /* Function key */
+			vc->vc_state = ESfunckey;
+			return;
 		case '?':
 			vc->vc_priv = EPdec;
 			return;
-- 
2.43.0


