Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3737377BFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjHNSOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjHNSOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:14:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10DCE65;
        Mon, 14 Aug 2023 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692036849; x=1723572849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPxt2QQcAtgeUsWpZ4wBDio4lSa6brn/TkPHu4rCISE=;
  b=ZJjb+1rj6GhiA9R1D1rFPr/wyB+L5aT15NiSRHhe1W+KatvcSWwNYtYr
   olqPMercPuI8i1J3eoJdrxNDsRxDp6SX53gdTJVG3mukyKYZCNQEYbrXa
   fSylbE9FQHrm5b3FVeK73sG6QMj1N0N3f1IQ2ZnX2jeV3v17Gb4CphZf0
   vbxv5s1K4bRTFepxQcySXrEycxtY9wLFPHfp0D1ZhkLTdoghqGy1XLM0+
   WlV8JGJi4FIExp5DxvZpe4qHGK36T83jdXUDv5z/WhHkgX0KL1D2+T1dG
   vp+UadwD5/b6c54vge/fxiCNTgRJyZ5ZxcKiKm5WAH6vhcFRZHSrkjgb2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438439543"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438439543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 11:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877060648"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2023 11:14:02 -0700
From:   rohan.g.thomas@intel.com
To:     jose.abreu@synopsys.com
Cc:     alexandre.torgue@foss.st.com, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, peppe.cavallaro@st.com, robh+dt@kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: RE: [PATCH net-next v3 2/2] net: stmmac: Tx coe sw fallback
Date:   Tue, 15 Aug 2023 02:13:54 +0800
Message-Id: <20230814181354.8603-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <DM4PR12MB50889D6CC25880757AB8F146D317A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <DM4PR12MB50889D6CC25880757AB8F146D317A@DM4PR12MB5088.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohan G Thomas <rohan.g.thomas@intel.com>

From: Rohan G Thomas <rohan.g.thomas@intel.com>
Date: Mon, Aug 14, 2023 at 15:06:37
> 
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> > @@ -219,6 +219,8 @@ struct stmmac_priv {
> >  	int hwts_tx_en;
> >  	bool tx_path_in_lpi_mode;
> >  	bool tso;
> > +	bool tx_q_coe_lmt;
> 
> Please use a flag here instead of "tx_q_coe_lmt". This is the preferrable
> method now.
> 
> Thanks,
> Jose

Thanks Jose for the feedback. If I read that correctly, your
suggestion is to change " tx_q_coe_lmt" to something more readable,
like "has_txcoe_limit". Please correct me if I understand it wrongly.

BR,
Rohan

> 
> > +	u32 tx_q_with_coe;
> >  	int sph;
> >  	int sph_cap;
> >  	u32 sarc_type;

