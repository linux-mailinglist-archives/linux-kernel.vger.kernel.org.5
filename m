Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991287CE7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjJRThl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJRThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343211C;
        Wed, 18 Oct 2023 12:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360EAC433C9;
        Wed, 18 Oct 2023 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697657858;
        bh=Pm68nGKZCBKSAtYtKm9YziV8SShEc1H1nFdeoAO94gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hnZgJ0+9fvLqsNUG+OCTRIzD9CeR0NFZd2lwTyyB9xAS2TA21NgBqW7jyK68xv0Sq
         w4giLGKcfCjJAuS9zxYkq9nAaydQ2ewSTtxuiuubla7tFrt7c84FWjmJbAGHvqa9oW
         y2f172IJir3MkQoB6usVMqdrNzoemRgU/KPymFuV9E/IUIuLy/XWY/qXSQHveyTrXg
         F+/jvB2ToriKXXWbYeX4xjDh0+GjC5wMmrhD5Fii0pATuWO+IpgVxi8kHWiZrFiQyG
         QdpdoqAznJGjwjW5ZmmGmMW8JB0Ceuh9qJcnTd2d/SEL0Hd1rnRDNMv7uguEuLr6c/
         IziemYhBULpHQ==
Date:   Wed, 18 Oct 2023 20:37:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 2/6] device property: Add
 fwnode_property_match_property_string()
Message-ID: <20231018203755.06cb1118@jic23-huawei>
In-Reply-To: <ZS7jyHkKJcubVxws@smile.fi.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
        <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
        <20230809185944.1ae78e34@jic23-huawei>
        <ZNTlniWf8Ou9hHOT@smile.fi.intel.com>
        <20230828190101.50f70921@jic23-huawei>
        <CAJZ5v0gOXsX98jQTRSwoYmfYBfva1RHTsDaLL++m7c+kLjStVA@mail.gmail.com>
        <ZS7jyHkKJcubVxws@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 22:43:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Oct 17, 2023 at 09:19:30PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Aug 28, 2023 at 8:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
>=20
> ...
>=20
> > Sorry for the delay, I've lost track of this. =20
>=20
> NP!
>=20
> > Honestly, I have no strong opinion, but I think that this is going to
> > reduce some code duplication which is a valid purpose, so please feel
> > free to add
> >=20
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >=20
> > to this patch. =20
>=20
> Thank you!
>=20
> Jonathan, are we all set for applying this series?
>=20
Applied, but it might end up as 6.8 material depending on exactly how
timing turns out.  I have one pull request sent and I'm not sure I'll get
another one in this cycle. Given I just applied some big drivers I'd like t=
o, but
not sure yet...


Jonathan


