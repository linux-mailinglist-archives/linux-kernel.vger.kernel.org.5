Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9D7CA6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjJPLol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:44:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C2DC;
        Mon, 16 Oct 2023 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697456678; x=1728992678;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jhmZOMCgOQZFyiS8nyvND4T+5urSIoQvwa9vLe3IUqo=;
  b=ITK+cr033ixgnoaWjUIiFD2GF+RVGGzy6kUoWjqzStcvk4eU6wwsMsGK
   TFNE2X8LCWbiF/PBEJXJ6wjo8CtA1S7UHXRvLcZ8pnl6UHSAG2JrLSEvt
   ktWtblu2ZAjyAhD9c3qvcYqq3abXHHUduH1tOby7nOly3fmSD9jH5eMv/
   ATziqX9g8jmFDHeiNM5rgxqWssG/pb2J70DdSiGZ2HL4Zd8geOPxE9MJc
   sgxBm4J5YYqp5H7osdWtK50yfptuFOfh5RGUTlHKZ47p+EiqOrG1WhwjA
   DuJUw+QeCyAra2FbOQ1vRJNoXlmFmaYHxISMK5R6cV981fw9YX4ljxqSB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="384377867"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="384377867"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705588280"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="705588280"
Received: from rhaeussl-mobl.ger.corp.intel.com ([10.252.59.103])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:44:35 -0700
Date:   Mon, 16 Oct 2023 14:44:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH 3/3] serial: core: Update uart_poll_timeout function to
 return unsigned int
In-Reply-To: <20231014104942.856152-4-vamshigajjela@google.com>
Message-ID: <32aae753-4a3-9c1c-9e4c-95fd2da8d4@linux.intel.com>
References: <20231014104942.856152-1-vamshigajjela@google.com> <20231014104942.856152-4-vamshigajjela@google.com>
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
> uart_fifo_timeout() returns unsigned value, hence the function
> uart_poll_timeout has been modified to use an unsigned int type for
> timeout values instead of a signed int. The return type of the function
> has been changed from int to unsigned int for consistency with the type
> of timeout values. The result of uart_fifo_timeout() is cast to u32,
> indicating that the value is truncated.
> 
> Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> ---
>  include/linux/serial_core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b128513b009a..445a1ff7e502 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
>  }
>  
>  /* Base timer interval for polling */
> -static inline int uart_poll_timeout(struct uart_port *port)
> +static inline unsigned int uart_poll_timeout(struct uart_port *port)

This is in jiffies so why don't you return unsigned long instead also 
here?

>  {
> -	int timeout = uart_fifo_timeout(port);
> +	unsigned int timeout = (u32)uart_fifo_timeout(port);

Use unsigned long and avoid casting entirely?
>  
>  	return timeout > 6 ? (timeout / 2 - 2) : 1;
>  }
> 

-- 
 i.

