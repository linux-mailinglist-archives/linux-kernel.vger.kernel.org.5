Return-Path: <linux-kernel+bounces-68960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68000858282
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21989281B20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ACD130AD8;
	Fri, 16 Feb 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba9T0zMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF52219ED;
	Fri, 16 Feb 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101128; cv=none; b=OeGM/SQDzTyae3VuXQjTkHMqwCz30kHxlLKn4bPRXQswTotgVT0QKXrixPbbt9Uy8o1MHBS9PLvIIIKpSDozkBuPca6GKi/ZloUTs9vpDq2e5qqs7488dGT+z+gasGCc+9MnUvkTs2Q4fw3xeqM/5uUVVxYwGKSYVZe5NN/1VDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101128; c=relaxed/simple;
	bh=JGR9oWuh9+Gj4ak7aoBRm7nN1ezVNuRLhjn7Tq1Dsog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fOso0/9urkWPXj6CbF09JXVnJTkZRE+SDOqqQprcYNvDy2ZITjmOdOAIRVR+WRHC/3zuZ+NKv/WhfANGrQle5BRffXXdSaiQ7GV5KImjnTJIyRRu5VLeoeX9WKfEInRVghOx8i26k/zIpUF3+4Z2EdwPRvDS+KjDYrEPq/3SNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba9T0zMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBC8C43390;
	Fri, 16 Feb 2024 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708101127;
	bh=JGR9oWuh9+Gj4ak7aoBRm7nN1ezVNuRLhjn7Tq1Dsog=;
	h=From:To:Cc:Subject:Date:From;
	b=Ba9T0zMHZyf/Ke4gnCc2keIIDMRzmRuPhteX/as0JvsiQ2E3w6CyWZB5GXO6EOOXl
	 ucXIIJiRkzT2EjoREmF0CVtbFqRuO1tq6H1hwyV+L8t1gP1HNJH1+LEFC7cBRskE+l
	 2FRK/nqeRrzX0tnK9giDxPJdiRS2pULsRPuix+xkfs/y/sWmfPAU3E5E9iq2WGQeAS
	 hhWBqo3mGxn44UfaWRAJ3Fe7HibrSYJ+0FMJdy7G/59XRD960WwNBU/yDqZJkkVBT1
	 542yYzoTa7b4wTPlf7JqZhkDuSgRKIh+YyM10hckMc9K91iF+6w0G23eW1wigsO2nP
	 NjUY67zUcgAHg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mark Brown <broonie@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] media: dvb-frontends: avoid stack overflow warnings with clang
Date: Fri, 16 Feb 2024 17:31:44 +0100
Message-Id: <20240216163201.1901744-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

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
---
 drivers/media/dvb-frontends/stv0367.c | 34 +++++++--------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-frontends/stv0367.c
index 48326434488c..72540ef4e5f8 100644
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
2.39.2


