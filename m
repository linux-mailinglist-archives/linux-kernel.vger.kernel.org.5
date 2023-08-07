Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0619772827
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjHGOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjHGOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:48:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FA10CA;
        Mon,  7 Aug 2023 07:48:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so3045229b3a.2;
        Mon, 07 Aug 2023 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691419737; x=1692024537;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aXST5XxnGg1D08Ob0oYRqu+Z1E9omOLSCpAH/+XiMLs=;
        b=bNDMN7arOAYFRZ2/QkHGwK14diK23U2mN4xbnZ94Aq8NWczhGROVH+bOBcDZ36WBCB
         WJOMSqlXJGejs6VRuf1vySrPWjenvkn2r73YkKVfZs9PomjujonCjM2w+mbYgPH4aro+
         HvIdyZDJoOdvOwXBEh+JJXDsaDjROlZwhMdBDy8QQpPmFI3YgRd5kCoqDISsZhO1dP91
         NMVlcb2/w/EIcpMpJwiAef3YrydNoL1YVO8ODy6GwiB7qenRhxyK8wVIxxOX81on2lby
         3DkG6WigvNZpARt9cmrkDwvyB3HkC+SYfvl2jSZSLfsmX0xyZ56EcmPqNp491Mq7C6lK
         V9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419737; x=1692024537;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXST5XxnGg1D08Ob0oYRqu+Z1E9omOLSCpAH/+XiMLs=;
        b=lCKlU7cSH2iTe7fzkfUnHllvjgP28x7EklQvnjwCYZHFlsSz/LrFT1dCNFdU2QV2Rx
         16yhKeZn6r7VoAUKwcG9MLN1xkEe6Ca7bICMueVK8jHgNxE9/r6JDI4Dl3RZOEXapdj2
         /6Mv4kn2wLxYEXa4HmXnFE4ya6WSuEnxgbmimM5ksGuIWJJYqR77LpjMM3Xtou1feC+R
         qygZapCBJ5kx6mG9HrT+oXwzqepdDRxMaK2AUMUu9zfKvlcZgrcRwiL4d2jBisIHty4x
         XuGHV9ytxsZZCnsM46JY+VtAnA42AsorXa54EKwRwoCaKujYdPlTrUYXPxS4euTPms38
         CjFw==
X-Gm-Message-State: AOJu0Yzi2D1PIdo8wYfqCWzi7ux5NPGimwvdwhWoRqcPavKT9RI1hu0H
        WRIqwoq0SC0/JlNf79l8x8M=
X-Google-Smtp-Source: AGHT+IGkGhlsT77JX5NjIBC+P5CszcxwznFI8rPMg/L56P5rbDzLbURH8+oaRk+RVPq1WwkRen4KEQ==
X-Received: by 2002:a05:6a20:258e:b0:13b:7776:ceed with SMTP id k14-20020a056a20258e00b0013b7776ceedmr9332434pzd.26.1691419736966;
        Mon, 07 Aug 2023 07:48:56 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d20-20020a170902c19400b001bbb7af4963sm7035140pld.68.2023.08.07.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:48:56 -0700 (PDT)
Message-ID: <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
Subject: Re: [PATCH net-next v4 5/6] page_pool: add a lockdep check for
 recycling in hardirq
From:   Alexander H Duyck <alexander.duyck@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Aug 2023 07:48:54 -0700
In-Reply-To: <20230804180529.2483231-6-aleksander.lobakin@intel.com>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
         <20230804180529.2483231-6-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 20:05 +0200, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
>=20
> Page pool use in hardirq is prohibited, add debug checks
> to catch misuses. IIRC we previously discussed using
> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
> that people will have DEBUG_NET enabled in perf testing.
> I don't think anyone enables lockdep in perf testing,
> so use lockdep to avoid pushback and arguing :)
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/lockdep.h | 7 +++++++
>  net/core/page_pool.c    | 2 ++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 310f85903c91..dc2844b071c2 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -625,6 +625,12 @@ do {									\
>  	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
>  } while (0)
> =20
> +#define lockdep_assert_no_hardirq()					\
> +do {									\
> +	WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
> +					   !this_cpu_read(hardirqs_enabled))); \
> +} while (0)
> +
>  #define lockdep_assert_preemption_enabled()				\
>  do {									\
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> @@ -659,6 +665,7 @@ do {									\
>  # define lockdep_assert_irqs_enabled() do { } while (0)
>  # define lockdep_assert_irqs_disabled() do { } while (0)
>  # define lockdep_assert_in_irq() do { } while (0)
> +# define lockdep_assert_no_hardirq() do { } while (0)
> =20
>  # define lockdep_assert_preemption_enabled() do { } while (0)
>  # define lockdep_assert_preemption_disabled() do { } while (0)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 03ad74d25959..77cb75e63aca 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -587,6 +587,8 @@ static __always_inline struct page *
>  __page_pool_put_page(struct page_pool *pool, struct page *page,
>  		     unsigned int dma_sync_size, bool allow_direct)
>  {
> +	lockdep_assert_no_hardirq();
> +
>  	/* This allocator is optimized for the XDP mode that uses
>  	 * one-frame-per-page, but have fallbacks that act like the
>  	 * regular page allocator APIs.

So two points.

First could we look at moving this inside the if statement just before
we return the page, as there isn't a risk until we get into that path
of needing a lock.

Secondly rather than returning an error is there any reason why we
couldn't just look at not returning page and instead just drop into the
release path which wouldn't take the locks in the first place? Either
that or I would even be good with some combination of the two where we
threw a warning, but still just dropped the page so we reduce our risk
further of actually locking things up.
