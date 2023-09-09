Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070F87997B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbjIILrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjIILrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:47:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC5186;
        Sat,  9 Sep 2023 04:47:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F03C433C8;
        Sat,  9 Sep 2023 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694260034;
        bh=KMWBsdp8nGAV3aRsdcvJzjfRJ3yWDJoFWmXVM+GYvHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSNoAPOjuLmayLiYyEGQIg3zAh8C0IwIA0x8gZvRUmUYhaK5vrCsPXS4GJjFLWnL3
         DlfGQ83t3IfEJ2370DOacV5C2q4djUG+iZz6j5tUsEyGCh4tE370mXJN/9dSE5jxJl
         9Jgez7MQpYbqiYCWae7KzGfNdJfhIG6gJITyTdqg=
Date:   Sat, 9 Sep 2023 12:47:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <2023090925-eloquence-derail-1e2b@gregkh>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
 <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <DM4PR11MB61890EE125816A786D153C22C4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090820-wielder-angled-3def@gregkh>
 <DM4PR11MB618943BFA18521150923326BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090826-fabulous-genetics-e912@gregkh>
 <DM4PR11MB61897793502F49240BCA903CC4ECA@DM4PR11MB6189.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB61897793502F49240BCA903CC4ECA@DM4PR11MB6189.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 08:49:52AM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org> 
> Sent: Friday, September 8, 2023 12:39 PM
> To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisco.com>
> Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
> 
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> 
> > A: No.
> > Q: Should I include quotations after my reply?
> 
> 
> > http://daringfireball.net/2007/07/on_top
> 
> On Fri, Sep 08, 2023 at 06:54:06AM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> > Hi Greg,
> > 
> > This change is required to fix kernel CVE: CVE-2023-1989 which is 
> > reported in v6.1 kernel version.
> 
> > Which change?
> 
> [Deepak]: I am referring below change. This below change is required to fix kernel CVE: CVE-2023-1989 which is reported in v6.1 kernel.
> 
> Subject: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
> 
> From: Zheng Wang <zyytlz.wz@163.com>
> 
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]

This commit is already in the 6.1.52 kernel release, why do you want it
included again?

confused,

greg k-h
