Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F9777D2CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbjHOTCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbjHOTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557BE268D;
        Tue, 15 Aug 2023 12:02:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 353B5211B8;
        Tue, 15 Aug 2023 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=//6lpnW6sCl4feNuAFbqi6XUsXoCWMdVSeRR25UImmk=;
        b=lKC4tZf7WG38nR/+S7P0hfukLxRpFMGV/R/rtIcnNlUGsWOO0WmwaXvEWgThkvB1ihsRXm
        HWmdV0Mo0Bwu13DaVDZt15C+28SU66ST57i/9JfQIAcomGTW0DEn3qM/Z7mh70VWRyUI0a
        tvIAUJZX0m1q1PB+9pcimyQjlw5iWL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=//6lpnW6sCl4feNuAFbqi6XUsXoCWMdVSeRR25UImmk=;
        b=7bAEkFaYSkQrYTqFUCvdJZuyzgiU44+C+bBhhQFbDIcKL7WJ0SParPiABaClmft1Gfd6Kg
        2o7jLFBIu41otZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9CCC1353E;
        Tue, 15 Aug 2023 19:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XZIxL5rL22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:46 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Utkin <andrey_utkin@fastmail.com>,
        Anton Sviridenko <anton@corp.bluecherry.net>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ismael Luceno <ismael@iodev.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-media@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 00/25] ALSA: Generic PCM copy ops using iov_iter
Date:   Tue, 15 Aug 2023 21:01:11 +0200
Message-Id: <20230815190136.8987-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a v2 patch set for cleaning up the PCM copy ops using
iov_iter to deal with kernel / user-space pointers consistently.

v1->v2:
* The error condition checks of copy_to/from_iter() are changed to
  be more strictly
* Put Acked and Reviewed tags
* The indents in the patch in dmaengine was slightly changed

v1:
  https://lore.kernel.org/r/20230814115523.15279-1-tiwai@suse.de


Takashi

===

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: Anton Sviridenko <anton@corp.bluecherry.net>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Banajit Goswami <bgoswami@quicinc.com>
Cc: Bluecherry Maintainers <maintainers@bluecherrydvr.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Ismael Luceno <ismael@iodev.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: xen-devel@lists.xenproject.org

===

Takashi Iwai (25):
  iov_iter: Export import_ubuf()
  ALSA: pcm: Add copy ops with iov_iter
  ALSA: core: Add memory copy helpers between iov_iter and iomem
  ALSA: dummy: Convert to generic PCM copy ops
  ALSA: gus: Convert to generic PCM copy ops
  ALSA: emu8000: Convert to generic PCM copy ops
  ALSA: es1938: Convert to generic PCM copy ops
  ALSA: korg1212: Convert to generic PCM copy ops
  ALSA: nm256: Convert to generic PCM copy ops
  ALSA: rme32: Convert to generic PCM copy ops
  ALSA: rme96: Convert to generic PCM copy ops
  ALSA: hdsp: Convert to generic PCM copy ops
  ALSA: rme9652: Convert to generic PCM copy ops
  ALSA: sh: Convert to generic PCM copy ops
  ALSA: xen: Convert to generic PCM copy ops
  ALSA: pcmtest: Update comment about PCM copy ops
  media: solo6x10: Convert to generic PCM copy ops
  ASoC: component: Add generic PCM copy ops
  ASoC: mediatek: Convert to generic PCM copy ops
  ASoC: qcom: Convert to generic PCM copy ops
  ASoC: dmaengine: Convert to generic PCM copy ops
  ASoC: dmaengine: Use iov_iter for process callback, too
  ALSA: doc: Update description for the new PCM copy ops
  ASoC: pcm: Drop obsoleted PCM copy_user ops
  ALSA: pcm: Drop obsoleted PCM copy_user and copy_kernel ops

 .../kernel-api/writing-an-alsa-driver.rst     | 58 ++++-------
 drivers/media/pci/solo6x10/solo6x10-g723.c    | 39 ++------
 include/sound/dmaengine_pcm.h                 |  2 +-
 include/sound/pcm.h                           | 13 ++-
 include/sound/soc-component.h                 | 14 +--
 lib/iov_iter.c                                |  1 +
 sound/core/memory.c                           | 56 +++++++++--
 sound/core/pcm_lib.c                          | 95 ++++++++++---------
 sound/core/pcm_native.c                       |  2 +-
 sound/drivers/dummy.c                         | 12 +--
 sound/drivers/pcmtest.c                       |  2 +-
 sound/isa/gus/gus_pcm.c                       | 23 +----
 sound/isa/sb/emu8000_pcm.c                    | 74 ++++-----------
 sound/pci/es1938.c                            | 30 +-----
 sound/pci/korg1212/korg1212.c                 | 50 +++-------
 sound/pci/nm256/nm256.c                       | 42 ++------
 sound/pci/rme32.c                             | 50 +++-------
 sound/pci/rme96.c                             | 42 ++------
 sound/pci/rme9652/hdsp.c                      | 42 ++------
 sound/pci/rme9652/rme9652.c                   | 46 ++-------
 sound/sh/sh_dac_audio.c                       | 25 +----
 sound/soc/atmel/mchp-pdmc.c                   |  2 +-
 sound/soc/mediatek/common/mtk-btcvsd.c        | 27 ++----
 sound/soc/qcom/lpass-platform.c               | 13 +--
 sound/soc/soc-component.c                     | 16 ++--
 sound/soc/soc-generic-dmaengine-pcm.c         | 18 ++--
 sound/soc/soc-pcm.c                           |  4 +-
 sound/soc/stm/stm32_sai_sub.c                 |  2 +-
 sound/xen/xen_snd_front_alsa.c                | 56 +++--------
 29 files changed, 269 insertions(+), 587 deletions(-)

-- 
2.35.3

