Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519CC787E34
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjHYDCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjHYDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9317C10F;
        Thu, 24 Aug 2023 20:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2964061229;
        Fri, 25 Aug 2023 03:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B2DC433C7;
        Fri, 25 Aug 2023 03:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692932543;
        bh=HW5dSZhX9VZiRlRSRJ7BXfW7fZFYK1O4sOa9OoGG01w=;
        h=Date:From:To:Cc:Subject:From;
        b=Laa3jipZpRB7Xvuhy4QMYH04BQex5B6UDBjxrInGnE8S4AZks7bpf9aXUfO5OA4GV
         d2pSJQtTkwwn1nPJJ1KNgj8bv8c25CoII1Z+SyT9/ZRZj9IzPZYG0MVgRYR3EDkNv8
         Sq5WtL3fwLIxcfKS9U5Pju8kkrBzyqPt/K1q6khyo0lU6kseqeTqlHxn+1D4l7jBE7
         myIzheh/wPw7hkb9VvidhU7DKEucM95fKcBfEsEWGwWX74MHH+25X3RilygNFGyZAp
         gXTnZPrSEi0ifdMLbmWni1DozHvJqhyzI8dLtisjTvqsNSt5TgWaRCm26gsTCGLEHv
         bcYkDwUR2iuzw==
Date:   Thu, 24 Aug 2023 21:03:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/3] wifi: mwifiex: Fix tlv_buf_left calculation and
 replace one-element array
Message-ID: <cover.1692931954.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This small series is aimed at fixing a bug in the tlv_buf_left
calculation, doing a flexible-array transformation, and adding
a couple of sanity checks.

Thanks

Changes in v2:
 - Fix format specifier in patch 3/3: %ld -> %zu
 - Update warning messages to explicitly mention that TLV size is
   greater than tlv_buf_len in patch 3/3.

v1:
 - Link: https://lore.kernel.org/linux-hardening/cover.1692829410.git.gustavoars@kernel.org/

Gustavo A. R. Silva (3):
  wifi: mwifiex: Fix tlv_buf_left calculation
  wifi: mwifiex: Replace one-element array with flexible-array member in
    struct mwifiex_ie_types_rxba_sync
  wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 22 ++++++++++++++++---
 drivers/net/wireless/marvell/mwifiex/fw.h     |  2 +-
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.34.1

