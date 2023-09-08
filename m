Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AAA798AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbjIHQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbjIHQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:42:22 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 398741FCD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:42:17 -0700 (PDT)
Received: (qmail 789180 invoked by uid 1000); 8 Sep 2023 12:42:16 -0400
Date:   Fri, 8 Sep 2023 12:42:16 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     gregkh@linuxfoundation.org, royluo@google.com,
        christophe.jaillet@wanadoo.fr, raychi@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com
Subject: Re: [PATCH] USB: core: Fix a NULL pointer dereference
Message-ID: <d3ffde1a-e0da-4f3f-ac34-659cbcf41258@rowland.harvard.edu>
References: <AS8P192MB12697886EC8DF1650AD56A57E8EDA@AS8P192MB1269.EURP192.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P192MB12697886EC8DF1650AD56A57E8EDA@AS8P192MB1269.EURP192.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 09:09:37PM +0530, Yuran Pereira wrote:
> 
> When the call to dev_set_name() in the usb_hub_create_port_device 
> function fails to set the device's kobject's name field, 
> the subsequent call to device_register() is bound to fail and cause
> a NULL pointer derefference, because kobject_add(), which is in the 
> call sequence, expects the name field to be set before it is called
> 
> 
> This patch adds code to perform error checking for dev_set_name()'s
> return value. If the call to dev_set_name() was unsuccessful, 
> usb_hub_create_port_device() returns with an error.
> 
> 
> PS: The patch also frees port_dev->req and port_dev before returning.
> However, I am not sure if that is necessary, because port_dev->req
> and port_dev are not freed when device_register() fails. Would be
> happy if someone could help me understand why that is, and whether I
> should keep those kfree calls in my patch.
> 
> dashboard link: https://syzkaller.appspot.com/bug?extid=c063a4e176681d2e0380
> 
> Reported-by: syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com

It shouldn't be necessary to check the return value from dev_set_name().  
Most of its other call sites ignore the return value.  In fact, only one 
of the call sites in drivers/base/core.c does check the return value!

Furthermore, device_add() includes the following test for whether the 
device's name has been set:

	if (!dev_name(dev)) {
		error = -EINVAL;
		goto name_error;
	}

The real question is why this test did not prevent the bug from 
occurring.  Until you can answer that question, any fix you propose is 
highly questionable.

Alan Stern
