Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38F7B4204
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjI3QOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjI3QOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:14:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5746DB9;
        Sat, 30 Sep 2023 09:14:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F11C433C8;
        Sat, 30 Sep 2023 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696090478;
        bh=MqO0aeyCzwGjYjLSV1SulI5oIkludvo2w2vvpfZBR5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHaXyUqb5u19NSeivZVuqsGLERwCFQVtvOSZ6WKeXWj8sZJ91a1IYj6qouew6kPjI
         xic8ZhHrlWpBTQRI75wHUDuR0HCvOcw+RALr8TcWA0b4NYJ7B9hJEaecUMVc0zUzBo
         xL9BwgWwTfzYsqBM7fiNNoFTpWIVmEpbD1ecY8PUIywsl6rYpabOdJjlCRxyHnDIMW
         obFboj9ouQBWtT6atC//ZwtkNCNWFzxJ3C4pgUuuxUW+ThIsRz6QCvtyjgPbLBHBJQ
         qXX1u3opw0VoTMXSqydg3hpaA9yRrVoLFDjMbbwPrOJe0G6RzF50c+G5k0PGSzb6YM
         Z1f6WflMt+f8A==
Date:   Sat, 30 Sep 2023 18:14:34 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <20230930161434.GC92317@kernel.org>
References: <20230926105732.10864-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926105732.10864-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:57:32AM +0000, Chengfeng Ye wrote:
> Timer interrupt ax25_ds_timeout() could introduce double locks on
> &ax25_list_lock.
> 
> ax25_ioctl()
> --> ax25_ctl_ioctl()
> --> ax25_dama_off()
> --> ax25_dev_dama_off()
> --> ax25_check_dama_slave()
> --> spin_lock(&ax25_list_lock)
> <timer interrupt>
>    --> ax25_ds_timeout()
>    --> spin_lock(&ax25_list_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch use spin_lock_bh()
> on &ax25_list_lock inside ax25_check_dama_slave().
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Hi Chengfeng Ye,

thanks for your patch.

As a fix for Networking this should probably be targeted at the
'net' tree. Which should be denoted in the subject.

        Subject: [PATCH net] ...

And as a fix this patch should probably have a Fixes tag.
This ones seem appropriate to me, but I could be wrong.

Fixes: c070e51db5e2 ("ice: always add legacy 32byte RXDID in supported_rxdids")

I don't think it is necessary to repost just to address these issues,
but the Networking maintainers may think otherwise.

The code change itself looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ax25/ax25_ds_subr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ax25/ax25_ds_subr.c b/net/ax25/ax25_ds_subr.c
> index f00e27df3c76..010b11303d32 100644
> --- a/net/ax25/ax25_ds_subr.c
> +++ b/net/ax25/ax25_ds_subr.c
> @@ -156,13 +156,13 @@ static int ax25_check_dama_slave(ax25_dev *ax25_dev)
>  	ax25_cb *ax25;
>  	int res = 0;
>  
> -	spin_lock(&ax25_list_lock);
> +	spin_lock_bh(&ax25_list_lock);
>  	ax25_for_each(ax25, &ax25_list)
>  		if (ax25->ax25_dev == ax25_dev && (ax25->condition & AX25_COND_DAMA_MODE) && ax25->state > AX25_STATE_1) {
>  			res = 1;
>  			break;
>  		}
> -	spin_unlock(&ax25_list_lock);
> +	spin_unlock_bh(&ax25_list_lock);
>  
>  	return res;
>  }
> -- 
> 2.17.1
> 
> 
