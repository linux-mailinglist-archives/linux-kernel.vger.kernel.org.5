Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5F7D29B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 07:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjJWFiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJWFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 01:37:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20C48D7A;
        Sun, 22 Oct 2023 22:37:47 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 61C0620B74C0; Sun, 22 Oct 2023 22:37:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61C0620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698039466;
        bh=wdBTgfyeYv6OIVrdKsx9E9VcCeZFvYAlw+80iTEMrps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5Jwgx+Xi1VRI/eExm57OFGigBWzze+6PSbDxMyTgK0FoF2rGx5ACsQudDhIn5Akr
         BuWlOrgxl+nCMkRZbmi1FXXkHaz4bJRjbrikVGMKmgNT9eoQBJJTIHFeRnOr3orjFy
         NKGyWoO2xM5R8pSvCR0kDuj4IPnj65A0hUd6TLUw=
Date:   Sun, 22 Oct 2023 22:37:46 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Ani Sinha <anisinha@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
Message-ID: <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20231016133122.2419537-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016133122.2419537-1-anisinha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:01:22PM +0530, Ani Sinha wrote:
> Some small fixes:
>  - lets make sure we are not adding ipv4 addresses in ipv6 section in
>    keyfile and vice versa.
>  - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead of
>    checking the whole value of addr_family.
>  - Some trivial fixes in hv_set_ifconfig.sh.
> 
> These fixes are proposed after doing some internal testing at Red Hat.
> 
> CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
> CC: Saurabh Sengar <ssengar@linux.microsoft.com>
> Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based connection profile")
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
>  tools/hv/hv_set_ifconfig.sh |  4 ++--
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 264eeb9c46a9..318e2dad27e0 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	if (error)
>  		goto setval_error;
>  
> -	if (new_val->addr_family == ADDR_FAMILY_IPV6) {
> +	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>  		error = fprintf(nmfile, "\n[ipv6]\n");
>  		if (error < 0)
>  			goto setval_error;
> @@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	if (error < 0)
>  		goto setval_error;
>  
> -	error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
> -	if (error < 0)
> -		goto setval_error;
> -
> -	error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
> -	if (error < 0)
> -		goto setval_error;
> +	/* we do not want ipv4 addresses in ipv6 section and vice versa */
> +	if (is_ipv6 != is_ipv4((char *)new_val->gate_way)) {
> +		error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
> +		if (error < 0)
> +			goto setval_error;
> +	}
>  
> +	if (is_ipv6 != is_ipv4((char *)new_val->dns_addr)) {
> +		error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
> +		if (error < 0)
> +			goto setval_error;
> +	}
>  	fclose(nmfile);
>  	fclose(ifcfg_file);
>  
> diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
> index ae5a7a8249a2..440a91b35823 100755
> --- a/tools/hv/hv_set_ifconfig.sh
> +++ b/tools/hv/hv_set_ifconfig.sh
> @@ -53,7 +53,7 @@
>  #                       or "manual" if no boot-time protocol should be used)
>  #
>  # address1=ipaddr1/plen
> -# address=ipaddr2/plen
> +# address2=ipaddr2/plen
>  #
>  # gateway=gateway1;gateway2
>  #
> @@ -61,7 +61,7 @@
>  #
>  # [ipv6]
>  # address1=ipaddr1/plen
> -# address2=ipaddr1/plen
> +# address2=ipaddr2/plen
>  #
>  # gateway=gateway1;gateway2
>  #
> -- 
> 2.39.2
Reviewed-by: Shradha Gupta <Shradhagupta@linux.microsoft.com>
