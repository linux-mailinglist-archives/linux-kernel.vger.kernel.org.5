Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC527DD06B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbjJaPVv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbjJaPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:21:47 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A4619B4;
        Tue, 31 Oct 2023 08:19:32 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5845b7ee438so529064eaf.1;
        Tue, 31 Oct 2023 08:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698765571; x=1699370371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5I+wv0AwpA/9AOWmahw4PTxgF8CLhlJBYtL+4HP13M=;
        b=q5lcjTaUfNRTDUUChtGFLJj0bfnqlHepZan3oHV8kVyyF73fQg1qAEo9HxcLzEMhJQ
         baYMTR463G3TiUQUavYDQmjaxBJADW128PxDvVb2vjhk/xe1jMk8MPxcGNBoHXtqfNxW
         IW50sdVMRh5IEVx7T73g1Jg6eSK6m2MnQRagBBcs9URFRrfCOqVZoGEKNcQBrERC5lmq
         Nj+IxsbG5CSnqeHFlQk7UtDSwjOPigKFUEcLhEWBXIhe2Ftt9D99VhnYoM0dWh3X5oEZ
         fKaaAIE+/HFrDA2O+UTUGNXwN0e+ZqWof6dUbSSRiWLc0/uT+lnMgUCO1WRmewaY2du2
         mIvA==
X-Gm-Message-State: AOJu0Yy2A8csQX0kRyGVZoXdsWhOEQjzCbjxJvkPjnKWiZQNR/F6QdWb
        xJOnF22yr9sFQfA+eb7rrOnPb1w1Ix3Y1bQwMUDrpq+r
X-Google-Smtp-Source: AGHT+IE6LyUsaOXfzrieA+BC3Hq2CDu5XgoUWpofSBhMa9N78AWkzjZij/4PCAITia/6mIl0Zp9EYN0mFRk83sGF5Mo=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr13046062oov.0.1698765569924; Tue, 31
 Oct 2023 08:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <2187487.irdbgypaU6@kreacher> <7609686.EvYhyI6sBW@kreacher>
 <ZUDBnEJ41tc7nnka@kekkonen.localdomain> <CAJZ5v0j_Uv=qVo6eFdz-Q7Ne7W7aTf9ThN128Ust+YEQQ9Gy+Q@mail.gmail.com>
 <ZUEIb81Bbzgvf2Uf@kekkonen.localdomain>
In-Reply-To: <ZUEIb81Bbzgvf2Uf@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Oct 2023 16:19:18 +0100
Message-ID: <CAJZ5v0ioy7n3ts9L6FQZcjngEU8qazXCdNKVXShpNL7+7hRtJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: scan: Extract MIPI DiSco for Imaging data
 into swnodes
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, Oct 31, 2023 at 3:00 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Tue, Oct 31, 2023 at 02:46:51PM +0100, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Tue, Oct 31, 2023 at 11:33 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On subject:
> > >
> > > s/DiSco/DisCo/
> >
> > Huh
> >
> > Thanks for catching this!
> >
> > > On Fri, Oct 20, 2023 at 04:39:27PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Add information extracted from the MIPI DiSco for Imaging device
> > >
> > > Ditto.
> > >
> > > > properties to software nodes created during the CSI-2 connection graph
> > > > discovery.
> > > >
> > > > Link: https://www.mipi.org/specifications/mipi-di
> > >
> > > This URL is broken. The correct URL is:
> > >
> > >         https://www.mipi.org/specifications/mipi-disco-imaging
> >
> > OK
> >
> > > > Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/acpi/internal.h |    1
> > > >  drivers/acpi/mipi-di.c  |  240 +++++++++++++++++++++++++++++++++++++++++++++++-
> > >
> > > How about mipi-disco.c? I wouldn't mind having mipi-disco-imaging.c either.
> >
> > Well, mipi-disco-imaging is a bit too long and the meaning of
> > mipi-disco would not be clear IMO.
> >
> > What about mipi-disco-img?
>
> Seems fine to me.
>
> >
> > [cut]
> >
> > > > +     ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
> > > > +     if (ret > 0) {
> > > > +             unsigned long mask;
> > > > +             unsigned int i;
> > > > +
> > > > +             /*
> > > > +              * Total number of lanes here is clock lane + data lanes.
> > > > +              * Require that number to be low enough so they all can be
> > > > +              * covered by the bits in one byte.
> > > > +              */
> > > > +             BUILD_BUG_ON(BITS_PER_TYPE(u8) <= ARRAY_SIZE(port->data_lanes));
> > > > +
> > > > +             fwnode_property_read_u8_array(port_fwnode,
> > > > +                                           "mipi-img-lane-polarities",
> > > > +                                           val, 1);
> > > > +
> > > > +             for (mask = val[0], i = 0; i < num_lanes + 1; i++)
> > > > +                     port->lane_polarities[i] = test_bit(i, &mask);
> > >
> > > This works only up to seven lanes.
> >
> > True, but then ACPI_DEVICE_CSI2_DATA_LANES is defined as 4.
>
> The spec has no limit and in practice 4 is relatively common while 8 exists
> (but is somewhat rare). I actually think it'd be a good idea to bump this
> to 8 already.

OK
