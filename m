Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7315C7C4510
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjJJWvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjJJWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:51:22 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72F7E3;
        Tue, 10 Oct 2023 15:51:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c67060fdfaso4270598a34.2;
        Tue, 10 Oct 2023 15:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696978276; x=1697583076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAPx7emm+jvc2q+Bc3jRC8KUctxaIgAys23gkHTb/Ng=;
        b=MtF6M9bZ/NnRGwat9LutdqYWFFBegynfMrSQDEbc/N5yBgtfSitCWRI3DCT0hwFfFQ
         V+oBnVxQN9OwOnBPDg3iCGgkp7FVKiIVvimEnyGQVF5olaWdgCSSqYzqRBjbAYqEH9/Q
         oIWv9Ougp6zTHsCreSAZrhGnVtMkMskTFqTcit2Kpe4A2dHqPf/gNg68VMMG8iZkOj0e
         x3WL+oFBxeBQlHuoD5fCd53pCwoJqoUwRzYNWNQHGVwLnQRaocIaINN6MiKsnNij/c5p
         gAgr8mMxuXPGuuwIKcefWVECxu0QG/cshuzEdasQQA2H50C/SIA0kFvD/wpqkPOmfX/a
         JtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978276; x=1697583076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAPx7emm+jvc2q+Bc3jRC8KUctxaIgAys23gkHTb/Ng=;
        b=mICC7/ib+xGjQ3v1TZtvktvw9sp+yOUqd/tfROo0+ZDU8ZSNvjJrAbXihEmybLNwcp
         wqg/3CpUc4KkYBzEslyaUvksr/l93s3MFDMOfWV8FHaeeVrpmWmW3vdv0f7BbV5Gm0kw
         mhkbJNPrpSCjzqJ5QEJPq7cmTFSW/m7iY1akW8V5NCmaBU4o2o+cbrCbtGgpplSu4Qp3
         QLdsK28XyXliISuBt21PGDq+2SNbfc9t317tny4L3IB7cYdZVcH6CpC9Z8+QMv9gUI92
         tsVoAnYsBMK76bzi/OUJmdQDe5bf5c2S3G1QShbcYc9o8maC5hQMHZbzFLdPvjd/m672
         hPrg==
X-Gm-Message-State: AOJu0YypkZ6ImCUaEGC6ImTJ4jGVAKE9Jn9RaWd/biY0eDRBiBhbmbOW
        hXn9wBHQYouKmhztH1m5mRs=
X-Google-Smtp-Source: AGHT+IH+5J16uc3L0kkDA8aO9xcwVg1Eq67MFvQMo7wRDvdT9c4px7qlZSXwP6e3Rp0AaG9N5LfKcg==
X-Received: by 2002:a05:6830:442:b0:6c6:42ca:ed52 with SMTP id d2-20020a056830044200b006c642caed52mr20713072otc.30.1696978276144;
        Tue, 10 Oct 2023 15:51:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s29-20020a63925d000000b0059a1c256bb2sm2545977pgn.60.2023.10.10.15.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 15:51:15 -0700 (PDT)
Message-ID: <ab48efc3-9f40-4eed-bdb1-4ce04d3c55cf@gmail.com>
Date:   Tue, 10 Oct 2023 15:51:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove extra unlock for the mutex
Content-Language: en-US
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 15:46, Abhinav Singh wrote:
> There is a double unlock on mutex. This can cause undefined behaviour.

Where is the double unlock of head->lock (which is a spinlock and not a 
mutex, btw)?

> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>   net/ipv4/inet_connection_sock.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index aeebe8816689..f11fe8c727a4 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -597,7 +597,6 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
>   	}
>   	if (head2_lock_acquired)
>   		spin_unlock(&head2->lock);
> -	spin_unlock_bh(&head->lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(inet_csk_get_port);

-- 
Florian

