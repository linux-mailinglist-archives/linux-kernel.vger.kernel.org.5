Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33757B7B85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbjJDJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbjJDJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:14:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28DDC;
        Wed,  4 Oct 2023 02:14:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A553BC433C8;
        Wed,  4 Oct 2023 09:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696410849;
        bh=P2JFyIm0Ru5QudOr5TqNTdeNy8UEQDyF/LCxvxSZOCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jN0Qg8i6kmwTvjglbFGkRUz4+gkl/w0GqYoCv/CQYeebzokODLnpHbZBrZY72jEU1
         qkMDT88LgiorOOh1SOV/RUWUTtKlxKlSeS9mFTGmmzPfX2FOjnn4CSluJglCTrYm5w
         YZKTKo0XwBTskdZEIHlaEvb0omHJ3jq5gdurTNT5Q0YwHChiTon6bGQ/TEFCeW+fk7
         wlA9TA1tqJ8UX6f6GK1BVeBqh79MVc4V4dDSKr3zVxyL48BkEKn9yHtYXvRg9z3ye1
         a46jrp6FQUzm5L5MkVzPxJkg+AxQRHPbqzjIpM413swoEi5+KOIkIuyTgMYRtvHYNG
         Qfy0XgSVtBodQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qnxxV-00025S-2O;
        Wed, 04 Oct 2023 11:14:21 +0200
Date:   Wed, 4 Oct 2023 11:14:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZR0s7dEh19lTid6-@hovoldconsulting.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <62d3678a-a23d-4619-95de-145026629ba8@gmail.com>
 <20231003121455.GB34982@atomide.com>
 <20231003122137.GC34982@atomide.com>
 <dc7af79d-bca8-4967-80fe-e90907204932@gmail.com>
 <20231004061708.GD34982@atomide.com>
 <ZR0Q7YUwgQV5TLhQ@hovoldconsulting.com>
 <20231004090320.GE34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004090320.GE34982@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:03:20PM +0300, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [231004 07:14]:
> > The pm_runtime_get_sync() in serdev_device_open() is supposed to prevent
> > that from happening by default and if that now longer works, then that
> > needs to be fixed.
> 
> No changes there, that all should work just as before.

Well, it clearly does not work as before.
 
> What is broken is that the new serial port device can autosuspend while
> the serdev device is active. This prevents serial tx in the suspend
> path.
> 
> The serial port device and serdev device are siblings of the physical
> serial port controller device as seen in the hierarcy printed out by
> Maximilian.

Yeah, and that's precisely the broken part. Keeping the serdev
controller active is supposed to keep the serial controller active. Your
serial core rework appears to have broken just that.

The new "devices" that you've added (I have still not tried to
understand why that was even needed, it looks overly complicated) must
not change that. 

If the serdev controller is active, tx should just work (as it did
before).

Johan
