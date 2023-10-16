Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2357CA4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjJPKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJPKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:05:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EFAC;
        Mon, 16 Oct 2023 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697450748; x=1728986748;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0Sr8jONeB/iwXa7yLiDNjBaWW6JJ+LVwSwU2BiigDKM=;
  b=BznR9sOeygkGhQcCBbca03ald54lpFvmkM78paGW6Ikf1VP8UMiPcSgk
   TJ1O1pAhQvsz4lsJQrQC5BcQFTguJWtRcrImF7mgeN4wG8zlvu54mRs2P
   40fFE1oZj0jmNrDDCH+CivhHlZl+9INrJ7SFIJeDC9DRs2yM4sIHdyes+
   a9cXE+7/pCNUDgm0onP0uqstCLx28MwkLRkzwHYqpWmdzPTCjt/bvo8dT
   CrJzP+BEQSrcGWYkKoQ1gwFTs/IlvD34hetuxBIOc/FZcbr9shGDzYiYm
   6YVj/4qkBRTyD1/lVhRvjzITDcAGUv9OOBCU5JR9sef7CeP36SD0eqpgo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365748639"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="365748639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 03:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="846338695"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="846338695"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO bhoerz-mobl1.ger.corp.intel.com) ([10.252.59.103])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 03:05:42 -0700
Date:   Mon, 16 Oct 2023 13:05:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 3/6] serial: core: fix sanitizing check for RTS
 settings
In-Reply-To: <b06c2fcd-02c0-464b-a7e8-4dfbf9e2befc@gmx.de>
Message-ID: <fe473887-3aa0-9a32-53d2-a39ce5247ccb@linux.intel.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com> <20231011181544.7893-4-l.sanfilippo@kunbus.com> <40e4c6b1-e217-2926-a351-bf685a5b775f@linux.intel.com> <da9a9d10-2568-4960-b9f8-9d43cbc1b295@kunbus.com> <63b62f6c-d97d-8d45-1612-968ef74b6365@linux.intel.com>
 <b06c2fcd-02c0-464b-a7e8-4dfbf9e2befc@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1860581932-1697450746=:1986"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1860581932-1697450746=:1986
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 14 Oct 2023, Lino Sanfilippo wrote:
> On 13.10.23 12:24, Ilpo Järvinen wrote:
> > On Thu, 12 Oct 2023, Lino Sanfilippo wrote:
> >> On 12.10.23 15:10, Ilpo Järvinen wrote:
> >>> On Wed, 11 Oct 2023, Lino Sanfilippo wrote:
> >>>
> >>>> Among other things uart_sanitize_serial_rs485() tests the sanity of the RTS
> >>>> settings in a RS485 configuration that has been passed by userspace.
> >>>> If RTS-on-send and RTS-after-send are both set or unset the configuration
> >>>> is adjusted and RTS-after-send is disabled and RTS-on-send enabled.
> >>>>
> >>>> This however makes only sense if both RTS modes are actually supported by
> >>>> the driver.
> >>>>
> >>>> With commit be2e2cb1d281 ("serial: Sanitize rs485_struct") the code does
> >>>> take the driver support into account but only checks if one of both RTS
> >>>> modes are supported. This may lead to the errorneous result of RTS-on-send
> >>>> being set even if only RTS-after-send is supported.
> >>>>
> >>>> Fix this by changing the implemented logic: First clear all unsupported
> >>>> flags in the RS485 configuration, then adjust an invalid RTS setting by
> >>>> taking into account which RTS mode is supported.
> >>>>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: be2e2cb1d281 ("serial: Sanitize rs485_struct")
> >>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>>> ---
> >>>>  drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++----------
> >>>>  1 file changed, 18 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> >>>> index 697c36dc7ec8..f4feebf8200f 100644
> >>>> --- a/drivers/tty/serial/serial_core.c
> >>>> +++ b/drivers/tty/serial/serial_core.c
> >>>> @@ -1370,19 +1370,27 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
> >>>>               return;
> >>>>       }
> >>>>
> >>>> +     rs485->flags &= supported_flags;
> >>>> +
> >>>>       /* Pick sane settings if the user hasn't */
> >>>> -     if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
> >>>> -         !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> >>>> +     if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> >>>>           !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
> >>>> -             dev_warn_ratelimited(port->dev,
> >>>> -                     "%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
> >>>> -                     port->name, port->line);
> >>>> -             rs485->flags |= SER_RS485_RTS_ON_SEND;
> >>>> -             rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> >>>> -             supported_flags |= SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND;
> >>>> -     }
> >>>> +             if (supported_flags & SER_RS485_RTS_ON_SEND) {
> >>>> +                     rs485->flags |= SER_RS485_RTS_ON_SEND;
> >>>> +                     rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> >>>>
> >>>> -     rs485->flags &= supported_flags;
> >>>> +                     dev_warn_ratelimited(port->dev,
> >>>> +                             "%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
> >>>> +                             port->name, port->line);
> >>>> +             } else {
> >>>> +                     rs485->flags |= SER_RS485_RTS_AFTER_SEND;
> >>>> +                     rs485->flags &= ~SER_RS485_RTS_ON_SEND;
> >>>
> >>> So if neither of the flags is supported, what will happen? You might want
> >>> add if after that else?
> >>>
> >>
> >> I would consider this a bug in the driver, as at least one of both modes
> >> has to be supported. If the driver does not have at least one of both flags
> >> set in rs485_supported.flags we could print a warning though. Would you prefer that?
> >
> > 8250_exar.c needs to fixed then?
> I was taking these as things one can
> > "configure" even if when there's support only for a one of them there's
> > not that much to configure. As there was neither in 8250_exar's code, I
> > didn't add either flag.
> 
> > But I suppose your interpretation of those flag makes more sense.
> 
> IMHO this is consistent with what we have in uart_get_rs485_mode(). This function
> ensures that we have at least one RTS mode set (with default to RTS_ON_SEND). So
> concerning 8250_exar.c, I think it should be fixed (havent noticed the missing
> RTS mode though until you mentioned it). Would you like to provide a fix for this
> or shall I include one into the next version of this series?

Just create that fix yourself thank you and include it into your series, 
I'm busy with other stuff currently.


-- 
 i.

--8323329-1860581932-1697450746=:1986--
