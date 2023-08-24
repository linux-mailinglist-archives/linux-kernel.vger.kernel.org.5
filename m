Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E957879D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbjHXVCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjHXVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:01:43 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F851BD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:01:41 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id C780E16C004E;
        Fri, 25 Aug 2023 00:01:39 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l2wbuo6xYTas; Fri, 25 Aug 2023 00:01:38 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1692910898; bh=6T2scqYit3D9spXNYhaJ1FM2bv2gPNeQev13zZjEi60=;
        h=From:To:Cc:Subject:Date:From;
        b=a8pNy9XqdK1KCXgqErE1o2Z08p2cOvKnAJZuW2VBoN3XsxXu6RDaQegxzWAdbbSIO
         D4Waqh5jo1DfhmzzTSmzaTflI0X13PaZpB74XAgGn7BBnFTzAiurKUErezUqDXrDZo
         vIJLrJBmNFg6YwkiIdQVJfQ7itX6sRFkiFtv/6+E=
To:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH v2 0/4] ASoC: amd: acp: Add sound support for a line of HUAWEI laptops
Date:   Fri, 25 Aug 2023 00:01:31 +0300
Message-ID: <20230824210135.19303-1-posteuca@mutex.one>
Content-Type: text/plain; charset="utf-8"
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

This series adds support for a line of HUAWEI laptops with
AMD CPUs that connect using the ACP3x module to a ES8336 CODEC.

The CODEC driver must be extended to support the S32 LE format
and the MCLK div by 2 option. MCLK div by 2 is needed for one specific
SKU, which uses a 48Mhz MCLK, which seems to be too high of a frequency
for the CODEC and must be divided by 2.

The acp legacy driver must also be extended by using callbacks so that
the more complicated handling of this specific CODEC can be moved
outside the more generic ACP code.

Changes in v2:

- Removed patch 4: "ASoC: amd: acp: Improve support for speaker
  power events". May be resubmitted separately.
- Split the first commit that enabled support for S32 LE format and
  the MCLK div by 2 option into two separate commits.
- Removed the MCLK div by 2 DT property that was previously enabled by
  the machine driver. Now it's enabled by the CODEC driver if the MCLK
  frequency is equal or greater than 48Mhz.
- Used normal conditional statements.
- Removed constraint rates from the machine driver, the CODEC should be
  able to set them.
- Moved the DAI format configuration.
- Uncoupled the speaker and headphone GPIOs. Now they can be handled
  independently

Marian Postevca (4):
  ASoC: es8316: Enable support for S32 LE format
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
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 449 ++++++++++++++++++
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h |  12 +
 sound/soc/codecs/es8316.c                     |  22 +-
 sound/soc/codecs/es8316.h                     |   3 +
 10 files changed, 724 insertions(+), 15 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h

-- 
2.41.0

