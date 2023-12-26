Return-Path: <linux-kernel+bounces-11233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6581E37D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E419C287E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76672847A;
	Tue, 26 Dec 2023 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9eMgqVn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DDEDB;
	Tue, 26 Dec 2023 00:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C171C433C7;
	Tue, 26 Dec 2023 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550178;
	bh=bUXXbpAUzKwZSW6AzFIb367DDnA0jXEe5R4SWVBJ8N4=;
	h=From:To:Cc:Subject:Date:From;
	b=k9eMgqVnaSXJvv+/CfLik7XeE7YLvplUx+xQKqs1WSey1FkpFNUYemMoQLEkicFK5
	 8qFz+gns9FaL/XhWNYm7G2TosIvW4Uzsr7x65GxIk7uP49uF6dZyMB+W36Z6/9YTYA
	 mX9N5hAKoW45ZUF60Xwt1RYCkJHWmJX+jUc7xEfcta1P/5XwwaEU7b3BwdbSG9EHq+
	 NrlPZ7rislFzszBNGGRfeuMTFMos2F9OFUXq31JEb8/lpM6sV75i/zxALjfZGFgmCJ
	 FCFgnpEPkcoU32vsx3MLjP4hAgZjg5rVpTpU++xldkVdA+GjHGyG9ZJ7Wc+FRwvIw3
	 EJgdNdSQxSUtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	rrangel@chromium.org,
	jefferymiller@google.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/24] Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1
Date: Mon, 25 Dec 2023 19:21:54 -0500
Message-ID: <20231226002255.5730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
Content-Transfer-Encoding: 8bit

From: José Pekkarinen <jose.pekkarinen@foxhound.fi>

[ Upstream commit c1f342f35f820b33390571293498c3e2e9bc77ec ]

Observed on dmesg of my laptop I see the following
output:

[   19.898700] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
[   19.936057] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[   19.936076] psmouse serio1: synaptics: Your touchpad (PNP: LEN0411 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[   20.008901] psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board id: 3471, fw id: 2909640
[   20.008925] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[   20.053344] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input7
[   20.397608] mousedev: PS/2 mouse device common for all mice

This patch will add its pnp id to the smbus list to
produce the setup of intertouch for the device.

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
Link: https://lore.kernel.org/r/20231114063607.71772-1-jose.pekkarinen@foxhound.fi
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index e43e93ac2798a..b6749af462620 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -183,6 +183,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN009b", /* T580 */
 	"LEN0402", /* X1 Extreme Gen 2 / P1 Gen 2 */
 	"LEN040f", /* P1 Gen 3 */
+	"LEN0411", /* L14 Gen 1 */
 	"LEN200f", /* T450s */
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
-- 
2.43.0


