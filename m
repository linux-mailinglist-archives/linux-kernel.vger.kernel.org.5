Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC39278FBEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbjIAKxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjIAKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:53:36 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E510CE;
        Fri,  1 Sep 2023 03:53:33 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so2086401a91.0;
        Fri, 01 Sep 2023 03:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693565613; x=1694170413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWZQOEBhVxoOt4tiQqlHUEMdli9ckDzD5FzzgBxRbUE=;
        b=M4TpwkcFKIhTR143nsWIg8eLxYTFgn9YpXehWxC9P48CA+VMyw2HcMBOB80koJDkuY
         TSy6N87cur9+X9NpwCk9oO+eTouYgxlrQQHEHZYqPqZWkKHKVpwF9XRlAy//TrGWtUSi
         AZSWlM0CtRj1euE9k1MByZR44rhemdryC4Z9X2+WsOrnKmlnr5i3WTOx+Xtfj2/l29IJ
         Qwy2x7g3raAXYmkQYJX+Zgkyy8R7KnkeYT8+TeaYuhE3fCQGHC11jvGg64yt2wiujptm
         wuSKgf517OPKEehKGtQuHflfWpEr+17TOXKLM0daMzDHyDdC0R2NbQXVXFOlwncXXR5O
         /AeA==
X-Gm-Message-State: AOJu0YwNQGGSO4y3MFLmEgjXrxss86DMCpsJAPhFiMdk1NGByLeejBVT
        JZ4tVG6g6Am+DyzCt0HT2hMXwVrdLi3L8TEmU4U=
X-Google-Smtp-Source: AGHT+IHhVLMZe0+O1NerBCfGRiwl5y30FYWye0njx9w566sNUkxJRRfEq/ORX6uAUsYDbODgfRqDBFVrhKW5mQMAcX4=
X-Received: by 2002:a17:90a:9cc:b0:268:8ff2:5c0d with SMTP id
 70-20020a17090a09cc00b002688ff25c0dmr2879920pjo.17.1693565612603; Fri, 01 Sep
 2023 03:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230901082755.27104-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230901082755.27104-1-jiasheng@iscas.ac.cn>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 1 Sep 2023 19:53:21 +0900
Message-ID: <CAMZ6RqK3MWEmEO8Yt3KjCYakya5cG0ccxGPcqbHpM2imKuzpVg@mail.gmail.com>
Subject: Re: [PATCH] can: etas_es58x: Add check for alloc_can_err_skb
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        arunachalam.santhanam@in.bosch.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri. 1 Sept 2023 at 19:22, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
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
>         }
>
>         skb = alloc_can_err_skb(netdev, &cf);
> +       if (!skb)
> +               return -ENOMEM;

NAK.

The checks on skb or cf are skipped intentionally here in order to
continue the error handling.

Later in this function, all the access to skb or cf and guarded by an:

        if (cf)

And if cf is not NULL, skb is also guaranteed not to be NULL. For
further details, please refer to this commit:

  https://git.kernel.org/torvalds/c/c8129487441e


Yours sincerely,
Vincent Mailhol

>         switch (error) {
>         case ES58X_ERR_OK:      /* 0: No error */
> --
> 2.25.1
>
