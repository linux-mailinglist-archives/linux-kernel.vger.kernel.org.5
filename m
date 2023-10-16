Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527DE7CA6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPLjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:39:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDBED9;
        Mon, 16 Oct 2023 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697456369; x=1728992369;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lDcyUcRHd6gIh/r9WZ7PJipz1qSJMSm4ZlUlo62jqA8=;
  b=DZLB8C9RceCbKF2wb2VyhVJWZsdW4b94jnsEeqsDKuXnOGAgs5XHiPgE
   lGdTa2CJKXJXb3SA1p0HpNg4JyWA2TiehepZr3jSI5tnWmF5ptfLk3sqm
   cANQKDI3O0lJFU1YW1/0fyvdPZOuYTY1K/HmVfNugbr1jrSPOorqNBdEO
   6j2OYHsBEHNLDYnrBUbdenwp9GHOg8uTgKQr/8hxxZbCj0X6S90RS+ayw
   uxwTvqvpJl7923btMcMslJhpyehX3sXCQY700wLuPmpIJckrSR46zBobr
   Ue51zN0YXhdnZJ+3Z03ffPIxoWGUv1MDybXvBRnCEPcVQSPbLNheKhj3Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="7070323"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7070323"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="879402460"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="879402460"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO bhoerz-mobl1.ger.corp.intel.com) ([10.252.59.103])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:39:25 -0700
Date:   Mon, 16 Oct 2023 14:39:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH 2/3] serial: core: Make local variable size to u64
In-Reply-To: <20231014104942.856152-3-vamshigajjela@google.com>
Message-ID: <b0ec67b1-24a2-d67d-d7c1-9c3fdafdb570@linux.intel.com>
References: <20231014104942.856152-1-vamshigajjela@google.com> <20231014104942.856152-3-vamshigajjela@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023, Vamshi Gajjela wrote:

> From: VAMSHI GAJJELA <vamshigajjela@google.com>
> 
> The variable size has been changed from u32 to u64 to accommodate a
> larger range of values without the need for explicit typecasting.

Don't use too broad/generic terminology in shortlog (on [PATCH] line in 
subject) or changelog but explicitly mention the variable names please.

> Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> ---
>  drivers/tty/serial/serial_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 7bdc21d5e13b..fb4696d17a8b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -410,10 +410,10 @@ void
>  uart_update_timeout(struct uart_port *port, unsigned int cflag,
>  		    unsigned int baud)
>  {
> -	unsigned int size = tty_get_frame_size(cflag);
> +	u64 size = tty_get_frame_size(cflag);
>  	u64 frame_time;
>  
> -	frame_time = (u64)size * NSEC_PER_SEC;
> +	frame_time = size * NSEC_PER_SEC;
>  	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
>  }
>  EXPORT_SYMBOL(uart_update_timeout);

This is actually a good cleanup all by itself unrelated to the other 
change but you need to adapt the changelog to reflect why this is helpful 
instead wording it based on the other change.

-- 
 i.

