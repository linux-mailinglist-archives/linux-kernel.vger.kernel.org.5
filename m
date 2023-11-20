Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0223C7F0F84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjKTJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjKTJzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:55:36 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6730E94;
        Mon, 20 Nov 2023 01:55:32 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AK8GTrw015438;
        Mon, 20 Nov 2023 03:55:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=
        PODMain02222019; bh=SNC1Z9jI3APw89gGPSbS88cfIAYgH29p/XTHlJAW08M=; b=
        S6crIaUFkAQ5ivCRcq+808uBr7xvPjPMWVLaJjf2DTb09WLfSUIErN6lMr2i72ia
        SkB8yUQHkY46izjbWxQbFuwc15Utj8b4kj/CQ+fnAY3deX9kLXUbpSsd8Pm4FREW
        K1jRTi1rnJDm1TLjPw2ZkSGY8oG92E71OoR8ImBm/myzvREGGXZp1XxnwXyB0s5+
        2TT/zTaelat6vbNeKe5Rr2EoPnTDvtRdF6MNnZFix5HR8FFry/oAQaLVVYfil1MQ
        mxy4ZnCCSRkgITmHByk5F7BC++hpaRVuzos3EEk5TlFVJgb0Lu3L/0zIbFVkO5s/
        yVt9nfE8yjU0nm2gv3kbgQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3uetjp9njg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 03:55:24 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 20 Nov
 2023 09:55:22 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 20 Nov 2023 09:55:22 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D423515B9;
        Mon, 20 Nov 2023 09:55:22 +0000 (UTC)
Date:   Mon, 20 Nov 2023 09:55:22 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
Message-ID: <20231120095522.GH32655@ediswmail.ad.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
 <20231117141344.64320-7-mstrozek@opensource.cirrus.com>
 <ZVeWfefrEQJIx0YL@finisterre.sirena.org.uk>
 <153531080cd3d36fea86263d393ef885533f6e44.camel@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153531080cd3d36fea86263d393ef885533f6e44.camel@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: _zgPHYykADs4dUIfYkQQmip0MpvmDQSi
X-Proofpoint-ORIG-GUID: _zgPHYykADs4dUIfYkQQmip0MpvmDQSi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:43:25AM +0000, Maciej Strozek wrote:
> W dniu pią, 17.11.2023 o godzinie 16∶36 +0000, użytkownik Mark Brown
> napisał:
> > On Fri, Nov 17, 2023 at 02:13:43PM +0000, Maciej Strozek wrote:
> > > Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > > ---
> > >  sound/soc/codecs/cs43130.c | 56 +++++++++++++++++++++++++++++++---
> > > ----
> > >  sound/soc/codecs/cs43130.h |  1 +
> > >  2 files changed, 47 insertions(+), 10 deletions(-)
> > 
> > Why?  This isn't some obvious fix, you need to write a changelog
> > motivating open coding interrupt handling if there's some reason for
> > doing that.
> 
> This is to support systems without physical IRQ connection. The device
> only requires the IRQ for a couple of internal delays, this polling
> mechanism is a fallback when no IRQ is specified.
> 

Yeah pop that in the change log and resend the patch as a v2.

Thanks,
Charles
