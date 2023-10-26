Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657637D7F82
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbjJZJYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344604AbjJZJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:24:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CD186;
        Thu, 26 Oct 2023 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698312252; x=1729848252;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GGySThur3nUH9Awz6sOfRFHEp8xnVhd1i4pIzCt+ZwQ=;
  b=mDIahvmqtnrXO6s1dcTbJKAgwF8ZR2UHq3EAykLlgmaj5t26QSUp7jjk
   IReMauaan5bzdZw4kHEnDe3+2rfr4SblIXZ/4GAsgjoj2QFiM+60tx+bE
   KAGAHzXvBoNXGt2GygEtQHktwq50Im0Mzx7BfaimURJXVibjx5VQceThw
   YHAPhmCMNScs9hHTTcSyGClHIQU2O8GZl9PhG3BbNcboa1xIjLW1Nwkmy
   PXiBIryoFcKUtjkkiG3/Yg75Rv0+InDNfk6KPKsOGBStix7xRO/FlHIP5
   nli/7Irhbj2FKl6rJnXUjZH+/fCmbBFQOBunQrVHulnWbwt/BLR7oTO3v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="6118576"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="6118576"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090538040"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1090538040"
Received: from weissenb-mobl1.ger.corp.intel.com ([10.252.32.65])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:24:09 -0700
Date:   Thu, 26 Oct 2023 12:24:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Vamshi Gajjela <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v2 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
In-Reply-To: <7e7eb495-8e54-49f3-bab7-0de72b2cf7b6@kernel.org>
Message-ID: <b86df0e0-ba54-232-1854-bf3d1cbbe479@linux.intel.com>
References: <20231025142609.2869769-1-vamshigajjela@google.com> <7e7eb495-8e54-49f3-bab7-0de72b2cf7b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023, Jiri Slaby wrote:

> On 25. 10. 23, 16:26, Vamshi Gajjela wrote:
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> > 
> > The function uart_fifo_timeout() returns an unsigned long value, which is
> > the number of jiffies. Therefore, the function uart_poll_timeout() has been
> > modified to use an unsigned long type for timeout values instead of an int
> > and to avoid truncation.
> 
> Hi,
> 
> there is no truncation possible, right?

That's very likely true (I didn't run the calculations), thus it's correct 
to not have Fixes tag. It's more about having consistent typing since 
we're talking about jiffies, so unsigned long as usual.

> > The return type of the function uart_poll_timeout() has also been changed
> > from int to unsigned long to be consistent with the type of timeout values.

Don't write changes you make in the patch in the past tense. Just say:

Change the return type of uart_poll_timeout() from ...

The comment also applies to the other sentence above this one.

-- 
 i.

> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> > v2:
> > - unsigned long instead of unsigned int
> > - added () after function name in short log
> > - updated description
> >   include/linux/serial_core.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index bb6f073bc159..6916a1d7e477 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct
> > uart_port *port)
> >   }
> >     /* Base timer interval for polling */
> > -static inline int uart_poll_timeout(struct uart_port *port)
> > +static inline unsigned long uart_poll_timeout(struct uart_port *port)
> >   {
> > -	int timeout = uart_fifo_timeout(port);
> > +	unsigned long timeout = uart_fifo_timeout(port);
> >     	return timeout > 6 ? (timeout / 2 - 2) : 1;
> >   }
> 
> 
