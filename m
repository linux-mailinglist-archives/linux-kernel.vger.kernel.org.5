Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BD47B5C15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjJBUbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJBUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA5AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696278642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8f6DdK1GdbJ9qglZe36tie4rL6xJEQDl6yTedgx1kc=;
        b=ZG8y6mUhssNujKITZUqDkub4CmFHP/2vrrY5NlKnfxaq7CB36/FuoHs5GbcpVKbdEVIEnk
        8kFk/B2Y+6vBTwkdQMKoBVZyuObOxvkXWpEOJp49stzAO8OemypjBO9yyaxntbCU8sNrf3
        odapv21DkAPIpRVr9uN6hU+nQ5wjyLE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ByT_flPnO9C3kHAIzhv8TQ-1; Mon, 02 Oct 2023 16:30:39 -0400
X-MC-Unique: ByT_flPnO9C3kHAIzhv8TQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65b00c2cbb6so3862056d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 13:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696278639; x=1696883439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8f6DdK1GdbJ9qglZe36tie4rL6xJEQDl6yTedgx1kc=;
        b=lm/Fzj0i0OXBKfNyqBVbUOrDw5rN4ZQMdA48LDdwTx0SCe4cR6TVuG1mvyCnio2j4b
         edi45syjtR+icnjOLiuDr0AqiKXQNIKFyEvcTOZep8L6raGXfI7PRoYDAxnvkUpKbmsd
         cgZ3NA3PYzXVrrBkSf2hYI9A/sErcLPvtQISAu0wmq3JU1CTulUs7dNPbsrVhor0tIuL
         iQqo23HKk1yFYN3Nylaot+BQmGo70rNk1kBzST8dw/zKA1ayRjBNk89COsdPdWk3FfY1
         X/1mMaxXOQeC0ZZ8/c3EpgDe3qWt4KtPkaMg9cCPVoobfcuBtqR4tmU1INS24At2W19M
         UF3g==
X-Gm-Message-State: AOJu0YxCncnJdYtprdz2sRha9CJSsjUXTmQstzAEHuF6TjcFShZEYibP
        yr48hcfee2wlqwco4ICNAeD2SfXrXBn+Bvr9yUP9r5q8RpL9hi6U3bFCiHc4AOjF662MxVqH7Ur
        s0IjokLa7sXy1ErMpXRwJC3Rd
X-Received: by 2002:a05:6214:500b:b0:65d:343:8e50 with SMTP id jo11-20020a056214500b00b0065d03438e50mr17919986qvb.3.1696278639174;
        Mon, 02 Oct 2023 13:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEBzcp3LOMaX+vRfy6OADLYWwS1aUlqXi3WUStAokU3G7oCq11ynu1Wreo7RqMGIcieUkl6A==
X-Received: by 2002:a05:6214:500b:b0:65d:343:8e50 with SMTP id jo11-20020a056214500b00b0065d03438e50mr17919965qvb.3.1696278638861;
        Mon, 02 Oct 2023 13:30:38 -0700 (PDT)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id h3-20020a0cf403000000b00655d711180dsm4844123qvl.17.2023.10.02.13.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 13:30:38 -0700 (PDT)
Message-ID: <a2a43d5a-678d-129b-d258-d559df42431f@redhat.com>
Date:   Mon, 2 Oct 2023 16:30:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, ying.xue@windriver.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230927181414.59928-1-dg573847474@gmail.com>
From:   Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20230927181414.59928-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-27 14:14, Chengfeng Ye wrote:
> It seems that tipc_crypto_key_revoke() could be be invoked by
> wokequeue tipc_crypto_work_rx() under process context and
> timer/rx callback under softirq context, thus the lock acquisition
> on &tx->lock seems better use spin_lock_bh() to prevent possible
> deadlock.
>
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
>
> tipc_crypto_work_rx() <workqueue>
> --> tipc_crypto_key_distr()
> --> tipc_bcast_xmit()
> --> tipc_bcbase_xmit()
> --> tipc_bearer_bc_xmit()
> --> tipc_crypto_xmit()
> --> tipc_ehdr_build()
> --> tipc_crypto_key_revoke()
> --> spin_lock(&tx->lock)
> <timer interrupt>
>     --> tipc_disc_timeout()
>     --> tipc_bearer_xmit_skb()
>     --> tipc_crypto_xmit()
>     --> tipc_ehdr_build()
>     --> tipc_crypto_key_revoke()
>     --> spin_lock(&tx->lock) <deadlock here>
>
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>   net/tipc/crypto.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index 302fd749c424..43c3f1c971b8 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c
> @@ -1441,14 +1441,14 @@ static int tipc_crypto_key_revoke(struct net *net, u8 tx_key)
>   	struct tipc_crypto *tx = tipc_net(net)->crypto_tx;
>   	struct tipc_key key;
>   
> -	spin_lock(&tx->lock);
> +	spin_lock_bh(&tx->lock);
>   	key = tx->key;
>   	WARN_ON(!key.active || tx_key != key.active);
>   
>   	/* Free the active key */
>   	tipc_crypto_key_set_state(tx, key.passive, 0, key.pending);
>   	tipc_crypto_key_detach(tx->aead[key.active], &tx->lock);
> -	spin_unlock(&tx->lock);
> +	spin_unlock_bh(&tx->lock);
>   
>   	pr_warn("%s: key is revoked\n", tx->name);
>   	return -EKEYREVOKED;
Acked-by: Jon Maloy <jmaloy@redhat.com>

