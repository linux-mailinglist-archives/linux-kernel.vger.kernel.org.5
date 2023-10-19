Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198347CFDEB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbjJSPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbjJSPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:32:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEF130;
        Thu, 19 Oct 2023 08:32:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71960C433CA;
        Thu, 19 Oct 2023 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729576;
        bh=6AUvT9lmCnlzH7BLowOH+X3uuIrFpt3l7ALwRPy7k48=;
        h=From:To:Cc:Subject:Date:From;
        b=eSSR0/rRNY8AZ6icxglMEVkboZR646ZlZMHxFOfc7LUuqbxuZXnuQ2m/uouOp/RBR
         QxGBBEa91unkbPNTEApm4rpxBDC7RrTRXkaGniCCFWxnpIts0wAYFTRR08iBMCxOqd
         xT3j7+RHWKQP+L+0olZsY+oHPd8tzkg0DJRMxOGssDivldEvqrRn30jYvqLIlXAkuT
         Fv2lJ26ZCT4xV9apTy4FZQtJfdKEaDDBmA1BVJUW22H5ntf04SW5LVr9ETR5az90DS
         cgGE+P8/B6z3MdOZlOZQKu4YhHnS6SNsivEx/fpL73ADd4LFIa6fOsNtNGBb4M1RgQ
         R3AwqSLXf332w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtV19-0006t8-1D;
        Thu, 19 Oct 2023 17:33:00 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/2] wifi: ath11k: fix event locking
Date:   Thu, 19 Oct 2023 17:31:13 +0200
Message-ID: <20231019153115.26401-1-johan+linaro@kernel.org>
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

RCU lockdep reported suspicious RCU usage when accessing the temperature
sensor. Inspection revealed that the DFS radar event code was also
missing the required RCU read-side critical section marking.

Johan


Changes in v2
 - add the missing rcu_read_unlock() to an
   ath11k_wmi_pdev_temperature_event() error path as noticed by Jeff


Johan Hovold (2):
  wifi: ath11k: fix temperature event locking
  wifi: ath11k: fix dfs radar event locking

 drivers/net/wireless/ath/ath11k/wmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.41.0

