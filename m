Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4617CA631
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJPLAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:00:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01395;
        Mon, 16 Oct 2023 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697454004; x=1728990004;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=PtndQi/QytZHbwFmFHdXFZNztB3a0L0kKYcNcHVcZiI=;
  b=FnCKCvtMila7D3UfJvQtuK0XGVxoh52TBpizYoc8xQy/VpWJ0tdVjdwx
   dfMshx9UGHpZL184J8PNekdNu/sJrO6rv7ZqPIX4tMvrJ+GicBDgpU3Yy
   I8JpgRYfNEmzRChxSksYCqcec5VfgEIKIetEH4GISsLz20oKDZcoRs4Ta
   gDteLZnh3Fn34EUeldcJlGRCnB6du02cmERSxzdkq+UKlXxu51rS2Ssnl
   8rGZvtUsWXNWyIvInNmUTbTM0NpQCq6WIkRL44m3B6bFjO5bj871C+CP2
   Bpy8K/h9/YkrpXmRBUBonZ6aEai0iOrXFa0e48cJx8kAbSNgxvTNOApLH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382721513"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="382721513"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:00:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="732259471"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="732259471"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:00:00 -0700
Date:   Mon, 16 Oct 2023 13:59:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/3] serial: core: Potential overflow of frame_time
In-Reply-To: <0d5f9af2-22ac-4753-8c5a-76c4d44dcc9c@kernel.org>
Message-ID: <7d5493f0-b9a6-5ddc-75a-9add2eb75a24@linux.intel.com>
References: <20231014181333.2579530-1-vamshigajjela@google.com> <0d5f9af2-22ac-4753-8c5a-76c4d44dcc9c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1949934536-1697452583=:1986"
Content-ID: <e97780b3-f194-196e-e8ac-5ea152bc7dc8@linux.intel.com>
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

--8323329-1949934536-1697452583=:1986
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c618a5f4-cfff-18fb-d829-c3782d6f8c16@linux.intel.com>

On Mon, 16 Oct 2023, Jiri Slaby wrote:

> On 14. 10. 23, 20:13, Vamshi Gajjela wrote:
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> > 
> > uart_update_timeout() sets a u64 value to an unsigned int frame_time.
> > While it can be cast to u32 before assignment, there's a specific case
> > where frame_time is cast to u64. Since frame_time consistently
> > participates in u64 arithmetic, its data type is converted to u64 to
> > eliminate the need for explicit casting.
> 
> And make the divisions by the order of magnutude slower for no good reason?
> (Hint: have you looked what DIV64_U64_ROUND_UP() looks like on 32bit yet?)
> 
> Unless you provide a reason it can overflow in real (in fact you spell the
> opposite in the text above):
> NACKED-by: Jiri Slaby <jirislaby@kernel.org>

I sorry but I have to concur Jiri heavily here,

NACKED-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> > v2:
> > - use DIV64_U64_ROUND_UP with frame_time

Please, I barely managed to read your v1 and it's v2 already, don't send 
the next version this soon. There's absolutely no need to fill our inboxes 
with n versions of your patch over a weekend, just remain patient 
and wait reasonable amount of time to gather feedback, please. ...I know 
it's often hard to wait, it's hard for me too at times.

You even failed to convert the other divide done on ->frame_time to 
DIV64_u64_ROUND_UP(), which looks a mindboggling oversight to me.
So far you've managed to cause so many problems with these two attempts to 
fix a non-problem I heavily suggest you focus on something that doesn't 
relate to fixing types. It takes time to understand the related code when 
doing something as simple as type change, which you clearly did not have 
as demonstrated by you missing that other divide which can be trivially 
found with git grep.

> > 
> >   drivers/tty/serial/8250/8250_port.c | 2 +-
> >   include/linux/serial_core.h         | 4 ++--
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c
> > b/drivers/tty/serial/8250/8250_port.c
> > index 141627370aab..d1bf794498c4 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
> >   			 * rather than after it is fully sent.
> >   			 * Roughly estimate 1 extra bit here with / 7.
> >   			 */
> > -			stop_delay = p->port.frame_time +
> > DIV_ROUND_UP(p->port.frame_time, 7);
> > +			stop_delay = p->port.frame_time +
> > DIV64_U64_ROUND_UP(p->port.frame_time, 7);
> >   		}
> >     		__stop_tx_rs485(p, stop_delay);
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index bb6f073bc159..b128513b009a 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -558,7 +558,7 @@ struct uart_port {
> >     	bool			hw_stopped;		/* sw-assisted CTS
> > flow state */
> >   	unsigned int		mctrl;			/* current modem ctrl
> > settings */
> > -	unsigned int		frame_time;		/* frame timing in ns
> > */
> > +	unsigned long		frame_time;		/* frame timing in ns
> > */

As with v1, u64 != unsigned long, I hope you do know that much about 
different architectures...

-- 
 i.

> >   	unsigned int		type;			/* port type */
> >   	const struct uart_ops	*ops;
> >   	unsigned int		custom_divisor;
> > @@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *port,
> > unsigned int baud);
> >    */
> >   static inline unsigned long uart_fifo_timeout(struct uart_port *port)
> >   {
> > -	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
> > +	u64 fifo_timeout = READ_ONCE(port->frame_time) * port->fifosize;
> >     	/* Add .02 seconds of slop */
> >   	fifo_timeout += 20 * NSEC_PER_MSEC;
> 
> 
--8323329-1949934536-1697452583=:1986--
