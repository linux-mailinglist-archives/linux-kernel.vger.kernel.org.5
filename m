Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61CF770E2E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjHEGqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHEGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:46:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9F4EDD;
        Fri,  4 Aug 2023 23:46:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-5645bbc82aaso1965352a12.2;
        Fri, 04 Aug 2023 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691217969; x=1691822769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajr4QLjd6Rc1PuAnxwRP/L4oJ5MAFVSkzlw/8yRBgC8=;
        b=h8NU5D89GbEww2egnB9jM+tYETO5t4H7CEIrEYSTNwcxa0UKVRtWaj0FSbVMQEtxsp
         k4IutRNvozDQ94f3zarpzOsvwXOqAVmJ6i9RpWHez/EKtSeznqsoF+o2YcmCG1v56vwN
         0ud+UZRSCQY2O+Xt0p4kOvSXzxWyR60pZertUfflvjvP+ojSBOiG/5+VzEyKME/7vBgD
         qUMpvw+ZNtKJxVZUYG0BGRZ8cSuebKnIb5tthkPabpIh7MMK30vgB1F0xMe0LkmqT3M+
         /Ej1xhBnGOQf7Yxc1LXVuEa8kFqI4Iqw/+/8NaGWOMPebBGepBHIsYRCZ2xmH5AUfMJb
         /bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691217969; x=1691822769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ajr4QLjd6Rc1PuAnxwRP/L4oJ5MAFVSkzlw/8yRBgC8=;
        b=EYK0naLYXlv6tTl6qVxHqRxQTgyPtWW93myOj9CTZh3zKs3n3mwEfJP1Y7ZqiEScs9
         eia9Lh9U+jsMB+OM6CX7lQPtiWipY+mYQzW05w6wH8Rw9LaMgMRYZL6uwKpVsV8faDn9
         Z5f25w0U3nWbyPelieD0IgumRcsrdhHNLLNYQZtmVVTFRFhpu2PhXDuqzVnN/J5tNuKW
         w59/IShU/VfzWx4tZsR0Ir+nEYxKmOtuR1npaqyU82dfiQK1DGjw1qRRuV3wzpEXJuEJ
         fw/yKDZAYnbO2m5fjx2zUM/zI1N/GBfTQF9iK0dN1NE77YuXc/pJPT//t4SmxbhZhX2G
         JKNQ==
X-Gm-Message-State: AOJu0YxkHfSTcG7K+Ux1GxSGDsiZFQskz3RQnCB8LWxc23xq44RRlBFo
        4cJocwy5BjG5QoMMSW2v0xE=
X-Google-Smtp-Source: AGHT+IHyL8TMjLqkckuhsndfFZq1zCmMzhQmtrjuWyBaJmr3Jq4aQa4KmblEsZjRJ9pKSTjTrl6MJQ==
X-Received: by 2002:a17:90a:d0f:b0:268:42a2:35db with SMTP id t15-20020a17090a0d0f00b0026842a235dbmr3257478pja.48.1691217969277;
        Fri, 04 Aug 2023 23:46:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a005e00b0025023726fc4sm5520425pjb.26.2023.08.04.23.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 23:46:08 -0700 (PDT)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     edumazet@google.com
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        yang.yang29@zte.com.cn
Subject: [PATCH] net: add net device refcount tracker to pneigh_queue
Date:   Sat,  5 Aug 2023 06:46:06 +0000
Message-Id: <20230805064606.237648-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iK61nt5o7KBZyjqVP6Q1EREvzg-x_bos8hSGSmwfwZRBw@mail.gmail.com>
References: <CANn89iK61nt5o7KBZyjqVP6Q1EREvzg-x_bos8hSGSmwfwZRBw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Add a static net device refcount tracker to neighbour.c to track
>> dev's refcnt when pneigh enqueuing and dequeuing.
>>
>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>> Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
>> Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
>> ---
>
>
>Can you explain how this patch was tested ?
>
>Thanks.

Sorry, I misunderstand the usage of netdev_hold and its netdevice_tracker.

I thought this tracker was simple enough, so I just added an additional netdev_hold
in the same postion and test if there is a warning "unregister_netdevice: waiting for ...".

But as you said, we need a separate netdevice_tracker per netdev_hold(), and specially `per dev`?

Actually, I'm still a little confused.

For example, here, can I move this netdevice_tracker into struct sk_buff ?

>diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>index ddd0f32de20e..56e87130fa95 100644
>--- a/net/core/neighbour.c
>+++ b/net/core/neighbour.c
>@@ -61,6 +61,7 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
> static const struct seq_operations neigh_stat_seq_ops;
> #endif
>
>+static netdevice_tracker pneigh_queue_dev_tracker;
> /*
>    Neighbour hash table buckets are protected with rwlock tbl->lock.
>
>@@ -364,7 +365,7 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
> 	spin_unlock_irqrestore(&list->lock, flags);
>
> 	while ((skb = __skb_dequeue(&tmp))) {
>-		dev_put(skb->dev);
>+		netdev_put(skb->dev, &pneigh_queue_dev_tracker);
> 		kfree_skb(skb);
> 	}
> }
>@@ -1633,7 +1634,7 @@ static void neigh_proxy_process(struct timer_list *t)
> 				kfree_skb(skb);
> 			}
>
>-			dev_put(dev);
>+			netdev_put(skb->dev, &pneigh_queue_dev_tracker);
> 		} else if (!sched_next || tdif < sched_next)
> 			sched_next = tdif;
> 	}
>@@ -1673,7 +1674,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
> 			sched_next = tbl->proxy_timer.expires;
> 	}
> 	skb_dst_drop(skb);
>-	dev_hold(skb->dev);
>+	netdev_hold(skb->dev, &pneigh_queue_dev_tracker, GFP_KERNEL);
> 	__skb_queue_tail(&tbl->proxy_queue, skb);
> 	p->qlen++;
> 	mod_timer(&tbl->proxy_timer, sched_next);
