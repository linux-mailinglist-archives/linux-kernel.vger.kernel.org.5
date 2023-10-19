Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45DB7CF738
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbjJSLml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345393AbjJSLmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE11BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697715712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TI/4hZfm5I46y0D29HAGjnS5oa9EwhobJ1CLerArnE=;
        b=Zeeb002vtfB57UtFfyNrl5OVnq/RbdNJow8xHrtE9hnZlFKtIXhEvsIC5LYhEYCIGlXWwD
        4ciBp3Hb8ndwdOtRROFUBcgegEIhSyeNwAmS6h0N7/cxEaWM9PwsA7Ir8Tu58+uJqeEfS2
        q+lPVp7iP+a2k0BBwskQ9pgcoGuVZOE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-HPIcWzPoPAGAnoBghXv9SQ-1; Thu, 19 Oct 2023 07:41:51 -0400
X-MC-Unique: HPIcWzPoPAGAnoBghXv9SQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c39f53775fso63448566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697715710; x=1698320510;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TI/4hZfm5I46y0D29HAGjnS5oa9EwhobJ1CLerArnE=;
        b=SJ1gOQfbPm9KQ3bAHPTLjtTH9quMJHwQIA7tYFgm/G9Rzl9B0kxuJylAaF69RQlerr
         Bcr95fijJeiphxD7f9p7qCZJzgUAK+cz4pGX2Sg+92uiA0H5DBL8QMuCYC6CdT4tT8nS
         kxcfXzuB8hXQz1rHBddFvtpe+uFQh5ncrDXBe+/R4IWG4f054nPb8rlgs1BgoBYqM+YC
         k8BRzAhNYcHC0Q72pN39Q2uaS/k7Hz0Yci7mtWfluCeEZe+Nayl1ic/rWH2tvqWhPKUe
         5pFadvmSxEgK5zAWTCgxJ6/xVmvzEaVHHa8kZEzCoiE8B8n7eLCEJHIDYBzAKbNjG1xx
         Z4OQ==
X-Gm-Message-State: AOJu0Yyo6WVzlYZDJps5LL612j14c46/PftXjInmRGoeWQbsx7uWY5zj
        QQiQR1bMF1uVhX7x6SUJO0rcKonqN4sT59rkgxl07/DCdn/lpZGk8seBiROJR6jCQiB36nMEoka
        gn34kh9slVrz94HVksNmjf9Au
X-Received: by 2002:a17:906:4784:b0:9c3:cefa:93c9 with SMTP id cw4-20020a170906478400b009c3cefa93c9mr1808807ejc.1.1697715710014;
        Thu, 19 Oct 2023 04:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzMsXhjyZ1KyMPesr+FdqrKQeZhrb69MrG73o73/8eoTBlCnEASSAFf3oHjlmBS3SYfsbjBg==
X-Received: by 2002:a17:906:4784:b0:9c3:cefa:93c9 with SMTP id cw4-20020a170906478400b009c3cefa93c9mr1808793ejc.1.1697715709608;
        Thu, 19 Oct 2023 04:41:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id g13-20020a1709063b0d00b009ae3e6c342asm3421743ejf.111.2023.10.19.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:41:49 -0700 (PDT)
Message-ID: <4c68b650b02b2a49f90cdf3a0084cf31bd6c7979.camel@redhat.com>
Subject: Re: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on
 raising memory
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Oct 2023 13:41:48 +0200
In-Reply-To: <c3110f12-5d9f-4907-a712-5a1004ec4fdc@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
         <20231016132812.63703-3-wuyun.abel@bytedance.com>
         <d1271d557adb68b5f77649861faf470f265e9f6b.camel@redhat.com>
         <c3110f12-5d9f-4907-a712-5a1004ec4fdc@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-19 at 19:23 +0800, Abel Wu wrote:
> On 10/19/23 4:53 PM, Paolo Abeni Wrote:
> > On Mon, 2023-10-16 at 21:28 +0800, Abel Wu wrote:
> > > Before sockets became aware of net-memcg's memory pressure since
> > > commit e1aab161e013 ("socket: initial cgroup code."), the memory
> > > usage would be granted to raise if below average even when under
> > > protocol's pressure. This provides fairness among the sockets of
> > > same protocol.
> > >=20
> > > That commit changes this because the heuristic will also be
> > > effective when only memcg is under pressure which makes no sense.
> > > Fix this by reverting to the behavior before that commit.
> > >=20
> > > After this fix, __sk_mem_raise_allocated() no longer considers
> > > memcg's pressure. As memcgs are isolated from each other w.r.t.
> > > memory accounting, consuming one's budget won't affect others.
> > > So except the places where buffer sizes are needed to be tuned,
> > > allow workloads to use the memory they are provisioned.
> > >=20
> > > Fixes: e1aab161e013 ("socket: initial cgroup code.")
> >=20
> > I think it's better to drop this fixes tag. This is a functional change
> > and with such tag on at this point of the cycle, will land soon into
> > every stable tree. That feels not appropriate.
> >=20
> > Please repost without such tag, thanks!
> >=20
> > You can send the change to stables trees later, if needed.
>=20
> OK. Shall I add a Acked-by tag for you?

Let's be formal:

Acked-by: Paolo Abeni <pabeni@redhat.com>

/P

