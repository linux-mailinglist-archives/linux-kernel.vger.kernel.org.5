Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540A67CF582
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjJSKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:43:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2311F;
        Thu, 19 Oct 2023 03:43:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AD0C433C7;
        Thu, 19 Oct 2023 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697712189;
        bh=iUSdV9CFZmw4yRgGQyhrpABX6aSvA+ch603XWDzFF6E=;
        h=From:To:Cc:Subject:Date:From;
        b=PB9JH2lKw92emWDbT8O4k989xfioIzTWSkvZC36EY8GmomzMrdlUwFj4um5PleG2z
         hznwRuYuSvJ8T8+EIGqgVZtWx/AT2wJNhU/UfsRdFhuglbl1cxgoxKWSPmU6/k5Lko
         6dTGH7Cn3kG8FsN1q9y5vSYfugN/ExifmxhFdGzrT4caXP3KXxixJz73kvD4Ni4OqO
         29pbGcHEbRlBWiYkodZAbWHqSS6PJmFheaac1qMXj4DLI1HBV7SFkv/VlOkw6vY2ri
         RmjMnDd7yN3zZTbcCL0ZOBK4eZ6cs0vCUS451hl7RqIFEvGv9L14kL+XG/MiNFAOWO
         9CYL1/56G+zPA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtQUh-0003ak-2v;
        Thu, 19 Oct 2023 12:43:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] wifi: ath11k: fix event locking
Date:   Thu, 19 Oct 2023 12:42:09 +0200
Message-ID: <20231019104211.13769-1-johan+linaro@kernel.org>
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

RCU lockdep reported suspicious RCU usage when accessing the temperature
sensor. Inspection revealed that the DFS radar event code was also
missing the required RCU read-side critical section marking.

Johan


Johan Hovold (2):
  wifi: ath11k: fix temperature event locking
  wifi: ath11k: fix dfs radar event locking

 drivers/net/wireless/ath/ath11k/wmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.41.0

