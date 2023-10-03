Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9410E7B6D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjJCP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjJCP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:29:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC6A6;
        Tue,  3 Oct 2023 08:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65F8C433C9;
        Tue,  3 Oct 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696346975;
        bh=jdmFvf1XK1R60wkH3BVlLhkwT3ffaOVJ5+VG7EPRU/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=nScQhqAfb8exmyHDZCRDCAh4Kc/h1bJD52yBDwzQXgJWiB8YlfAdFUItN66FcVrPM
         oQmJKlGXZv+qvaR4wNyN7MVhT9NfMM4UIGJJKGFwLlNRUo0tIR7XliTkGibNdFmfA6
         PbvQ6o/EXt3jOvAc8KzhSK3lcm9FKWa/QVLrgihJxXIOCCM4UFEE0BmzoGEhwODbRF
         yuWLivvlVdcEVUocYA3/ZtrcjMVDRmfQ1qjM/9bb/g/GzgIPGbLpuD8RMGAuyzzlzE
         f++Ao8rzPBns1iRvalw1O57dpwegOvy7HuZ6svo3HDB5fxPoDkir82nqm49bxiQwGg
         ApDflH2yoEQ9A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhLF-0003uJ-1z;
        Tue, 03 Oct 2023 17:29:45 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/5] mfd: qcom-spmi-pmic: fix revid implementation
Date:   Tue,  3 Oct 2023 17:29:22 +0200
Message-ID: <20231003152927.15000-1-johan+linaro@kernel.org>
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

The Qualcomm SPMI PMIC revid implementation is broken in multiple ways
that can lead to resource leaks and crashes. This series reworks the
implementation so that can be used safely.

Included is also a rename of the SPMI device lookup helper which can
hopefully help prevent similar leaks from being reintroduced.

Johan


Johan Hovold (5):
  mfd: qcom-spmi-pmic: fix reference leaks in revid helper
  mfd: qcom-spmi-pmic: fix revid implementation
  mfd: qcom-spmi-pmic: switch to EXPORT_SYMBOL_GPL()
  spmi: document spmi_device_from_of() refcounting
  spmi: rename spmi device lookup helper

 drivers/mfd/qcom-spmi-pmic.c | 103 +++++++++++++++++++++++++----------
 drivers/spmi/spmi.c          |   9 ++-
 include/linux/spmi.h         |   2 +-
 3 files changed, 80 insertions(+), 34 deletions(-)

-- 
2.41.0

