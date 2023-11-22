Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC47F4BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbjKVPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344643AbjKVPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:51:21 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9810D1;
        Wed, 22 Nov 2023 07:51:16 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AMCI4cB009416;
        Wed, 22 Nov 2023 09:51:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        PODMain02222019; bh=0EJUDXEEx1uaj+Vpy9q/HshvrhOAKakRmd0jf8CvOjs=; b=
        myf08uUsuUbI3bRCvtMMq6/JMRVhnQqU0cndDe2xLHAtw1hcuHUGEnH99/q8Yea9
        Hb8tWJtfXpqFuQocbtaG03+OUm3T2Fh6bmhAFYvBDfdTgYcIsb38xTUPClaNNGOG
        yEGOu1t7/9NoI724SBhP1ajLkQxwQ/4R8P3LF7cboKvDQ5O5E26CXrq6K1eWJycm
        Hm+yPRBw+dqfDFIo6SsC20tFuofbYa6qALbUkVCme/hGc3V/18MdmgEkvdFtX0N2
        NTL4orfdJsRwTdc9kVPcj7cixB14AmGI6sNnFJhyLCd5W2N8ELxSI5O1Y1NR7kHz
        HF8ygyQuAJzM/R2qyJR06Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj2cp4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:51:08 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 22 Nov
 2023 15:51:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 22 Nov 2023 15:51:06 +0000
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.251.123])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B4D3715B6;
        Wed, 22 Nov 2023 15:51:06 +0000 (UTC)
Message-ID: <399d6e4fcbaa590bcd92869e7d02402a9226cad2.camel@opensource.cirrus.com>
Subject: Re: [PATCH v4] ASoC: cs43130: Allow driver to work without IRQ
 connection
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Nov 2023 15:51:06 +0000
In-Reply-To: <20231122154238.GM32655@ediswmail.ad.cirrus.com>
References: <20231122143459.26861-1-mstrozek@opensource.cirrus.com>
         <20231122154238.GM32655@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LxaKH6Si1qg48sy4WPOpafk-lSIpc2JU
X-Proofpoint-GUID: LxaKH6Si1qg48sy4WPOpafk-lSIpc2JU
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu śro, 22.11.2023 o godzinie 15∶42 +0000, użytkownik Charles
Keepax napisał:
> On Wed, Nov 22, 2023 at 02:34:59PM +0000, Maciej Strozek wrote:
> > Add a polling mechanism that will keep the driver operational even
> > in
> > absence of physical IRQ connection. If IRQ line is detected, the
> > driver
> > will continue working as usual, in case of missing IRQ line it will
> > fallback to the polling mechanism introduced in this change.
> > This will support users which choose not to connect an IRQ line as
> > it
> > is not critical to part's operation.
> > 
> > Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > ---
> 
> Apologies Maciej, should have spotted this when I had a look this
> morning but I have just spotted one more thing, we should actually
> remove the polling for the hpload detect. The hpload detect can
> actually only be triggered by the IRQ handler anyway so that code
> will never run, and there would be much more work required to get
> the jack detect working without the IRQ.
> 
> Thanks,
> Charles

No problem, will send V5 with the hpload detect deleted tomorrow

