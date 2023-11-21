Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7A7F323A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjKUPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjKUPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:21:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAD0DD;
        Tue, 21 Nov 2023 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700580099; x=1732116099;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WijYm8vuHC5ZmFA7w1CK+dl8BooW+FtnuyTe351N948=;
  b=WtyyA6kNJIK487iSa7UupuvmGmO8r9D/q99CuTjJ9QEzhdPyiuZhWtkU
   udmB5THW4tBjcSDTDujfQYsmVY19tUX5EE9+zJpWkh+lA720Q84blYhU2
   GFef7izJl4bquPdWb8UadCdKgj48Sj73mtd6Le8SHi1xF6FqKfOIDskN6
   54PmnZ9Bude7ciL2zHKyC0Er3y7o9LIaP8JuyVBqT7avQlLJMHH8qifEX
   h7wYl/0SHFvh/t7VoHyorQrzLhYLO12GBP9tHkr9PAKoSoVEFyPuse364
   ztG3+rHwbrcz/FzGxHwgrCJINBtDwq4KHeDX0OIKQVksv8yvyT/LLN2If
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13404500"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13404500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795824207"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="795824207"
Received: from azanetti-mobl.ger.corp.intel.com ([10.249.46.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:21:35 -0800
Date:   Tue, 21 Nov 2023 17:21:32 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 14/17] tty: srmcons: use 'count' directly in
 srmcons_do_write()
In-Reply-To: <20231121092258.9334-15-jirislaby@kernel.org>
Message-ID: <4f0db52-6430-9122-1ecc-86e337644944@linux.intel.com>
References: <20231121092258.9334-1-jirislaby@kernel.org> <20231121092258.9334-15-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:

> Similarly to 'buf' in the previous patch, there is no need to have a
> separate counter ('remaining') in srmcons_do_write(). 'count' can be
> used directly which simplifies the code a bit.
> 
> Note that the type of the current count ('c') is changed from 'long' to
> 'size_t' so that:
> 1) it is prepared for the upcoming change of 'count's type, and
> 2) is unsigned.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/kernel/srmcons.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index b68c5af083cd..8025e2a882ed 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -92,24 +92,24 @@ static int
>  srmcons_do_write(struct tty_port *port, const char *buf, int count)
>  {
>  	static char str_cr[1] = "\r";
> -	long c, remaining = count;
> +	size_t c;
>  	srmcons_result result;
>  	int need_cr;
>  
> -	while (remaining > 0) {
> +	while (count > 0) {
>  		need_cr = 0;
>  		/* 
>  		 * Break it up into reasonable size chunks to allow a chance
>  		 * for input to get in
>  		 */
> -		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
> +		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
>  			if (buf[c] == '\n')
>  				need_cr = 1;
>  		
>  		while (c > 0) {
>  			result.as_long = callback_puts(0, buf, c);
>  			c -= result.bits.c;
> -			remaining -= result.bits.c;
> +			count -= result.bits.c;
>  			buf += result.bits.c;
>  
>  			/*
> 

The patches in the series are in pretty odd order and it was not told 
anywhere here that the return value is unused by the callers. I'd just 
reorder the patches.

-- 
 i.

