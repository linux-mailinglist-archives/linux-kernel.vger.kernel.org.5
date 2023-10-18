Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF23A7CD930
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjJRK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjJRK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:28:40 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069EB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3jpi6tb2USUsryGUEr6x7yJ/m4xxBkCDZ36oL0gWECY=;
  b=lduhjMdf6rMq63cR4tJzKodlbSMhSjFOCoZdjij/lJ580mw0rdvlt6BT
   XE1MP7WktTFWHp/cMRYHb5XOs0fHFvHm9eGPBEPPKdFZBx/0C6DN62EOQ
   gZzCE9wd9hjv3eBz+B/TqfNGo/dBq1Lw2hMcHIlcEoU8H8FOlGwRWUwBS
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,234,1694728800"; 
   d="scan'208";a="131873658"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:28:35 +0200
Date:   Wed, 18 Oct 2023 12:28:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Karolina Stolarek <karolina.stolarek@intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kenechukwu maduechesi <maduechesik@gmail.com>,
        outreachy@lists.linux.dev, shreeya.patel23498@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
In-Reply-To: <7dde176b-1059-e9a4-a023-0243cce61d01@intel.com>
Message-ID: <12b375b1-acd3-476e-17bc-b4db22efba69@inria.fr>
References: <20231018004300.GA3189@ubuntu> <7bc719c4-459f-3d8-7ed-b1e1adf158@inria.fr> <1118ec6d-e1e7-79f3-08e4-9a79c996eed1@intel.com> <2023101853-axis-stylist-f1b9@gregkh> <7dde176b-1059-e9a4-a023-0243cce61d01@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Oct 2023, Karolina Stolarek wrote:

> On 18.10.2023 09:45, Greg Kroah-Hartman wrote:
> > On Wed, Oct 18, 2023 at 09:32:46AM +0200, Karolina Stolarek wrote:
> > > On 18.10.2023 09:03, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 17 Oct 2023, kenechukwu maduechesi wrote:
> > > >
> > > > > Replace udelay() with usleep_range() for more precise delay handling.
> > > > >
> > > > > Reported by checkpatch:
> > > > >
> > > > > CHECK: usleep_range is preferred over udelay
> > > >
> > > > This message is typically not a good candidate for outreachy patches,
> > > > because you need access to the device to be sure that any change is
> > > > correct.
> > >
> > > Could we add a paragraph on how to pick good checkpatch.pl error to fix to
> > > the Outreachyfirstpatch docs? This could go to "Find a driver to clean up"
> > > section, for example.
> >
> > The ability to find a "good" error changes over time, so this might be
> > hard to do.
>
> I agree, but we can all agree that experimenting with udelay during Outreachy
> is not a good idea, and people should know about it

In general, I think that it is better in the contribution period to do the
wrong thing and then learn about why it is wrong, but this case comes up
over and over, and it is always not the right thing to do, so I added an
appropriate explanation.  Thanks for the suggestion.

julia

>
> All the best,
> Karolina
>
> >
> > good luck!
> >
> > greg k-h
>
