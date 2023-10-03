Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A327B6DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjJCP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbjJCP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:58:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D39B0;
        Tue,  3 Oct 2023 08:58:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AAEC433CB;
        Tue,  3 Oct 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696348710;
        bh=2DhAHBo+YbBdItb8HnA01InHv+0f3MquKuWsrN91pvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0yACS9I5mo04/f0p1lkuf9QE0h/FBp1VdvpIubCClTCduooBHTGsehbanfK6yFvr
         3d8ujJR0Gt/HlsJsczhxWFnef/uOGAfKSriVeQMl5hfqfrk6NOaLe+O5EaPctUWU1z
         +QSkqUWkWnPx+BvrCmKjWSkvqhDzubLJzNnqEFTPwpFpZg3UX6XdnBtW4No9ZVrsBG
         zMZKn/1N8amwOwczJjtASlirvoX3vZQl4towl66BWWGHiQUHRFrKy3C3auyGuRlF79
         mrk4YBN1ph1ItMh67p8ApqzWEsINR+BzKnV6LA8a9IpbAnCrnYR6A1Je6+1/Su5Ws5
         RKSGUTLwkQGzQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhnG-00074z-13;
        Tue, 03 Oct 2023 17:58:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 6/7] ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
Date:   Tue,  3 Oct 2023 17:55:57 +0200
Message-ID: <20231003155558.27079-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003155558.27079-1-johan+linaro@kernel.org>
References: <20231003155558.27079-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to deregister the component when the driver is being unbound
and before the underlying device-managed resources are freed.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 6951120057e5..1baea04480e2 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1281,6 +1281,15 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 	return component_add(dev, &wcd938x_sdw_component_ops);
 }
 
+static int wcd9380_remove(struct sdw_slave *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	component_del(dev, &wcd938x_sdw_component_ops);
+
+	return 0;
+}
+
 static const struct sdw_device_id wcd9380_slave_id[] = {
 	SDW_SLAVE_ENTRY(0x0217, 0x10d, 0),
 	{},
@@ -1320,6 +1329,7 @@ static const struct dev_pm_ops wcd938x_sdw_pm_ops = {
 
 static struct sdw_driver wcd9380_codec_driver = {
 	.probe	= wcd9380_probe,
+	.remove	= wcd9380_remove,
 	.ops = &wcd9380_slave_ops,
 	.id_table = wcd9380_slave_id,
 	.driver = {
-- 
2.41.0

