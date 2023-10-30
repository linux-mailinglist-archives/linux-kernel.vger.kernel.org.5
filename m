Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8F7DB618
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjJ3JZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjJ3JZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:25:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC79EA;
        Mon, 30 Oct 2023 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698657942; x=1730193942;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wTMbD+Y3gUCGRghE6+820yKHgUukE/w0guWwpnRSIoo=;
  b=BDqKdv2oCsjhXEcKyWweyQW77xniZj/c+3NnW5ezZnI/P9ajEwNu/TEA
   MzjSaBILxArq5+zI2uPwarRGouVXle0wKxi/P19hpTvy9yV0S7k8St/8m
   UYgewTzxTMWv64JOMHuIiwgIFE8vw8OJnNUtzoi49hmiVnH/xCfAfRPXX
   Qr/X9WhEHNA+/g1c+ekKvwtM8eimkuGs09AQhO/DFYwz7sj9lf+0ikWX3
   t1DMRWzetbc4O3VQGNIfFh/jXT0u30L/EJA/sFx0IBAgN8plMxJS9iX3b
   sLXX45xv+/emFXzN4Qj1lrdcF77+wevExyXWdiKABxjI9jj3AMgIOuH07
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="367386344"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367386344"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="830632658"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="830632658"
Received: from sgruszka-mobl.ger.corp.intel.com ([10.252.50.181])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:25:39 -0700
Date:   Mon, 30 Oct 2023 11:25:37 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v5 1/2] serial: core: Update uart_poll_timeout() function
 to return unsigned long
In-Reply-To: <20231030073542.251281-2-vamshigajjela@google.com>
Message-ID: <2ed2249-d4ce-410-17d1-b78be4a3a643@linux.intel.com>
References: <20231030073542.251281-1-vamshigajjela@google.com> <20231030073542.251281-2-vamshigajjela@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1516915826-1698657941=:1729"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1516915826-1698657941=:1729
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 30 Oct 2023, Vamshi Gajjela wrote:

> The function uart_fifo_timeout() returns an unsigned long value, which
> is the number of jiffies. Therefore, change the variable timeout in the
> function uart_poll_timeout() from int to unsigned long.
> Change the return type of the function uart_poll_timeout() from int to
> unsigned long to be consistent with the type of timeout values.
> 
> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> ---
> v5:
> - no change. Consistent version for series
> v4:
> - author name in capitals to lowercase
> v3:
> - updated description
> v2:
> - unsigned long instead of unsigned int
> - added () after function name in short log
> - updated description
> 
>  include/linux/serial_core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index bb6f073bc159..6916a1d7e477 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
>  }
>  
>  /* Base timer interval for polling */
> -static inline int uart_poll_timeout(struct uart_port *port)
> +static inline unsigned long uart_poll_timeout(struct uart_port *port)
>  {
> -	int timeout = uart_fifo_timeout(port);
> +	unsigned long timeout = uart_fifo_timeout(port);
>  
>  	return timeout > 6 ? (timeout / 2 - 2) : 1;
>  }
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1516915826-1698657941=:1729--
