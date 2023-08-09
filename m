Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E063776010
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjHIM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjHIM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5081FF6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42ABB639E8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37995C433CB;
        Wed,  9 Aug 2023 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691585996;
        bh=Kjv7BSip4U2Z76k+hApURRKL4hnouy3m/W2QpYLKPo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuvplUmmZ1qTGk7obsCf7HGiIbt84kz89KMj6mvs5v/+GanHGU1RtChVxT8efOgtk
         8hiIfTVQIeTv8orz5OihFkQV9+5M5V3jXJVpS/S4cO/5nO2DWIwDB7OhPpQlKh7lzt
         quPlOgcWfab/fApuBTWEQWMFXP1uVgjSYyvAB09xdLI0Q7EhuoTe31W8iH7dHk1cJx
         Bqz8N6o/F6XcHQHEwmBS4ahEf7xuSw772NleWQUwA9Owx+ZKQB86wur6kb0WVnlV1X
         xIhx1GkBVTEJVnPJAZ5kyH7RppmjqxIeSgNjWfM4CUPcdoZ6/OmfCX5M3x+GBiFhGW
         rPJGbVo0hS6nw==
Date:   Wed, 9 Aug 2023 14:59:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] net/llc/llc_conn.c: fix 4 instances of
 -Wmissing-variable-declarations
Message-ID: <ZNONx8N1/NFqmP6b@vergenet.net>
References: <20230808-llc_static-v1-1-c140c4c297e4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-llc_static-v1-1-c140c4c297e4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kuniyuki Iwashima

On Tue, Aug 08, 2023 at 09:43:09AM -0700, Nick Desaulniers wrote:
> I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
> bot spotted the following instances:
> 
>   net/llc/llc_conn.c:44:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_ack_timeout'
>   [-Wmissing-variable-declarations]
>   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:44:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:45:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_p_timeout'
>   [-Wmissing-variable-declarations]
>   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:45:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:46:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_rej_timeout'
>   [-Wmissing-variable-declarations]
>   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:46:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:47:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_busy_timeout'
>   [-Wmissing-variable-declarations]
>   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:47:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
>      | ^
> 
> These symbols are referenced by more than one translation unit, so make
> include the correct header for their declarations. Finally, sort the
> list of includes to help keep them tidy.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/llc/llc_conn.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index d037009ee10f..0a3f5e0bec00 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -14,14 +14,15 @@
>  
>  #include <linux/init.h>
>  #include <linux/slab.h>
> -#include <net/llc_sap.h>
> -#include <net/llc_conn.h>
> -#include <net/sock.h>
> -#include <net/tcp_states.h>
> -#include <net/llc_c_ev.h>
> +#include <net/llc.h>
>  #include <net/llc_c_ac.h>
> +#include <net/llc_c_ev.h>
>  #include <net/llc_c_st.h>
> +#include <net/llc_conn.h>
>  #include <net/llc_pdu.h>
> +#include <net/llc_sap.h>
> +#include <net/sock.h>
> +#include <net/tcp_states.h>
>  
>  #if 0
>  #define dprintk(args...) printk(KERN_DEBUG args)
> 
> ---
> base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
> change-id: 20230808-llc_static-de4dddcc64b4
> 
> Best regards,
> -- 
> Nick Desaulniers <ndesaulniers@google.com>
> 
> 
