Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411997A2BF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbjIPA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbjIPA0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:26:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33F49E5;
        Fri, 15 Sep 2023 17:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=seiFPh/RNGfAZ+in9FMjht9cWbGAXZLBZhZdj4gxOGQ=; b=fG0g2Lv6luE70akUAjd7jkjBIh
        XVu67BwfKuccykyAV6sF/lUJ8QIKXwajn+C+RNrIoFHJX6e9DqpWxbDt9SAssBLFwLFGxLSz5gC5h
        /6heev58te1YmC2dv5COPf0vvoVpr824Mj/q89F+5BlNaKoYKTWSyiUbIiwKxlSdOFxC7Z3NUHhwx
        C5Le8oUXd0VAelGoLhbWdrS3Vq9c/vG56yLBBRyigxhFVBR78bPYiR06R6ZzElZmfsSuZObp2LkyV
        3gEd/e+QLE+pjq8ke9bNW85t/2wbtDnlWXclNv3rjy/VU0PDiwwFT8SCQFXP4BAMzI/EAws8Un4ux
        9ea/7qYQ==;
Received: from [172.59.186.83] (helo=[192.168.12.170])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhJ4H-009iKn-1X;
        Sat, 16 Sep 2023 00:21:52 +0000
Message-ID: <e0ed4f6b-3db0-9729-6582-8a5e3b4e2064@infradead.org>
Date:   Fri, 15 Sep 2023 19:21:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH][next] net: spider_net: Use size_add() in call to
 struct_size()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZQSvsLmJrDsKtLCa@work>
Content-Language: en-US
From:   Geoff Levand <geoff@infradead.org>
In-Reply-To: <ZQSvsLmJrDsKtLCa@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 14:25, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: 3f1071ec39f7 ("net: spider_net: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/toshiba/spider_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
> index 50d7eacfec58..87e67121477c 100644
> --- a/drivers/net/ethernet/toshiba/spider_net.c
> +++ b/drivers/net/ethernet/toshiba/spider_net.c
> @@ -2332,7 +2332,7 @@ spider_net_alloc_card(void)
>  	struct spider_net_card *card;
>  
>  	netdev = alloc_etherdev(struct_size(card, darray,
> -					    tx_descriptors + rx_descriptors));
> +					    size_add(tx_descriptors, rx_descriptors)));
>  	if (!netdev)
>  		return NULL;
>  

Looks good to me.  Thanks for your fix-up.

Signed-off-by: Geoff Levand <geoff@infradead.org>


