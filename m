Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0154679762E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjIGQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjIGQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:02:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1C59F3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:52:08 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3875p76G004490;
        Thu, 7 Sep 2023 03:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=s4QvFLjCdfbxhAG
        nuFXV1BMWi0jA62lbyy724T4ih1E=; b=qxm9g5NT1lV0RyQTZP45Xbd81weIPfD
        HKnQjq9fkyeKIHp/y0QE7TicQcvdoLTOrc5jSIHDAcOzmygYNQawuSysrhRekgn2
        B6nqWDb6gzQO8yGw+pQua8PxRZNPwaSB2xXLM0lYnWhWPOb+FPXlxI/YkKE9EHGY
        mjYnecqjTbJuLOvyOkrd4t8H6jj3BRY9+86FdTsqbU65FG+Qm4HAxYzqs9JABDUx
        H+D60gCiUV2jWrdwHjVY2Yv3thAyKao7bgtrz0vAfey+4U04JZMvFkkdBEras5Lp
        3j+w22JmLaMtGsEsI/rYCruaA4qNpSwuPXmrLE+GYNP6mNMB0soEJZw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex6b2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 03:37:09 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 7 Sep
 2023 09:37:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 7 Sep 2023 09:37:07 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 87ACF458;
        Thu,  7 Sep 2023 08:37:07 +0000 (UTC)
Date:   Thu, 7 Sep 2023 08:37:07 +0000
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
Subject: Re: [PATCH 9/9] ASoC: cs35l41: Use devm_pm_runtime_enable()
Message-ID: <20230907083707.GO103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-10-cristian.ciocaltea@collabora.com>
 <20230905094535.GK103419@ediswmail.ad.cirrus.com>
 <953eb242-4d52-4cdc-8f7d-71af003778c5@collabora.com>
 <20230906163725.GN103419@ediswmail.ad.cirrus.com>
 <de9bf872-16ca-4b4e-9543-87f463b985a0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de9bf872-16ca-4b4e-9543-87f463b985a0@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: Ar4ROd4euK5R8TVCYvRjiOa-S15YGxFV
X-Proofpoint-GUID: Ar4ROd4euK5R8TVCYvRjiOa-S15YGxFV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:55:28PM +0300, Cristian Ciocaltea wrote:
> On 9/6/23 19:37, Charles Keepax wrote:
> > On Tue, Sep 05, 2023 at 10:15:46PM +0300, Cristian Ciocaltea wrote:
> >> On 9/5/23 12:45, Charles Keepax wrote:
> >>> On Sun, Sep 03, 2023 at 12:06:21AM +0300, Cristian Ciocaltea wrote:
> Agree, let's keep it simple. I will revert the change and instead ensure
> a proper cleanup of pm_runtime_use_autosuspend(), according to the
> documentation:
> 
> "It's important to undo this with pm_runtime_dont_use_autosuspend() at
> driver exit time unless your driver initially enabled pm_runtime with
> devm_pm_runtime_enable() (which handles it for you)."
> 

Good spot was not aware of that, thank you.

Thanks,
Charles
