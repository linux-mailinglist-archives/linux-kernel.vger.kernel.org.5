Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4679E3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjIMJjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIMJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:39:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD7F196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694597972; x=1726133972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AFPkf81JiqACjKxsag5lm5MCBmk/FWJjDDbZ5Lp7fwc=;
  b=mlH6KTN/cYf5NBNhGGap+a3pFTWxY5nuhCVMIq+HxZidF0TuYb0sNFyl
   GnOb0Q8LHtUFa1KzeyU42yPZ2sfhfqYx0kw/iOB2apr/dO2NogkvCQL8B
   hYEMxIQNQwZ0QyHS/8+IFtidkPtpk2e7MY8XTUrh/kYZD+IpCbBPDGKXF
   jABKMb5bGaLCtcv9Qt7nWwFLBbVpTdsusikkBNrkDjcBcnkwDeRQuhd3L
   88p7zJOPJ6UOTUKtth0+uTAgvlIJuqXuxt6UIdcTY/k1d833wqJlN6HUa
   KO8sR/Fj0UGql2ZyfxvqxeaiTN3k5crZNMVOXcTu+L6LlAWdawcS6oKjO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464982301"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464982301"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867720893"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="867720893"
Received: from mduman-mobl.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.48.209])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:39:29 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     tiwai@suse.com, perex@perex.cz, arnd@arndb.de
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, maciej.szmigiero@oracle.com
Subject: [PATCH] ALSA: usb-audio: mixer: Remove temporary string use in parse_clock_source_unit
Date:   Wed, 13 Sep 2023 12:39:33 +0300
Message-ID: <20230913093933.24564-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kctl->id.name can be directly passed to snd_usb_copy_string_desc() and
if the string has been fetched the suffix can be appended with the
append_ctl_name() call.
The temporary name string becomes redundant and can be removed.

This change will also fixes the following compiler warning/error (W=1):

sound/usb/mixer.c: In function ‘parse_audio_unit’:
sound/usb/mixer.c:1972:29: error: ‘ Validity’ directive output may be truncated writing 9 bytes into a region of size between 1 and 44 [-Werror=format-truncation=]
 1972 |                          "%s Validity", name);
      |                             ^~~~~~~~~
In function ‘parse_clock_source_unit’,
    inlined from ‘parse_audio_unit’ at sound/usb/mixer.c:2892:10:
sound/usb/mixer.c:1971:17: note: ‘snprintf’ output between 10 and 53 bytes into a destination of size 44
 1971 |                 snprintf(kctl->id.name, sizeof(kctl->id.name),
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1972 |                          "%s Validity", name);
      |                          ~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The warnings got brought to light by a recent patch upstream:
commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/usb/mixer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9105ec623120..985b1aea9cdc 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1929,7 +1929,6 @@ static int parse_clock_source_unit(struct mixer_build *state, int unitid,
 	struct uac_clock_source_descriptor *hdr = _ftr;
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
-	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int ret;
 
 	if (state->mixer->protocol != UAC_VERSION_2)
@@ -1966,10 +1965,9 @@ static int parse_clock_source_unit(struct mixer_build *state, int unitid,
 
 	kctl->private_free = snd_usb_mixer_elem_free;
 	ret = snd_usb_copy_string_desc(state->chip, hdr->iClockSource,
-				       name, sizeof(name));
+				       kctl->id.name, sizeof(kctl->id.name));
 	if (ret > 0)
-		snprintf(kctl->id.name, sizeof(kctl->id.name),
-			 "%s Validity", name);
+		append_ctl_name(kctl, " Validity");
 	else
 		snprintf(kctl->id.name, sizeof(kctl->id.name),
 			 "Clock Source %d Validity", hdr->bClockID);
-- 
2.42.0

