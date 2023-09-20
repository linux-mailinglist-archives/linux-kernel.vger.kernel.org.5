Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4337A765F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjITIwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjITIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:52:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43B94
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:52:01 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38K7AkKY028950;
        Wed, 20 Sep 2023 03:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=6q5eu8R+bJ9vSdd
        eGnuymqFgSWOOmC7K7ROAa3mOVbQ=; b=d4DgQU++j2N5E380+rJE4xnU2ocsKHy
        IOa1XBCqFrFBqL85C24a41dGDdYBoI3aQSG9ZUpi96wGU2sATUhamOMPCEgQScEk
        TG7crnWkfkcf3u2JyzsrMKvTCwnsk6ty7u//1qr7LzBao11STDC1nuq7OkNOc2WJ
        qF2nrXvmS2bsr1udbJcUISAS7jn6/OkKUdGy8kxzDkzzbD8OMQswAPUC0i59WEy0
        X6hnRM/uq9krWIdBvIXs2bp3Onf4Hjz3T6S26IqyYr6DpK5euUtN4IVSbvzDBPec
        tPq9P754YKu4wmrtAKzEJFaCL6IEBxG6+iS1S4vqkce/ei4zVF/5n8w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58shv5g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 03:51:35 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 20 Sep
 2023 09:51:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 20 Sep 2023 09:51:33 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7AE0B11AA;
        Wed, 20 Sep 2023 08:51:33 +0000 (UTC)
Date:   Wed, 20 Sep 2023 08:51:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <rdunlap@infradead.org>
Subject: Re: [PATCH] soundwire: bus: Make IRQ handling conditionally built
Message-ID: <20230920085133.GE103419@ediswmail.ad.cirrus.com>
References: <20230918161026.472405-1-ckeepax@opensource.cirrus.com>
 <ZQqZqalGdqy86qdD@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQqZqalGdqy86qdD@matsya>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 0UdEfjuFUU1YZIucE2H-iVpmM5U_Zznq
X-Proofpoint-ORIG-GUID: 0UdEfjuFUU1YZIucE2H-iVpmM5U_Zznq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:05:13AM +0200, Vinod Koul wrote:
> On 18-09-23, 17:10, Charles Keepax wrote:
> > SoundWire has provisions for a simple callback for the IRQ handling so
> > has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
> > handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
> > moving the IRQ handling into its own file and only add it to the build
> > when IRQ_DOMAIN is included in the kernel.
> > 
> > Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/soundwire/Makefile   |  4 +++
> >  drivers/soundwire/bus.c      | 31 +++----------------
> >  drivers/soundwire/bus_type.c | 11 +++----
> >  drivers/soundwire/irq.c      | 59 ++++++++++++++++++++++++++++++++++++
> >  drivers/soundwire/irq.h      | 43 ++++++++++++++++++++++++++
> >  5 files changed, 115 insertions(+), 33 deletions(-)
> >  create mode 100644 drivers/soundwire/irq.c
> >  create mode 100644 drivers/soundwire/irq.h
> > 
> > diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> > index c3d3ab3262d3a..657f5888a77b0 100644
> > --- a/drivers/soundwire/Makefile
> > +++ b/drivers/soundwire/Makefile
> > @@ -15,6 +15,10 @@ ifdef CONFIG_DEBUG_FS
> >  soundwire-bus-y += debugfs.o
> >  endif
> >  
> > +ifdef CONFIG_IRQ_DOMAIN
> > +soundwire-bus-y += irq.o
> > +endif
> 
> Any reason why we cant use depends for this?
> 

No reason we can't, but my thinking was really that SoundWire doesn't
really have a dependency on IRQ_DOMAIN, as you can use the original
callback mechanism. It seemed a shame to force it as a dependency,
when the whole subsystem can function happily without it.

That said, I am happy to switch to a simple dependency if you prefer?
It would certainly be a much simpler change.

Thanks,
Charles
