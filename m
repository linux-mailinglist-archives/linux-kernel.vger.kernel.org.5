Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12F7B6D9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbjJCP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjJCP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:58:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61FAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:58:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0063C433C9;
        Tue,  3 Oct 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696348710;
        bh=x4+F/ayjzolbI5Z0chsY8fDErsz5v4RnO2hda7AbeCk=;
        h=From:To:Cc:Subject:Date:From;
        b=IBYUGpgVFFgQoig5s2QW9LJjtYjJMW/WRBBlkYxbnXnMZ72pTEve2G2zYTs8NlzQC
         DMROuAtz1IOdXT2P7PH5FdCV2TyV7+4d+EQjSzOHLqYHZTd2v0m+wPGemgTuUu76+V
         DzsFOHEzOqMe9GBFpU+3L2CHK+MoMjTj72OQPe3km4ANp0YzfFJ++XYMhXZ8wWlyiM
         F3Oq2/pvgfp6fu79JHz3ushUpTm2PB7R06dNmYLJ0BqJJnrOzgNc5xV1XIWgYr7+B3
         pXaj4vaMuVdbf4wYl6hR62AurNdj0Cy3OqHOzg6idqQCl6mCJSnW5UvTMnvyXrwNW2
         UGGkHRPlmsqdA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhnF-00074l-2r;
        Tue, 03 Oct 2023 17:58:41 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/7] ASoC: codecs: wcd938x: fix probe and bind error handling
Date:   Tue,  3 Oct 2023 17:55:51 +0200
Message-ID: <20231003155558.27079-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
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

The wcd938x codec driver happily ignores error handling, something which
has bitten us in the past when we hit a probe deferral:

	https://lore.kernel.org/lkml/20230705123018.30903-1-johan+linaro@kernel.org/

Fix up the remaining probe and component bind paths that left resources
allocated and registered after errors to avoid similar future issues.

Johan


Johan Hovold (7):
  ASoC: codecs: wcd938x: drop bogus bind error handling
  ASoC: codecs: wcd938x: fix unbind tear down order
  ASoC: codecs: wcd938x: fix resource leaks on bind errors
  ASoC: codecs: wcd938x: fix regulator leaks on probe errors
  ASoC: codecs: wcd938x: fix runtime PM imbalance on remove
  ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
  ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors

 sound/soc/codecs/wcd938x-sdw.c | 27 +++++++++++-
 sound/soc/codecs/wcd938x.c     | 76 +++++++++++++++++++++++++---------
 2 files changed, 83 insertions(+), 20 deletions(-)

-- 
2.41.0

