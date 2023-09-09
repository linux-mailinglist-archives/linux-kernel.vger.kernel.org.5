Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405FB7999EE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjIIQ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjIIPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:35:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D3138;
        Sat,  9 Sep 2023 08:35:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0145C433C8;
        Sat,  9 Sep 2023 15:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694273729;
        bh=LZz+tmcgF9fWYqabYSOw8moDmQGvpH5W7FKHUWOOjvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYUxgLZIKsHLUZsKePPYkDj0wgN6OXQQe4ejXAjxZTcTtjPui/dY+mes0/xb8jeig
         5Hm6KZo6sDmj3vA5tA94L8ao9eyuJ1L7US1iqEt3uor8sbi1vAReWoz+KoWjkfIMqY
         0GWhaMbkpGJkVyz1wXEna36h3IBQeDVA4nu/1h7s=
Date:   Sat, 9 Sep 2023 16:35:26 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "royluo@google.com" <royluo@google.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "raychi@google.com" <raychi@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com" 
        <syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com>
Subject: Re: [PATCH] USB: core: Fix a NULL pointer dereference
Message-ID: <2023090955-sandy-yummy-3d1e@gregkh>
References: <AS8P192MB12697886EC8DF1650AD56A57E8EDA@AS8P192MB1269.EURP192.PROD.OUTLOOK.COM>
 <d3ffde1a-e0da-4f3f-ac34-659cbcf41258@rowland.harvard.edu>
 <AM9P192MB12670D185D208AFA51B8348EE8ECA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
 <c072b373-0368-4f49-a4da-da309955cb7a@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c072b373-0368-4f49-a4da-da309955cb7a@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 10:36:53AM -0400, Alan Stern wrote:
> On Sat, Sep 09, 2023 at 06:28:12AM +0000, Yuran Pereira wrote:
> > Hello Alan,
> > 
> > Thank you for elucidating that.
> > 
> > So, this bug is present on the mainline tree which is where syzkaller 
> > found it. My patch was also based on the mainline tree.
> > 
> > I just ran the same reproducer against a kernel compiled from the usb 
> > tree, and, as you suggested, the test you mentioned does in fact, 
> > prevent the bug from occurring.
> > 
> > Please forgive my ignorance; I am a new contributor to the community. 
> > But in this situation how should I proceed? Is there even a need to 
> > submit a patch, or will the code currently present in the usb tree 
> > eventually be reflected in the mainline?
> 
> The first step is to find the difference between the mainline and USB 
> trees that is responsible for this change in behavior.  A quick check of 
> the Git logs shows that the change was caused by commit d21fdd07cea4 
> ("driver core: Return proper error code when dev_set_name() fails"), 
> written by Andy Shevchenko.  As a result of this commit, the code in 
> device_add() now says:
> 
> 	if (dev_name(dev))
> 		error = 0;
> 	/* subsystems can specify simple device enumeration */
> 	else if (dev->bus && dev->bus->dev_name)
> 		error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
> 	if (error)
> 		goto name_error;
> 
> This obviously omits a final "else" clause; it should say:
> 
> 	if (dev_name(dev))
> 		error = 0;
> 	/* subsystems can specify simple device enumeration */
> 	else if (dev->bus && dev->bus->dev_name)
> 		error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
> +	else
> +		error = -EINVAL;
> 	if (error)
> 		goto name_error;

And:
  https://lore.kernel.org/r/20230828145824.3895288-1-andriy.shevchenko@linux.intel.com
is the fix for this which will show up in time for 6.6-final.

thanks,

greg k-h
