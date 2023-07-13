Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750D9752789
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjGMPnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGMPnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:43:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCF2680;
        Thu, 13 Jul 2023 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=e1RschMAietqo4yrW4fae/Y/YBT6qlJyR4H15nx9b/c=; b=j+Mu6xLXRTrrXKeT6HECd8Ud04
        XKOaZ9pu9coE1LMrRTG2GcvkI/IbXHqweQ6930xoT+KufQV8LMto4yh74B3+Ef03ZTIV8/vOA2Gnw
        IKaPSyDnh/vMH9OdwrRJ5yBbONMxeeGdxBnaXlKuZGgQZaNoQHw6B6y43IknlVytCnAALiCbPLqB0
        2RWjhUsQdJF4cIQfvCEWpEgzxhG8hVjOVQqBIjVY7FAbW0smvrVAZbu0nJhexL/Z1So+u9u5z6nl9
        8NfBvA2IojHJjXevR+bPzh4IX8WOXd/pF/ZDZw3nteZ9TfDZ43IfYkfGzYnwADsBmv++TDYfl4uhc
        2QKB5qZw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJyT1-003o2A-0C;
        Thu, 13 Jul 2023 15:42:55 +0000
Message-ID: <04a96ba2-6952-e6de-93a2-dc2998ce519d@infradead.org>
Date:   Thu, 13 Jul 2023 08:42:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2] net: tcp: support to probe tcp receiver OOM
Content-Language: en-US
To:     menglong8.dong@gmail.com, edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, dsahern@kernel.org, kuniyu@amazon.com,
        morleyd@google.com, imagedong@tencent.com, mfreemon@cloudflare.com,
        mubashirq@google.com, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230713112404.2022373-1-imagedong@tencent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230713112404.2022373-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/23 04:24, menglong8.dong@gmail.com wrote:
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 4a010a7cde7f..3de2dce74037 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -694,6 +694,20 @@ tcp_retries2 - INTEGER
>  	RFC 1122 recommends at least 100 seconds for the timeout,
>  	which corresponds to a value of at least 8.
>  
> +tcp_oom_retries - INTEGER
> +	RTO retransmissions count of the receiver is recognised as OOM.
> +	Given a value N, a hypothetical TCP connection will enter probe
> +	state if N times RTO retransmissions performed and every
> +	retransmission gets a pure ack, who doesn't contain SACK block.

	                           ACK
> +
> +	The default value is 0, which means disable the OOM detection.
> +	If disabled, skb will be dropped directly, without sending an
> +	ACK, when rmem schedule fails. The function is valid only if sack

	                                                             SACK

> +	is enabled.
> +
> +	3 is the suggested value to enable this function. Do't make it

	                                                  Don't

> +	greater than tcp_retries2.

-- 
~Randy
