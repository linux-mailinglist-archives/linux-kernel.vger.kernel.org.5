Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F537F5C11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjKWKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjKWKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:16:42 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A047FD62;
        Thu, 23 Nov 2023 02:16:45 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AN6l0Ll006611;
        Thu, 23 Nov 2023 04:16:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Ufd5pw5Di+iMf5j
        O8XXprPxu8mrSlk4TCzLJhhSyc9k=; b=YAmd5uyRTBZLydJZNSh7a5Sz4FmNMfq
        a9lhs8rTI9ohwLrPwsrN5tR1TJ7SUhqIaBTqO1Vot7ky8p06JBhkMqFXScO/9j70
        cCBnw3+YznIisa2PcWFa/dZJXEjXiGoMfEntmpDOIxBoQ1FNzPt1XFxHZx1h6fBe
        uKkjRD4oSy71z1XXP9yqYyebQ86YrRssBvLT4kCxVJEKLQvDBjBMLKUkLCyBrX4y
        /04WT46WtR25uR8j8PmYWUYpyTgvuS0JRSDPwzCvr7gozxC/c01TF7J1LthbC051
        0G3YEssrNNuj3lSNAdSp2+PZmVx6ApcZy30+OxbvngFOThHK3wBuEPA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3uetjpdkgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 04:16:38 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 23 Nov
 2023 10:16:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Thu, 23 Nov 2023 10:16:36 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D1DB915B4;
        Thu, 23 Nov 2023 10:16:36 +0000 (UTC)
Date:   Thu, 23 Nov 2023 10:16:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-ID: <20231123101636.GN32655@ediswmail.ad.cirrus.com>
References: <20231123090658.10418-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231123090658.10418-1-mstrozek@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: hxzEozEIxy2CRk1PkWzNY4DNHDyME87-
X-Proofpoint-ORIG-GUID: hxzEozEIxy2CRk1PkWzNY4DNHDyME87-
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 09:06:58AM +0000, Maciej Strozek wrote:
> Add a polling mechanism that will keep the driver operational even in
> absence of physical IRQ connection. If IRQ line is detected, the driver
> will continue working as usual, in case of missing IRQ line it will
> fallback to the polling mechanism introduced in this change.
> This will support users which choose not to connect an IRQ line as it
> is not critical to part's operation.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
