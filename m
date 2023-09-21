Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545107AA5D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIUX6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIUX6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:58:17 -0400
Received: from out-215.mta0.migadu.com (out-215.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35FF4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:58:11 -0700 (PDT)
Message-ID: <e5022460-fc45-5571-1f5b-2b81f7811a7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695340689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUJHN3YfhHAwoXl+1sbrTgWZ/YrCi9D1KruOjj1djMM=;
        b=hz6nVQjKD0rPC1gxSGbf9AaBCRYE5ubk4LvtwRm0zjPsMz2vq/WYMTr5od3zFykk6d+1/6
        uzX2glTAi41cOAgZi4PWHKelE5jD+s8uUQrPiBdLtGF82daQfAXhVUs0MH8MRJCYgIrqr/
        JNLU2uUx1IJtzZ+RKW9lit3RmXVObtE=
Date:   Fri, 22 Sep 2023 00:58:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] ice: fix undefined references from DPLL code
 when !CONFIG_PTP_1588_CLOCK
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Michal Michalik <michal.michalik@intel.com>,
        Milena Olech <milena.olech@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-3-aleksander.lobakin@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230920180745.1607563-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 19:07, Alexander Lobakin wrote:
> DPLL code in ice unconditionally calls several PTP functions which are
> only built when CONFIG_PTP_1588_CLOCK is set. This throws a good bunch
> of link errors:
> 
> ERROR: modpost: "ice_cgu_get_pin_name"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_get_cgu_state"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> OR: modpost: "ice_is_cgu_present"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_get_cgu_rclk_pin_info"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_cgu_get_pin_type"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "ice_cgu_get_pin_freq_supp"
> [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> 
> ice_dpll_{,de}init() can be only called at runtime when the
> corresponding feature flags are set, which is not the case when PTP
> support is not compiled. However, the linker has no clue about this.
> Compile DPLL code only when CONFIG_PTP_1588_CLOCK is enabled and guard
> the mentioned init/deinit function calls, so that ice_dpll.o is only
> referred when it gets compiled.
> 
> Note that ideally ice_is_feature_supported() needs to check for
> compile-time flags first to be able to handle this without any
> additional call guards, and we may want to do that in the future.
> 

There is another fix under review [1], which came from Jacob.
It converts the code a bit more, and will create conflicts.
I would suggest to drop this patch until another series is fully
reviewed.

[1] 
https://lore.kernel.org/netdev/20230921000633.1238097-1-jacob.e.keller@intel.com/
