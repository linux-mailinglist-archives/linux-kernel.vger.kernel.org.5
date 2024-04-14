Return-Path: <linux-kernel+bounces-144097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB478A41C0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5058E1F21634
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A602D04E;
	Sun, 14 Apr 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="afEGcyno"
Received: from msa.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F532C848;
	Sun, 14 Apr 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089535; cv=none; b=r+423BN1qS8ouhxvCvbxeaX83GTMWkabUh4snLW33+O8VxJCj4wqnwE9xCgz3NGG5ncaJG2aO+ijutQTIfssWAypJqvwbCcWcGiDtkrxms5jJ1Be68g/xbSkLwg2jfmBQBYvujuNFGgWIzOnepEAA7Gvv7+8m6yTdOESJbIGG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089535; c=relaxed/simple;
	bh=lkq1lrzB9HxKNl03Hpci59UA0sfQ1vTlkLoKDGZGgc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBP7LbsC8vT45iLRAZp9pn/eD9el8c+i4SDGhie22casHLOBoeU367DA7yjedBtzkIUnClaX2dEbdyhkUmOnazCmIzbqCUmOM4GjFEsLSrvFDOeZ8s++Vzbb05CdVLdPTQ2sYt69Dv29x66fYPn1VT8OIE2UbmcD3svcjdXPKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=afEGcyno; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vwhervJ5FwSN5vwherU9fE; Sun, 14 Apr 2024 12:03:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713088996;
	bh=vJwVeMXmnUN8m7oxlGG0PhRilSD1pyJWjsrWEGLWca8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=afEGcynoPMftMo0taM5DLQbyO5wId531Rxl3MdAcfn+qajL3mgP5c7PqKHAkz78s7
	 ZQza+LIx3ob2WuE3j1pDK0ihGlBQ0hyKZvX2Q7nlO/phSkIR5+xPwbQZuqYHWG1E2v
	 Q7BP0coNiSyuCCKuKixVvlKXtiHzaBX7bXO6zRKCWMzi9PlJEOM8kRqwNN98NS4xpN
	 C0yiTasdHVeG3nkA18uBdDn3EiPgMcrfkQvcw3qnag0fkdnoL+ewoUsh2PWeRpw69/
	 +Kw/7X6US5SNfVxdbV4soQuoGae1EGhYf1SJuNeJDprFewKdYDglyUk/EhBQT4aXZ2
	 jcpClt8KvG7Ng==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 12:03:16 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: akpm@linux-foundation.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org
Subject: [PATCH RESEND] HID: sony: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Apr 2024 12:03:11 +0200
Message-ID: <9b7684381f9d09a7cd5840caa2a160d7764d6403.1713088684.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch has been sent about 3 months ago [1].
A gentle reminder has been sent 1 month later [2].

Neither one got any reply.

So, I'm adding Andrew Morton in To:, in order to help in the merge process.

Context:
=======
All patches to remove the ida_simple API have been sent.
Matthew Wilcox seems happy with the on going work. (see [3])

Based on next-20240412
$git grep ida_simple_get | wc -l
25

Based on next-20240220
$git grep ida_simple_get | wc -l
36

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/9c092dc6db15984d98732510bb052bb00683489b.1705005258.git.christophe.jaillet@wanadoo.fr/https://lore.kernel.org/all/19b538bc05c11747a3dd9fa204fde91942063d52.1698831460.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/a1af20a9-951f-4a5d-8a60-04ded8d6f9a0@wanadoo.fr/
[3]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/
---
 drivers/hid/hid-sony.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ebc0aa4e4345..55c0ad61d524 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1844,8 +1844,7 @@ static int sony_set_device_id(struct sony_sc *sc)
 	 * All others are set to -1.
 	 */
 	if (sc->quirks & SIXAXIS_CONTROLLER) {
-		ret = ida_simple_get(&sony_device_id_allocator, 0, 0,
-					GFP_KERNEL);
+		ret = ida_alloc(&sony_device_id_allocator, GFP_KERNEL);
 		if (ret < 0) {
 			sc->device_id = -1;
 			return ret;
@@ -1861,7 +1860,7 @@ static int sony_set_device_id(struct sony_sc *sc)
 static void sony_release_device_id(struct sony_sc *sc)
 {
 	if (sc->device_id >= 0) {
-		ida_simple_remove(&sony_device_id_allocator, sc->device_id);
+		ida_free(&sony_device_id_allocator, sc->device_id);
 		sc->device_id = -1;
 	}
 }
-- 
2.44.0


