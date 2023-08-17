Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB777FCAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353848AbjHQRKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353875AbjHQRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A3359C;
        Thu, 17 Aug 2023 10:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F39675A3;
        Thu, 17 Aug 2023 17:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD208C43397;
        Thu, 17 Aug 2023 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292176;
        bh=tr+gP1wBdRSCgmPKKlr0hl197P9Phizogm7powCc/ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOorrPBMF7lDdfdLSDTHK/I+6wSeVQzn8mDmHCDl6sGa2MVBTxLaY2rJM/pBgjY6D
         tjP6nouIHjzzA4uVpnjFxtrHC7bsb7WAC/zVbsWgowFCoUHGybCVk1dENk1lN07UqE
         1z72bRHSUw+QMl0lgKMITdeBy5lFqsMP5wgtoVUv4a9p0wb28eC3t8hxc3u7A7CtN1
         er+PL/kk+rYuZqGHE/8VhrGteYbsH6TLoY6dmLYYKuE9hq9yeMWNWXyoXR/0wVfqAF
         0oHKaQUq6iWZwrrXUyWYA0LlP2xj4tCJwKSrlsV6/aOfpAu55pVcx+9ngxeHWhEFA7
         HsuPVHXa0kyNw==
Received: (nullmailer pid 1548189 invoked by uid 1000);
        Thu, 17 Aug 2023 17:09:34 -0000
Date:   Thu, 17 Aug 2023 12:09:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] of: dynamic: Move dead property list check into
 property add/update functions
Message-ID: <20230817170934.GA1495946-robh@kernel.org>
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-5-c2b701579dee@kernel.org>
 <ZNEPqwQ0H9srkxxq@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEPqwQ0H9srkxxq@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 06:37:15PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 04, 2023 at 04:41:55PM -0600, Rob Herring wrote:
> > The changeset code checks for a property in the deadprops list when
> > adding/updating a property, but of_add_property() and
> > of_update_property() do not. As the users of these functions are pretty
> > simple, they have not hit this scenario or else the property lists
> > would get corrupted.
> 
> Suggested-by: ? :-)

Humm, by me? The change in behavior and point of this patch comes from 
me. You've provided review comments which will get covered by a
Reviewed-by I presume.

> 
> ...
> 
> > +static void __of_remove_dead_property(struct device_node *np, struct property *prop)
> > +{
> > +	struct property **next;
> > +
> > +	/* If the property is in deadprops then it must be removed */
> > +	for (next = &np->deadprops; *next; next = &(*next)->next) {
> > +		if (*next != prop)
> > +			continue;
> > +
> > +		*next = prop->next;
> > +		prop->next = NULL;
> > +		break;
> 
> Why not
> 
> 		if (*next == prop) {
> 			*next = prop->next;
> 			prop->next = NULL;
> 			break;
> 		}
> 
> which seems to me clearer?

Sure. I like the style I wrote, but whichever way ends the discussion is 
fine for me.

Rob
