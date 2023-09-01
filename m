Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98778FA36
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbjIAIud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjIAIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:50:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230BF10D3;
        Fri,  1 Sep 2023 01:50:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3814hqbh004037;
        Fri, 1 Sep 2023 03:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=dfrKDxDDZZ2VDjG
        lcPEe3RlSfsXnC0lxELdtB+CyKEY=; b=KYh5W0PwkRvIKS8Lc1SRMnX0SCN/kH3
        AUPZbOt6L9Kb9jT6oqOO7428GsNq0xBaBiw1e+vIZYrCV+C6uSbXM4fz+V/2B/nT
        KbtoqevfDThA2kB5gB/V3xAiaag9ojzDZpNr3Da9ALIELWW7Y/3FYrcEpga+RWkS
        FpVwsGKcH83GaFDD6FqbT3pDkvuP4PL+ysuPI0rdmUhotpcWWy1vTth1ooUBqB47
        prPRohw14J3gNE5L4R1YrkBxSeM1fPqwUTbVtyDKtT3oO2waSvy+4mCF0/WtoZsG
        88YaWn0BgBzT/vOxSM7ooGoLCBPcfKiiz9q16Nns5k9E7bu8a3kqaUA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyg4mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 03:50:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 1 Sep
 2023 09:50:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 1 Sep 2023 09:50:10 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE29EB06;
        Fri,  1 Sep 2023 08:50:10 +0000 (UTC)
Date:   Fri, 1 Sep 2023 08:50:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] ASoC: cs35l45: Analog PCM Volume and Amplifier
 Mode controls
Message-ID: <20230901085010.GA103419@ediswmail.ad.cirrus.com>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
 <20230831162042.471801-2-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831162042.471801-2-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: V64ASNJaKUtF6pKuRxGirmonRv3-nXiw
X-Proofpoint-GUID: V64ASNJaKUtF6pKuRxGirmonRv3-nXiw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:20:40AM -0500, Vlad Karpovich wrote:
> Adds "Analog PCM Volume" control with supported values
> 0 = 10dB,1 = 13dB,2 = 16dB and 3 = 19dB.
> The amplifier can operate either in Speaker Mode or Receiver Mode
> as configured by the user. Speaker Mode has four gain options
> to support maximum amplifier output amplitude for loud
> speaker application. Receiver Mode has further optimized
> noise performance while maintaining sufficient output to support
> phone receiver application. While configured in Receiver Mode,
> the analog PCM Volume control is disabled and
> the analog gain is fixed to 1dB.
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
