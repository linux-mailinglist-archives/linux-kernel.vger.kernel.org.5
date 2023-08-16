Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95777E0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbjHPLpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbjHPLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:45:16 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3F61FC3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:45:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by albert.telenet-ops.be with bizsmtp
        id aBlD2A00D45ualL06BlDpf; Wed, 16 Aug 2023 13:45:13 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWExd-000p4r-8K;
        Wed, 16 Aug 2023 13:45:13 +0200
Date:   Wed, 16 Aug 2023 13:45:13 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tty: gdm724x: use min_t() for size_t varable and a
 constant
In-Reply-To: <20230816085322.22065-1-jirislaby@kernel.org>
Message-ID: <e76ddc3-4843-a6bb-6b32-92dc5ca3e178@linux-m68k.org>
References: <20230816085322.22065-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023, Jiri Slaby (SUSE) wrote:
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

Thanks, this fixes the m68k/allmodconfig build.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -17,9 +17,9 @@
> #define GDM_TTY_MAJOR 0
> #define GDM_TTY_MINOR 32
>
> -#define WRITE_SIZE 2048UL
> +#define WRITE_SIZE 2048
>
> -#define MUX_TX_MAX_SIZE 2048UL
> +#define MUX_TX_MAX_SIZE 2048

You probably want to keep the "U" suffix, so at least both parts
of min() are unsigned.

See also "[PATCH next v3 0/5] minmax: Relax type checks in min() and max().".
https://lore.kernel.org/all/01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com,

>
> static inline bool gdm_tty_ready(struct gdm *gdm)
> {
> @@ -159,7 +159,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
> 		return -ENODEV;
>
> 	while (remain) {
> -		size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
> +		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
> 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
> 					(void *)(buf + sent_len),
> 					sending_len,
> -- 
> 2.41.0
>
>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
