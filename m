Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464AD7D1C9F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjJUK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:59:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C799
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:58:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5469AC433C8;
        Sat, 21 Oct 2023 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697885935;
        bh=VXBbxg8w4zTKXCyrSSeoaCaTpBuPrlii7tfO2ZHQkPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifnYkUmY6lIw15QqNIRHSCwHO34rXRxMPYczWurRPRQan2vVXOEjDmLcDQjg9BQim
         Uq0QVoX/lM6JbqLixamIUUZmI/zsjyXDWgvmUVOsWuc80ucNjhqZf5Cjabv6UqMNKD
         y9fKywBftkaK/3mAFoNC6c97/T4LlZCAEa6kSzfI=
Date:   Sat, 21 Oct 2023 12:58:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4] driver core: shut down devices asynchronously
Message-ID: <2023102151-rejoicing-studio-6126@gregkh>
References: <20230921163443.9224-1-stuart.w.hayes@gmail.com>
 <2023100507-refocus-stooge-08dd@gregkh>
 <4f36de79-6271-ab6f-19fe-ba189e748b8f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f36de79-6271-ab6f-19fe-ba189e748b8f@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:40:48PM -0500, stuart hayes wrote:
> 
> 
> On 10/5/2023 4:36 AM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 21, 2023 at 11:34:43AM -0500, Stuart Hayes wrote:
> > > Shut down devices asynchronously, ensuring that each device is shut down
> > > before its parents.
> > > 
> > > This can dramatically reduce system shutdown/reboot time on systems that
> > > have devices that take many seconds to shut down, such as some NVMe drives.
> > > On one system tested, the shutdown time went from 11 minutes without this
> > > patch to 55 seconds with the patch.
> > 
> > That's a nice improvement, but I think we need a lot more testing on a
> > wide range of systems before we can take a patch like this.
> > 
> > Also, what about busses that don't want this type of shutdown?  We allow
> > busses to opt-in for async probing, shouldn't that be also done for
> > shutting them down to resolve issues for busses that can not handle
> > this?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Yes, I could add something like what is done for async probing, so drivers
> have to opt in to async shutdown of their devices.
> 
> But I'm not sure how to get it tested on a wide range of systems, other than
> than having the patch in the kernel.

Yes, breaking things is the only way you will know :)

> What if it defaults to synchronous
> shutdown for now, but the option is there so people are able to test async
> shutdown by changing an attribute in sysfs?  Then drivers could be patched
> later to opt in to async shutdown of their devices by default...?

Yes, that will be the proper way forward, default to what you know works
today, and then busses can opt-in for the async option if they work
properly.  That's what we did with probing, so it can mirror that.

thanks,

greg k-h
