Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B379E34D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjIMJPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbjIMJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:15:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742001BF2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694596404; x=1726132404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VG6V4ukHC529W2hH3FCZgm6FniJtv+CyYtQ7+HR3P5s=;
  b=L7CzgvtBqYUYZXQ/Ydt29RpAiq8dy4wYbLBNtn2ZsIbh5UuXV4FP0mR6
   PYSVcGk4/vl08yuNQRP+XWIzBXr9hEdwvaV13GfQgdR/CTpqKkgXcr2r+
   qjzP8JjXH716c1VtnvPMmcAv2kukPpRc9iHyUuGnbnDySMJaMQDCYAdf5
   aogQjCsUjWVeC1dNvqfN6Nw8nCZ5p/Iz93S5Yy6o24djnwV0Kw/efwQE8
   fsnOA7KKyThUSRmabZzPF6rdWfvRsj5lOnJypOx54NRCkq5YHLV69unR9
   VVGOl7xAfcBQLx7m1I4UbmMA5r3uT0RKxvV/8RJ1SeZmoIwdNF/5pbTiW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378519726"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="378519726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737420904"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="737420904"
Received: from mduman-mobl.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.48.209])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:13:20 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        perex@perex.cz, arnd@arndb.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
Subject: [PATCH] ASoC: hdac_hdmi: Remove temporary string use in create_fill_jack_kcontrols
Date:   Wed, 13 Sep 2023 12:13:25 +0300
Message-ID: <20230913091325.16877-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use temporary strings to construct the kcontrol names,
devm_kasprintf can be used to replace the snprintf + devm_kstrdup pairs.

This change will also fixes the following compiler warning/error (W=1):

sound/soc/codecs/hdac_hdmi.c: In function ‘hdac_hdmi_jack_port_init’:
sound/soc/codecs/hdac_hdmi.c:1793:63: error: ‘ Switch’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Werror=format-truncation=]
 1793 |                         snprintf(kc_name, sizeof(kc_name), "%s Switch", xname);
      |                                                               ^~~~~~~
In function ‘create_fill_jack_kcontrols’,
    inlined from ‘hdac_hdmi_jack_port_init’ at sound/soc/codecs/hdac_hdmi.c:1871:8:
sound/soc/codecs/hdac_hdmi.c:1793:25: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
 1793 |                         snprintf(kc_name, sizeof(kc_name), "%s Switch", xname);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The warnings got brought to light by a recent patch upstream:
commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 8b6b76029694..b9c5ffbfb5ba 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1771,7 +1771,6 @@ static int create_fill_jack_kcontrols(struct snd_soc_card *card,
 {
 	struct hdac_hdmi_pin *pin;
 	struct snd_kcontrol_new *kc;
-	char kc_name[NAME_SIZE], xname[NAME_SIZE];
 	char *name;
 	int i = 0, j;
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
@@ -1785,14 +1784,14 @@ static int create_fill_jack_kcontrols(struct snd_soc_card *card,
 
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
 		for (j = 0; j < pin->num_ports; j++) {
-			snprintf(xname, sizeof(xname), "hif%d-%d Jack",
-						pin->nid, pin->ports[j].id);
-			name = devm_kstrdup(component->dev, xname, GFP_KERNEL);
+			name = devm_kasprintf(component->dev, GFP_KERNEL,
+					      "hif%d-%d Jack",
+					      pin->nid, pin->ports[j].id);
 			if (!name)
 				return -ENOMEM;
-			snprintf(kc_name, sizeof(kc_name), "%s Switch", xname);
-			kc[i].name = devm_kstrdup(component->dev, kc_name,
-							GFP_KERNEL);
+
+			kc[i].name = devm_kasprintf(component->dev, GFP_KERNEL,
+						    "%s Switch", name);
 			if (!kc[i].name)
 				return -ENOMEM;
 
-- 
2.42.0

