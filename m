Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223F7E93C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjKMA5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMA5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:57:01 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E263819A3;
        Sun, 12 Nov 2023 16:56:58 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7781bc3783fso268388285a.1;
        Sun, 12 Nov 2023 16:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699837018; x=1700441818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9QZ1n8POJh9+TvhL/Oy+pYpky3GU7bSBr0YDOk94J8=;
        b=esw4ADa4wWYbo2pVBLLbHdZ6kUtFfbZ85I+tIotfY9eYBNSvS8CZnEKizAJAhXS769
         VDTUT1Ze1OPrplczDEi41iWO5IuAnjLHgcgDtKVVd25DqG+NqcMDs3Kxbo72DoQ/isPC
         GLf8FIaKV5a66jb5eqWM+BzXCBnbNKrojRh7qcqnR7lqmKbh/G43LYtJBplApPY7L2De
         rKmzlueRrrJ3/Zx+imbeIY8AtCCjZEim7DSRGy49iuh9rRdmPsiUe2Pu0L+Akm6a7JES
         qMf8l9xzHHaLuE+N+gaRHbqIHcwIinYQDD0eLJO818As/Z2CStrMk3kPys4RvHog1Cwu
         7rwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699837018; x=1700441818;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9QZ1n8POJh9+TvhL/Oy+pYpky3GU7bSBr0YDOk94J8=;
        b=blrasRQ/y7YJBt2b6cF4aoIqyZOyQcvYyoyhUnA/DSl5nM4yy6Ahie0WyvuTKBkD4L
         GlaGFwttqfJkfiQX2HI0RUJd1u6oGXhMekQMbG+8v7uOgNkrko5qv4odFu6I0p3Anxpi
         cZ0Ou2bzm9kHjjaE7weJmdECbYoDOJ8abghq5DyBk11dPPBkqQpxfqO/gc0/gy7ogksU
         ACBReYOoSVt3zFhmeilM3LrXE/XjW1jaJI364eRFg4eZ9J8e+qQl5odwb1LSSv+qy50d
         2ZTgBrguipNeojFftSDkn5RKDSr7FEF1WCNfjKnHzP131J0CvClf9UC+FOBR+yP2hfCk
         n0Dg==
X-Gm-Message-State: AOJu0YyQMLUV0Y84BZjlK1vIv7rhGtVi6l4voue+dlHLWsQCwcblQ3k9
        JIVf3txy/+4+eEY84m11go8=
X-Google-Smtp-Source: AGHT+IH7rZFdulENijlkHxzeB6f1z9NgqYbwBtQgkfE8f/ZAnH0JFduNGoTsfSW5f6F5jCWI49besQ==
X-Received: by 2002:a05:620a:2981:b0:77b:c493:b5f9 with SMTP id r1-20020a05620a298100b0077bc493b5f9mr7003496qkp.57.1699837017939;
        Sun, 12 Nov 2023 16:56:57 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id qq3-20020a05620a38c300b0076d08d5f93asm1500421qkn.60.2023.11.12.16.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 16:56:57 -0800 (PST)
Date:   Sun, 12 Nov 2023 19:56:56 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com
Message-ID: <65517458ef995_a08352943@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231110173632.2511-1-bragathemanick0908@gmail.com>
References: <20231110173632.2511-1-bragathemanick0908@gmail.com>
Subject: Re: [PATCH] net: memory leak in nr_rx_frame
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bragatheswaran Manickavel wrote:
> The condition (make = nr_make_new(sk)) == NULL suggests
> that nr_make_new allocates memory and returns a pointer.
> If this allocation fails (returns NULL), it indicates a
> potential memory leak.
> 
> Added sock_put() for make which can potentially solve
> this issue
> 
> Reported-by: syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0145ea560de205bc09f0
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  net/netrom/af_netrom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index 0eed00184adf..7d7cda4ae300 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -970,6 +970,8 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
>  		nr_transmit_refusal(skb, 0);
>  		if (sk)
>  			sock_put(sk);
> +		if (make)
> +			sock_put(make);
>  		return 0;
>  	}

If the branch is entered because (make = nr_make_new(sk)) == NULL then
make is.. NULL. If the branch is entered for one if the earlier two
conditions failing, then make is undefined.

The syzbot report is that make is allocated here and eventually
nothing points to this still allocated memory. It does not report
where the last reference was lost. Not inside this branch.
