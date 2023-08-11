Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FBC77897F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjHKJLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjHKJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:11:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600CC211C;
        Fri, 11 Aug 2023 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691745106; x=1723281106;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PIyYb86jQXoQP2Kws+Hf7GsK88ApYcG7AUxYkztV4RA=;
  b=Rpvf8T85ErzkkX3r49O9oxwwiy8OPbW9zCxGgKmh9QXuJj8JeEw5zfGw
   zPfqT3UoeLp1WqSs+60fGTRly+Uwa15Pdxqke9gwAwkdn50IVaJqHruWS
   TdJ7oHDvANMycUYzv1/etboQonHYHw5QAuhGCILAR18oixdHX/Se+o19S
   ov74xQ0Gh/uZJvsGyNbabnK/ckP5j7rKJ+O8aDTsktdnqV88liKHJzJe+
   IvH5rJnWWOevg1y56c64KM+DeISUSSYr2MuyhT6Li3F6ERK7pMoEG5ctQ
   HdidNwG+J8DdNbRhxFNkzV0vxHLSeMuCuPlHfYb9XZRuLhvVJPBomjYb+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369105993"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369105993"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="732603755"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="732603755"
Received: from aberko-mobl1.ger.corp.intel.com ([10.252.51.87])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:11:41 -0700
Date:   Fri, 11 Aug 2023 12:11:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 34-and-three-quarters/36] tty: gdm724x: simplify
 gdm_tty_write()
In-Reply-To: <20230810103900.19353-1-jirislaby@kernel.org>
Message-ID: <8df438f1-354a-7e2c-53c5-872f32c56a7@linux.intel.com>
References: <ba8becf4-786a-4923-92f7-b4ec3038295f@kadam.mountain> <20230810103900.19353-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-213125295-1691745104=:1742"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-213125295-1691745104=:1742
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 10 Aug 2023, Jiri Slaby (SUSE) wrote:

> len and remain can never be negative in gdm_tty_write(). So remove such
> a check and move the check of remaining bytes to the loop condition.
> This way, the preceding 'if' is now superfluous too. Fix all that and
> make the code cleaner.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

I guess Suggested-by would be more appropriate since there's no problem 
being fixed here.

> Cc: linux-staging@lists.linux.dev

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.



> ---
>  drivers/staging/gdm724x/gdm_tty.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index cbaaa8fa7474..67d9bf41e836 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -158,10 +158,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  	if (!gdm_tty_ready(gdm))
>  		return -ENODEV;
>  
> -	if (!len)
> -		return 0;
> -
> -	while (1) {
> +	while (remain) {
>  		size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
>  		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
>  					(void *)(buf + sent_len),
> @@ -171,8 +168,6 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  					gdm);
>  		sent_len += sending_len;
>  		remain -= sending_len;
> -		if (remain <= 0)
> -			break;
>  	}
>  
>  	return len;
> 
--8323329-213125295-1691745104=:1742--
