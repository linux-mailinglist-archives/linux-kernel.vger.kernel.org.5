Return-Path: <linux-kernel+bounces-113350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C93288839F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F76281A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA07199EB8;
	Sun, 24 Mar 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRAhbIcF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE750199E9A;
	Sun, 24 Mar 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320150; cv=none; b=e7FiqfQDEAG7pjGKfVFDg6OEoc5Ch55V4Ps/wFmhZngqFeAlehF4J0kilxbuHpm1DDzjqa/tHZEtNMXuzvOvyMAmcx2FZv9iedZ4qxdoLqitQCCBUchSH71LxP5VS6TOQIXbXVIMTlO10CzvLom3v5qzcY6bWmlBPYrlSPa32rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320150; c=relaxed/simple;
	bh=QDq+Wacgo7Tvlg5d3XH68gvV/+2+r70i/mI+JetZZfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6qfYrtLKv3ycPSLTjC6ipwtXLreit7/0Nn5m7xhqQ7BnWzCsVLryvj1novMI3Ff1azj25dGFuL0QwY1TxruIICv3Gf11Sq8ByH3twNWtN80Mb4CyL6rK1Sg4S63B0weTNdEnCxDUTZx2VzgYlqEoASfCxbpt2dojBScMHnTN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRAhbIcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16155C43390;
	Sun, 24 Mar 2024 22:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320150;
	bh=QDq+Wacgo7Tvlg5d3XH68gvV/+2+r70i/mI+JetZZfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRAhbIcFGuqFZZmLoD8TuJeTSttmD4J8YsY5tlvpwG8e50em24LAHa6xvOMfcNlon
	 RGi3bdo2ff9V7QL72G9kHCLqVd6CsbYe6hNCyyHQMmSHOijcqj1PeldlWa3md7jE8o
	 IBZpAjBTDH0/W+F4M5NDKkJU+iqI/nEc1tnsmXJXzgT8323HEHlyMkwxvxBjHGD2fu
	 n3swNQcceVIVwclFsNTAxh/IKQ2LEV6Wx29roNlAGN1bdXJawrNU0+qKvVCauoIzSB
	 64vu1wuVzMGVfTa8LSP9LMtU9l5Ve8X7iTuXrZzB6VhJB5OyaRISks8wPh/Xqjk/T+
	 Xa/HxJsX1GP1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 459/715] tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning
Date: Sun, 24 Mar 2024 18:30:38 -0400
Message-ID: <20240324223455.1342824-460-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 188942f05ce45f80c06f7242ad7478bd204c3387 ]

mips_ejtag_fdc_encode() method expects having a first argument passed of
the "u8 **" type, meanwhile the driver passes the "const char **" type.
That causes the next build-warning:

drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_console_write’:
drivers/tty/mips_ejtag_fdc.c:343:32: error: passing argument 1 of ‘mips_ejtag_fdc_encode’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   word = mips_ejtag_fdc_encode(&buf_ptr, &buf_len, 1);
                                ^
drivers/tty/mips_ejtag_fdc.c:216:24: note: expected ‘const u8 ** {aka const unsigned char **}’ but argument is of type ‘const char **’
 static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
                        ^~~~~~~~~~~~~~~~~~~~~

Fix it by altering the type of the pointer which is passed to the
mips_ejtag_fdc_encode() method.

Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/mips_ejtag_fdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index aac80b69a069c..afbf7738c7c47 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -309,7 +309,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
 	unsigned int i, buf_len, cpu;
 	bool done_cr = false;
 	char buf[4];
-	const char *buf_ptr = buf;
+	const u8 *buf_ptr = buf;
 	/* Number of bytes of input data encoded up to each byte in buf */
 	u8 inc[4];
 
-- 
2.43.0


