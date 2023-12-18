Return-Path: <linux-kernel+bounces-3780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A9817113
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EBF2812F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5114F63;
	Mon, 18 Dec 2023 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a4m2NNEy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733431D12D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC28040E00CB;
	Mon, 18 Dec 2023 13:53:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZekdwaTttCYx; Mon, 18 Dec 2023 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702907631; bh=2BdIepiFCyNWY1HXGUCFba+Y4aYC3Syv6mhSQjmq5T0=;
	h=From:To:Cc:Subject:Date:From;
	b=a4m2NNEy+iPkWxAiEyPLPh4I2ilyQOg7+UDKH7dUhlY4uw0LB/samG8TxIDFj5SmT
	 5YBgIfQmLWM8kMHKVftEi4VHVn6Q6H4k/dxbOvPt+g3V1FjgZrTTfEDjxxEYADYL1I
	 KzkSSCmgY4I5nOc8rltDB1GeeNVXSMk58TBIzTRWMtJwwTGFIa8VPkYOvKyyEN4NZn
	 bVaaxTI9ewjoC2K4km8M61I9Al2K8s0+nSXDN6lEU+lKgK32BSSV+wbVwWpkHszWKY
	 G6m9kx8fzt9oQ3m7uKst/GXgP72yBjiHL4KrjtaIITsj+bEwieNHUWDMy9KHqUcK4L
	 +b+246iO8cFzp1/xn2z9H2b1j4OI/OrzzW88CBdazoPWrTTl57EQQWGo637YxFJJKw
	 WY4i238A3osvGN3wEp5FgafoDvSNiqGGFIzkEwJ7YCWLw+1fx7CocEvisJY6d2zVZ5
	 B54kOZ2bPwQhqFrugeImxrwrNj8ogjClGuuaLAI0XgvnN6ReGLCT9z6gq1rxICUqgE
	 foPLR/3h0KxTuRqN7mQ0vp71h4aRcOnqV/YBmKjbTh/LcWkA9er68/EDrFrRq45C03
	 +PIidkH7GU+OBbEaCaN3XhiiaPjnHxEiZaLy1EpvQBLwlt+spu3DHiB9P3h8Rq36L4
	 8nLm/ZBu7lmsldnH9W7TPpc8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 281D040E0030;
	Mon, 18 Dec 2023 13:53:48 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] UBSAN: Use the kernel panic message markers
Date: Mon, 18 Dec 2023 14:53:39 +0100
Message-ID: <20231218135339.23209-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Use the same splat markers as panic does for easier matching by external
tools scanning kernel dmesg for splats.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/ubsan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 3f90810f9f42..df4f8d1354bb 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -204,8 +204,8 @@ static void ubsan_prologue(struct source_location *lo=
c, const char *reason)
 {
 	current->in_ubsan++;
=20
-	pr_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
-		"=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+	pr_warn(CUT_HERE);
+
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
 		loc->line & LINE_MASK, loc->column & COLUMN_MASK);
=20
@@ -215,8 +215,7 @@ static void ubsan_prologue(struct source_location *lo=
c, const char *reason)
 static void ubsan_epilogue(void)
 {
 	dump_stack();
-	pr_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
-		"=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+	pr_warn("---[ end trace ]---\n");
=20
 	current->in_ubsan--;
=20
--=20
2.42.0.rc0.25.ga82fb66fed25


