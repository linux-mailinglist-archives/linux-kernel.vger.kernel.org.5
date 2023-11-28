Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A07FB703
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjK1KUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjK1KUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:20:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5281DE6;
        Tue, 28 Nov 2023 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701166824; x=1732702824;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pRg4A/1XNn/gV9f7Su5nwFL58C3OXhlWqDX8A+9UGt8=;
  b=a7wFYM5C+9kTgry+S3j4t9yuw/8GHGyAaAL7VVystUaWxMTETzGhFf7K
   fSroiWkt4KvFK7uzdxKJeRevuImOCGqqnEXbBdxuFWjYlqgkMI0W0vUgZ
   xpbA30Zt/DoAjm6WgtL55h4cpLzXS35l79L2uGWSDmQQ1Ss7/ZaxbZPZr
   sREUO2NIOI0QXM3AQxKU5J6AZbnI7qUWeGrxJjgpxQkvmwF7SdgQ+nYAc
   JqpLVJE1Qmh3OZVaUVuNgv3t40xjM3qio6fIHJFcaKE44cixAiRTjgMhY
   NyGgn+0gJOiypDS5tg9U2rNBsfWwxkRvuEQCaE69lkwYLkZAfG4xPsT5K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383278090"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="383278090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="941868474"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="941868474"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:20:22 -0800
Date:   Tue, 28 Nov 2023 12:20:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] tty: make tty const in tty_get_baud_rate()
In-Reply-To: <20231127123713.14504-1-jirislaby@kernel.org>
Message-ID: <acdbb083-997f-b9ee-a4a8-3815c54f1f17@linux.intel.com>
References: <20231127123713.14504-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2114108693-1701166823=:1797"
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

--8323329-2114108693-1701166823=:1797
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 27 Nov 2023, Jiri Slaby (SUSE) wrote:

> After commit 87888fb9ac0c ("tty: Remove baudrate dead code & make
> ktermios params const"), the 'tty' parameter is only read in
> tty_get_baud_rate(). Therefore, we can make 'tty' accepted in the
> function 'const' for clarity.
> 
> The "the terminal bit flags may be updated." part of the
> tty_get_baud_rate()'s kernel-doc is dropped as it is no longer true.
> Because of the same commit above. And it was misplaced anyway.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  include/linux/tty.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 7625fc98fef3..e96c85f4f91e 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -440,10 +440,9 @@ void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
>   *
>   * Returns: the baud rate as an integer for this terminal
>   *
> - * Locking: The termios lock must be held by the caller and the terminal bit
> - * flags may be updated.
> + * Locking: The termios lock must be held by the caller.
>   */
> -static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
> +static inline speed_t tty_get_baud_rate(const struct tty_struct *tty)
>  {
>  	return tty_termios_baud_rate(&tty->termios);
>  }

Thanks,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2114108693-1701166823=:1797--
