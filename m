Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FDE8107D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378230AbjLMBst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378199AbjLMBss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:48:48 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B984CAD;
        Tue, 12 Dec 2023 17:48:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyO3miM_1702432130;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VyO3miM_1702432130)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 09:48:51 +0800
Date:   Wed, 13 Dec 2023 09:48:47 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Ahelenia =?us-ascii?Q?Ziemia'nska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please add correct tag, for this patch, IIUC, it should be a fix, and
you need add [PATCH net].

On Tue, Dec 12, 2023 at 11:12:47AM +0100, Ahelenia Ziemia'nska wrote:
> Otherwise we risk sleeping with the pipe locked for indeterminate
> lengths of time.
> 
> Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u

Fixes line is needed.

> Signed-off-by: Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>
> ---
>  net/smc/af_smc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd971615e..89473305f629 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3243,12 +3243,8 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>  			rc = -ESPIPE;
>  			goto out;
>  		}
> -		if (flags & SPLICE_F_NONBLOCK)
> -			flags = MSG_DONTWAIT;
> -		else
> -			flags = 0;
>  		SMC_STAT_INC(smc, splice_cnt);
> -		rc = smc_rx_recvmsg(smc, NULL, pipe, len, flags);
> +		rc = smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
>  	}
>  out:
>  	release_sock(sk);
> -- 
> 2.39.2


