Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22407757D89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjGRN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGRN3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48779189;
        Tue, 18 Jul 2023 06:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D036158F;
        Tue, 18 Jul 2023 13:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4FEC433C8;
        Tue, 18 Jul 2023 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686984;
        bh=UhYK2NmyGcq3Gi92tNijrKmmDY7odeQbLB9eFdMrpNo=;
        h=From:To:Cc:Subject:Date:From;
        b=UiEFcgKHWAxDBQ9vb6/SNTH3OtrOooOapbiRN0NzM6y2VQoY7Htqe6LiKFK3QzuJO
         ywWOXTLd0aQSAd65yX7ZK7Bzu8iLYDwzv0f5sxN4/UT5HgoAI8arRQhDXba29iXIOK
         Ny47setCHD89uUvideW7zx2VZZqznbpnsvGZPCSTf5ZdWYtYLOtYPR368xVqHY1l4s
         TGNYXD5Nc/jM5CbadVLagDe9WcULHsb5cUQNIiIM+OToIiHzup2Fvy/41+s8f9nfsa
         DvcaSPqh7uaZFT6nlezFN7Ga/thMQRAv9SXaq7p43H5sOFd0PPFjr1+sWz9sHt7gdB
         iKEmGLEcEEBBQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qLkm1-0005bw-22;
        Tue, 18 Jul 2023 15:29:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/8] clk: qcom: fix runtime PM bugs
Date:   Tue, 18 Jul 2023 15:28:54 +0200
Message-ID: <20230718132902.21430-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a number of runtime PM related bugs found through
inspection.

Johan


Johan Hovold (8):
  clk: qcom: camcc-sc7180: fix async resume during probe
  clk: qcom: dispcc-sm8450: fix runtime PM imbalance on probe errors
  clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors
  clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on probe errors
  clk: qcom: lpasscc-sc7280: fix missing resume during probe
  clk: qcom: q6sstop-qcs404: fix missing resume during probe
  clk: qcom: mss-sc7180: fix missing resume during probe
  clk: qcom: turingcc-qcs404: fix missing resume during probe

 drivers/clk/qcom/camcc-sc7180.c    |  2 +-
 drivers/clk/qcom/dispcc-sm8450.c   | 13 +++++++++++--
 drivers/clk/qcom/dispcc-sm8550.c   | 13 +++++++++++--
 drivers/clk/qcom/gcc-sc8280xp.c    | 14 +++++++++++---
 drivers/clk/qcom/lpasscc-sc7280.c  | 16 ++++++++++++----
 drivers/clk/qcom/mss-sc7180.c      | 13 ++++++++++++-
 drivers/clk/qcom/q6sstop-qcs404.c  | 15 +++++++++++++--
 drivers/clk/qcom/turingcc-qcs404.c | 13 ++++++++++++-
 8 files changed, 83 insertions(+), 16 deletions(-)

-- 
2.41.0

