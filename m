Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F37FBB77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjK1N0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbjK1NZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:25:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FE10CC;
        Tue, 28 Nov 2023 05:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701177949; x=1732713949;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JebVHIZOVrZtED//8vf5RQo5zIQOxwFIKkNo/h+jdwc=;
  b=K+GVxWEjOlZ2Oa4Wv/wXk2YT//Hk/r0XVMs6vaSc5YnWUGIgxJWegSrb
   k2Lvo4ap5O5TlNRn/mtsvq8tITF2b7r/jmms9e3TCLoBYcWZTET1GQs/A
   Ldw4nHc1LA6cVBXqgvea+medvW42wJoLqYDoxAmz3YizhRsv1ooVrEE5h
   H2+/TqF0VSRo362BnM+M1m2vnlX3YHJmQXX5fxpTnOV1WFH6sYLqwLcyt
   0QwiPJ7UNxlMgEshlVzBshnynft3FeQZSnbjIOnT5XyMUZIF6INHOTTGs
   TMf8qeFdYwjVTJqKkxOUn5FnrRK/jH8xT+77fXB7ixuTd846MqnaUs68F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="424073526"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="424073526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="768527100"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="768527100"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:25:46 -0800
Date:   Tue, 28 Nov 2023 15:25:43 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 4/5] tty: srmcons: switch need_cr to bool
In-Reply-To: <20231127123713.14504-4-jirislaby@kernel.org>
Message-ID: <abd0deda-cec1-d089-e2e-67dcb780ff83@linux.intel.com>
References: <20231127123713.14504-1-jirislaby@kernel.org> <20231127123713.14504-4-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2110396918-1701177948=:1797"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2110396918-1701177948=:1797
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 27 Nov 2023, Jiri Slaby (SUSE) wrote:

> 'need_cr' is a flag, so type it properly to be a 'bool'. Move the
> declaration into the loop too. That ensures the variable is initialized
> properly even if the code was moved somehow.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/kernel/srmcons.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index 32bc098de7da..c6b821afbfd3 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -94,17 +94,16 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
>  	static char str_cr[1] = "\r";
>  	size_t c;
>  	srmcons_result result;
> -	int need_cr;
>  
>  	while (count > 0) {
> -		need_cr = 0;
> +		bool need_cr = false;
>  		/* 
>  		 * Break it up into reasonable size chunks to allow a chance
>  		 * for input to get in
>  		 */
>  		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
>  			if (buf[c] == '\n')
> -				need_cr = 1;
> +				need_cr = true;
>  		
>  		while (c > 0) {
>  			result.as_long = callback_puts(0, buf, c);
> @@ -122,7 +121,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
>  		while (need_cr) {
>  			result.as_long = callback_puts(0, str_cr, 1);
>  			if (result.bits.c > 0)
> -				need_cr = 0;
> +				need_cr = false;
>  		}
>  	}
>  }
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2110396918-1701177948=:1797--
