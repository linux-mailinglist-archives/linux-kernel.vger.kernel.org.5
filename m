Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B77CD7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjJRJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJRJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:26:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107D10B;
        Wed, 18 Oct 2023 02:26:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B0FC433C9;
        Wed, 18 Oct 2023 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697621196;
        bh=A80ZhPjQi2rG5AAi+IIdfwA8t+4osyNzDn4honhOq4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aijq9lDLgQi15TEZWb3Xi/+6RTJUYm+sEGq/ovK1hLkZAFMC6A/2EakSkeCy8T4Va
         O0nQpEiDHZcFrXcnoFNj32Ac52d7YPv8iUA8PmWawvMVu+H3UVLWkXoAeiXvBO4o2/
         Wql91yJBXg2BTvNIskXntHF/A0/JizI0KyAtxmBc=
Date:   Wed, 18 Oct 2023 11:26:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org, andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
Message-ID: <2023101846-synopses-paralyses-d1ee@gregkh>
References: <cover.1697619623.git.anonolitunya@gmail.com>
 <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:07:38PM +0300, Dorcas AnonoLitunya wrote:
> Modifies the return type of program_mode_registers()
> to void from int as the return value is being ignored in
> all subsequent function calls.
> 
> This improves code readability and maintainability.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index 83ace6cc9583..e15039238232 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
>  }
>  
>  /* only timing related registers will be  programed */
> -static int program_mode_registers(struct mode_parameter *mode_param,
> -				  struct pll_value *pll)
> +static void program_mode_registers(struct mode_parameter *mode_param,
> +				   struct pll_value *pll)
>  {
>  	int ret = 0;
>  	int cnt = 0;
> @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
>  	} else {
>  		ret = -1;

Why are you still setting the 'ret' variable if you are not doing
anything with it anymore?

>  	}
> -	return ret;

Are you sure that the caller shouldn't be checking for errors instead of
dropping the return value?  If so, document that in the changelog too.

thanks,

greg k-h
