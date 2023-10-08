Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2637BCD2E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjJHIId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJHIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:08:32 -0400
X-Greylist: delayed 506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Oct 2023 01:08:30 PDT
Received: from 6.mo575.mail-out.ovh.net (6.mo575.mail-out.ovh.net [46.105.63.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E2CA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:08:30 -0700 (PDT)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.143.72])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id ED82827DA8
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 08:00:01 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-9mdf6 (unknown [10.110.171.163])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5E1A01FE55;
        Sun,  8 Oct 2023 08:00:00 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.106])
        by ghost-submission-6684bf9d7b-9mdf6 with ESMTPSA
        id SGIwEoBhImXIvwAA5rXBkA
        (envelope-from <jose.pekkarinen@foxhound.fi>); Sun, 08 Oct 2023 08:00:00 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-106R006c7d3698b-c1da-41f1-860f-13c89ef29aab,
                    F6EE83B07292679BC443460DC7C66060252C3E74) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 83.100.45.21
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        amandhoot12@gmail.com, rrangel@chromium.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Input: synaptics: enable InterTouch for ThinkPad L14 G1
Date:   Sun,  8 Oct 2023 11:01:28 +0300
Message-ID: <20231008080129.17931-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7025896895597160102
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrhedtgdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeeftdelueetieetvdettdetueeivedujeefffdvteefkeelhefhleelfeetteejjeenucfkphepuddvjedrtddrtddruddpkeefrddutddtrdeghedrvddupdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
produce the setup of intertouch for the device. After
applying, the ouput will look like:

[   19.168664] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
[   19.206311] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[   19.206325] psmouse serio1: synaptics: Trying to set up SMBus access
[   19.209545] psmouse serio1: synaptics: SMbus companion is not ready yet
[   19.283845] psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board id: 3471, fw id: 2909640
[   19.283863] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[   19.328959] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input8
[   19.706164] mousedev: PS/2 mouse device common for all mice

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ada299ec5bba..376a041c80b2 100644
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
2.41.0

