Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA98978FC1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbjIALMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349105AbjIALMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:12:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B9A107;
        Fri,  1 Sep 2023 04:12:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 33DEA1F45E;
        Fri,  1 Sep 2023 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693566746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qA31knuQGMKkbCxHuD0KfED2+pMUYgwjt4x2MR5OHvg=;
        b=PmuL+DrcX/I0nP6KDLqTkG2hxCE2ya7cfJQ14v+Zs4z0NbZq3PE5Q9hUH1SUHuPW5Fc1MV
        mro+IfBzU9SiAaBkr4spg4gG2Wi8XwgKdOBdyORGzt+qZWepas9L4bRlWsafUFmPzuEGqn
        R6SvCDAivyU/swutJsRtn8YOStFEgNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693566746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qA31knuQGMKkbCxHuD0KfED2+pMUYgwjt4x2MR5OHvg=;
        b=JbgbSDYMWUj67nUAINKeTK9jn5EPAnq9LswZOWtmT+4wLoAtMzdie2O2tu4THXqn8dCpGG
        GZkdUfowyo6uVqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB5E913582;
        Fri,  1 Sep 2023 11:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BpbvLxnH8WSFeAAAMHmgww
        (envelope-from <dkirjanov@suse.de>); Fri, 01 Sep 2023 11:12:25 +0000
Message-ID: <4d953daf-f426-e2fe-ca27-6da30fddaa40@suse.de>
Date:   Fri, 1 Sep 2023 14:12:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] can: etas_es58x: Add check for alloc_can_err_skb
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, mailhol.vincent@wanadoo.fr,
        wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        arunachalam.santhanam@in.bosch.com
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230901082755.27104-1-jiasheng@iscas.ac.cn>
From:   Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20230901082755.27104-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/23 11:27, Jiasheng Jiang wrote:
> Add check for the return value of alloc_can_err_skb in order to
> avoid NULL pointer dereference.
> 
> Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index 0c7f7505632c..d694cb22d9f4 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -680,6 +680,8 @@ int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
>  	}
>  
>  	skb = alloc_can_err_skb(netdev, &cf);
> +	if (!skb)
> +		return -ENOMEM;

Should you adjust the stats for dropped packets as well?

>  
>  	switch (error) {
>  	case ES58X_ERR_OK:	/* 0: No error */
