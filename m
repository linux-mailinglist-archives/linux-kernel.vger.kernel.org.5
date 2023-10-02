Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FF7B4DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjJBIxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjJBIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:53:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4391
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:53:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3928XgBH008714;
        Mon, 2 Oct 2023 03:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=SKecTmmCY0zRv4s
        gmvybVFeEowaV6C1NNcnaM0R4+BY=; b=YQi7CQiY4o0Z8vQPRJ9A88gLXQ+9vFB
        AAIzA6xwd8bgRqeCh1W/aX9Z7EFgyK+O6cBKBBELDjs5q9a8+iFseD/dYnlYhhuR
        QjW7h/RiMfuSqGqphy2tNQW4xr25zpgakuPlPIJcCDYyF5JsuRdqkqnBo1n+VxjZ
        VrQC0+rxS3WXix92Ojh9qDwRlNPDAZ1rtwUDlk7S2aniS/+PmnfzyX22sX6XlRA7
        DjnU30uItkrzK0WleIWqzUpF4yyBkEP68Go5V3uF0Nzo60HR1wQ1ChBqHpk5tidr
        pIvnPIzriyhsTnhWIICp8K7qPwGxGvnTSm/VacJrmToL8R3m355KiNw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3teg3k27gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 03:52:53 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 2 Oct
 2023 09:52:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 2 Oct 2023 09:52:52 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1E8D13563;
        Mon,  2 Oct 2023 08:52:52 +0000 (UTC)
Date:   Mon, 2 Oct 2023 08:52:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <rdunlap@infradead.org>
Subject: Re: [PATCH v2] soundwire: bus: Make IRQ handling conditionally built
Message-ID: <20231002085252.GM103419@ediswmail.ad.cirrus.com>
References: <20230920160401.854052-1-ckeepax@opensource.cirrus.com>
 <169528907320.97239.11506619845267367958.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169528907320.97239.11506619845267367958.b4-ty@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: pNfrAjEL_qFwzhWjodnqfKOPqFWYHzS8
X-Proofpoint-ORIG-GUID: pNfrAjEL_qFwzhWjodnqfKOPqFWYHzS8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:37:53AM +0200, Vinod Koul wrote:
> 
> On Wed, 20 Sep 2023 17:04:01 +0100, Charles Keepax wrote:
> > SoundWire has provisions for a simple callback for the IRQ handling so
> > has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
> > handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
> > moving the IRQ handling into its own file and only add it to the build
> > when IRQ_DOMAIN is included in the kernel.
> > 
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] soundwire: bus: Make IRQ handling conditionally built
>       commit: 3b6c4a11bf2b810f772f5c2c1ef6eef3fc268246
> 

Did something go wrong here? I still don't see a commit with
that SHA in your tree.

Thanks,
Charles
