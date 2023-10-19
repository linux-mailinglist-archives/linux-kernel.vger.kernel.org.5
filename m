Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5962F7CF6FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345386AbjJSLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjJSLhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:37:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B812D;
        Thu, 19 Oct 2023 04:37:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08C3C433CA;
        Thu, 19 Oct 2023 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697715441;
        bh=XRLiFEfMwPbR8a7nAVapktcO0NcTy6NCdxqoQM3snxg=;
        h=From:To:Cc:Subject:Date:From;
        b=qmRuIlXIR74X5BKQOa/KowjNG5uJeJiJ6i+tre6pUhvGQ2DkBCeoBtdGWga2qZs5g
         fgCNo5+CbGFk4UbfgkX9QTHPEhTQbZ0m6paBxhyUk/X6bmT4VkRW21N0ArYVRGYI2l
         YJdnZpIEdAVVPsHkeEAIwHVNwABELZlIQB2DrWspIgqk6avSx0Wfs2p3ZXhP9+XB1H
         8R5Hr1WDlsNlYHi0j6q+ARCIkxkzrVDiDoOkORsfDbXbobEuXqmNOJNvAL4xQ8tlZA
         LROdrQSqlROmkbAgsVLw2jbvU2iqO1ufL5UVkWlRdjQlQGowOtDhJnf77IIS5UM6no
         Y/vZpgGaCRT7g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtRLA-0002Me-2u;
        Thu, 19 Oct 2023 13:37:24 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] wifi: ath12k: fix event locking
Date:   Thu, 19 Oct 2023 13:36:48 +0200
Message-ID: <20231019113650.9060-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As was reported here:

	https://lore.kernel.org/lkml/20231019104211.13769-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20231019112521.2071-1-johan+linaro@kernel.org/

RCU lockdep reported suspicious RCU usage in the ath11k temperature
event handling code and code review revealed a few more handlers with
similar problems.

Apparently these issues have also been reproduced in the ath12k driver. 

Note that these were found through inspection and that this series has
only been compile tested.

Johan


Johan Hovold (2):
  wifi: ath12k: fix dfs-radar and temperature event locking
  wifi: ath12k: fix htt mlo-offset event locking

 drivers/net/wireless/ath/ath12k/dp_rx.c | 7 +++++--
 drivers/net/wireless/ath/ath12k/wmi.c   | 8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.41.0

