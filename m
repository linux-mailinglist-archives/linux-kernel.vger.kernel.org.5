Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9FC75DD8D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGVQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751910FA;
        Sat, 22 Jul 2023 09:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79CD860B8B;
        Sat, 22 Jul 2023 16:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC52C433C8;
        Sat, 22 Jul 2023 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690045147;
        bh=Ij/rcsp5XlAxMerhVwPsIgVA3kkMS01caPTwvxw8uGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Odo2jweh+cUBE0mbhrXwKnFNCjy3c5laBUNaawbmRe/fOxoaGoXTrNTse7XnCmddB
         Eatr7NAcPkXii/qd8Si1FFx+cNzdjTYYfbMDJKskbzOqar3KgOm3hRbfj8FmQsTCtL
         RRciAVIBqnMz9+1I6RifmFlbuw9/gwIqm2mcY8blmwbEbs9CNZbzKw1Uul2uMl0DU9
         7PaLy2kmjX/K00aOjhlsRBJD5iwbx93ny+6pu/Zn8HKCL2lwGKGTMZRWq1dEODbGU/
         uvLPLdeQTF8Dn9PNxrTg29fOYYWNqHP5Zxu7qnN/AVwIxS0z4/Udt0nFSvSaZGPgg6
         ku3OI5qa+vQzQ==
Date:   Sat, 22 Jul 2023 17:59:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        George Stark <gnstark@sberdevices.ru>, <lars@metafoo.de>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 0/3] iio: adc: meson: tune init sequence
Message-ID: <20230722175901.16f47142@jic23-huawei>
In-Reply-To: <20230718104100.00007c0c@Huawei.com>
References: <20230715110654.6035-1-gnstark@sberdevices.ru>
        <20230716171134.43d05c45@jic23-huawei>
        <a172c764-1eef-835f-f237-8f78b4c6e877@sberdevices.ru>
        <ZLURZWPkmP6aKDOZ@smile.fi.intel.com>
        <20230718104100.00007c0c@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 10:41:00 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 17 Jul 2023 13:01:09 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Jul 17, 2023 at 12:41:29PM +0300, George Stark wrote:  
> > > On 7/16/23 19:11, Jonathan Cameron wrote:    
> > > > On Sat, 15 Jul 2023 14:05:57 +0300
> > > > George Stark <gnstark@sberdevices.ru> wrote:    
> > 
> > ...
> >   
> > > > These look fine to me, but I'd like them to sit on list a little while
> > > > on off chance anyone else has feedback on them.    
> > > 
> > > I understand. I'd resend the patches in a week or more if there's no
> > > feedback.    
> > 
> > There is no need to resend as long as they are available via lore.kernel.org
> > mail archives.
> >   
> 
> FYI, I track using patchwork.kernel.org so rarely drop a patch set down the back of the
> sofa any more...
> 
> Jonathan

Long enough.  Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if we missed anything.

Thanks,

Jonathan


