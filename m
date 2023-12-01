Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56C8013C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379551AbjLATzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379538AbjLATzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:55:51 -0500
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 11:55:53 PST
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F510C2;
        Fri,  1 Dec 2023 11:55:53 -0800 (PST)
Received: from [192.168.1.22] (193-81-119-54.adsl.highway.telekom.at [193.81.119.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.horus.com (Postfix) with ESMTPSA id 7E988640C9;
        Fri,  1 Dec 2023 20:49:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1701460199;
        bh=o3DhyGVOK7Y0f6isvi8hjBFAaVlSguWB91NNo7aZ/8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6s+0/0aguZhFlHT/zSmQ5I3E+HXBuKk+sEaoEJMa7lxvCE76b2v/GWBJkB3BmoBt
         5XKHn/WoY+JbCrZc6BZ2omxBfWSIW03rQHCsv6prSsO0VbscBZ4fll++NktLPW7oAi
         fojf9TRbE+HTpHq2dQC3HJ136orjFSkzcf5XGSHc=
Received: by camel3.lan (Postfix, from userid 1000)
        id E974B54020B; Fri,  1 Dec 2023 20:49:58 +0100 (CET)
Date:   Fri, 1 Dec 2023 20:49:58 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org,
        jslaby@suse.cz
Subject: Re: Linux 6.6.3
Message-ID: <ZWo45hiK-n8W_yWJ@camel3.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        stable@vger.kernel.org, jslaby@suse.cz
References: <2023112811-ecosphere-defender-a75a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112811-ecosphere-defender-a75a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:27:10PM +0000, Greg Kroah-Hartman wrote:
> Mark Brown (1):
>       regmap: Ensure range selector registers are updated after cache sync

This commit caused a regression, accessing a pcm512x based soundcard now
fails with EINVAL and dmesg shows sync cache and pm_runtime_get errors:

# speaker-test -D hw:CARD=PCM5122,DEV=0 -c 2 -t sine
speaker-test 1.1.8

Playback device is hw:CARD=PCM5122,DEV=0
Stream parameters are 48000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Playback open error: -22,Invalid argument
# dmesg | grep pcm512x
[  228.794676] pcm512x 1-004c: Failed to sync cache: -22
[  228.794740] pcm512x 1-004c: ASoC: error at snd_soc_pcm_component_pm_runtime_get on pcm512x.1-004c: -22

We initially noticed that on the downstream RPi kernels 6.6.3 and
6.1.64 https://github.com/raspberrypi/linux/issues/5763 and
I now reproduced that with vanilla 6.6.3 running on a RPi2
(multi_v7_defconfig plus CONFIG_SND_SOC_PCM512x_I2C and a pcm5122
soundcard with simple-audio-card driver).

Reverting the commit fixes the issue.

I'm not familiar with the regcache code but it looks a bit like the
return value from the regcache_read check is leaking out - not
assigning the value to ret seems to resolve the issue, too
(no idea though if that would be the correct fix):

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 92592f944a3df..ac63a73ccdaaa 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -410,8 +410,7 @@ int regcache_sync(struct regmap *map)
 			rb_entry(node, struct regmap_range_node, node);
 
 		/* If there's nothing in the cache there's nothing to sync */
-		ret = regcache_read(map, this->selector_reg, &i);
-		if (ret != 0)
+		if (regcache_read(map, this->selector_reg, &i) != 0)
 			continue;
 
 		ret = _regmap_write(map, this->selector_reg, i);

so long,

Hias
