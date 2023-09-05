Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB1792B32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbjIEQte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354035AbjIEJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:23:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966CE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:23:37 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3858Ps8D028086;
        Tue, 5 Sep 2023 04:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=A5TyNX6jAAZJVYx
        1al7IpQ/nzgp4zrymgxX3vCsoSPo=; b=mCULNmPqss2LMG2708SMYkk5yL64WzV
        NxHdskX3tsW/hlrV35bBslHn6qWM0M64w6BvsDhe0Lcka9JKNAqA8UryJw8IYRoe
        z+KkmX0Sq+yJFs8vktUhpOmTnL+2DhCoY3tuUr82A1IdYj+o+2x8XNZEB1lNymHh
        wgwkydse8QJkuEt/DR6ME6y9pQ8hY/LVR3Avfj43EfM+OZvo9svwyFLRopefRKiI
        a0Ar8AQ6Zd1/E/k0VCWvEASo4imNKdVv3XBnlmZHCWtE8MsL/2dVEvbHaZR3osC4
        xbHwJc6DgnkM+w8Uqg3kVnBxPPWX4zWyIFjZjidoejh15s/2hWREArQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhtrr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:23:23 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 10:23:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 5 Sep 2023 10:23:21 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8CC2215B9;
        Tue,  5 Sep 2023 09:23:21 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:23:21 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH 2/9] ASoC: cs35l41: Handle mdsync_up reg write errors
Message-ID: <20230905092321.GE103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-3-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902210621.1184693-3-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 1_U13ttigB6Vwz3pa-MygkYcswIclzem
X-Proofpoint-GUID: 1_U13ttigB6Vwz3pa-MygkYcswIclzem
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 12:06:14AM +0300, Cristian Ciocaltea wrote:
> The return code of regmap_multi_reg_write() call related to "MDSYNC up"
> sequence is shadowed by the subsequent regmap_read_poll_timeout()
> invocation, which will hit a timeout in case the write operation above
> fails.
> 
> Make sure cs35l41_global_enable() returns the correct error code instead
> of -ETIMEDOUT.
> 
> Additionally, to be able to distinguish between the timeouts of
> wait_for_completion_timeout() and regmap_read_poll_timeout(), print an
> error message for the former and return immediately.  This also avoids
> having to wait unnecessarily for the second time.
> 
> Fixes: f8264c759208 ("ALSA: cs35l41: Poll for Power Up/Down rather than waiting a fixed delay")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
