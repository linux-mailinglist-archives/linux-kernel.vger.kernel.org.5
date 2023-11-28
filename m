Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9F7FBB84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjK1N04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbjK1N0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:26:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4DDA;
        Tue, 28 Nov 2023 05:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701178009; x=1732714009;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tLbRwq2xR2Tx+fbyLv9fv7ObAEEUF1xBEik8fPi4U0E=;
  b=CYfPrrrUCOu1dfvpzGMnee3jTZEluWMTvSaMkTHWhuIqqgqX8wXt53ou
   psKh/RY2Yy0DnLGzKxyUw5730hKWqOxuN0bVQ0EM4WQLtlI+fILTLqaDb
   3k1AvWAr29Nr4/ZnEMhF4Vk7LBmTcUnMuqN1rUFpfEBdt0s2A8RkhW0G+
   RNQ9x2dJvPF6M8FmdU2OlpQ6JACRSe+arqHgaXsKTnYtpxZWpQqEDNJqq
   W+PiBTWRVMXgnSlo42tFk2RU/S58BtVwzXE2EmQ5aHTV83dcU6i6la5Zg
   1NGEek0U7NEDz5Th+Lp+cZQeGYTA3A2x5/3CvVcjHxEua2PjTOXxCbxTV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372296191"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="372296191"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:26:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="912430966"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="912430966"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:26:22 -0800
Date:   Tue, 28 Nov 2023 15:26:20 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 5/5] tty: srmcons: remove 'str_cr' and use string
 directly
In-Reply-To: <20231127123713.14504-5-jirislaby@kernel.org>
Message-ID: <c15efeb7-9b72-dd5c-df94-5d36f37aa1fd@linux.intel.com>
References: <20231127123713.14504-1-jirislaby@kernel.org> <20231127123713.14504-5-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-240685859-1701177984=:1797"
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

--8323329-240685859-1701177984=:1797
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 27 Nov 2023, Jiri Slaby (SUSE) wrote:

> 'str_cr' contains a single character: \r. There is no need to declare it
> as array. Instead, pass the character (as a string) to callback_puts()
> directly. This ensures the string is in proper .rodata (const) section
> and makes the code more obvious.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
> 
> Notes:
>     [v2]
>       pass "\r" directly to callback_puts() as Richard suggests
>       spell correct \r in the commit log as Ilpo noticed
> 
>  arch/alpha/kernel/srmcons.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index c6b821afbfd3..42deea53beab 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -91,7 +91,6 @@ srmcons_receive_chars(struct timer_list *t)
>  static void
>  srmcons_do_write(struct tty_port *port, const char *buf, int count)
>  {
> -	static char str_cr[1] = "\r";
>  	size_t c;
>  	srmcons_result result;
>  
> @@ -119,7 +118,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
>  		}
>  
>  		while (need_cr) {
> -			result.as_long = callback_puts(0, str_cr, 1);
> +			result.as_long = callback_puts(0, "\r", 1);
>  			if (result.bits.c > 0)
>  				need_cr = false;
>  		}
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-240685859-1701177984=:1797--
