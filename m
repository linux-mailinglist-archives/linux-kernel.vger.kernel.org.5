Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE7779D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjHLF3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjHLF3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:29:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB22728;
        Fri, 11 Aug 2023 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=g5NFUKgbQYz1dATIngsvfO0U1dhl0IZLO4aTbVVSTIg=; b=jO9TgWeryajGwbsedVXMLlZz+2
        9FGP9xqBmaMHODdzaU+0NIgdaRHh1ILlPo3YN20+6Je2QcDozgyIAgxmG0UW1bW5B7VnvYFFhrt6R
        GT3nTiZPmphmLhluO1CNJPNCfocsWk4obOsXW58QOka2dGi+89DWrOmk7zwjIZqeteUu+hX9wE7ky
        LnJYdN1/xF/E3rD7AwRW/BMz6MTi7jiTiwz8+M43+DMJuaAb7b1LoDu/YtL6CF31z0CuV9dWgXl+7
        aaScFOVLgsCOfLZEaFKxDOtyrRvzHmwQ+tkVdLNMPVFAizdWZCB0VGL/luH71TwAhwUJCdZoNnbVs
        QUzhlSpQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUhCA-00Chm0-2O;
        Sat, 12 Aug 2023 05:29:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH net] wifi: iwlwifi: mvm: add dependency for PTP clock
Date:   Fri, 11 Aug 2023 22:29:47 -0700
Message-ID: <20230812052947.22913-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the code to use the PTP HW clock was added, it didn't update
the Kconfig entry for the PTP dependency, leading to build errors,
so update the Kconfig entry to depend on PTP_1588_CLOCK_OPTIONAL.

aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_init':
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294: undefined reference to `ptp_clock_register'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294:(.text+0xce8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_register'
aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301: undefined reference to `ptp_clock_index'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301:(.text+0xd18): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_remove':
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315: undefined reference to `ptp_clock_index'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315:(.text+0xe80): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319: undefined reference to `ptp_clock_unregister'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319:(.text+0xeac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_unregister'

Fixes: 1595ecce1cf3 ("wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202308110447.4QSJHmFH-lkp@intel.com/
Cc: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/wireless/intel/iwlwifi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -66,6 +66,7 @@ config IWLMVM
 	tristate "Intel Wireless WiFi MVM Firmware support"
 	select WANT_DEV_COREDUMP
 	depends on MAC80211
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  This is the driver that supports the MVM firmware. The list
 	  of the devices that use this firmware is available here:
