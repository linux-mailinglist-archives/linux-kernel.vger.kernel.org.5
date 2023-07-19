Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3D7594D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGSMOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGSMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:14:08 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1841B5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:14:05 -0700 (PDT)
Message-ID: <2ed288d0-c8fe-1856-dbe9-74f4f7c075ba@linux.intel.com>
Date:   Wed, 19 Jul 2023 14:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH] ASoC: SOF: Intel: Remove deferred probe for SOF
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alsa-devel <alsa-devel@alsa-project.org>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Matthew Auld <matthew.auld@intel.com>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
 <20230718084522.116952-7-maarten.lankhorst@linux.intel.com>
 <alpine.DEB.2.22.394.2307181922160.3532114@eliteleevi.tm.intel.com>
 <874jm0modf.wl-tiwai@suse.de>
 <66d22637-069f-5262-2249-6041ef9d4614@linux.intel.com>
 <875y6g5feo.wl-tiwai@suse.de>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <875y6g5feo.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-07-19 13:06, Takashi Iwai wrote:
> On Wed, 19 Jul 2023 11:48:06 +0200,
> Maarten Lankhorst wrote:
>>
>>      The 60 seconds timeout is a thing "better than complete disablement",
>>      so it's not ideal, either.  Maybe we can add something like the
>>      following:
>>      
>>      - Check when the deferred probe takes too long, and warn it
>>      - Provide some runtime option to disable the component binding, so
>>        that user can work around it if needed
>>      
>> A module option to snd_hdac_i915_init would probably be the least of all evils
>> here.
> 
> Yes, probably it's the easiest option and sufficient.
> 
> 
> thanks,
> 
> Takashi
Hey,

Patch below, can be applied immediately iresspective of the other patches.

---->8----------

Selecting CONFIG_DRM selects CONFIG_VIDEO_NOMODESET, which exports 
video_firmware_drivers_only(). This can be used as a first approximation
on whether i915 will be available. It's safe to use as this is only 
built when CONFIG_SND_HDA_I915 is selected by CONFIG_I915.

It's not completely fool proof, as you can boot with "nomodeset 
i915.modeset=1" to make i915 load regardless, or use
"i915.force_probe=!*" to never load i915, but the common case of booting
with nomodeset to disable all GPU drivers this will work as intended.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 1637dc6e630a6..90bcf84f7b2ce 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -11,6 +11,8 @@
  #include <sound/hda_i915.h>
  #include <sound/hda_register.h>

+#include <video/nomodeset.h>
+
  #define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
  				((pci)->device == 0x0c0c) || \
  				((pci)->device == 0x0d0c) || \
@@ -122,6 +124,9 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
  {
  	struct pci_dev *display_dev = NULL;

+	if (video_firmware_drivers_only())
+		return false;
+
  	for_each_pci_dev(display_dev) {
  		if (display_dev->vendor == PCI_VENDOR_ID_INTEL &&
  		    (display_dev->class >> 16) == PCI_BASE_CLASS_DISPLAY &&
