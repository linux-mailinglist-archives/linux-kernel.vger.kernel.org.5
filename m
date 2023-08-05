Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C325770F72
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHEL1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHEL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 07:27:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC22468C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 04:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228B560CEC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13A2C433C8;
        Sat,  5 Aug 2023 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691234820;
        bh=MPFDaEPMaDAQrnaY+HCii+Xg819lddX2AnQYfGV07TQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYSXrBrq7Xoo6/iJErFdYr9xTYjzFaqi/v8Q48WblzTYKBUqzSlFuAZyPAIsyKG6W
         QxP3+Wa0EgWR6sdpcQcnKESpt+veuf9W6dRojFTCX5yj1XqxNc4Y4p3KNC5COHsPFL
         7rqSXnSv1XE5tnTwlijQSM5LDcSsvEg8K4bBHQswL3J1s9t6sjjE4YkjypoAHUB9hY
         XAGvJPTvyR7jkAJvYPty7JUvP2hqLqO4jXLqfMc+vaglCbiFmCctjrKdp6VoK/qGuk
         AyyyYvfsDd5u5iFKSz5LBgYDjlfR26elajy0LrXA1tBPo03+j7Tnbj+duNHbdQKg7m
         bhjt4XZM4ubAQ==
Date:   Sat, 5 Aug 2023 13:26:56 +0200
From:   Simon Horman <horms@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     jmaloy@redhat.com, davem@davemloft.net, ying.xue@windriver.com,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tipc: add net device refcount tracker for bearer
Message-ID: <ZM4yAOKtdcTBXQQY@vergenet.net>
References: <202308041653414100323@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308041653414100323@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:53:41PM +0800, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Add net device refcount tracker to the struct tipc_bearer.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
> Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>

...

> @@ -479,7 +479,7 @@ void tipc_disable_l2_media(struct tipc_bearer *b)
>  	dev_remove_pack(&b->pt);
>  	RCU_INIT_POINTER(dev->tipc_ptr, NULL);
>  	synchronize_net();
> -	dev_put(dev);
> +	netdev_put(dev, &b->devtracker);
>  }
> 
>  /**
> diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
> index 41eac1ee0c09..1adeaf94aa62 100644
> --- a/net/tipc/bearer.h
> +++ b/net/tipc/bearer.h
> @@ -174,6 +174,7 @@ struct tipc_bearer {
>  	u16 encap_hlen;
>  	unsigned long up;
>  	refcount_t refcnt;
> +	netdevice_tracker	devtracker;

Hi Xu Xin and Yang Yang,

Please add netdevice_tracker to the kernel doc for struct tipc_bearer,
which appears just above the definition of the structure.

>  };
> 
>  struct tipc_bearer_names {

With that fixed, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: changes-requested

