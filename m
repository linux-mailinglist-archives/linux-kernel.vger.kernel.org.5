Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41975812F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjGRPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjGRPmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:42:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8C1726
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:42:09 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36I7rQwY013833;
        Tue, 18 Jul 2023 10:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=MSvzRAFOJ4AYGEX
        dZyueqxYtwFswn6tCeR4OGrX8bg8=; b=FBpjJsgDvcHQCHyy+0BtuiVFWYAYAMO
        00MESlVkxiBF967WvRYYhlK1/5typpz0fa6C++JSq+Ck8QjE3B53xnGsS/pv12RK
        4ovKe6WOpUqjpLGwQ5R/2mxivTofgN4TtBtj2ZpmdXwg8hjnyp9Ea+1f36q4lkOK
        rAH3eWXiavtg8ZpZOHImBt7DQDxiRlLite5S0glPTnuYJ/bdhh1maEuDv8b5uszE
        /C7qOCGHqBejibP8di1k0RQedEN0oAYk2DQ6R2XnSpSmuh1zKVpmQjyNNuRBtsFX
        Zw8SNXOeuSUOhPZljtDc6AcctsSAYOva4lmdDuxjTofdoVTQ5TPApMg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gumam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 10:42:02 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 16:42:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 18 Jul 2023 16:42:00 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C0B5E3563;
        Tue, 18 Jul 2023 15:42:00 +0000 (UTC)
Date:   Tue, 18 Jul 2023 15:42:00 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] mfd: wm5110: Update to use maple tree register
 cache
Message-ID: <20230718154200.GG103419@ediswmail.ad.cirrus.com>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
 <20230713-mfd-cirrus-maple-v1-8-16dacae402a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230713-mfd-cirrus-maple-v1-8-16dacae402a8@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: RCxF2_bUe9ZMoxy4XvdZIdYDMermGsfS
X-Proofpoint-GUID: RCxF2_bUe9ZMoxy4XvdZIdYDMermGsfS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:49:26AM +0100, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache. In
> v6.5 it has also acquired the ability to generate multi-register writes in
> sync operations, bringing performance up to parity with the rbtree cache
> there.
> 
> Update the wm5110 driver to use the more modern data structure.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/mfd/wm5110-tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
> index 65b9b1d6daec..eba324875afd 100644
> --- a/drivers/mfd/wm5110-tables.c
> +++ b/drivers/mfd/wm5110-tables.c
> @@ -3218,7 +3218,7 @@ const struct regmap_config wm5110_i2c_regmap = {
>  	.readable_reg = wm5110_readable_register,
>  	.volatile_reg = wm5110_volatile_register,
>  
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  	.reg_defaults = wm5110_reg_default,
>  	.num_reg_defaults = ARRAY_SIZE(wm5110_reg_default),
>  };
> 
> -- 
> 2.39.2
> 

This one appears to cause me some issues, seems to get the IRQs
into a weird state when doing compressed stream stuff. The
issue seems to also require commit bfa0b38c1483 ("regmap:
maple: Implement block sync for the maple tree cache") to be
present. So it definitely seems to relate to the cache sync,
but not sure if it is something todo with the device itself,
or the maple tree stuff yet.

Thanks,
Charles
