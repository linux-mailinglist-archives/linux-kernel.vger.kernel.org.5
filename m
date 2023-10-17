Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374427CCE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbjJQUqB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344198AbjJQTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:19:44 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F5F9;
        Tue, 17 Oct 2023 12:19:42 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-581e106fd25so127545eaf.0;
        Tue, 17 Oct 2023 12:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570381; x=1698175181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7ieEvfyHQY7ULuaED1WrfSZ5wAczggZiEh44Iol3Mg=;
        b=V6RDkGVr1oElsuHIr2MuhX2JvF0c+/qhsqHaMRUDpNlFHVozAd0AiORTjnbmfpRnsk
         lQ0u5EdS2qnNJRAQ0/BaC28klJl0CfiHNgTnPM3yRgav7VeR17MOKEVjmOIKW6i1gCvm
         9Jfxv6ZNMwCzNcJPoRG2Hgq1Ix3b5E5VCjCrYzwYsMG6euFyv/L2BSey17C6mDUlekfx
         7FLFJZMYLVirxY+BejXGH3kwMlydiZNOOK3wZhkQjlQOz30RflU1hG6OSHTbM4Jm7ijc
         nlDzMe5UM/386nzMM0W8iyRl1Jertz42GbRRVwtfo1f3RDp/4QWE0u0+tPCeToaa8Rbi
         8BGA==
X-Gm-Message-State: AOJu0YwGoZH1+SIMJHJ35CmIdUnKRzfTX1PGHrWF3i4Kq2gwYbaNvF0X
        RGDxkCWD6HybumfsOa5tYlkpmzhVX1BDubDPCv4=
X-Google-Smtp-Source: AGHT+IH7Ib+IgBHBd8TNyJMhv0EEBE9C9qmkJPLadiqejEoD18ZONUozBNi5jP6C7gdY9ygf44U13Go+m7CqCGt9u2c=
X-Received: by 2002:a4a:e60d:0:b0:57b:7e31:c12 with SMTP id
 f13-20020a4ae60d000000b0057b7e310c12mr3522279oot.1.1697570381480; Tue, 17 Oct
 2023 12:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
 <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
 <20230809185944.1ae78e34@jic23-huawei> <ZNTlniWf8Ou9hHOT@smile.fi.intel.com> <20230828190101.50f70921@jic23-huawei>
In-Reply-To: <20230828190101.50f70921@jic23-huawei>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Oct 2023 21:19:30 +0200
Message-ID: <CAJZ5v0gOXsX98jQTRSwoYmfYBfva1RHTsDaLL++m7c+kLjStVA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] device property: Add fwnode_property_match_property_string()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 8:00 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 10 Aug 2023 16:26:54 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > On Wed, Aug 09, 2023 at 06:59:44PM +0100, Jonathan Cameron wrote:
> > > On Tue,  8 Aug 2023 19:27:56 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > ...
> >
> > > > +int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
> > > > + const char *propname, const char * const *array, size_t n)
> > >
> > > Hi Andy,
> > >
> > > Whilst I'm not 100% sold on adding ever increasing complexity to what we
> > > match, this one feels like a common enough thing to be worth providing.
> >
> > Yep, that's why I considered it's good to add (and because of new comers).
> >
> > > Looking at the usecases I wonder if it would be better to pass in
> > > an unsigned int *ret which is only updated on a match?
> >
> > So the question is here are we going to match (pun intended) the prototype to
> > the device_property_match*() family of functions or to device_property_read_*()
> > one. If the latter, this has to be renamed, but then it probably will contradict
> > the semantics as we are _matching_ against something and not just _reading_
> > something.
> >
> > That said, do you agree that current implementation is (slightly) better from
> > these aspects? Anyway, look at the below.
> >
> > > That way the common properties approach of not checking the return value
> > > if we have an optional property would apply.
> > >
> > > e.g. patch 3
> >
> > Only?
> I didn't look further :)
>
> >
> > > would end up with a block that looks like:
> > >
> > >     st->input_mode = ADMV1014_IQ_MODE;
> > >     device_property_match_property_string(&spi->dev, "adi,input-mode",
> > >                                           input_mode_names,
> > >                                           ARRAY_SIZE(input_mode_names),
> > >                                           &st->input_mode);
> > >
> > > Only neat and tidy if the thing being optionally read into is an unsigned int
> > > though (otherwise you still need a local variable)
> >
> > We also can have a hybrid variant, returning in both sides
> >
> >   int device_property_match_property_string(..., size_t *index)
> >   {
> >         if (index)
> >                 *index = ret;
> >         return ret;
> >   }
> >
> > (also note the correct return type as it has to match to @n).
> >
> > Would it be still okay or too over engineered?
> >
> Probably over engineered....
>
> Lets stick to what you have.  If various firmware folk are happy with
> the new function that's fine by me.  Rafael?

Sorry for the delay, I've lost track of this.

Honestly, I have no strong opinion, but I think that this is going to
reduce some code duplication which is a valid purpose, so please feel
free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to this patch.

Thanks!
