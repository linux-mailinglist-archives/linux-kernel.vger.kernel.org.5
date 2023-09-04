Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27FB790F65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349949AbjIDAsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349873AbjIDAsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:48:19 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A689FB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 17:48:16 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:3f:e471:aa00::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 43EDFCAC;
        Sun,  3 Sep 2023 17:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1693788496;
        bh=gM6buDzOFn/lhLf7aoB9KjFYkewAQ2BO7skcawl3/P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWCiJV4NOQSt1eF6P2b8TJ5OL/QzQjzdwWOc7u6RvelftDxcEPHlSJ8XLZPAZGibq
         /p+njEgpaOR4nNZpNqNQ2im09g0E4DON1q4+Lj9mxOTEcw49gbRnjByEiVn75V8hYn
         GBqlrdNk2c3mTHEm1YsGCw/Jlr45CzH8PHQcndLs=
Date:   Sun, 3 Sep 2023 17:48:14 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
 <2023090330-bling-mammary-3177@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023090330-bling-mammary-3177@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 06:04:23AM PDT, Greg Kroah-Hartman wrote:
>On Fri, Sep 01, 2023 at 02:13:23AM -0700, Zev Weiss wrote:
>> Adding Greg re: sysfs ABI design...
>>
>> On Thu, Aug 31, 2023 at 05:14:10AM PDT, Naresh Solanki wrote:
>> > Adds sysfs-driver-regulator-output
>> >
>> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> > ---
>> > .../ABI/testing/sysfs-driver-regulator-output         | 11 +++++++++++
>> > 1 file changed, 11 insertions(+)
>> > create mode 100644 Documentation/ABI/testing/sysfs-driver-regulator-output
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-driver-regulator-output b/Documentation/ABI/testing/sysfs-driver-regulator-output
>> > new file mode 100644
>> > index 000000000000..f9b0a8f810fa
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-driver-regulator-output
>> > @@ -0,0 +1,11 @@
>> > +What:		/sys/bus/platform/drivers/regulator-output/*/events
>> > +Date:		August 2023
>> > +Description:	Provided regulator events.
>> > +
>> > +		Read provides various events the regulator associated with the
>> > +		driver has encountered. All REGULATOR_EVENT_* are
>> > +		defined in include/uapi/linux/regulator.h
>> > +
>> > +		e.g.
>> > +		cat /sys/bus/platform/drivers/regulator-output/ssb_rssd32/events
>> > +		0x0
>>
>> If we really are going to proceed with a "read with side-effects"
>> (clear-on-read) design, that should absolutely be loudly and clearly
>> documented, since it's very different from how sysfs files typically work
>> and hence a somewhat glaring principle-of-least-surprise violation.  Also,
>> since from the code it looks like it's intended to be used via poll(2), that
>> should be described here as well.
>
>Poll?  Ick, but that can happen.
>
>But yes, reading a sysfs should almost never cause a side affect at all.
>
>But what do you mean by "clear events?"  

I mean that when the sysfs file is read, the state variable whose value 
it exposes is also cleared as a side-effect (so the read operation 
"consumes" the value it returns) -- see the implementation in patch 2 of 
this series (specifically the 'data->events = 0' assignment in 
events_show()):

https://lore.kernel.org/lkml/20230831121412.2359239-2-Naresh.Solanki@9elements.com/

(As indicated in my reply to that patch, this seems like a footgun to me 
and I'm hoping we can come up with a better approach.)


Zev

