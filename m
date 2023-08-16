Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3857777E75D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbjHPROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345160AbjHPRNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:13:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98CE52;
        Wed, 16 Aug 2023 10:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0205F62232;
        Wed, 16 Aug 2023 17:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EACAC433C7;
        Wed, 16 Aug 2023 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692206020;
        bh=p24LV4d/PSjicOA4bNsxeM8KTvX0pE92+j4eepvZU6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qu2vRBDXS+n1XINFh040FrwUvC+/M1w4Ul37EH8D4Lxl2Gi6UQ1SQiguVYF7Z0r2Z
         uc+++yqVHTXSQUmB7vSfNX0Bw5mZKxOzqsNGx5em2wZuptyW0No6g8XWYwgUn2TBnD
         ifY2sqCRNYVkuKEE0rtcZWvhd0tRqKc6biOcQp9Bh63UzO2cjLSLSefAX60lmFMYPo
         NS8P6oMJc0T2B+qrE5NynW7V1xFB53dKNHxY3TjaTBBsP/O/ceWiOQRjzkjXULC+eT
         Ku4lMy90FrXDqjwVBPm4Ma+DZwlg04N/G5/ELAxjDQa6OWOazbdqQtrePI4N2AlF6C
         g4GGEd2gGc4ng==
Date:   Wed, 16 Aug 2023 10:13:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tty: gdm724x: use min_t() for size_t varable and a
 constant
Message-ID: <20230816171338.GA2138570@dev-arch.thelio-3990X>
References: <20230816085322.22065-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816085322.22065-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:53:22AM +0200, Jiri Slaby (SUSE) wrote:
> My thinking was that ulong is the same as size_t everywhere. No, size_t
> is uint on 32bit. So the below commit introduced a build warning on
> 32bit:
> .../gdm724x/gdm_tty.c:165:24: warning: comparison of distinct pointer types ('typeof (2048UL) *' (aka 'unsigned long *') and 'typeof (remain) *' (aka 'unsigned int *'))
> 
> To fix this, partially revert the commit (remove constants' suffixes)
> and switch to min_t() in this case instead.
> 
> /me would hope for Z (or alike) suffix for constants.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: c3e5c706aefc (tty: gdm724x: convert counts to size_t)
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308151953.rNNnAR2N-lkp@intel.com/

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> ---
>  drivers/staging/gdm724x/gdm_tty.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 67d9bf41e836..32b2e817ff04 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -17,9 +17,9 @@
>  #define GDM_TTY_MAJOR 0
>  #define GDM_TTY_MINOR 32
>  
> -#define WRITE_SIZE 2048UL
> +#define WRITE_SIZE 2048
>  
> -#define MUX_TX_MAX_SIZE 2048UL
> +#define MUX_TX_MAX_SIZE 2048
>  
>  static inline bool gdm_tty_ready(struct gdm *gdm)
>  {
> @@ -159,7 +159,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  		return -ENODEV;
>  
>  	while (remain) {
> -		size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
> +		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
>  		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
>  					(void *)(buf + sent_len),
>  					sending_len,
> -- 
> 2.41.0
> 
