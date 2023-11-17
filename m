Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0D7EFBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjKQW5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQW5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:57:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E26194;
        Fri, 17 Nov 2023 14:57:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7899BFF805;
        Fri, 17 Nov 2023 22:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700261825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9KIy9DRblNLZwax2uMtws630q6MOKJ/pwNRzyK1MdoI=;
        b=Fq8Lowh/99UyB7YM1ExHUkOftLjtP7TTmQ++3NOmeVWQ5Uh+/BrC6mIfIsO4W6yRimcXOR
        LtqqitqzyO4pHkgBk7VjX6NQzLxAB1MYWN9f75PjpYmmrWvFQCtun/HVYmL0pvg+3Fm9pu
        DJc2hAM7W0kt/7qRIIC1Z7PTRpuoVcQA6lkdIswLWIqmNhzL+Pe+qFfjXmQWXKstEmHRcq
        59aX4sHbZqcmml3Vs1bQXuZb2tVzc+9sf2vkaNzMvY6JAx8tIB2qUK3KFpR7fLdp2cnooC
        WEQjeMzsOBAeKy3P2tyjDfdQpzZlGKT8PMGM1pyefXyL6/2usozYW0kHAAdvcw==
Date:   Fri, 17 Nov 2023 23:57:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        Raul Rangel <rrangel@google.com>
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
Message-ID: <2023111722570552652970@mail.local>
References: <20231106162310.85711-1-mario.limonciello@amd.com>
 <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
 <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com>
 <20231113223819fb469198@mail.local>
 <ZVM4nFaDTwrKMr8K@duo.ucw.cz>
 <2023111422283827b2a3f2@mail.local>
 <5029e355-6fe8-4d48-9bc3-20256adfbdb7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5029e355-6fe8-4d48-9bc3-20256adfbdb7@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2023 18:15:02-0600, Mario Limonciello wrote:
> On 11/14/2023 16:28, Alexandre Belloni wrote:
> > On 14/11/2023 10:06:36+0100, Pavel Machek wrote:
> > > On Mon 2023-11-13 23:38:19, Alexandre Belloni wrote:
> > > > On 13/11/2023 15:36:28-0600, Mario Limonciello wrote:
> > > > > Now that the merge window is over, can this be picked up?
> > > > > 
> > > > 
> > > > I'd be happy to invoice AMD so they get a quick response time.
> > > 
> > > That is a really bad joke.
> > 
> > Why would it be a joke?
> > 
> >  From what I get this is an issue since 2021, I don't get how this is so
> > urgent that I get a ping less than 24h after the end of the merge
> > window.
> 
> It's possibly longer; but I don't have a large enough sample to say that
> it's safe that far back.

Would this help this one:
https://bugzilla.kernel.org/show_bug.cgi?id=68331

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
