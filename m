Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0D7C9E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjJPEJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPEJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:09:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC331C1;
        Sun, 15 Oct 2023 21:08:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9052BC433C8;
        Mon, 16 Oct 2023 04:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697429339;
        bh=bvZr4jk4NKVc1U+NKKntLqYXoaaClbnClTIHwv+im3I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HXNbqQ54BakkL7JQdFAoUIZKRm6ZP0RDL7SRPD3TzjHy9+tqe8mGj0IT6M0pKWhuL
         jSOFeE5xRN69RwVXNC3mSOE13dQ5RY8dVFK8NJv14OR2lMCRMjygaqZOylK/thkAZ/
         mT10M44l9e9oXC6b1J8oERUsU4pd4gnIl5KosmrL3q7PkiCim0zy4tEiNUZMTOMNI/
         TqP9pOpMifMmK23aeRgD+HGY8u2OVcw18jz7kH1iMnM7yFTAPmK/J+wQ4jELUKkOo1
         r2IbncD0X7gdViFOFA2hlhoijBOQIOhSgyxLXPOokcb/Pft12xOfvd1Z5FEu8weaQx
         eQzvNvlIDMYqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 32D5CCE0593; Sun, 15 Oct 2023 21:08:59 -0700 (PDT)
Date:   Sun, 15 Oct 2023 21:08:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: add nolibc init support for mips, ppc and
 rv64
Message-ID: <d41e7924-f497-4517-87c8-1961434d72dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231016-rcu-nolibc-arch-v1-1-391af51b129b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016-rcu-nolibc-arch-v1-1-391af51b129b@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:25:14AM +0200, Thomas Weiﬂschuh wrote:
> Use nolibc for all support architectures.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> index 212c52ca90b5..f3f867129560 100755
> --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> @@ -67,7 +67,10 @@ ___EOF___
>  # build using nolibc on supported archs (smaller executable) and fall
>  # back to regular glibc on other ones.
>  if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
> -	   "||__ARM_EABI__||__aarch64__||__s390x__||__loongarch__\nyes\n#endif" \
> +	   "||__ARM_EABI__||__aarch64__||(__mips__ && _ABIO32)" \
> +	   "||__powerpc__||(__riscv && __riscv_xlen == 64)" \
> +	   "||__s390x__||__loongarch__" \
> +	   "\nyes\n#endif" \
>     | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
>     | grep -q '^yes'; then
>  	# architecture supported by nolibc
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231016-rcu-nolibc-arch-edd1db03554a
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
