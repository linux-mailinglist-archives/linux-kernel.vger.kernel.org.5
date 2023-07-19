Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF08759077
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGSIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGSIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:40:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C57A4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:40:25 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J7qqFK015759;
        Wed, 19 Jul 2023 03:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Fz133NM+PH6ytpE
        wMN9/wPaTNZjQNN9eSPsk7vdO6Og=; b=j743dRJddq07tC6lGxvTm8ZyNBnJquc
        v3Y5fFRpIHtQVPYERy24uj5rk5Y3KNil9eFK/Oyd1TsTq21qVaofeyNQK9rv5iC2
        ///fHaYynxdsN7JnUE7cnyqPgtTqlfw6kqQ0RGaUjXuctYUnaOmPb6w3PY6tVz57
        CoeLH/XaM7ugBzRKzlW8kX2vrMhxM76M/IuIj96DJwyL1xgVOtO2e7MtBjJ3eJtQ
        ecram45oEp+jnXpV4OgDhZxv42OfBDkCj2XKcmhikYbBatV+JSw0ukcSWWGI2es8
        QBkE1IuVI8zDinGEyRz4llsHz9JP4quIZgwfeuLRJfmgPAr1pDg1Mmw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62v8n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 03:40:12 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 09:40:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 19 Jul 2023 09:40:09 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E3DD115A2;
        Wed, 19 Jul 2023 08:40:09 +0000 (UTC)
Date:   Wed, 19 Jul 2023 08:40:09 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regcache: Push async I/O request down into the rbtree
 cache
Message-ID: <20230719084009.GI103419@ediswmail.ad.cirrus.com>
References: <20230719-regcache-async-rbtree-v1-1-b03d30cf1daf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719-regcache-async-rbtree-v1-1-b03d30cf1daf@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: reECnw2JRdG1r7WkXjSa3_ogKRQVJAFT
X-Proofpoint-ORIG-GUID: reECnw2JRdG1r7WkXjSa3_ogKRQVJAFT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:30:40AM +0100, Mark Brown wrote:
> Currently the regcache core unconditionally enables async I/O for all cache
> types, causing problems for the maple tree cache which dynamically allocates
> the buffers used to write registers to the device since async requires the
> buffers to be kept around until the I/O has been completed.
> 
> This use of async I/O is mainly for the rbtree cache which stores data in
> a format directly usable for regmap_raw_write(), though there is a special
> case for single register writes which would also have allowed it to be used
> with the flat cache. It is a bit of a landmine for other caches since it
> implicitly converts sync operations to async, and with modern hardware it
> is not clear that async I/O is actually a performance win as shown by the
> performance work David Jander did with SPI. In multi core systems the cost
> of managing concurrency ends up swamping the performance benefit and almost
> all modern systems are multi core.
> 
> Address this by pushing the enablement of async I/O down into the rbtree
> cache where it is actively used, avoiding surprises for other cache
> implementations.
> 
> Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Fixes: bfa0b38c1483 ("regmap: maple: Implement block sync for the maple tree cache")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
