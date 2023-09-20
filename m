Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40787A79AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjITKsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjITKsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:48:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0758F185
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:48:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD2C433C8;
        Wed, 20 Sep 2023 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695206882;
        bh=oiDBvTO9seuy4eOGlsXrxIgALqg2yanNoMbBcsGwKDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfvw0J7uHqb+ZBmcrLzSFZ4BYDnNNs++8ss/hj/Yl+m5ck3Xs/Kt4KO5VrhldMz4a
         JrxIJD5BUG0sJ6oCa5f2I1L+6CBwXwtKIItZrC3PIFkoYfIJt8BIYkNODElOeszlUL
         N1sWNro5kQ9nBCfh8h+2Zv9y/+RpfFQ5X314iwaY=
Date:   Wed, 20 Sep 2023 12:48:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <2023092027-epileptic-jolly-84ef@gregkh>
References: <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
 <2023090330-bling-mammary-3177@gregkh>
 <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
 <763bd845-d8d6-489c-bd31-305ed14bc40f@sirena.org.uk>
 <1518370c-e0cd-4d78-af54-3e2cf4dd6e3c@hatter.bewilderbeest.net>
 <5282acd1-3c7a-4948-83f2-2829910ab841@sirena.org.uk>
 <25844d80-fadb-44c3-a0e6-334aa6e4afd7@hatter.bewilderbeest.net>
 <2023092037-denote-enslave-0a3f@gregkh>
 <63fe0803-8120-41a8-8998-a4e6aa32308e@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fe0803-8120-41a8-8998-a4e6aa32308e@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:44:29AM -0700, Zev Weiss wrote:
> On Wed, Sep 20, 2023 at 02:29:15AM PDT, Greg Kroah-Hartman wrote:
> > On Wed, Sep 20, 2023 at 02:02:49AM -0700, Zev Weiss wrote:
> > >  static int regulator_userspace_notify(struct notifier_block *nb,
> > >  				      unsigned long event,
> > >  				      void *ignored)
> > >  {
> > >  	struct userspace_consumer_data *data =
> > >  		container_of(nb, struct userspace_consumer_data, nb);
> > > -	static const char * const *envp[] = { "NAME=events", NULL };
> > 
> > You removed this user/kernel api value, what will break if you do that?
> > 
> 
> Sorry, I don't follow -- what removal are you referring to?  The envp array
> still has a NAME entry -- I changed its value from "events" to "event",

Yes, that value.

> but
> I wrote that part before I realized that the 'event' parameter of the
> function was actually a bitmask that might convey multiple events and just
> forgot to change it back, so keeping it pluralized is probably more
> appropriate.
> 
> And FWIW, I didn't intend for the exact format of the EVENT parameter that I
> sketched there to be something that had to be kept; given that there might
> be multiple entries perhaps it'd be better to use separate parameters more
> like NUMEVENTS, EVENT0, EVENT1, etc?  (Or omit NUMEVENTS and just let the
> consumer count upward until it doesn't find a match.)

I don't know, what does userspace do with this value today?  If you
change it, what will break?

thanks,

greg k-h
