Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8397FBB81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjK1N0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbjK1N02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:26:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1310F4;
        Tue, 28 Nov 2023 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701177991; x=1732713991;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Vfb4ahSBf4vSRtc/lP0oWViVNK0OVo/cmZbQVDvOfeI=;
  b=EAGUmJV1uS0Whw3XtnesHOSDo1eaF8aL/qAH5JX5Z48RIYPnzFlKY2NY
   B1Cljt82E8v4Ghg7d5jeg2OmOhy4s8QUGGqbAa4KcGCwx7RvsEylCwx48
   bjcC8S0gaTZY0/lKEtZH3jj02cQ3q/tBqemsjzlU65A3co9qM4tUtOkHG
   RK9xfRsygRGNBRzX+j89tZej27YCeGX3YN1iGT3ZgQZ9k33qnT2GPuRls
   KYwoYfttvoHjbZK0YmCz2YWcRHkEz+VWzHehtR0M/VV+z15tYls/QhyFI
   7r3IEJ/HwzN0+b6xnOUwSGW8CE3TpF5ntsFdkXBZCzsiF4AZzgIJ4EPwx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372296118"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="372296118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="912430861"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="912430861"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:26:06 -0800
Date:   Tue, 28 Nov 2023 15:26:03 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 3/5] tty: srmcons: use 'count' directly in
 srmcons_do_write()
In-Reply-To: <20231127123713.14504-3-jirislaby@kernel.org>
Message-ID: <c06cb71-575f-1d6b-aed-49e4bbab444@linux.intel.com>
References: <20231127123713.14504-1-jirislaby@kernel.org> <20231127123713.14504-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1536688584-1701177968=:1797"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1536688584-1701177968=:1797
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 27 Nov 2023, Jiri Slaby (SUSE) wrote:

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
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
> 
> Notes:
>     [v2] reordered so that it makes sense
> 
>  arch/alpha/kernel/srmcons.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index de896fa9829e..32bc098de7da 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -92,24 +92,24 @@ static void
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1536688584-1701177968=:1797--
