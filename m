Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D027C9775
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjJOAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 20:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjJOAym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 20:54:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A831D6;
        Sat, 14 Oct 2023 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bMYx0YBKVD4QkYartiIDuMj8aY1P3FXdUnaKI2aSW6I=; b=Cdwkek2/GkQQGXJHD8SMaUvnY7
        5ItxkTrJiolaGolJYRMgXu7PrYSNB+JSrMYGipvTGPqK24iazoyo5NZk75E0xev7SykUWDiqbjXcu
        TPw9h6TY2JKsxkaX+S+jUQ8A4neGhoC2QIMjcR2j4oAGNKFsJxFRmi2zC0EKqrC9ygCXhe4S+aFxm
        UFzqLsx9UxR6ap8cjVCVmrJr5aEaxLXHJu93tNwa10er5Yh1fCE+jMefNfFMUo8d1ch6Ot52YJ+4d
        gbXwiMKAc4eDVBXPdl8WDhEA5u29VCpGqUHfTYDrStOfJcOeWEsQB1+Ajz5tOVbIkajL4YlH/y9sd
        AaFJpoHw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qrpOr-001Kdq-2V;
        Sun, 15 Oct 2023 00:54:33 +0000
Date:   Sat, 14 Oct 2023 17:54:30 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH net-next v4 1/4] netconsole: move init/cleanup functions
 lower
Message-ID: <ZSs4RgtcYqkJc1Px@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
References: <20231012111401.333798-1-leitao@debian.org>
 <20231012111401.333798-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012111401.333798-2-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 04:13:58AM -0700, Breno Leitao wrote:
> Move alloc_param_target() and its counterpart (free_param_target())
> to the bottom of the file. These functions are called mostly at
> initialization/cleanup of the module, and they should be just above the
> callers, at the bottom of the file.
> 
> >From a practical perspective, having alloc_param_target() at the bottom
> of the file will avoid forward declaration later (in the following
> patch).
> 
> Nothing changed other than the functions location.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joel Becker <jlbec@evilplan.org>

> ---
>  drivers/net/netconsole.c | 104 +++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 3111e1648592..d609fb59cf99 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -192,58 +192,6 @@ static struct netconsole_target *alloc_and_init(void)
>  	return nt;
>  }
>  
> -/* Allocate new target (from boot/module param) and setup netpoll for it */
> -static struct netconsole_target *alloc_param_target(char *target_config)
> -{
> -	struct netconsole_target *nt;
> -	int err;
> -
> -	nt = alloc_and_init();
> -	if (!nt) {
> -		err = -ENOMEM;
> -		goto fail;
> -	}
> -
> -	if (*target_config == '+') {
> -		nt->extended = true;
> -		target_config++;
> -	}
> -
> -	if (*target_config == 'r') {
> -		if (!nt->extended) {
> -			pr_err("Netconsole configuration error. Release feature requires extended log message");
> -			err = -EINVAL;
> -			goto fail;
> -		}
> -		nt->release = true;
> -		target_config++;
> -	}
> -
> -	/* Parse parameters and setup netpoll */
> -	err = netpoll_parse_options(&nt->np, target_config);
> -	if (err)
> -		goto fail;
> -
> -	err = netpoll_setup(&nt->np);
> -	if (err)
> -		goto fail;
> -
> -	nt->enabled = true;
> -
> -	return nt;
> -
> -fail:
> -	kfree(nt);
> -	return ERR_PTR(err);
> -}
> -
> -/* Cleanup netpoll for given target (from boot/module param) and free it */
> -static void free_param_target(struct netconsole_target *nt)
> -{
> -	netpoll_cleanup(&nt->np);
> -	kfree(nt);
> -}
> -
>  #ifdef	CONFIG_NETCONSOLE_DYNAMIC
>  
>  /*
> @@ -938,6 +886,58 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
>  	spin_unlock_irqrestore(&target_list_lock, flags);
>  }
>  
> +/* Allocate new target (from boot/module param) and setup netpoll for it */
> +static struct netconsole_target *alloc_param_target(char *target_config)
> +{
> +	struct netconsole_target *nt;
> +	int err;
> +
> +	nt = alloc_and_init();
> +	if (!nt) {
> +		err = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	if (*target_config == '+') {
> +		nt->extended = true;
> +		target_config++;
> +	}
> +
> +	if (*target_config == 'r') {
> +		if (!nt->extended) {
> +			pr_err("Netconsole configuration error. Release feature requires extended log message");
> +			err = -EINVAL;
> +			goto fail;
> +		}
> +		nt->release = true;
> +		target_config++;
> +	}
> +
> +	/* Parse parameters and setup netpoll */
> +	err = netpoll_parse_options(&nt->np, target_config);
> +	if (err)
> +		goto fail;
> +
> +	err = netpoll_setup(&nt->np);
> +	if (err)
> +		goto fail;
> +
> +	nt->enabled = true;
> +
> +	return nt;
> +
> +fail:
> +	kfree(nt);
> +	return ERR_PTR(err);
> +}
> +
> +/* Cleanup netpoll for given target (from boot/module param) and free it */
> +static void free_param_target(struct netconsole_target *nt)
> +{
> +	netpoll_cleanup(&nt->np);
> +	kfree(nt);
> +}
> +
>  static struct console netconsole_ext = {
>  	.name	= "netcon_ext",
>  	.flags	= CON_ENABLED | CON_EXTENDED,
> -- 
> 2.34.1
> 

-- 

"There is shadow under this red rock.
 (Come in under the shadow of this red rock)
 And I will show you something different from either
 Your shadow at morning striding behind you
 Or your shadow at evening rising to meet you.
 I will show you fear in a handful of dust."

			http://www.jlbec.org/
			jlbec@evilplan.org
