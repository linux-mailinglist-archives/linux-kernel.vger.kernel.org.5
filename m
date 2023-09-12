Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7179CA32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjILIjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjILIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:39:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01002AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694507950; x=1726043950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4ejql24HEMpBoTtiKSAXpLvVWBPjkQdUnHC8bPFBtto=;
  b=JmOg+9KDitB72NMXe9IMI7A30BP/mx/8jZXQs8BXlu9+wdCOTES5NYQI
   h4ZQzTiiY64gpEcXjw2Vdaj6WNc/wjbjn13Y1kmoE2lCXNxsBklPqpzLd
   /XZSwZluw5j3+xB1jhcgMJPdWNWqFVXFERoua3787e7Vo36LMOq5Jm5Ob
   N4LOEU/oCMwrKMc603UkVWxal2ft1vtEN3WcV/N21NwquQNWOM5/lqYJP
   PBSM4asWmXxT9tBUrvIJZjMFrQ9bTR5mqyL0xEbSn1AUwYxmX9v31gKoD
   JswkfG3ER4ALtbJFbsMQUb7zbBMLCWtvjgLFr/wON6k3cqJhiSE9DyZ+S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381015223"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="381015223"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833826778"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="833826778"
Received: from mkidd-mobl.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.251.217.72])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:39:06 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     tiwai@suse.com, perex@perex.cz, arnd@arndb.de
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: core: Increase the name array size for debugfs directory name
Date:   Tue, 12 Sep 2023 11:39:10 +0300
Message-ID: <20230912083910.15994-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idx is guarantied to be less than SNDRV_CARDS (max 256 or 8) by the
code in snd_card_init(), however the compiler does not see that.
Compiling with W=1 results:

sound/core/init.c: In function ‘snd_card_init’:
sound/core/init.c:367:28: error: ‘%d’ directive writing between 1 and 10 bytes into a region of size 4 [-Werror=format-overflow=]
  367 |         sprintf(name, "card%d", idx);
      |                            ^~
sound/core/init.c:367:23: note: directive argument in the range [0, 2147483646]
  367 |         sprintf(name, "card%d", idx);
      |                       ^~~~~~~~
sound/core/init.c:367:9: note: ‘sprintf’ output between 6 and 15 bytes into a destination of size 8
  367 |         sprintf(name, "card%d", idx);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

While the code is correct, we need to silence the compiler somehow.
It could be done by limiting the range in sprintf like
sprintf(name, "card%d", idx % SNDRV_CARDS);
sprintf(name, "card%hhd", idx);
etc

These are too workaroundish. Increase the name array to 15 instead which
looks better and only adds 7 bytes on stack.

The warnings got brought to light by a recent patch upstream:
commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi,

The mentioned commit causes other build failures with W=1 at least in
sound/usb/mixer_scarlett_gen2.c
sound/usb/mixer.c
sound/soc/codecs/hdac_hdmi.c
sound/hda/intel-sdw-acpi.c

Some of them are also false and we need to find a workaround, but
I think the scarlett case might be valid.

Regards,
Peter

 sound/core/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index d61bde1225f2..d8a13a76d241 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -279,7 +279,7 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 {
 	int err;
 #ifdef CONFIG_SND_DEBUG
-	char name[8];
+	char name[15];
 #endif
 
 	if (extra_size > 0)
-- 
2.42.0

