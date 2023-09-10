Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE8799CDC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346350AbjIJG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjIJG7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 02:59:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48301BD;
        Sat,  9 Sep 2023 23:59:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323ACC433C7;
        Sun, 10 Sep 2023 06:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694329149;
        bh=5gpqg/DpUwN2Pc9g8wvI9fcEXZrb9npPHr+b/QvBmc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMlHdAPM3m8+u8Eb0U382WZh9yLqmqmqJtwVqDKz5BL9vhjy0lOHhc2sccyQhU22I
         hRitRaLY18OGgZSCEU07WjtdFI+Xi6u7xdx667TjwH/E0HHx92DwnGNJsms+ppZTNy
         0//JfR9x6qNwQOr7nQcVeZzG6Htd5bkO5ZQN9FyA=
Date:   Sun, 10 Sep 2023 07:59:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
Cc:     "salvatore.bonaccorso@gmail.com" <salvatore.bonaccorso@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <2023091051-blaspheme-quack-c949@gregkh>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
 <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <DM4PR11MB61890EE125816A786D153C22C4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090820-wielder-angled-3def@gregkh>
 <DM4PR11MB618943BFA18521150923326BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090826-fabulous-genetics-e912@gregkh>
 <DM4PR11MB61897793502F49240BCA903CC4ECA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090925-eloquence-derail-1e2b@gregkh>
 <DM4PR11MB6189F15AB7DFD11AA02A16C2C4F3A@DM4PR11MB6189.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB6189F15AB7DFD11AA02A16C2C4F3A@DM4PR11MB6189.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 06:25:22AM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org> 
> Sent: Saturday, September 9, 2023 5:17 PM
> To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisco.com>
> Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
> 
> On Sat, Sep 09, 2023 at 08:49:52AM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, September 8, 2023 12:39 PM
> > To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) 
> > <deeratho@cisco.com>
> > Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free 
> > bug in btsdio_remove due to race condition
> > 
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > 
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > 
> > 
> > > http://daringfireball.net/2007/07/on_top
> > 
> > On Fri, Sep 08, 2023 at 06:54:06AM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> > > Hi Greg,
> > > 
> > > This change is required to fix kernel CVE: CVE-2023-1989 which is 
> > > reported in v6.1 kernel version.
> > 
> > > Which change?
> > 
> > [Deepak]: I am referring below change. This below change is required to fix kernel CVE: CVE-2023-1989 which is reported in v6.1 kernel.
> > 
> > Subject: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in 
> > btsdio_remove due to race condition
> > 
> > From: Zheng Wang <zyytlz.wz@163.com>
> > 
> > [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
> 
> > This commit is already in the 6.1.52 kernel release, why do you want it included again?
> 
> > confused,
> 
> > greg k-h
> 
> Hi Greg, Salvatore,
> 
> When I have submitted this patch for review, at that time, 6.1.52 was not released.
> 
> It will be good if you can share me guideline or details like how I
> can share CVE fix patch to upstream for review like what details I
> need to include in patch for review so from next time, we can save
> time in query discussion.

Why does the random assignment of a CVE number mean anything should be
done differently than the normal process of getting a stable patch
merged?

You have read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

right?

That should cover it.

thanks,

greg k-h
