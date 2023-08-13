Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAE77AA12
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHMQaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjHMQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A68270C;
        Sun, 13 Aug 2023 09:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD76A63E4C;
        Sun, 13 Aug 2023 16:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E0C433C7;
        Sun, 13 Aug 2023 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691944211;
        bh=k/DBSLeuTDT5ffAyIQgS9LkNXlXka5DsrXBly3EUM0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFQxSkVPvVNMY5UGkTgEyjqDjqrB49JwReYXKnsxLTmIytnyOC5Ivrm5bumPDj79S
         MrikeE1aFQxDkFQe1kVJ/+07ZhzCDiOkBDfqo/61gIqGiubQiqUP58XpxzbhespKlm
         B1xHwCRETs+nH4YDTfs45b/adRiPbJNurMxwmYd3xEg8wSHna1y9Yc692MgvWNvXHu
         bLYi0ygSqCg1UvXQniVEKnWwb7NAouzpXrvq2a3mXgj9u/bHhtTlJCgSWC2n9EbWTi
         V0h56gbG8V2PxbpIPCwTqh54dOr6O82h487xNMQYbyVbUyWKZFi9ZkMRV+uLJt7OjD
         +MULKkHfQW09g==
Date:   Sun, 13 Aug 2023 18:30:06 +0200
From:   Simon Horman <horms@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net] wifi: iwlwifi: mvm: add dependency for PTP clock
Message-ID: <ZNkFDufqMRYoIAGV@vergenet.net>
References: <20230812052947.22913-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812052947.22913-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Richard Cochran

On Fri, Aug 11, 2023 at 10:29:47PM -0700, Randy Dunlap wrote:
> When the code to use the PTP HW clock was added, it didn't update
> the Kconfig entry for the PTP dependency, leading to build errors,
> so update the Kconfig entry to depend on PTP_1588_CLOCK_OPTIONAL.
> 
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_init':
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294: undefined reference to `ptp_clock_register'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294:(.text+0xce8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_register'
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301: undefined reference to `ptp_clock_index'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301:(.text+0xd18): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_remove':
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315: undefined reference to `ptp_clock_index'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315:(.text+0xe80): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319: undefined reference to `ptp_clock_unregister'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319:(.text+0xeac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_unregister'
> 
> Fixes: 1595ecce1cf3 ("wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202308110447.4QSJHmFH-lkp@intel.com/
> Cc: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: Gregory Greenman <gregory.greenman@intel.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

> ---
>  drivers/net/wireless/intel/iwlwifi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -66,6 +66,7 @@ config IWLMVM
>  	tristate "Intel Wireless WiFi MVM Firmware support"
>  	select WANT_DEV_COREDUMP
>  	depends on MAC80211
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
>  	  This is the driver that supports the MVM firmware. The list
>  	  of the devices that use this firmware is available here:
> 
