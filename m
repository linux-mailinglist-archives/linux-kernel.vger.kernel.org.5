Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2177D0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjHORZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjHORYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072701BEA;
        Tue, 15 Aug 2023 10:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D99C165E1A;
        Tue, 15 Aug 2023 17:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F1EC433C8;
        Tue, 15 Aug 2023 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692120169;
        bh=7O9FdqMiLm40fpPG8sUMe1FLvmeqL8CETydj3KFafrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATni7ZcWLK7LxKF2dqg/BcRGt2/E1l6M1qW78YiYhEygtMnZ8xUpdOngoWuoiBLyz
         giTI+h7KBgFTnN6wk+pwbkqcR8RaBraeiDH/vW/XOBGv2X+jyf2HzWfP4BixMAmgQG
         vvx5UTJtNAsNC8G00Y4sNWHJYu8Z5wfLymHFwGLBKdUi0XqXe9JvsvbVVDDgHqIgmW
         dMZc3ychRFhcIw6TfRBpoIi/KcjP5/tKHYQ5sPDKzsfAqUTj8W4RzgVnM5ybRxXbTb
         IGC73JEQSvrLS5tySj3z3OlNVm7PKsFCYRcTLfNS/Gf72UgoSz/sE2h/vR8LwwJwX6
         /PNngo4A8tGIQ==
Date:   Tue, 15 Aug 2023 10:22:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Message-ID: <20230815172247.GA1690054@dev-arch.thelio-3990X>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-35-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-35-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:15:08AM +0200, Jiri Slaby (SUSE) wrote:
> Unify the type of tty_operations::write() counters with the 'count'
> parameter. I.e. use size_t for them.
> 
> This includes changing constants to UL to keep min() and avoid min_t().

This patch appears to cause a warning/error on 32-bit architectures now
due to this part of the change, as size_t is 'unsigned int' there:

  In file included from include/linux/kernel.h:27,
                   from drivers/staging/gdm724x/gdm_tty.c:6:
  drivers/staging/gdm724x/gdm_tty.c: In function 'gdm_tty_write':
  include/linux/minmax.h:21:35: error: comparison of distinct pointer types lacks a cast [-Werror]
     21 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
        |                                   ^~
  include/linux/minmax.h:27:18: note: in expansion of macro '__typecheck'
     27 |                 (__typecheck(x, y) && __no_side_effects(x, y))
        |                  ^~~~~~~~~~~
  include/linux/minmax.h:37:31: note: in expansion of macro '__safe_cmp'
     37 |         __builtin_choose_expr(__safe_cmp(x, y), \
        |                               ^~~~~~~~~~
  include/linux/minmax.h:68:25: note: in expansion of macro '__careful_cmp'
     68 | #define min(x, y)       __careful_cmp(x, y, <)
        |                         ^~~~~~~~~~~~~
  drivers/staging/gdm724x/gdm_tty.c:162:38: note: in expansion of macro 'min'
    162 |                 size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
        |                                      ^~~
  cc1: all warnings being treated as errors

> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: linux-staging@lists.linux.dev
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index b31f2afb0286..cbaaa8fa7474 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -17,9 +17,9 @@
>  #define GDM_TTY_MAJOR 0
>  #define GDM_TTY_MINOR 32
>  
> -#define WRITE_SIZE 2048
> +#define WRITE_SIZE 2048UL
>  
> -#define MUX_TX_MAX_SIZE 2048
> +#define MUX_TX_MAX_SIZE 2048UL
>  
>  static inline bool gdm_tty_ready(struct gdm *gdm)
>  {
> @@ -152,9 +152,8 @@ static void gdm_tty_send_complete(void *arg)
>  static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  {
>  	struct gdm *gdm = tty->driver_data;
> -	int remain = len;
> -	int sent_len = 0;
> -	int sending_len = 0;
> +	size_t remain = len;
> +	size_t sent_len = 0;
>  
>  	if (!gdm_tty_ready(gdm))
>  		return -ENODEV;
> @@ -163,7 +162,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  		return 0;
>  
>  	while (1) {
> -		sending_len = min(MUX_TX_MAX_SIZE, remain);
> +		size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
>  		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
>  					(void *)(buf + sent_len),
>  					sending_len,
> -- 
> 2.41.0
> 
