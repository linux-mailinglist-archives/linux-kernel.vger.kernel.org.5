Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F97EAF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjKNLsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:48:38 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF1A7;
        Tue, 14 Nov 2023 03:48:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3821AFF803;
        Tue, 14 Nov 2023 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699962514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ecc2U8XKNAiKPYVEs6kOx9hM2XH9Tt8TCuws1240YTw=;
        b=WTnPxPVyckP+A0BzC7eaUF/2H8p8/YNg/sg7BmqSWyd7UP8TY5OwzJRhkgq+AYfexSM5Yr
        js51iQf9AqX1FcmCaQm8LmT5XNQVOceD75MYOjJGe9Niyqm7ppgaSdY+uUU2TkcDn13lUK
        sS4YdHGe7f3amOLybBZ9xcsB1b7VR4KROu5tiV3cZRJjUx0xzkSIWJN491T7B1EUkf5mTP
        fa8FQInIoiC9c6gYc5oU3ct2BF3QbQV1KnvjmKkuFUREDpzJdsM5l8DBVCqcIxnxjnE2gJ
        XXJOkgslyXRWnb0tZJkTVVqzrke6aSLEkYgLpfmBc6fJGhAKv1p5d26CMQwI4Q==
Date:   Tue, 14 Nov 2023 12:48:32 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] lib/vsprintf: Fix %pfwf when current node refcount
 == 0
Message-ID: <20231114124832.40d4ced4@bootlin.com>
In-Reply-To: <ZVNZ63HdoRKT4IQ9@kekkonen.localdomain>
References: <20231114110456.273844-1-herve.codina@bootlin.com>
        <ZVNZ63HdoRKT4IQ9@kekkonen.localdomain>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, 14 Nov 2023 11:28:43 +0000
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -2108,8 +2108,8 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
> >  {
> >  	int depth;
> >  
> > -	/* Loop starting from the root node to the current node. */
> > -	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> > +	/* Loop starting from the root node to the parent of current node. */
> > +	for (depth = fwnode_count_parents(fwnode); depth > 0; depth--) {
> >  		struct fwnode_handle *__fwnode =
> >  			fwnode_get_nth_parent(fwnode, depth);  
> 
> How about, without changing the loop:
> 
> 		/*
> 		 * Only get a reference for other nodes, fwnode refcount
> 		 * may be 0 here.
> 		 */
> 		struct fwnode_handle *__fwnode =
> 			depth ? fwnode_get_nth_parent(fwnode, depth) : fwnode;
> 
> >  
> > @@ -2121,6 +2121,16 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
> >  		fwnode_handle_put(__fwnode);  
> 
> And:
> 
> 		if (__fwnode != fwnode)
> 			fwnode_handle_put(__fwnode);
> 

Sure.
I will just change to keep the both tests consistent.
I mean test with depth or test with __fwnode != fwnode but avoid
mixing them.

What do you think about testing using depth in all cases and so:
	if (depth)
		fwnode_handle_put(__fwnode);

Best regards,
Hervé

