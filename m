Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44B77B6D55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbjJCPlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjJCPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:41:23 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19B95;
        Tue,  3 Oct 2023 08:41:20 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 393Fc9sj015864;
        Tue, 3 Oct 2023 10:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=UshK4TaSVNwezbB
        N5bZqdstEY08K/OpsJKNbQZ06nDM=; b=lTw3NXXiu9vCFDQC8FUVJfBGl0U7o9O
        EXXjBYMvqt9vwafgJNDzRni6TQ8+Ito7iK6rZpG4I5OA1mdfT7G8TrPPXm57Uiuo
        MS3chEgxyaIHGhjWOPbPY3FM5JSFa/i2nle4cfPz3b9HnsRZzrGrfcrO6jgyvJ4C
        8eiifCQk9nbQVHdDAXkAtQd5P0C5px6hV833qqlfzEbBb6Ud7ao9QkSn1PyRqSu8
        vFzDXW/1Itjq2K3L8CvUEBsaFwM0H2h0dhF5BTx75t41OxZp+o1BC1uyGlu3aH0J
        eFlel6o99zgIOND5/mDebJ8NEDcYvpe8VbGKbMSXI2wYkHBka5Bvvmw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3teg3k45p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 10:41:08 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 3 Oct
 2023 16:41:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 3 Oct 2023 16:41:06 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 758973563;
        Tue,  3 Oct 2023 15:41:06 +0000 (UTC)
Date:   Tue, 3 Oct 2023 15:41:06 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 21/36] pinctrl: cirrus: use new pinctrl GPIO helpers
Message-ID: <20231003154106.GO103419@ediswmail.ad.cirrus.com>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-22-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231003145114.21637-22-brgl@bgdev.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: qEOvuBdeYuub8KOOHydplmKS4-sTIHHr
X-Proofpoint-ORIG-GUID: qEOvuBdeYuub8KOOHydplmKS4-sTIHHr
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:50:59PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
