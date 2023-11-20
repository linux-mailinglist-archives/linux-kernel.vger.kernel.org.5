Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20217F0F46
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKTJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:43:45 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6272D94;
        Mon, 20 Nov 2023 01:43:42 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AK6U480003527;
        Mon, 20 Nov 2023 03:43:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        PODMain02222019; bh=vQ2IyIVC8216MO+P/8nCTcn6PLpw2lKV/uP0jokEWtI=; b=
        VBjMI8HwRLIsrP6WwoQguHOkThfazIJH16oqinw0aoeCAysbWjuQgh9cLDnWt2Yl
        rBOdyyHZeaqkIY8JT/RR/jiTkwV8NN6g/+NHfv9M7U++kqK8K5mSnNmom2LiELFS
        ErRyCpzbX+Qh2CsmB2d5vMrqGXjr0n+8WxdOrOqXU6i28jdV2yhlVQVutFiWFcUP
        M8F0GbVE+WaZK4n2kEOAwzchSdLKAtdNDSR0SJCkR8XKskbmpeXBXCZVoY8L7f6j
        /m+hIM+ntu8VKvdm6f/cr+toW8OKnqcVoVOunLd9nE9kVT5Se75+s34fV3isQ0XX
        yI3U5mgUkxlWbTIFScWMzg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3uetjp9n93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 03:43:29 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 20 Nov
 2023 09:43:25 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 20 Nov 2023 09:43:25 +0000
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.251.123])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 81E9215B9;
        Mon, 20 Nov 2023 09:43:25 +0000 (UTC)
Message-ID: <153531080cd3d36fea86263d393ef885533f6e44.camel@opensource.cirrus.com>
Subject: Re: [PATCH 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Nov 2023 09:43:25 +0000
In-Reply-To: <ZVeWfefrEQJIx0YL@finisterre.sirena.org.uk>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
         <20231117141344.64320-7-mstrozek@opensource.cirrus.com>
         <ZVeWfefrEQJIx0YL@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4ZFKJ0HZR7aS3bXlufFbMGcIRNV3gggY
X-Proofpoint-ORIG-GUID: 4ZFKJ0HZR7aS3bXlufFbMGcIRNV3gggY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu pią, 17.11.2023 o godzinie 16∶36 +0000, użytkownik Mark Brown
napisał:
> On Fri, Nov 17, 2023 at 02:13:43PM +0000, Maciej Strozek wrote:
> > Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > ---
> >  sound/soc/codecs/cs43130.c | 56 +++++++++++++++++++++++++++++++---
> > ----
> >  sound/soc/codecs/cs43130.h |  1 +
> >  2 files changed, 47 insertions(+), 10 deletions(-)
> 
> Why?  This isn't some obvious fix, you need to write a changelog
> motivating open coding interrupt handling if there's some reason for
> doing that.

This is to support systems without physical IRQ connection. The device
only requires the IRQ for a couple of internal delays, this polling
mechanism is a fallback when no IRQ is specified.

