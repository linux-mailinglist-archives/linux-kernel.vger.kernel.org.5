Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9860B7EB335
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjKNPNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKNPNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:13:48 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44809E3;
        Tue, 14 Nov 2023 07:13:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82C5920007;
        Tue, 14 Nov 2023 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699974823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIcfcJYo9Q7ijv30KQH5KiYGvf5xWIQo8n+CJ3Rxw+g=;
        b=aUuZEWbRx1iLY38fnY9G+BloSdQqrYYOwWrdbra7rWGe+i+EZmP/MqEMKX6tqHOtJ0pkuS
        PfVbI7T2VhBfZTqiSrermTIDO/qvxd4jSKWm8DfocPlKXHt2+1u2Jshl0nLw1pwBedrrxe
        X436bGzAp85vZjVDN8avAJ54YTk2921mi8Obl1b4QfBalmy/RjZqAgfiucnpxhJVerTqUv
        H/5FCFkkMUwUmXw0dQ9I8sALC8Ox9qepAyp1GNevSxjmqifa50XIg6EaZAq/SR2J0AhbTL
        ckX1xVsCyOFgGcgYRNhv0ifguU/4djzTzWvivgo+u9kKIO7dXdgjPFbEj/PQsw==
Date:   Tue, 14 Nov 2023 16:13:41 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Fix %pfwf when current node
 refcount == 0
Message-ID: <20231114161341.2651d393@bootlin.com>
In-Reply-To: <ZVOLV008PaKFXRy9@smile.fi.intel.com>
References: <20231114143558.356259-1-herve.codina@bootlin.com>
        <ZVOLV008PaKFXRy9@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, 14 Nov 2023 16:59:35 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

[...]

> 
> One nit-pick below, otherwise
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ...
> 
> >  	/* Loop starting from the root node to the current node. */
> >  	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> > -		struct fwnode_handle *__fwnode =
> > -			fwnode_get_nth_parent(fwnode, depth);
> > +		/*
> > +		 * Only get a reference for other nodes (ie parents node).  
> 
> "parent's node" (doesn't look right)? Or "parent nodes"?
> 

Will be changed to "parent nodes" in the next iteration.

Best regards,
Hervé
