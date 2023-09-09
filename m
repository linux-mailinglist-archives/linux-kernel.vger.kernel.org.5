Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3692B7999DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjIIQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbjIIOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:37:02 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9B5F218E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 07:36:54 -0700 (PDT)
Received: (qmail 816565 invoked by uid 1000); 9 Sep 2023 10:36:53 -0400
Date:   Sat, 9 Sep 2023 10:36:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yuran Pereira <yuran.pereira@hotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "royluo@google.com" <royluo@google.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "raychi@google.com" <raychi@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com" 
        <syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com>
Subject: Re: [PATCH] USB: core: Fix a NULL pointer dereference
Message-ID: <c072b373-0368-4f49-a4da-da309955cb7a@rowland.harvard.edu>
References: <AS8P192MB12697886EC8DF1650AD56A57E8EDA@AS8P192MB1269.EURP192.PROD.OUTLOOK.COM>
 <d3ffde1a-e0da-4f3f-ac34-659cbcf41258@rowland.harvard.edu>
 <AM9P192MB12670D185D208AFA51B8348EE8ECA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P192MB12670D185D208AFA51B8348EE8ECA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 06:28:12AM +0000, Yuran Pereira wrote:
> Hello Alan,
> 
> Thank you for elucidating that.
> 
> So, this bug is present on the mainline tree which is where syzkaller 
> found it. My patch was also based on the mainline tree.
> 
> I just ran the same reproducer against a kernel compiled from the usb 
> tree, and, as you suggested, the test you mentioned does in fact, 
> prevent the bug from occurring.
> 
> Please forgive my ignorance; I am a new contributor to the community. 
> But in this situation how should I proceed? Is there even a need to 
> submit a patch, or will the code currently present in the usb tree 
> eventually be reflected in the mainline?

The first step is to find the difference between the mainline and USB 
trees that is responsible for this change in behavior.  A quick check of 
the Git logs shows that the change was caused by commit d21fdd07cea4 
("driver core: Return proper error code when dev_set_name() fails"), 
written by Andy Shevchenko.  As a result of this commit, the code in 
device_add() now says:

	if (dev_name(dev))
		error = 0;
	/* subsystems can specify simple device enumeration */
	else if (dev->bus && dev->bus->dev_name)
		error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
	if (error)
		goto name_error;

This obviously omits a final "else" clause; it should say:

	if (dev_name(dev))
		error = 0;
	/* subsystems can specify simple device enumeration */
	else if (dev->bus && dev->bus->dev_name)
		error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
+	else
+		error = -EINVAL;
	if (error)
		goto name_error;

So to answer your questions: No, the code in the USB tree will not find 
its way into mainline.  The opposite will happen: The mainline code will 
land in the USB tree.  Which means that yes, there is a need to submit a 
patch.  You can go ahead and write this up for submission, or I can 
submit it for you.  Or you can check with Andy and see if he wants to 
fix the problem in a different way.

Alan Stern
