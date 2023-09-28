Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB77B1D32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjI1NAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjI1NAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:00:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC0199;
        Thu, 28 Sep 2023 06:00:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC3DC433C7;
        Thu, 28 Sep 2023 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695906050;
        bh=1w5FRlOo1tK8D8G1rHrmB3vPWLFLyIZOOaoFfnEL2Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8N5b0bFaojf/1rQrdbr+Nc6K6JlJEYbmvmTM3APbrIv1dDDlzmLViptfoJl0NSqk
         wlJdnJKk8RdOgWxHk0HPn+68ktWelgKGpHKeIfYxxEqFflbpjCyq0HGDRMP6SW9WAG
         4xdtwp176vOXaxqv5YcKKcn1mz6FWZnZJ7LF7Q83topamtD58cF7JtkW8u8OOkU7u5
         CciCrwmetlb54aGVZquF3WlMnVTgE/oNKq6IvDB6cBiry8AGKGGkl727MAUkzBcLkC
         E0u53xWe732dqsrYhyNH9D/6RRZ8AgsfVMFVPP2oL84+IK8XuwDANI9RU2b2nH8iGa
         okbG9cBTBq1ew==
Date:   Thu, 28 Sep 2023 15:00:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] locktorture: Check the correct variable for allocation
 failure
Message-ID: <ZRV4/20T4pGk2QuX@lothringen>
References: <ec2c9ecf-9360-41fa-934d-6854d2615799@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2c9ecf-9360-41fa-934d-6854d2615799@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:06:11AM +0300, Dan Carpenter wrote:
> There is a typo so this checks the wrong variable.  "chains" plural vs
> "chain" singular.  We already know that "chains" is non-zero.
> 
> Fixes: 7f993623e9eb ("locktorture: Add call_rcu_chains module parameter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  kernel/locking/locktorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index a3abcd136f56..69d3cd2cfc3b 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -1075,7 +1075,7 @@ static int call_rcu_chain_init(void)
>  	if (call_rcu_chains <= 0)
>  		return 0;
>  	call_rcu_chain = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain), GFP_KERNEL);
> -	if (!call_rcu_chains)
> +	if (!call_rcu_chain)
>  		return -ENOMEM;
>  	for (i = 0; i < call_rcu_chains; i++) {
>  		call_rcu_chain[i].crc_stop = false;

Oh good catch, queueing this one, thanks!
