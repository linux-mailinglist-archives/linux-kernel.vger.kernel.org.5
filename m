Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCBA7C82F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJMKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:25:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31AC9;
        Fri, 13 Oct 2023 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697192701; x=1728728701;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K2rdGornxNI803mjCk+56gpA8USxtvZFxPbLLi47j8E=;
  b=nkFsIyo24imX/mLPbvs+1nYcUEgWDM66anos1chAv1I+7DSxr5OkXXsQ
   SUxhp9a3r+0hcJlg+43Vb1vvaCsDOMqcf8z0Zi+i7bgiyULPXlsi/OV3J
   X022HfSm1wvFkYe1Laz99mokvBsC2wihvJG62+rgGycmxFLHis6//qUey
   HmqrECns1wO4mavxX5UifjQQa8vn67hEWUcPZwZbphAZYUk1cjzHXBpr8
   G2RzpHn69FAk8PWF7mOxsrwnPknCUmFQ9m1YtbOCzaDv9KQyOn3YQOsJU
   WJcrF/YhLkSvot7cV38O+pp4uGuOcbqJ5myOVNutaoDMdXM9EWix1PEdR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="382379958"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="382379958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="789818023"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="789818023"
Received: from ttmerile-mobl1.ger.corp.intel.com (HELO rploss-MOBL.ger.corp.intel.com) ([10.249.37.202])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:24:57 -0700
Date:   Fri, 13 Oct 2023 13:24:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LinoSanfilippo@gmx.de, Lukas Wunner <lukas@wunner.de>,
        p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/6] serial: core: fix sanitizing check for RTS
 settings
In-Reply-To: <da9a9d10-2568-4960-b9f8-9d43cbc1b295@kunbus.com>
Message-ID: <63b62f6c-d97d-8d45-1612-968ef74b6365@linux.intel.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com> <20231011181544.7893-4-l.sanfilippo@kunbus.com> <40e4c6b1-e217-2926-a351-bf685a5b775f@linux.intel.com> <da9a9d10-2568-4960-b9f8-9d43cbc1b295@kunbus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1327546645-1697192700=:2026"
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

--8323329-1327546645-1697192700=:2026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 Oct 2023, Lino Sanfilippo wrote:
> On 12.10.23 15:10, Ilpo Järvinen wrote:
> > On Wed, 11 Oct 2023, Lino Sanfilippo wrote:
> > 
> >> Among other things uart_sanitize_serial_rs485() tests the sanity of the RTS
> >> settings in a RS485 configuration that has been passed by userspace.
> >> If RTS-on-send and RTS-after-send are both set or unset the configuration
> >> is adjusted and RTS-after-send is disabled and RTS-on-send enabled.
> >>
> >> This however makes only sense if both RTS modes are actually supported by
> >> the driver.
> >>
> >> With commit be2e2cb1d281 ("serial: Sanitize rs485_struct") the code does
> >> take the driver support into account but only checks if one of both RTS
> >> modes are supported. This may lead to the errorneous result of RTS-on-send
> >> being set even if only RTS-after-send is supported.
> >>
> >> Fix this by changing the implemented logic: First clear all unsupported
> >> flags in the RS485 configuration, then adjust an invalid RTS setting by
> >> taking into account which RTS mode is supported.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: be2e2cb1d281 ("serial: Sanitize rs485_struct")
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >> ---
> >>  drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++----------
> >>  1 file changed, 18 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> >> index 697c36dc7ec8..f4feebf8200f 100644
> >> --- a/drivers/tty/serial/serial_core.c
> >> +++ b/drivers/tty/serial/serial_core.c
> >> @@ -1370,19 +1370,27 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
> >>               return;
> >>       }
> >>
> >> +     rs485->flags &= supported_flags;
> >> +
> >>       /* Pick sane settings if the user hasn't */
> >> -     if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
> >> -         !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> >> +     if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> >>           !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
> >> -             dev_warn_ratelimited(port->dev,
> >> -                     "%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
> >> -                     port->name, port->line);
> >> -             rs485->flags |= SER_RS485_RTS_ON_SEND;
> >> -             rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> >> -             supported_flags |= SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND;
> >> -     }
> >> +             if (supported_flags & SER_RS485_RTS_ON_SEND) {
> >> +                     rs485->flags |= SER_RS485_RTS_ON_SEND;
> >> +                     rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> >>
> >> -     rs485->flags &= supported_flags;
> >> +                     dev_warn_ratelimited(port->dev,
> >> +                             "%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
> >> +                             port->name, port->line);
> >> +             } else {
> >> +                     rs485->flags |= SER_RS485_RTS_AFTER_SEND;
> >> +                     rs485->flags &= ~SER_RS485_RTS_ON_SEND;
> > 
> > So if neither of the flags is supported, what will happen? You might want
> > add if after that else?
> >
> 
> I would consider this a bug in the driver, as at least one of both modes 
> has to be supported. If the driver does not have at least one of both flags
> set in rs485_supported.flags we could print a warning though. Would you prefer that?

8250_exar.c needs to fixed then? I was taking these as things one can 
"configure" even if when there's support only for a one of them there's 
not that much to configure. As there was neither in 8250_exar's code, I 
didn't add either flag.

But I suppose your interpretation of those flag makes more sense.

-- 
 i.

--8323329-1327546645-1697192700=:2026--
