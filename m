Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2437BE1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377552AbjJINyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377632AbjJINyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:54:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269399
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:54:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC743C433C8;
        Mon,  9 Oct 2023 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696859644;
        bh=Do0OSnCoIrgA63N7+OoDGYu8qYZpmXnRnU0TElVI78o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mDvfBr9oAw6rRwIOH+CKli+rRsLVKX4wQvuqZv3IqfLhIh9l/ihzkNDY8+J7lh7hI
         EiLu8hTLiMyOlCiVirQwlGPJQrsYD2dinN6NlUT6pDmA1i0fKo09sQ/PcthlgScb+Z
         kobr9vkmutfY4jwama9oeSIQ1A5Bq9savu/9BAMFKdl9pVLMgKL+/H0WPAySmrPY8x
         Xyp7E+PPpvKYMPdvLGPIzrR9WP5X8q3uc0TZpsK+BZQzxY9a6s6SXAwk5sIgBkA4Gi
         ztZ/UN6QPnMA4wmnl6xg9AewDG8DJtdqpD0uyLM0WGCZpSg8tfr2jHBplIxOdNND2C
         yd9GQaDmBp+PA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81B4DCE016C; Mon,  9 Oct 2023 06:54:04 -0700 (PDT)
Date:   Mon, 9 Oct 2023 06:54:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <9c29f134-cf5c-4d21-bd66-9393db100f0c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
 <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
 <23bc3841-4cda-4a23-a67f-a944e1104f1d@paulmck-laptop>
 <20231007070630.GB20998@1wt.eu>
 <d80c1da1-56f8-4b94-b1e2-eef75a52d022@paulmck-laptop>
 <fad7814f-0bbd-43f0-a205-9ba2c08bac22@t-8ch.de>
 <76a51116-46bb-4271-b5ac-c101e02d5a63@paulmck-laptop>
 <ZSOjhgIbK8bs3Asu@1wt.eu>
 <f9695abc-f1f2-49e0-901b-41a078ec57c5@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9695abc-f1f2-49e0-901b-41a078ec57c5@t-8ch.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:22:59AM +0200, Thomas Weißschuh wrote:
> Hi Willy, Paul,
> 
> On 2023-10-09 08:53:58+0200, Willy Tarreau wrote:
> > On Sun, Oct 08, 2023 at 09:27:43AM -0700, Paul E. McKenney wrote:
> > (...)
> > > The other approach involves rebasing the "nolibc/next" stack
> > > on top of the "nolibc/fixes" stack.
> > 
> > That was my initial expectation as well, it's much easier, preserves
> > the patches ordering so it guarantees that all fixes are always present
> > in -next and that there won't be conflicts when they're finally submitted.
> 
> The workflow Paul described indeed makes a lot of sense.
> 
> I can redo it this afternoon.
> 
> > [..]
> 
> > > While in the area, would the following (absolutely not urgent or even
> > > particularly important) patch be a good idea?  This gets rid of a line
> > > of noise from "git status" after running the tests.
> > 
> > Good idea, feel free to propose a patch ;-)
> 
> How about directly folding it into the original patch?
> I can take care of that later today, too.

Works for me, and thank you!

							Thanx, Paul
