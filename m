Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8507F7909A5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjIBVGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIBVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:06:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C6AB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:06:27 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EF9B6607285;
        Sat,  2 Sep 2023 22:06:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693688785;
        bh=OwodNzQow81cioZ/x0NFsPD4e4UBN2L+BF3m/k/eTjY=;
        h=From:To:Cc:Subject:Date:From;
        b=IuNe7fdRvYqd600PCKP9mxCOAAYRUEXAC9kmN9WRd3HtS/cl/gi7nOaLX0tEgnjvi
         V4b1wpNzZOKpHS3iMBK87N8LUFSObzRIh/LyAT3mHbYyy96jd4FDKZr5qSFMMbQP3n
         gwyKEyxpiH6g/i/0dLvgui10KydGZOR2v7QIQXSMjHp+BB8guBkNMhkQi9PDKc1YF0
         7P7ynyUi4Mun29FBQOv9KyPTPusDwD07eNMNGb6X70GqqziexbMGNtAniodCiZEk7A
         uoGKYG8RjeMmsP9/2uoYxDxhVAvdpDnLr/W85TV/GKVO/3TEBJ0BEFqTJKEVDZnYYu
         MLOB46NUBChvQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 0/9] Improve CS35l41 ALSA SoC audio driver
Date:   Sun,  3 Sep 2023 00:06:12 +0300
Message-ID: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains several fixes and improvements to 
the CS35l41 audio codec driver.

It has been verified on Valve's Steam Deck.

Cristian Ciocaltea (9):
  ASoC: cs35l41: Handle mdsync_down reg write errors
  ASoC: cs35l41: Handle mdsync_up reg write errors
  ASoC: cs35l41: Initialize completion object before requesting IRQ
  ASoC: cs35l41: Fix broken shared boost activation
  ASoC: cs35l41: Rename pll_lock to pll_lock_done
  ASoC: cs35l41: Make use of dev_err_probe()
  ASoC: cs35l41: Verify PM runtime resume errors in IRQ handler
  ASoC: cs35l41: Use modern pm_ops
  ASoC: cs35l41: Use devm_pm_runtime_enable()

 include/sound/cs35l41.h        |   5 +-
 sound/soc/codecs/cs35l41-i2c.c |  11 ++-
 sound/soc/codecs/cs35l41-lib.c |  83 ++++++++++++++++------
 sound/soc/codecs/cs35l41-spi.c |  11 ++-
 sound/soc/codecs/cs35l41.c     | 121 ++++++++++++++++++++++-----------
 sound/soc/codecs/cs35l41.h     |   4 +-
 6 files changed, 158 insertions(+), 77 deletions(-)

-- 
2.41.0

