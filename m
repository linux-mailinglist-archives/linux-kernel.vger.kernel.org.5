Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE77CBD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjJQIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:33:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607493
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697531617; x=1729067617;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=MxayT2/XEWdFuARMII+EG5lLXg5UMsqpoavndXRXyTw=;
  b=ej5KjSZjUesu3bTjPY4/+5DPXPpo4jzcimyxTvp+yCgoYKuo4j08cY5r
   UXBM9ig35aR3fW0h46S9w7fB45A2NFPbOp2G4rqxFfiEeBbqELmyZpLIE
   ynvyiciWxvgEHs5kATshrA5oL5VXGCjXpLN5NfstL9NyctbdfJt76B8w8
   RTUcm9Yf9HhnbsV+TbwsUvKtH9wgbl6F2o42c50nv1umortG1o2+R5gfU
   SMin19YJCYTcakXKOhwpczSANR0AOeFU2gGO+BztojJnKMc1dty8J7Ruy
   7CyELSOsaUpQzKvYVeSOAiZjDS8Gu/mOld+CJ9CgMf7//1y3oewFwNT4y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384608513"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="384608513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826353237"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826353237"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2023 01:33:35 -0700
Message-ID: <af35a533-2126-4a61-a6cd-31ed1e615f2b@linux.intel.com>
Date:   Tue, 17 Oct 2023 11:33:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i3c: master: svc return actual transfer data len
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, alexandre.belloni@bootlin.com,
        miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
 <20231016154632.2851957-5-Frank.Li@nxp.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20231016154632.2851957-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10/16/23 18:46, Frank Li wrote:
> I3C allow devices early terminate data transfer. So set "actual" to
> indicate how much data get by i3c_priv_xfer.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/i3c/master/svc-i3c-master.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 3570b709cf60..444825aafa6f 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -138,6 +138,7 @@ struct svc_i3c_cmd {
>   	const void *out;
>   	unsigned int len;
>   	unsigned int actual_len;
> +	struct i3c_priv_xfer *xfer;
>   	bool continued;
>   };
>   
I'm thinking would it make sense to combine this and previous patch by 
removing the read_len/actual_len variable from this structure and use 
the added one (by the patch 2/5) from "struct i3c_priv_xfer" directly?
