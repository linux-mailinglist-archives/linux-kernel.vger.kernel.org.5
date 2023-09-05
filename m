Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04BF79289C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbjIEQXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354100AbjIEJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:37:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E61A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:37:46 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3858RFWp030223;
        Tue, 5 Sep 2023 04:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Nl4QMc496QpBt0c
        q5gJy1r26oYZLrCNIKMt/zibjNd8=; b=U8o7zn4YtXalQqmp0rajIdCGXhSShPo
        F3ck7vTn0PbodHF2htKMYr/oNo3q2GukBAyQw4G4vhcSppVsDzELTpDjbOqGSIrw
        57UGvwEUue56OFhFnlip6imF5On1DVtcBXpwC42QZBu98HSsjSd6b+WZ5Rl9PylL
        3Ox35owSn7dBSQHFUriIgBJaGio+mkRi3pq6UPe18vj8RB8M8LM10BE2dg9681Wp
        5S6yJWqP4ePMCssTTeftDe0fix6lXwQVWZfneRp7gQXiWiP+euwAH+bj8BpR9Rtt
        7j5jtgSsD9ItRVDKZ+8Mp9gLoxlBkA7t3Kk/hKgGavQrm1sBW08PjCg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhts3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:37:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 10:37:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 5 Sep 2023 10:37:26 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 163B115B9;
        Tue,  5 Sep 2023 09:37:26 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:37:26 +0000
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
Subject: Re: [PATCH 7/9] ASoC: cs35l41: Verify PM runtime resume errors in
 IRQ handler
Message-ID: <20230905093726.GI103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-8-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902210621.1184693-8-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: qXIMc21SVk7immCT0baunBGLQXl-grCt
X-Proofpoint-GUID: qXIMc21SVk7immCT0baunBGLQXl-grCt
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 12:06:19AM +0300, Cristian Ciocaltea wrote:
> The interrupt handler invokes pm_runtime_get_sync() without checking the
> returned error code.
> 
> Add a proper verification and switch to pm_runtime_resume_and_get(), to
> avoid the need to call pm_runtime_put_noidle() for decrementing the PM
> usage counter before returning from the error condition.
> 
> Fixes: f517ba4924ad ("ASoC: cs35l41: Add support for hibernate memory retention mode")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
