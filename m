Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51797825D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjHUIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHUIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5298F;
        Mon, 21 Aug 2023 01:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B736761138;
        Mon, 21 Aug 2023 08:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94205C433C8;
        Mon, 21 Aug 2023 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692607869;
        bh=nKi2XShAbwnotQpCpq0StyQSOBV8KJ5Knd9t3XoN5QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdYucQbkgXiek8fpT7Ybf8we0A9YnTl3ed+xopccFJl5dstqIvWmeXwH7NjTQy1zk
         Puoqbp+sY+d+6x096fKDO0VaVawDjgNiZFER8s79jxvwF6k6dJ4hZq7ZcZIZxsb1Lj
         oFoTYxUEz6Vk2Wdg/7UoWvQ6iDj2901+9FvYoS7KgUQZ227SmMT7mk2nJdoYj0I3VZ
         QxIkl5OZaCJW6JzuD20Npho+11Odr/IiLu9jsoJzru6IYZRcMvHYXxfY2D0wqG7TWn
         px8KZMlAamommXuvLtvDXVBy+BkCq9oGu4awAs5ECpM4XsIz8MM2O6njlIleY5aw0I
         Bl1P2FveoR7vA==
Date:   Mon, 21 Aug 2023 10:51:04 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
 <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
 <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm>
 <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 21 2023, Andy Shevchenko wrote:
> On Mon, Aug 14, 2023 at 11:28:58AM +0200, Jiri Kosina wrote:
> > On Mon, 7 Aug 2023, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > > After I updated GPIO library for the case Benjamin has with CP2112,
> > > > > > > I have a brief look into the CP2112 driver itself.
> > > > > > > 
> > > > > > > From GPIO perspective it has two main (maitenance) issues:
> > > > > > > - usage of ->to_irq() with IRQ chip present;
> > > > > > > - having IRQ chip not immutable.
> > > > > > > 
> > > > > > > Besides that there are plenty small cleanups here and there.
> > > > > > > Hence this series.
> > > > > > 
> > > > > > Any comments on this?
> > > > > 
> > > > > Gentle ping^2 for this...
> > > > > 
> > > > > Anything should I do to improve it or is it okay to go as is?
> > > > 
> > > > I have been off pretty much the whole July. I am now back and slowly 
> > > > making my way through everything that accumulated, I will eventually get 
> > > > to this.
> > > > 
> > > > Thanks for the patience,
> > > 
> > > Ah, okay, no worries and take your time!
> > > 
> > > I was thinking more on Benjamin's answer as last time he had a hw setup
> > > to test... Not sure what the status of that now and if he has a chance
> > > to test this or busy enough with something else.
> > 
> > Ah, that would be of course nice. Benjamin?
> 
> Benjamin? It almost full release cycle passed...
> I understand if you are busy with something, just tell us.

Sorry for not answering, I was off in August until just now.

I tried you series just before taking time off, but the problem was that
my automation relies on this driver to not be too far from the current
upstream, as I need to patch it to be able to inject a node child in it.

Which is why I was very interested in the ACPI/DT work so that I do not
have to patch the driver.

Long story short, I'm not able to test it right now (and I got quite
some backlog as you can imagine). IIRC the code was fine, so I think we
can just take the series as is, and work on the quirks (if any) later.

Cheers,
Benjamin
