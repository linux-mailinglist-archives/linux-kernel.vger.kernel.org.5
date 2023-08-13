Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5977A7C6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjHMPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjHMPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4F199D;
        Sun, 13 Aug 2023 08:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B39F9631D1;
        Sun, 13 Aug 2023 15:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B39DC433C9;
        Sun, 13 Aug 2023 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941800;
        bh=iGTcYwKqgPj79EMUdjpLiT0rDvucpDHlktU1nMEDQEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIAZ6AGqDImEblabhxnYZ4a8mDCrgvSckagj9DEpvNnZSVsmb6L/Hrp+iTUMwaIEb
         KjmxX3mFb0teDUTTL2aAtCLFUDOWgCueULgCSG55jNBCSR7koPhdEfLlnJ/Y2t/HtK
         mwpO335mt0REiWBx/vdPkYAfCyREba7T1T7R1Ip1yTxmsPr0olrAvWIAEAdP+deq72
         mQHCLUOHlFyWVob6zAiQelT0J9qaTmUNWQujbmC111cc3GxhUVaeLj0rOcZ/AuwoDi
         6vLzursSY6JAIi7i2+Ej9HLX0znWuGnHuXMSlR+KdgFwX6oxaACyChY11bGkMkPf9X
         d8nL6Q4p+SCfA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmytro Maluka <dmy@semihalf.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 15/54] ASoC: da7219: Flush pending AAD IRQ when suspending
Date:   Sun, 13 Aug 2023 11:48:54 -0400
Message-Id: <20230813154934.1067569-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Maluka <dmy@semihalf.com>

[ Upstream commit 91e292917dad64ab8d1d5ca2ab3069ad9dac6f72 ]

da7219_aad_suspend() disables jack detection, which should prevent
generating new interrupts by DA7219 while suspended. However, there is a
theoretical possibility that there is a pending interrupt generated just
before suspending DA7219 and not handled yet, so the IRQ handler may
still run after DA7219 is suspended. To prevent that, wait until the
pending IRQ handling is done.

This patch arose as an attempt to fix the following I2C failure
occurring sometimes during system suspend or resume:

[  355.876211] i2c_designware i2c_designware.3: Transfer while suspended
[  355.876245] WARNING: CPU: 2 PID: 3576 at drivers/i2c/busses/i2c-designware-master.c:570 i2c_dw_xfer+0x411/0x440
...
[  355.876462] Call Trace:
[  355.876468]  <TASK>
[  355.876475]  ? update_load_avg+0x1b3/0x615
[  355.876484]  __i2c_transfer+0x101/0x1d8
[  355.876494]  i2c_transfer+0x74/0x10d
[  355.876504]  regmap_i2c_read+0x6a/0x9c
[  355.876513]  _regmap_raw_read+0x179/0x223
[  355.876521]  regmap_raw_read+0x1e1/0x28e
[  355.876527]  regmap_bulk_read+0x17d/0x1ba
[  355.876532]  ? __wake_up+0xed/0x1bb
[  355.876542]  da7219_aad_irq_thread+0x54/0x2c9 [snd_soc_da7219 5fb8ebb2179cf2fea29af090f3145d68ed8e2184]
[  355.876556]  irq_thread+0x13c/0x231
[  355.876563]  ? irq_forced_thread_fn+0x5f/0x5f
[  355.876570]  ? irq_thread_fn+0x4d/0x4d
[  355.876576]  kthread+0x13a/0x152
[  355.876581]  ? synchronize_irq+0xc3/0xc3
[  355.876587]  ? kthread_blkcg+0x31/0x31
[  355.876592]  ret_from_fork+0x1f/0x30
[  355.876601]  </TASK>

which indicates that the AAD IRQ handler is unexpectedly running when
DA7219 is suspended, and as a result, is trying to read data from DA7219
over I2C and is hitting the I2C driver "Transfer while suspended"
failure.

However, with this patch the above failure is still reproducible. So
this patch does not fix any real observed issue so far, but at least is
useful for confirming that the above issue is not caused by a pending
IRQ but rather looks like a DA7219 hardware issue with an IRQ
unexpectedly generated after jack detection is already disabled.

Signed-off-by: Dmytro Maluka <dmy@semihalf.com>
Link: https://lore.kernel.org/r/20230717193737.161784-2-dmy@semihalf.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 993a0d00bc48d..07c5d9d354b6d 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -910,6 +910,8 @@ void da7219_aad_suspend(struct snd_soc_component *component)
 			}
 		}
 	}
+
+	synchronize_irq(da7219_aad->irq);
 }
 
 void da7219_aad_resume(struct snd_soc_component *component)
-- 
2.40.1

