Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9B75CC20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGUPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGUPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D211BF7;
        Fri, 21 Jul 2023 08:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B870761CAD;
        Fri, 21 Jul 2023 15:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A232CC433CA;
        Fri, 21 Jul 2023 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689954021;
        bh=L/8ROPKn5FRlN87/a9hvfNMvi9wPkopmqeGrLx/LYvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbGHQxLzzcyM3GtLL7UE2QCJDHJhtvK+SwyVPMZgvQy5dGI1sdaVucZWNShHf0F8I
         nm1ijlgOQkn2DVDlBEcowN0pKLflTtZAVH7TGmBfb0nuTt5JyiWmsGwgbC+iDQw4vJ
         E79Y4YTLqARhR0XIZe+q66KZdBmIHFn3vqJpSRkc=
Date:   Fri, 21 Jul 2023 17:40:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <2023072152-traffic-skype-8765@gregkh>
References: <CAHp75VcWSVgA8LFLo0-b5TfKWdHb2GfLpXV-V3PZvthTv1Xc4A@mail.gmail.com>
 <20230620113312.882d8f0c7d5603b1c93f33fb@hugovil.com>
 <CAHp75VfGm6=ULW6kMjsg2OgB1z1T0YdmzvCTa3DFXXX-q_RnfA@mail.gmail.com>
 <20230620114209.fb5272ad8cf5c5e2895d68b1@hugovil.com>
 <CAHp75VcieuYqxWrO7rknx2ROYz=rnWnKV6s9eXZ5Zd1BKc6YMg@mail.gmail.com>
 <20230620121645.512b31a872306b43a276bbac@hugovil.com>
 <20230719144048.4f340b8aa0a29ab65a274273@hugovil.com>
 <2023071922-rigor-collage-804e@gregkh>
 <2023072040-clock-waltz-a5f2@gregkh>
 <20230721112517.38ab9a40cdf6a0eddf074615@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721112517.38ab9a40cdf6a0eddf074615@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:25:17AM -0400, Hugo Villeneuve wrote:
> On Thu, 20 Jul 2023 21:38:21 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Jul 19, 2023 at 09:14:23PM +0200, Greg KH wrote:
> > > On Wed, Jul 19, 2023 at 02:40:48PM -0400, Hugo Villeneuve wrote:
> > > > On Tue, 20 Jun 2023 12:16:45 -0400
> > > > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > 
> > > > > On Tue, 20 Jun 2023 18:45:51 +0300
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > 
> > > > > > On Tue, Jun 20, 2023 at 6:42 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > > > On Tue, 20 Jun 2023 18:35:48 +0300
> > > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > > > On Tue, Jun 20, 2023 at 6:33 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > > > > > On Tue, 20 Jun 2023 18:18:12 +0300
> > > > > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > > > > > On Tue, Jun 20, 2023 at 5:08 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > > > > > > > On Sun, 4 Jun 2023 22:31:04 +0300
> > > > > > > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > 
> > > > > > ...
> > > > > > 
> > > > > > > > > > > did you have a chance to look at V8 (sent two weks ago) which fixed all
> > > > > > > > > > > of what we discussed?
> > > > > > > > > >
> > > > > > > > > > The patch 6 already has my tag, anything specific you want me to do?
> > > > > > > > >
> > > > > > > > > Hi Andy,
> > > > > > > > > I forgot to remove your "Reviewed-by: Andy..." tag before sending V8
> > > > > > > > > since there were some changes involved in patch 6 and I wanted you to
> > > > > > > > > review them. Can you confirm if the changes are correct?
> > > > > > > > >
> > > > > > > > > I also added a new patch "remove obsolete out_thread label". It has no
> > > > > > > > > real impact on the code generation itself, but maybe you can review and
> > > > > > > > > confirm if tags are ok or not, based on commit message and also
> > > > > > > > > additional commit message.
> > > > > > > >
> > > > > > > > Both are fine to me.
> > > > > > >
> > > > > > > Hi,
> > > > > > > Ok, thank you for reviewing this.
> > > > > > >
> > > > > > > I guess now we are good to go with this series if the stable tags and
> > > > > > > patches order are good after Greg's review?
> > > > > > 
> > > > > > Taking into account that we are at rc7, and even with Fixes tags in
> > > > > > your series I think Greg might take this after v6.5-0rc1 is out. It's
> > > > > > up to him how to proceed with that. Note, he usually has thousands of
> > > > > > patches in backlog, you might need to respin it after the above
> > > > > > mentioned rc1.
> > > > > 
> > > > > Ok, understood.
> > > > > 
> > > > > Let's wait then.
> > > > 
> > > > Hi Andy/Greg,
> > > > we are now at v6.5-rc2 and I still do not see any of our patches in
> > > > linus or gregkh_tty repos.
> > > > 
> > > > Is there something missing from my part (or someone else) to go forward
> > > > with integrating these patches (v8) for v6.5?
> > > 
> > > My queue is huge right now, please be patient, I want to have them all
> > > handled by the end of next week...
> > > 
> > > You can always help out by reviewing other patches on the mailing list
> > > to reduce my review load.
> > 
> > Wait, no, this series was superseeded by v8, and in there you said you
> > were going to send a new series.  So please, fix it up and send the
> > updated version of the series, this one isn't going to be applied for
> > obvious reasons.
> 
> Hi Greg,
> I never said that I would resend another update for this current
> serie (unless of course if it was to address a new comment). Re-reading
> that email made me realise that it was maybe not perfectly clear the
> way I wrote it.
> 
> What I said was that, once V8 was finally applied and
> incorporated in the kernel, then I would send a completely new and
> different serie to address issues/concerns/improvements/suggestions
> noted during the review of this serie (example: conversion of bindings
> to YAML and improve DTS node names, etc). We already agreed with some
> maintainers (ex: Conor Dooley) that it was reasonnable to do so.
> 
> That is why I asked Andy if we were good to go with V8 and he
> confirmed that, and that it was now up to you to integrate it if your
> review was satisfactory.
> 
> Hope this clears things and we can integrate it soon.

I don't have any of your series in my review queue at all, so please
resend them.

thanks,

greg k-h
