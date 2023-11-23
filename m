Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E837F5BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjKWJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjKWJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:48:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC5D49
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:48:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BAC433C9;
        Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700732904;
        bh=hgdvnIPPccubzs/g8g1k94iDsPT4gPn3WhqGmyKIz/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=sX9JcuMXDY3YUOTcFYDBGux0YFcW90U71oN5fOTga/3Cr1pc9vi7HXbzDi6cPpJXn
         I1nBnofehwbZwffToBqtvjgBL2TPIsFdgLC5XUTTnih0YAXJdNcBEcQMUEQqo1gOGb
         o2+Q64yIEH5q9AiDBU4sb2tOpHFBHB7Yt2Jf6F2NEyl2Cn+1z3RP3iOP6lYFsinFlD
         JBF9FKPF6zP8RZ85rkMTgoVAicxkEyQ+olwuSpjP1N39COnMvxJAAucnryBKTWpRB+
         c2XxIJr1cCkd8we1AIv4QTjELF6i26ZyB3rCfbzj8OPbbrG2vT6HGampvAnjyAzsvC
         LpMS5+sAKX+Bw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r66K9-0005KO-1m;
        Thu, 23 Nov 2023 10:48:41 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-sound@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH stable-6.6 0/2] ASoC: codecs: wsa883x: fix pops and clicks
Date:   Thu, 23 Nov 2023 10:47:47 +0100
Message-ID: <20231123094749.20462-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a backport of commits

	0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")

which specifically fix a loud crackling noise when starting a stream on
the Lenovo ThinkPad X13s.

These backports should apply to any stable tree which already has commit
3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters cleared if the
DAI becomes inactive") backported (e.g. 6.6.2 and 6.5.12).

Note that the interaction of these commits resulted in a bad merge in
mainline which is fixed up here:

	https://lore.kernel.org/lkml/20231123091815.21933-1-johan+linaro@kernel.org/

Johan


Srinivas Kandagatla (2):
  ASoC: soc-dai: add flag to mute and unmute stream during trigger
  ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag

 include/sound/soc-dai.h    |  1 +
 sound/soc/codecs/wsa883x.c |  7 +------
 sound/soc/soc-dai.c        |  7 +++++++
 sound/soc/soc-pcm.c        | 12 ++++++++----
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.41.0

