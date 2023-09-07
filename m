Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFC77979E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbjIGRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243291AbjIGRZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:25:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DD1FEB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:25:15 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13D2B66072AC;
        Thu,  7 Sep 2023 18:10:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694106615;
        bh=sJCfHnubTNfY/3S9mfHkj5m1x1oxHAvtH3b8DUOe0Ek=;
        h=From:To:Cc:Subject:Date:From;
        b=UxdFKSdP6AUDS6OJrN/Phv3NJp5yXNm4NGsQ/r9rGWoihkyFElFi+RQSGywhMPTAm
         ze3LX6p7plxsL8h69HtmoE7huiWYFxOxwDaCB9pZtMuDm7/PctG8kCkLrFGgKknmEb
         wbwJwRhJ23PUMjR3/ASjZ9pe79aaivH+2A17gYLxSKZlBiGB6f6tGzRn8gPI+kpA4g
         qFQxPJlnzIyJsnx1Ic6p9mwlwCX6P2dmnYCCLuo5piR0bFlXw+EVwaF1Pex7sxWvWo
         xjfgkXhRhLOQMHL85SEEB9dafbOW4mwQL7G9yOVjy7rpqkb8qJE5y7m78jsYp62tGz
         ZCeM/UhqAI19w==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 00/11] Improve CS35l41-based audio codec drivers
Date:   Thu,  7 Sep 2023 20:09:59 +0300
Message-ID: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains several fixes and improvements to drivers
based on the CS35l41 audio codec.

It has been verified on Valve's Steam Deck, except the HDA related patches.

Changes in v2:
 - Added Acked-by tags from Charles
 - Reworked the shared boost handling per reviews from Charles and David
 - Dropped PATCH 5/9 and moved PATCH 6/9 a bit down the list, as it doesn't
   contain a Fixes tag
 - Reverted usage of devm_pm_runtime_enable() in PATCH 9/9 and replaced with
   a proper runtime PM changes undo in PATCH v2 06/11
 - Added 3 new patches providing some HDA related fixes
 - v1: https://lore.kernel.org/all/20230902210621.1184693-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (11):
  ASoC: cs35l41: Handle mdsync_down reg write errors
  ASoC: cs35l41: Handle mdsync_up reg write errors
  ASoC: cs35l41: Initialize completion object before requesting IRQ
  ASoC: cs35l41: Fix broken shared boost activation
  ASoC: cs35l41: Verify PM runtime resume errors in IRQ handler
  ASoC: cs35l41: Undo runtime PM changes at driver exit time
  ASoC: cs35l41: Make use of dev_err_probe()
  ASoC: cs35l41: Use modern pm_ops
  ALSA: hda: cs35l41: Fix unbalanced pm_runtime_get()
  ALSA: hda: cs35l41: Undo runtime PM changes at driver exit time
  ALSA: hda: cs35l41: Consistently use dev_err_probe()

 include/sound/cs35l41.h        |  4 +-
 sound/pci/hda/cs35l41_hda.c    | 23 +++++----
 sound/soc/codecs/cs35l41-i2c.c | 11 ++--
 sound/soc/codecs/cs35l41-lib.c | 60 +++++++++++++---------
 sound/soc/codecs/cs35l41-spi.c | 11 ++--
 sound/soc/codecs/cs35l41.c     | 93 +++++++++++++++++++---------------
 sound/soc/codecs/cs35l41.h     |  1 -
 7 files changed, 112 insertions(+), 91 deletions(-)

-- 
2.41.0

