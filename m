Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422217C4A94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjJKGa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:30:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715F93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:30:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E06C433C7;
        Wed, 11 Oct 2023 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697005823;
        bh=cOfTkY43H2nW587bRbrhIWOL7GLGr7wMPsVn9tjAmW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wT4buVgUFRsybw4xiRLI0LgTqeVc7oFuas3/Y5EtgAlXJfXTG2Bn/LrQ4zN5W+gyo
         93GacY0ieRvY5wmyPmzX0Lf4ly56RkkjmEm5q0aOccBGmvYUIdIV7cg/rdiww5exmR
         tqMdWp9VVKmvolYBfYeWBF2CWiKZ/I1GP1vp07c0=
Date:   Wed, 11 Oct 2023 08:30:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove extra unlock for the mutex
Message-ID: <2023101136-irritate-shrine-cde6@gregkh>
References: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:16:30AM +0530, Abhinav Singh wrote:
> There is a double unlock on mutex. This can cause undefined behaviour.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index aeebe8816689..f11fe8c727a4 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -597,7 +597,6 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
>  	}
>  	if (head2_lock_acquired)
>  		spin_unlock(&head2->lock);
> -	spin_unlock_bh(&head->lock);

How was this tested?

And where is the now-needed unlock of the head->lock?

How was this change found?

And your subject line needs a lot of work...

thanks,

greg k-h
