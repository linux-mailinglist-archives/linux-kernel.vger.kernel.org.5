Return-Path: <linux-kernel+bounces-114899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB688921D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F751F2E063
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B51BD029;
	Mon, 25 Mar 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3dOgp8x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655F14198E;
	Sun, 24 Mar 2024 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323592; cv=none; b=qs6vNxbY84Qq3IFRp6yHW2ay7lYZpFY7gyKo88ccYjsZ0WiXEENp935ePj4aYjaOLO3C36aJQe/QuH7pvrwg7bmWQXaTO5uurSR7ed53kC3tVnirtTd2qD3GcBZBRWi998SbHcqm0M0Xqzd/MhSqRsurtMJINLe8sFbKseEdT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323592; c=relaxed/simple;
	bh=7nFrWKjORVJFDZ04vWB+gW5EXeckc6rX1NicBls0Js0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bbv+r/lx4XB0yHDjjN1oj3XOJ36JBAYLLAeVLP69SFLFfQ7uncF1sQD+ealnWf5qQFL9QRy8THt70q9WACCSSAKirgFypn9gv6e+BGFZduhUPfx9QVFd6WiH/qq/Ff6+kDhG9C8ylrsjZFViohxrK1LMhfYC1DhaSpnzTU1e+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3dOgp8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AC7C433C7;
	Sun, 24 Mar 2024 23:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323591;
	bh=7nFrWKjORVJFDZ04vWB+gW5EXeckc6rX1NicBls0Js0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3dOgp8xOCWyxa5hORN8cCphh8OIShE8YZE0Y6Y0TouXowX8HLPX03B1ccsU1LNcs
	 PM5GVxr2HqXWpUT6PjcIkFBvI84wgN8E5X1W2CkM33x0nr+N9zG9NFWmtRMTfqfDOG
	 QPtmaNHkEFgWv6dLhLfymljHIbrwVoFINsp49BJPodO3Tjc4Y+bepDz85QzVBltg7m
	 y998qwrOVMMVUzqj4gc+jLyhdCK/ExJiQfowAEgZJmdcvaCeBFbQv4NFF24BWcskT6
	 ksysS7qP5tJyEqlZoBinpqOJyvUBrtk5BlDI6knvi8XG38SOZXIRgdNJ7AlXtV9XWE
	 yBewSKhyQ4y1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Justin Swartz <justin.swartz@risingedge.co.za>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 298/317] net: dsa: mt7530: prevent possible incorrect XTAL frequency selection
Date: Sun, 24 Mar 2024 19:34:38 -0400
Message-ID: <20240324233458.1352854-299-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit f490c492e946d8ffbe65ad4efc66de3c5ede30a4 ]

On MT7530, the HT_XTAL_FSEL field of the HWTRAP register stores a 2-bit
value that represents the frequency of the crystal oscillator connected to
the switch IC. The field is populated by the state of the ESW_P4_LED_0 and
ESW_P4_LED_0 pins, which is done right after reset is deasserted.

  ESW_P4_LED_0    ESW_P3_LED_0    Frequency
  -----------------------------------------
  0               0               Reserved
  0               1               20MHz
  1               0               40MHz
  1               1               25MHz

On MT7531, the XTAL25 bit of the STRAP register stores this. The LAN0LED0
pin is used to populate the bit. 25MHz when the pin is high, 40MHz when
it's low.

These pins are also used with LEDs, therefore, their state can be set to
something other than the bootstrapping configuration. For example, a link
may be established on port 3 before the DSA subdriver takes control of the
switch which would set ESW_P3_LED_0 to high.

Currently on mt7530_setup() and mt7531_setup(), 1000 - 1100 usec delay is
described between reset assertion and deassertion. Some switch ICs in real
life conditions cannot always have these pins set back to the bootstrapping
configuration before reset deassertion in this amount of delay. This causes
wrong crystal frequency to be selected which puts the switch in a
nonfunctional state after reset deassertion.

The tests below are conducted on an MT7530 with a 40MHz crystal oscillator
by Justin Swartz.

With a cable from an active peer connected to port 3 before reset, an
incorrect crystal frequency (0b11 = 25MHz) is selected:

                      [1]                  [3]     [5]
                      :                    :       :
              _____________________________         __________________
ESW_P4_LED_0                               |_______|
              _____________________________
ESW_P3_LED_0                               |__________________________

                       :                  : :     :
                       :                  : [4]...:
                       :                  :
                       [2]................:

[1] Reset is asserted.
[2] Period of 1000 - 1100 usec.
[3] Reset is deasserted.
[4] Period of 315 usec. HWTRAP register is populated with incorrect
    XTAL frequency.
[5] Signals reflect the bootstrapped configuration.

Increase the delay between reset_control_assert() and
reset_control_deassert(), and gpiod_set_value_cansleep(priv->reset, 0) and
gpiod_set_value_cansleep(priv->reset, 1) to 5000 - 5100 usec. This amount
ensures a higher possibility that the switch IC will have these pins back
to the bootstrapping configuration before reset deassertion.

With a cable from an active peer connected to port 3 before reset, the
correct crystal frequency (0b10 = 40MHz) is selected:

                      [1]        [2-1]     [3]     [5]
                      :          :         :       :
              _____________________________         __________________
ESW_P4_LED_0                               |_______|
              ___________________           _______
ESW_P3_LED_0                     |_________|       |__________________

                       :          :       : :     :
                       :          [2-2]...: [4]...:
                       [2]................:

[1] Reset is asserted.
[2] Period of 5000 - 5100 usec.
[2-1] ESW_P3_LED_0 goes low.
[2-2] Remaining period of 5000 - 5100 usec.
[3] Reset is deasserted.
[4] Period of 310 usec. HWTRAP register is populated with bootstrapped
    XTAL frequency.
[5] Signals reflect the bootstrapped configuration.

ESW_P3_LED_0 low period before reset deassertion:

              5000 usec
            - 5100 usec
    TEST     RESET HOLD
       #         (usec)
  ---------------------
       1           5410
       2           5440
       3           4375
       4           5490
       5           5475
       6           4335
       7           4370
       8           5435
       9           4205
      10           4335
      11           3750
      12           3170
      13           4395
      14           4375
      15           3515
      16           4335
      17           4220
      18           4175
      19           4175
      20           4350

     Min           3170
     Max           5490

  Median       4342.500
     Avg       4466.500

Revert commit 2920dd92b980 ("net: dsa: mt7530: disable LEDs before reset").
Changing the state of pins via reset assertion is simpler and more
efficient than doing so by setting the LED controller off.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
Co-developed-by: Justin Swartz <justin.swartz@risingedge.co.za>
Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f74d9fbd08178..636943035c292 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2154,11 +2154,11 @@ mt7530_setup(struct dsa_switch *ds)
 	 */
 	if (priv->mcm) {
 		reset_control_assert(priv->rstc);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
 		gpiod_set_value_cansleep(priv->reset, 0);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		gpiod_set_value_cansleep(priv->reset, 1);
 	}
 
@@ -2368,11 +2368,11 @@ mt7531_setup(struct dsa_switch *ds)
 	 */
 	if (priv->mcm) {
 		reset_control_assert(priv->rstc);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
 		gpiod_set_value_cansleep(priv->reset, 0);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		gpiod_set_value_cansleep(priv->reset, 1);
 	}
 
-- 
2.43.0


