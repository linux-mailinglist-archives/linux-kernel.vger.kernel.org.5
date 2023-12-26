Return-Path: <linux-kernel+bounces-11193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A246A81E309
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD68B1C210E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD57E6;
	Tue, 26 Dec 2023 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpEPLtvZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C736E;
	Tue, 26 Dec 2023 00:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF05C433C7;
	Tue, 26 Dec 2023 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550025;
	bh=i4wXejtK3M6QlaHztWuWv4sXZWQ+aOYpR+7zI6fzdYA=;
	h=From:To:Cc:Subject:Date:From;
	b=jpEPLtvZSH64C3CtBeJUAk9p3YYf/T7KFJIOqT0W7L5VpZDMAwiXlk4EKcP2PTVRl
	 loplfZXjxlzZ1eEzbx5TFpRIsvlbfDA6aRn8o94w/cTBWeIEe1r/Sl3rwoiK8LSC9z
	 YS7sOAh6q8BQ6dY0IKhrKIK4CDzWnlGbY5Qg8Khcgt81KvyDyxAAyjnPWYZ+Yc2aVh
	 KL3CuBwsNXWFj+f25kRQASp1QnoQZKC5ZXySJV1y49VZwW39caAoWkFxscLyGD270E
	 9SFzGNGuyA6lD7PIjJN01j7REmO5Y5IsKwIG09j93AMp0Fg8+yCJ6zaynn/kuaFnmt
	 URz1TlUudDUJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	jefferymiller@google.com,
	rrangel@chromium.org,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/39] Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1
Date: Mon, 25 Dec 2023 19:18:51 -0500
Message-ID: <20231226002021.4776-1-sashal@kernel.org>
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
X-stable-base: Linux 6.6.8
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
index 22d16d80efb93..7a303a9d6bf72 100644
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


