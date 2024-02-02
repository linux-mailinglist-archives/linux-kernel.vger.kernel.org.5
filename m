Return-Path: <linux-kernel+bounces-49338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DCC8468CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F736292D22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D334B5DD;
	Fri,  2 Feb 2024 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVU03+NQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F404A99C;
	Fri,  2 Feb 2024 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857005; cv=none; b=XEwTG77xSOmKXNIClABx8AqQytHy53JvUP2v2YcolD/q3DEGFWZBHTdwKNrcKWtxFo/SCiTROgsQ04Edr/cEY1vVtyZISvudcseYlMdCovw5LdL06TgHOKGtn/VTmWWem1zvQrlQ055HjRquhc16Z7YhZjwNtkcL05zmtoGhZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857005; c=relaxed/simple;
	bh=iv8M0VVwLR+J8qViltmqr1VCLaV0asCVn17nf33N41A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMDTyKUQ0RT1lyfsdCnwYQdmItEpqTjNCT11ScuzEmCKIBDxcM0WGMzwS26tGcpGB5tLdo9KkEsJS7OVnBdzVWwuJMvt+CfzhqSeZgRforlv1UrPl9skF4NkpGmC0xzHCe0NdzWOWLqQbq/psqxjen976CnVPiCki10LZ8sm9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVU03+NQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE8EC43394;
	Fri,  2 Feb 2024 06:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706857005;
	bh=iv8M0VVwLR+J8qViltmqr1VCLaV0asCVn17nf33N41A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVU03+NQ/chDLzbyR5IiLeEN4h/MMNrH/Xg9npNv6ZyjaMiifhgyZfHCPrdeTo9JE
	 S0EYRGPIfAer8r4tnag5qldCgCAQUoYzKsywp3yVYSUUC4G1y+h5bEiLil9xJKH0Yj
	 oKkQRqeJM5fTKsH/nHXQzi8P26yduZ+F8kVYPW4U4nPTMIQ5s1+UEohndlKpl8UGSa
	 0Qy2MsSxSAOolhGpoKmTQNMTZimrcXSsTTA4XVvZeYV37QZKBCbXpbiBOmEO+KKNE2
	 ls0QwF+w9d4k5wvHbaQVW9dNh7CP31mZQ4NohYCBXdes1gHXm3lhOFGgV12mXgnojm
	 plKK+hLt8f1kw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 22/22] tty: vt: decrypt magic constants in vc_is_control()
Date: Fri,  2 Feb 2024 07:56:08 +0100
Message-ID: <20240202065608.14019-23-jirislaby@kernel.org>
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

0x0d00ff81 and 0x0800f501 are bitmasks of ASCII characters. Spell them
explicitly using BIT() + ASCII constants. GENMASK() is used for the
9-bit range in CTRL_ACTION.

This also modifies the 'if' checking if the masks should be applied.
From a "random" ' ' to the actual size of the bitmasks' type.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e35f7a31a7bd..463be4e48dc8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2893,9 +2893,13 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
 	 * as cursor movement) and should not be displayed as a glyph unless
 	 * the disp_ctrl mode is explicitly enabled.
 	 */
-	static const u32 CTRL_ACTION = 0x0d00ff81;
+	static const u32 CTRL_ACTION = BIT(ASCII_NULL) |
+		GENMASK(ASCII_SHIFTIN, ASCII_BELL) | BIT(ASCII_CANCEL) |
+		BIT(ASCII_SUBSTITUTE) | BIT(ASCII_ESCAPE);
 	/* Cannot be overridden by disp_ctrl */
-	static const u32 CTRL_ALWAYS = 0x0800f501;
+	static const u32 CTRL_ALWAYS = BIT(ASCII_NULL) | BIT(ASCII_BACKSPACE) |
+		BIT(ASCII_LINEFEED) | BIT(ASCII_SHIFTIN) | BIT(ASCII_SHIFTOUT) |
+		BIT(ASCII_CAR_RET) | BIT(ASCII_FORMFEED) | BIT(ASCII_ESCAPE);
 
 	if (vc->vc_state != ESnormal)
 		return true;
@@ -2912,7 +2916,7 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
 	 * useless without them; to display an arbitrary font position use the
 	 * direct-to-font zone in UTF-8 mode.
 	 */
-	if (c < ' ') {
+	if (c < BITS_PER_TYPE(CTRL_ALWAYS)) {
 		if (vc->vc_disp_ctrl)
 			return CTRL_ALWAYS & BIT(c);
 		else
-- 
2.43.0


