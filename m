Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07827F1857
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjKTQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKTQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:16:51 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABBD10C;
        Mon, 20 Nov 2023 08:16:48 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AK6oXeG014560;
        Mon, 20 Nov 2023 10:16:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=
        PODMain02222019; bh=Ywj1kdPjKsuou2fy1TtXc2Xqs1GoaBvw35slxNV/7EU=; b=
        I0W+9Ho3GB8GYvDBtlhm2uf1mZEPslXeitaQMajmsf12ZhhLVOpVQUHGBrJupnJp
        Dz2oWe61n9xMvfXJgupn5XGhizv14uUkV6mXyz5GSJ/fg3NLIxmBi0V8UYS6Ychp
        R6iF3xeMArWUgFMJK76c49zRKWe80FJLl6igniopbKC6FbGNTscgcbQvUqEojx9o
        I60+yu+5fZwSc2ecVz1fA34acwQ0Rvs+fhuK0ozUTIODJVQl7RnFDkN0x1Sb+QhX
        7BvzroAn+AKFyRnnBA6VtcrptqcrG48m3MJ7pP2rN3TwHM1+A8ej7R+p0uSQlgZv
        hvJ//3d1Lo4LcB+zD8VGZA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj2a1e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:16:40 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 20 Nov
 2023 16:16:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 20 Nov 2023 16:16:38 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 31900357F;
        Mon, 20 Nov 2023 16:16:38 +0000 (UTC)
Date:   Mon, 20 Nov 2023 16:16:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Maciej Strozek <mstrozek@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-ID: <20231120161638.GJ32655@ediswmail.ad.cirrus.com>
References: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
 <7248897a-0b59-4cdc-9915-d3297f2d6efe@sirena.org.uk>
 <261e118d-529b-0ce0-5524-d24d767fa92f@opensource.cirrus.com>
 <c031657a-a1ec-44eb-8885-afee68d7523b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c031657a-a1ec-44eb-8885-afee68d7523b@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: o5eMkHLJNbnn67w0gTWh6TXQS7nIHgxj
X-Proofpoint-GUID: o5eMkHLJNbnn67w0gTWh6TXQS7nIHgxj
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:54:14PM +0000, Mark Brown wrote:
> On Mon, Nov 20, 2023 at 03:46:26PM +0000, Maciej Strozek wrote:
> > W dniu 20/11/2023 o 14:40, Mark Brown pisze:
> 
> > > > +		} else {
> > > > +			return 0;
> > > > +		}
> 
> > > Is it a bug to call this function without to_poll set to something
> > > known?  This will just silently ignore it which seems wrong and is
> > > inconsitent with the handling in the interrupt case which will wait for
> > > the the completion to be signalled and report a timeout on error.
> 
> > In interrupt case 0 means timeout (and calling function should expect 0 as
> > error/timeout), so the only inconsistency I see is in not waiting before
> > returning a timeout, but that would be needlessly wasting time?
> > Do you think adding a debug print or a comment would help here?
> 
> It seems like a clear code bug if this is ever called with an unknown
> completion, I'd expect a WARN_ON_ONCE() there.  The lack of a delay is
> potentially going to affect how any error handling works which doesn't
> feel ideal though the users look fine right now.

I guess perhaps another option might be to not stick so strictly
to the wait_for_completion_timeout API. This function could
return an -EINVAL here and a -ETIMEDOUT for a timeout then the
callers could be updated accordingly.

Thanks,
Charles
