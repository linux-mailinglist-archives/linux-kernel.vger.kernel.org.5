Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6980A434
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjLHNM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:12:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40705171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:12:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C6AC433C8;
        Fri,  8 Dec 2023 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702041149;
        bh=LRHKXloa3MmO6SoONfxXn/xJpmyyKAc/mIUHXv6+GMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tW11Uc298n3GMfqBAAke/uzS7WbHqNqrm5l7/LAA1eYmPWnqBHiGdej+PPvMGhynk
         coRDgr19TLIFhhi6RaBoqtkSAYKsl98u+Tf/2UH580LCdsmbZ3+TsPT4ZwkYPunoMf
         1I1dr5MchgWH1PC+o1HFr5Cxc2fzQfBBkoU1AZmvE0nybp32t0fnP6BAtKF1MyIc/I
         WcI4oqGHtaKKnpASkzt48/aDUrgrm8wY/Lp3gwmB7X6iVadCH38r8J21InGn8BtUF1
         uzgxqpVi4aFJTg5sTTjhV2/zt9nqCEUSqqH+Bh8au7+2yzS+V1Tc0JjdMPFuj0Tnjw
         kvmeCou1Fl4aQ==
Date:   Fri, 8 Dec 2023 14:12:25 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Adrian Reber <areber@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Message-ID: <20231208-begibt-besonderen-096761ac8d3b@brauner>
References: <20231206134340.7093-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206134340.7093-1-areber@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 02:43:40PM +0100, Adrian Reber wrote:
> The capability CAP_CHECKPOINT_RESTORE was introduced to allow non-root
> users to checkpoint and restore processes as non-root with CRIU.
> 
> This change extends CAP_CHECKPOINT_RESTORE to enable the CRIU option
> '--shell-job' as non-root. CRIU's man-page describes the '--shell-job'
> option like this:
> 
>   Allow one to dump shell jobs. This implies the restored task will
>   inherit session and process group ID from the criu itself. This option
>   also allows to migrate a single external tty connection, to migrate
>   applications like top.
> 
> TIOCSLCKTRMIOS can only be done if the process has CAP_SYS_ADMIN and
> this change extends it to CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE.
> 
> With this change it is possible to checkpoint and restore processes
> which have a tty connection as non-root if CAP_CHECKPOINT_RESTORE is
> set.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
>  drivers/tty/tty_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 4b499301a3db..95d14d7128cc 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -844,7 +844,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>  			ret = -EFAULT;
>  		return ret;
>  	case TIOCSLCKTRMIOS:
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))

In both cases you should be able to use:

if (!checkpoint_restore_ns_capable(&init_user_ns))
	return -EPERM;

with that fixed,

Acked-by: Christian Brauner <brauner@kernel.org>

>  			return -EPERM;
>  		copy_termios_locked(real_tty, &kterm);
>  		if (user_termios_to_kernel_termios(&kterm,
> @@ -861,7 +861,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>  			ret = -EFAULT;
>  		return ret;
>  	case TIOCSLCKTRMIOS:
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
>  			return -EPERM;
>  		copy_termios_locked(real_tty, &kterm);
>  		if (user_termios_to_kernel_termios_1(&kterm,
> 
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> -- 
> 2.43.0
> 
