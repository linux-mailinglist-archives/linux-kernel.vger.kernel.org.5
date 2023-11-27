Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B297FA1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjK0N6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjK0Nzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:55:37 -0500
X-Greylist: delayed 256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 05:54:51 PST
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43652689;
        Mon, 27 Nov 2023 05:54:51 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 2844060505;
        Mon, 27 Nov 2023 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701093291;
        bh=EtIU+PEYgPCx3Mm2g0hJqVPScocVED+L9UPkdbOXz1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDa+yf0nu24ZFF11mlVKDcQNxjjZPmQEpyhqhHgHNjBNXQ6bjrTCAbfaVOoz9XVYe
         7NcUJewdhEbEs/TiJGYhz36LdF/qRdEKaUVbzHwDG6ISRuB00apByCCXVhYnXiKKUR
         tSF4mAZQMKb+hb1QXElHSZBd3fS5hO4gftfKEfDivEPvvEeLBCOzrLgnlHZRpQAnbH
         L1w+T8TV0Bh3G4r9iuChudd0L066qawGN4U3c2mxbsagLdbw+WFYs8V4fq9OPBisLd
         DprrwpQksmevBSGlYy7aKr/Zlp7vkhCyE8Ehdadyc1I9XUkJBkWM0NsFNB8oC/L9h/
         SYyU2Zj0R8Awg==
Date:   Mon, 27 Nov 2023 15:54:24 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com,
        =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20231127135424.GO5169@atomide.com>
References: <20231126191840.110564-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126191840.110564-1-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [231126 19:18]:
> So the main questions I see:
> - is the approach right to abandon drivers/misc/ti-st?

Yes.

> - Output at /dev/gnssX:
>   AI2 vs. NMEA
>   The chip can be configured into sending AI2-encapsulated NMEA,
>   or proving data in a binary format.
>   Some research has to be done yet for the details.
>   A pile of logs is waiting for further analysis...
> 
>   Arguments for/against NMEA:
>   + Userspace is prepared to handle it
>   + Power management can be easily done by the kernel
>   - Less functionality can be used.

I'd go with NMEA format as the default setting :)

>   Arguments for/against AI2:
>   + Full functionality can be accessed from userspace (incl. A-GPS,
>     maybe raw satellite data)
>   - Userspace has to behave to have proper power management
>   - No freely (not even as in beer) tool available to fully use AI2,
>     so there will be only a real advantage after long "French Cafe"
>     sessions.

Seems AI2 could be optionally enabled as needed with some writes
to /dev/gnss0 to change the mode?

Regards,

Tony
