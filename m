Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59A7EAFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjKNM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKNM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:28:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E8F13A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:27:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5C4C433C7;
        Tue, 14 Nov 2023 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699964879;
        bh=OOtLX4L5bvbZ/lYycLXinIfawDRqNeWMFk6Eb+zcll0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnn+9IFg9FBefbaw+BFnxwDnMO7Br7OzuHOvhjxsuAg139WQPvbtl0KHsFDCdFav6
         lufPJUJSW+J9s2Svbvr627euOvntzMRVuHJJXAXutAxDB1FAJuZB/v28HfsBZcqW3Y
         UhE2slJwbYmfu5UOEWW5RnGuQVH11UCVGvrt5tw4=
Date:   Tue, 14 Nov 2023 07:27:57 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
Message-ID: <2023111440-stray-uncloak-484c@gregkh>
References: <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx>
 <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx>
 <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
 <877cpd7a96.ffs@tglx>
 <CAMRc=MfNaydT8gnvusKdJrNrtjKVE4LTqdanh3+WNd5QF-2q_Q@mail.gmail.com>
 <87y1hb1ckk.ffs@tglx>
 <CAMRc=Meq6qrXsbDQiQHJ8t9tTh2V5Fb2ut6TcWYd5CKJwGBiAg@mail.gmail.com>
 <CAMRc=MeWPcaiB12f_R5jR+b-THZgHYS2bx3KypX+o5Afz1ebyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeWPcaiB12f_R5jR+b-THZgHYS2bx3KypX+o5Afz1ebyg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 09:53:47PM +0100, Bartosz Golaszewski wrote:
> On Fri, Sep 15, 2023 at 9:50 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> 
> [snip]
> 
> >
> > My point is: the same rule should apply to in-kernel consumers. When
> > they request a resource, they get a reference to it. The resource is
> > managed by its provider. If the provider is going down, it frees the
> > resource. The consumer tries to use it -> it gets an error. I'm not
> > convinced by the life-time rules argument. The consumer is not
> > CREATING a resource. It's REQUESTING it for usage. IMO this means it
> > REFERENCES it, not OWNS it. And so is only responsible for putting the
> > reference.
> >
> > Bartosz
> >
> 
> Hi Thomas, Greg et al,
> 
> I am at LPC and will present a talk on Wednesday 5:15pm at the kernel
> summit about object life-time issues. I'll reference this problem
> among others. Please consider it in your schedules, I think it'll be
> useful to discuss it in person as it's a generic problem in many
> driver subsystems.

Sounds great, I'll try to make it there!

greg k-h
