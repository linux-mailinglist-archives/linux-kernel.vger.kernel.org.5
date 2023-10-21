Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B67D1DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjJUPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:52:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B7913E;
        Sat, 21 Oct 2023 08:52:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE97FC433C8;
        Sat, 21 Oct 2023 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697903572;
        bh=7TjlB9aoSZ9815DfMrxuJtQz6zC044xTw1Yj6BKuTms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b+K6XEqRGp9d0Vz81r4ZvvvUwfHB/srqOevZyaZHtrUXW1zBBo9BU3ofEhSIzRiu5
         XPlvWw0voHmJ190ioNpvb4aHCYxAu21mqv9+JwVYDqLO2U2gctBpG0FkLRZ3MKWads
         P4r7msdXsstOtlp/uySkQbIbUjl9Dn5cl3D1YD5o1+FeG7t9xU5X8Ddtey7VA9l3Bz
         zPbHPH9z6vz//V106s86txXmPxUQFlt0aA2HiEDNaRYOfCsMjLCVTQSRZjZ+cUR3Ch
         5+yhzOxqyLLlnuSUSUwweWkoCf3LRrp7lyjSxoYL97odTfxFJ4CjoUjvbFiUSAOEBH
         m5DqsV34bGngA==
Date:   Sat, 21 Oct 2023 16:52:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: bmp280: fix eoc interrupt usage
Message-ID: <20231021165245.4f6c9aa3@jic23-huawei>
In-Reply-To: <ZTFkKl6Qu4vpfcC4@anderl>
References: <20231018152816.56589-1-ak@it-klinger.de>
        <20231019162209.18872-1-ak@it-klinger.de>
        <ZTFfRaShatWdxGB9@smile.fi.intel.com>
        <ZTFkKl6Qu4vpfcC4@anderl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 19:15:22 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Andy,
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Do, 19. Okt 19:54:
> > On Thu, Oct 19, 2023 at 06:22:09PM +0200, Andreas Klinger wrote:  
> > > Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
> > > bmp085 and bmp180 share the same chip id. Therefore it's necessary to
> > > distinguish the case in which the interrupt is set.
> > > 
> > > Fix the if statement so that only when the interrupt is set and the chip
> > > id is recognized the interrupt is requested.
> > > 
> > > This bug exists since the support of EOC interrupt was introduced.  
> >   
> > > Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")  
> > 
> > As Jonathan already commented, this is part of a tag block below...
> >   
> > > Also add a link to bmp085 datasheet for reference.
> > >   
> > 
> > ...somewhere here.
> >   
> > > Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > > ---
> > >  v1 -> v2: Remove extra space (seen by Andy)  
> > 
> > 
> > And seems Jonathan mentioned that this is already fixed in his tree.
> > Did I understand that correctly?  
> 
> I just read it in the archive. For some reason I didn't get Jonathans mail
> yesterday. Sorry for the spam.

btw, don't reply to an earlier version.  New version is new email thread.
Otherwise things get very tricky to follow once we have lots of versions

Jonathan

> 
> Andreas
> 

