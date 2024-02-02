Return-Path: <linux-kernel+bounces-49332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E098468C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5783E1F26D3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C21481C3;
	Fri,  2 Feb 2024 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajng1D+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD3481A5;
	Fri,  2 Feb 2024 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856996; cv=none; b=KC9G1gLYYyIBzAt371rrHntkzQfkHhXvufHo2Glg4gzOOTg1wbIdQfquTg3dbF688ysdDQ1+ZnMyY9TibCXfLHgnlNOyiAJBfnmt71X+p2Exbmt9t99tCoOo6lR2GJWJml0ccV7qesuN+Qg/Ca6wLX1vgD8LVaJ6tRvWOBUZWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856996; c=relaxed/simple;
	bh=jceecDRmdMOBljAQEyGtk+60sTp3SXvkt+2y39jsxjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+X5f4uwxLneDcvxYHnstEWAnh/L4bI9lqpo7kXWVZuoLf+RG/CCfYJPgePNyozKsJ1RkHQWnYZOaDMLdGoZMB2oDGWbFCohEgkE9H+7Zs1SfL35TuW3RPSP5ijgxbrSyfMw/RNPR5lF4LevoM4nl8avlxWi3tgDrchlhVBO/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajng1D+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091F4C43394;
	Fri,  2 Feb 2024 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856996;
	bh=jceecDRmdMOBljAQEyGtk+60sTp3SXvkt+2y39jsxjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajng1D+qyLcEo3NKj2TKAFekEQK4OpTjcATlGAi0UzAzndbu42IXqlyD9TSS/lS/g
	 5zCrj6DZmV30SnJp2o3z0//gq1U600DsBmfu4uPpdRjXbOJ/D8eAT8WYQkfFYX+lsV
	 eP1KsbWgZ5aOXxQTi/UQhWbnAkam1yVy29rjQqlt2IkuutOLnNlwRA9sWy3TsDvlUa
	 UdlqV4kKirAILgxYbKCSsw9H6aSM+ZcmAAxXHGBrVg0uVRP/nptJPXmneHq95BN33v
	 1oHUHLWvDekjHvWxgdRGPxpwVriFdzUA79uPCZ/znwPz7hL0GLxBQy05rGwUCfQs45
	 FQxiNu6/KLH8w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 16/22] tty: vt: simplify ansi_control_string()
Date: Fri,  2 Feb 2024 07:56:02 +0100
Message-ID: <20240202065608.14019-17-jirislaby@kernel.org>
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

Given all the ANSI control states are sequential in the vc_ctl_state
enum, we can define first/last constants and use them in
ansi_control_string(). It makes the test simple and allows for removal
of the 'if' (which was unnecessary at all -- the 'return' should have
returned the 'if' content directly anyway).

And remove the useless comment -- it's clear from the function
prototype.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6d08290fdfdf..e1cbe966bc84 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2107,9 +2107,11 @@ static void restore_cur(struct vc_data *vc)
  * @ESnonstd:		OSC parsed
  * @ESpalette:		OSC P parsed
  * @ESosc:		OSC [0-9] parsed
+ * @ESANSI_first:	first state for ignoring ansi control sequences
  * @ESapc:		ESC _ parsed
  * @ESpm:		ESC ^ parsed
  * @ESdcs:		ESC P parsed
+ * @ESANSI_last:	last state for ignoring ansi control sequences
  */
 enum vc_ctl_state {
 	ESnormal,
@@ -2125,9 +2127,11 @@ enum vc_ctl_state {
 	ESnonstd,
 	ESpalette,
 	ESosc,
+	ESANSI_first = ESosc,
 	ESapc,
 	ESpm,
 	ESdcs,
+	ESANSI_last = ESdcs,
 };
 
 /* console_lock is held (except via vc_init()) */
@@ -2202,12 +2206,9 @@ static void vc_setGx(struct vc_data *vc, unsigned int which, u8 c)
 		vc->vc_translate = set_translate(*charset, vc);
 }
 
-/* is this state an ANSI control string? */
-static bool ansi_control_string(unsigned int state)
+static bool ansi_control_string(enum vc_ctl_state state)
 {
-	if (state == ESosc || state == ESapc || state == ESpm || state == ESdcs)
-		return true;
-	return false;
+	return state >= ESANSI_first && state <= ESANSI_last;
 }
 
 enum {
-- 
2.43.0


