Return-Path: <linux-kernel+bounces-113381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585338883E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2E61F2718B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E151A03D5;
	Sun, 24 Mar 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LauooWVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CD1A03BB;
	Sun, 24 Mar 2024 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320183; cv=none; b=MXHR5eVPdoeKF0jV3IyOmibch6ekoB+JPXknRHJdc02fBkwoe//uLQ1nK/IcKw+FCncetMa6XwOoBKsYufQBuq5X+F1O5ut/jh0xr0uavW3H1VlTP0HuGXqFCXw2S2YXVSV9t8cnjHgUp15CCs4uBDCzhx/FVPk8Ja9xED0byBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320183; c=relaxed/simple;
	bh=wsCttE/8/Ku+Vjtz6C9C/qBhYMSWFBBeJX3HQY8qfyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2WWSFyIjzg8Jp3QJOvZ5AvIaWsEFBUbvBrgI+pPO923McqqcCQOm2P7fopech0YblYQtz7UPIHPfWRYZAywsgFnPHl3TQ+7faC/muJlTZ8KdzVkOhtu0Y2Or6UemOVawoupG+kQIqny0MxNRVhegH/o2R3/+2Z95TZeJ7EVFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LauooWVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B35C43399;
	Sun, 24 Mar 2024 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320182;
	bh=wsCttE/8/Ku+Vjtz6C9C/qBhYMSWFBBeJX3HQY8qfyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LauooWVq1lbDzymCJusR0L7+1QFgKVteDf2/v9RSMc19Aru5zeppggmmcT5DGJeUq
	 npbGXAzAkNjJO3WunZaF1a9NWKiRwvvZXbcW87wOs5lRXA+ORxqrs3q1XoavNoSPy5
	 oDvVIrlu4ujgA/KeW5IS6sM7igagZRYdxkQRpksy9q3hE3B6UVFvb1I/cMs3TkS8fm
	 /iSOM+152W28YWJQVjGjmCZRMYXsSRZ9Du6rkkrb8FZRaokLGTC6Ly2CgKmZDFjfkb
	 VePKUDMV++cskbrj428R5RGARI4tzyT2JOixlS68B3u1u7No/1J3QY04M778jOEO2a
	 V5gWVSZQ6olGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Justin Stitt <justinstitt@google.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 490/715] media: dvb-frontends: avoid stack overflow warnings with clang
Date: Sun, 24 Mar 2024 18:31:09 -0400
Message-ID: <20240324223455.1342824-491-sashal@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 7a4cf27d1f0538f779bf31b8c99eda394e277119 ]

A previous patch worked around a KASAN issue in stv0367, now a similar
problem showed up with clang:

drivers/media/dvb-frontends/stv0367.c:1222:12: error: stack frame size (3624) exceeds limit (2048) in 'stv0367ter_set_frontend' [-Werror,-Wframe-larger-than]
 1214 | static int stv0367ter_set_frontend(struct dvb_frontend *fe)

Rework the stv0367_writereg() function to be simpler and mark both
register access functions as noinline_for_stack so the temporary
i2c_msg structures do not get duplicated on the stack when KASAN_STACK
is enabled.

Fixes: 3cd890dbe2a4 ("media: dvb-frontends: fix i2c access helpers for KASAN")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/stv0367.c | 34 +++++++--------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-frontends/stv0367.c
index 48326434488c4..72540ef4e5f88 100644
--- a/drivers/media/dvb-frontends/stv0367.c
+++ b/drivers/media/dvb-frontends/stv0367.c
@@ -118,50 +118,32 @@ static const s32 stv0367cab_RF_LookUp2[RF_LOOKUP_TABLE2_SIZE][RF_LOOKUP_TABLE2_S
 	}
 };
 
-static
-int stv0367_writeregs(struct stv0367_state *state, u16 reg, u8 *data, int len)
+static noinline_for_stack
+int stv0367_writereg(struct stv0367_state *state, u16 reg, u8 data)
 {
-	u8 buf[MAX_XFER_SIZE];
+	u8 buf[3] = { MSB(reg), LSB(reg), data };
 	struct i2c_msg msg = {
 		.addr = state->config->demod_address,
 		.flags = 0,
 		.buf = buf,
-		.len = len + 2
+		.len = 3,
 	};
 	int ret;
 
-	if (2 + len > sizeof(buf)) {
-		printk(KERN_WARNING
-		       "%s: i2c wr reg=%04x: len=%d is too big!\n",
-		       KBUILD_MODNAME, reg, len);
-		return -EINVAL;
-	}
-
-
-	buf[0] = MSB(reg);
-	buf[1] = LSB(reg);
-	memcpy(buf + 2, data, len);
-
 	if (i2cdebug)
 		printk(KERN_DEBUG "%s: [%02x] %02x: %02x\n", __func__,
-			state->config->demod_address, reg, buf[2]);
+			state->config->demod_address, reg, data);
 
 	ret = i2c_transfer(state->i2c, &msg, 1);
 	if (ret != 1)
 		printk(KERN_ERR "%s: i2c write error! ([%02x] %02x: %02x)\n",
-			__func__, state->config->demod_address, reg, buf[2]);
+			__func__, state->config->demod_address, reg, data);
 
 	return (ret != 1) ? -EREMOTEIO : 0;
 }
 
-static int stv0367_writereg(struct stv0367_state *state, u16 reg, u8 data)
-{
-	u8 tmp = data; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
-
-	return stv0367_writeregs(state, reg, &tmp, 1);
-}
-
-static u8 stv0367_readreg(struct stv0367_state *state, u16 reg)
+static noinline_for_stack
+u8 stv0367_readreg(struct stv0367_state *state, u16 reg)
 {
 	u8 b0[] = { 0, 0 };
 	u8 b1[] = { 0 };
-- 
2.43.0


