Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3D78CF58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjH2WBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjH2WBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:01:30 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87423122
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:01:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 008FB16C004E;
        Wed, 30 Aug 2023 01:01:24 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NX2psMeZRXTw; Wed, 30 Aug 2023 01:01:22 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1693346481; bh=X0Dq/ie15C6kVMLCIxX5m01gOxRCdkYlZEPaPGAgA1E=;
        h=From:To:Cc:Subject:Date:From;
        b=j+hoXvCCAgvZlLcWUb0EXP4ITtDd+RcQT46WU6ogpWvS0SCtbQFP4G3GnBpxGf5zl
         N2RpYqtzjXqUdPU+jN8f1uzlgynxzXf5AxJ7TXZ8gOwOR7/qbrP9FkPMYssRvY+8tT
         zHsB2iydu+vf42YSBGYj8eyl61fLJu3xxI+EHRzQ=
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH v3 0/5] ASoC: amd: acp: Add sound support for a line of HUAWEI laptops
Date:   Wed, 30 Aug 2023 01:01:11 +0300
Message-ID: <20230829220116.1159-1-posteuca@mutex.one>
Content-Type: text/plain; charset="utf-8"
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

This series adds support for a line of HUAWEI laptops with
AMD CPUs that connect using the ACP3x module to a ES8336 CODEC.

The CODEC driver must be extended to support the S32 LE format
and the MCLK div by 2 option. MCLK div by 2 is needed for one specific
SKU, which uses a 48Mhz MCLK, which seems to be too high of a frequency
for the CODEC and must be divided by 2.

The acp legacy driver must also be extended by using callbacks so that
the more complicated handling of this specific CODEC can be moved
outside the more generic ACP code.

Changes in v3:

- Modified commit message for patch 1: ASoC: es8316: Enable support for
   S32 LE format. The commit message implied that S32 LE format is the
   only one that is supported by the machine driver. The AMD ACP
   supports a wide variety of formats that are also supported by the
   CODEC. Now the purpose of the patch is to enable one additional
   format that is supported by the CODEC chip.

- Added new patch: Replace NR_SUPPORTED_MCLK_LRCK_RATIOS with ARRAY_SIZE()
   No need to have a special define when we can use ARRAY_SIZE() directly.

- Reworked the MCLK div by 2 option. Now the CODEC driver will first
   try to use halved frequency by checking if it can generate
   suitable clocking. If it can not, then the full MCLK will be used.
   In this way we can also support unknown SKU that have a too high
   MCLK frequency.

- Moved generic ACP code from patch 5, that introduces the new machine
   driver, to patch 4, that introduces ACP legacy callback mechanism.

- Removed the forced S32 LE format in the new machine driver.

Marian Postevca (5):
  ASoC: es8316: Enable support for S32 LE format
  ASoC: es8316: Replace NR_SUPPORTED_MCLK_LRCK_RATIOS with ARRAY_SIZE()
  ASoC: es8316: Enable support for MCLK div by 2
  ASoC: amd: acp: Add support for splitting the codec specific code from
    the ACP driver
  ASoC: amd: acp: Add machine driver that enables sound for systems with
    a ES8336 codec

 sound/soc/amd/acp-config.c                    |  70 +++
 sound/soc/amd/acp/Makefile                    |   2 +-
 sound/soc/amd/acp/acp-legacy-mach.c           | 102 +++-
 sound/soc/amd/acp/acp-mach-common.c           |   8 +
 sound/soc/amd/acp/acp-mach.h                  |  67 +++
 sound/soc/amd/acp/acp-renoir.c                |   4 +
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 443 ++++++++++++++++++
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h |  12 +
 sound/soc/codecs/es8316.c                     |  52 +-
 sound/soc/codecs/es8316.h                     |   3 +
 10 files changed, 736 insertions(+), 27 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h

-- 
2.41.0

