Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3407D9128
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjJ0IU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJ0IT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:19:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40301198E;
        Fri, 27 Oct 2023 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698394775; x=1729930775;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GvOmoSKLCYIyNBraTNtw+qJ6Ly1A3iWfsq0xxWrPRPc=;
  b=Xj9Jo5mxRDTXbFlD8p8fqbu8qDyGDmGQbnZC3QbrU2+7QHyVVD/SQsi7
   QaqfUeLV2Y9d0r0ZRlbiHE7ewq7bppdpajiJVGjfwZME4CDU5v8kEruCX
   ULtAsk8UWKT7PGYSqr6edgKrJV+j4cmT/5frqYL0knu08nWepf2B2o6vk
   3Uz5F9mAUH+TieGrzT6jpdh7k1UV0pQZZuliu+xJt4G43DDi2KBn8/ndq
   8czrTQ3sSkQZ0cXV+C5jnwIozrGRJOriOa1f7+JmXY1IYKsi43zp7qW+u
   fD8mn4HR95Zg7o53g8+c0hCUGaxc0CcCdzkHrStLlrxLGSFcAVWW8z49a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="454196083"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="454196083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="850167915"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="850167915"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:19:32 -0700
Date:   Fri, 27 Oct 2023 11:19:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Vamshi Gajjela <vamshigajjela@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
In-Reply-To: <2023102712-frolic-bush-3d67@gregkh>
Message-ID: <f4358da2-af4-189a-eb93-3e82404c72eb@linux.intel.com>
References: <20231026135628.2800617-1-vamshigajjela@google.com> <2023102712-frolic-bush-3d67@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023, Greg Kroah-Hartman wrote:

> On Thu, Oct 26, 2023 at 07:26:28PM +0530, Vamshi Gajjela wrote:
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> 
> Please use lower case letters like I think you mean to?
> 
> Also, where are patches 1/3 and 2/3 of this series?  I can't do anything
> without them as well.
> 
> > The function uart_fifo_timeout() returns an unsigned long value, which
> > is the number of jiffies. Therefore, change the variable timeout in the
> > function uart_poll_timeout() from int to unsigned long.
> > Change the return type of the function uart_poll_timeout() from int to
> > unsigned long to be consistent with the type of timeout values.
> > 
> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> > v3:
> > - updated description
> > v2:
> > - unsigned long instead of unsigned int
> > - added () after function name in short log
> > - updated description
> > 
> >  include/linux/serial_core.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index bb6f073bc159..6916a1d7e477 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
> >  }
> >  
> >  /* Base timer interval for polling */
> > -static inline int uart_poll_timeout(struct uart_port *port)
> > +static inline unsigned long uart_poll_timeout(struct uart_port *port)
> >  {
> > -	int timeout = uart_fifo_timeout(port);
> > +	unsigned long timeout = uart_fifo_timeout(port);
> >  
> >  	return timeout > 6 ? (timeout / 2 - 2) : 1;
> 
> So we are now doing 64bit math?  Did that just make things slower?

That divide with a constant 2 though so I'd expect compiler to turn it 
into a shift.

> What bug is this actually fixing?  How have you tested this to verify it
> works?

AFAIK this doesn't fix anything because emptying when measured in jiffies
isn't that big number. It's just about making the types more consistent.

-- 
 i.

