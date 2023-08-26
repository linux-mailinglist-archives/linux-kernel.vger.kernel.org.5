Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45674789876
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHZRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHZRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:42:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4BA10A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:42:27 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ZxInqYKe17qfuZxInqGrPq; Sat, 26 Aug 2023 19:42:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693071746;
        bh=orB9jPwaecPFP/gpzbrOrsYdsANF2oVXr2ZGkrw1kio=;
        h=From:To:Cc:Subject:Date;
        b=NJHc2LnPPCsJoZ1Ueo2HFkPUULSxF3IPHkgQ5KDAT1lAynfkoQtFBKjg/+3bE9/Ca
         dWS4w5bcD09zfugdsG+HqBMefh6RCcoBDNPI+SBVZcV/jniTspdwtb/8lpxHOjaYig
         VIDQbCYsLFkmjOFc2p04DIB8GB53BRUsoIAQL17N47Ot7kTagsICH0I0VbMRTZZ66y
         8Xu+pxLOvrLCGULDZYu44PZStavJJ6ISh39DPqzCsVZOTyakYXKbvO2m64DtqC5YRq
         lSQkn+pOTv3CgOyMS+oQn6ohPAIA2EQL0kW6z90zc1ZCgZiZQSQxszIdqzo86qyGDp
         lK07r7YBaZ/UA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 19:42:26 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rrameshbabu@nvidia.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] HID: nvidia-shield: Fix the error handling path of shield_probe()
Date:   Sat, 26 Aug 2023 19:42:16 +0200
Message-Id: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie fixes some missing clean-up function calls in the error handling of
the probe.

Patch 1 and 2 fix some similar issues introduced in 2 different commits (hence 2
patches)

Patch 3 is a proposal to be more future proof.


*Note*: I'm not 100% sure that the order of the functions is the best one in
thunderstrike_destroy(), but it is the way it was.

My personal preference would be to undo things in reverse order they are
allocated, such as:
	led_classdev_unregister(&ts->led_dev);
	power_supply_unregister(ts->base.battery_dev.psy);
	if (ts->haptics_dev)
		input_unregister_device(ts->haptics_dev);
	ida_free(&thunderstrike_ida, ts->id);
This order was explicitly chnaged by 3ab196f88237, so, as I can't test the
changes on a real harware, I've left it as-is.

Christophe JAILLET (3):
  HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
    probe error handling path
  HID: nvidia-shield: Fix some missing function calls() in the probe
    error handling path
  HID: nvidia-shield: Introduce thunderstrike_destroy()

 drivers/hid/hid-nvidia-shield.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.34.1

