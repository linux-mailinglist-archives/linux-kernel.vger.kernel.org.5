Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0411C78162C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbjHSAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243325AbjHSAxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:53:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8851448D;
        Fri, 18 Aug 2023 17:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692406415; x=1723942415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpUo5Edi6QFUhdJVj1ej9UvxlhacliszgVQIhmTKSe0=;
  b=YRlNur6KXSGvypmwfJ2zXMS6iTLXB1NBHS8LTaohqmxkw44gfp5sUmJ6
   UKTwNlt+5C2EDUO5DipwpoGgJoEnJ93zVNbf/yxLdUnUmaG3Lajg6e1/J
   ft2luc0IjjoPz9Lt8MOB9DvQOa1RONLq4X2T0ixpynFjPIeAdAoNGw1pV
   Ude2AtVzn5c+GQRWWdX0HM6WWOtz832lMO0RV/J8X7vGzyX/rcTEqEA3r
   EwZ8GHEYNKs8aasMV51GpQQVODBvmjpEKxiiCcshC9mXe8hGDm6V5Vrgv
   zc7T18Nz9ml6e4X20ik51XxPPv7HcZ/S39fw+2e1sfqGGli9i46m2mWi8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="373209892"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="373209892"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 17:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770311176"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="770311176"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2023 17:53:29 -0700
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     fancer.lancer@gmail.com
Cc:     alexandre.torgue@foss.st.com, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, joabreu@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, peppe.cavallaro@st.com, robh+dt@kernel.org,
        rohan.g.thomas@intel.com
Subject: [PATCH net-next v4 2/2] net: stmmac: Tx coe sw fallback
Date:   Sat, 19 Aug 2023 08:53:26 +0800
Message-Id: <20230819005326.22204-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <trcp4f77dv2e36zpe53s7sjoyevgd5qtpv6m4a75ryalglqnev@trcsnsmvtijy>
References: <trcp4f77dv2e36zpe53s7sjoyevgd5qtpv6m4a75ryalglqnev@trcsnsmvtijy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:53:50PM +0800, Rohan G Thomas wrote:
>> +	u32 flags;
>
>This looks redundant. See my last comment.
>
>> +
>
>> +	u32 tx_q_with_coe;
>
>This one too. Can't you just use the
>plat_stmmacenet_data.tx_queues_with_coe field?
>
>> +	if (priv->plat->tx_coe &&
>> +	    priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use) {
>> +		priv->flags |= STMMAC_PRIV_FLG_TXQ_COE_LIMIT;
>> +		priv->tx_q_with_coe = priv->plat->tx_queues_with_coe;
>> +		dev_info(priv->device, "TX COE limited to %u tx queues\n",
>> +			 priv->tx_q_with_coe);
>> +	}
>
>What about:
>+	if (priv->plat->tx_coe && !priv->plat->tx_queues_with_coe)
>+		priv->plat->tx_queues_with_coe = priv->plat->tx_queues_to_use;
>+	else if (!priv->plat->tx_coe)
>+		priv->plat->tx_queues_with_coe = 0;
>+	else if (priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use)
>+		dev_info(priv->device, "TX COE is available for %u queues\n", priv->plat->tx_queues_with_coe);
>
>?
>
>-Serge(y)

Hi Serge,

Agreed.
Thanks for the suggestion. Will rework in next version.

BR,
Rohan

>> 
>>
