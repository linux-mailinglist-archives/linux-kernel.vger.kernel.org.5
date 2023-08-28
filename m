Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C526578B6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjH1SBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjH1SAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328010D;
        Mon, 28 Aug 2023 11:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 965B963D91;
        Mon, 28 Aug 2023 18:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5695FC433C7;
        Mon, 28 Aug 2023 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693245644;
        bh=anTSmw6MgyMNpmqC7sR5fOUZIGW4VnZ7ptwo6QfqrwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F2kqKyUReIXbWgeBCBB0IPwXKeN+gGSKd7SxvtUnsdlacikInN2+FxRKGxDdy0v+u
         bwDxue+PcVHpJIVlXwOOjBierv35ag0lVbtPsWSOiXGBnQWN1fzUa3zqGE+U8jV9kZ
         v6HhvUlEHvpdnMnePOUioD94jG30D5RXkcHdD2f+kt47KmrVBb9TKgZoSLwuc6NQDz
         IFmmFG1ik+J2IawdrQr47pc4XN/FxbWfxgHod2iifEDS7q9C8RdLPl7rizqKwzeRN0
         wNuKqIBszTVKsTe3gyUMwV1y2CMygohiF6940p7LJ4MImSC7QncIG9VDO4IlGXvoi7
         m71sa1EOu+eBQ==
Date:   Mon, 28 Aug 2023 19:01:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 2/6] device property: Add
 fwnode_property_match_property_string()
Message-ID: <20230828190101.50f70921@jic23-huawei>
In-Reply-To: <ZNTlniWf8Ou9hHOT@smile.fi.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
        <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
        <20230809185944.1ae78e34@jic23-huawei>
        <ZNTlniWf8Ou9hHOT@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 16:26:54 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Aug 09, 2023 at 06:59:44PM +0100, Jonathan Cameron wrote:
> > On Tue,  8 Aug 2023 19:27:56 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> 
> ...
> 
> > > +int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
> > > +	const char *propname, const char * const *array, size_t n)  
> > 
> > Hi Andy,
> > 
> > Whilst I'm not 100% sold on adding ever increasing complexity to what we
> > match, this one feels like a common enough thing to be worth providing.  
> 
> Yep, that's why I considered it's good to add (and because of new comers).
> 
> > Looking at the usecases I wonder if it would be better to pass in
> > an unsigned int *ret which is only updated on a match?  
> 
> So the question is here are we going to match (pun intended) the prototype to
> the device_property_match*() family of functions or to device_property_read_*()
> one. If the latter, this has to be renamed, but then it probably will contradict
> the semantics as we are _matching_ against something and not just _reading_
> something.
> 
> That said, do you agree that current implementation is (slightly) better from
> these aspects? Anyway, look at the below.
> 
> > That way the common properties approach of not checking the return value
> > if we have an optional property would apply.
> > 
> > e.g. patch 3  
> 
> Only?
I didn't look further :)

> 
> > would end up with a block that looks like:
> > 
> > 	st->input_mode = ADMV1014_IQ_MODE;
> > 	device_property_match_property_string(&spi->dev, "adi,input-mode",
> > 					      input_mode_names,
> > 					      ARRAY_SIZE(input_mode_names),
> > 					      &st->input_mode);
> > 
> > Only neat and tidy if the thing being optionally read into is an unsigned int
> > though (otherwise you still need a local variable)  
> 
> We also can have a hybrid variant, returning in both sides
> 
>   int device_property_match_property_string(..., size_t *index)
>   {
> 	  if (index)
> 		  *index = ret;
> 	  return ret;
>   }
> 
> (also note the correct return type as it has to match to @n).
> 
> Would it be still okay or too over engineered?
> 
Probably over engineered....

Lets stick to what you have.  If various firmware folk are happy with
the new function that's fine by me.  Rafael?

Jonathan


