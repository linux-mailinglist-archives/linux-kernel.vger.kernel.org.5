Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E7774934
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHHTuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjHHTtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:49:53 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86C51D24
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:56:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3784vnZ4015760
        for <linux-kernel@vger.kernel.org>; Tue, 8 Aug 2023 07:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=3GQkqeX48AmxR+N
        mG0BNLounrL7/4Kjkcy8q1SMrdxE=; b=BCVFiVMwpYHt+IUcd55fiDjl2c9pmkO
        o+6LCV9IYneXx2IRtSLO4ys4QneUQR5HRDM/jmV5NxN3EsCGV0WVJD1pKWpjqt6f
        Ht67Y7LUWWvQf3WmiLfj50u6PFAMhddkRASuCT6kiw7I1e8MWmch+pCqYWiVXa+j
        KgZQkXIdSHbHNlSsRr+pRinidyThIzvHnsBB9JRh2PlGRRpgsdPEpG/s37oGd0Xe
        ur244LfuTT7IOUrtsIVhOicASmla6F7xSIEhC0XEHJ/q16C2VFRYYOp9WJvPNoxU
        q2DqyPsR/knN23cbVnloG1zp+VoUe25713uYXJNPyMg9lrDLHVXIwYQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vt8v1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 07:51:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 13:51:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 13:51:24 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F12FD15B4;
        Tue,  8 Aug 2023 12:51:23 +0000 (UTC)
Date:   Tue, 8 Aug 2023 12:51:23 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
CC:     Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: cs_dsp: Fix new control name check
Message-ID: <20230808125123.GU103419@ediswmail.ad.cirrus.com>
References: <20230804165212.236822-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804165212.236822-1-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: k_twSSqVpc27yKxkRQVFb9o-4Qano0Lb
X-Proofpoint-ORIG-GUID: k_twSSqVpc27yKxkRQVFb9o-4Qano0Lb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:52:12AM -0500, Vlad Karpovich wrote:
> Before adding a new FW control, its name is checked against
> existing controls list. But the string length in strncmp used
> to compare controls names is taken from the list, so if beginnings
> of the controls are matching,  then the new control is not created.
> For example, if CAL_R control already exists, CAL_R_SELECTED
> is not created.
> The fix is to compare string lengths as well.
> 
> Fixes: 6477960755fb ("ASoC: wm_adsp: Move check for control existence")
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
