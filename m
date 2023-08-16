Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0F77E645
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbjHPQXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbjHPQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:23:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6887310C8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:23:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40a47e8e38dso320261cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692202994; x=1692807794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEUQJmCPLmerzzrEwbFkonmpbNVXBI0EafuTDjuODgI=;
        b=ViELFEs4iBXiNl3oyvsbvdWS5sMvhkvVRHTlOkbbnxutaEVMirOD70fgY7xfQ4wJ1h
         KSjnLDNvFp0ye7FCxUP7ANGfmKsApFxQCBCnuEMV7/VYu5Tdy+ltAX3ClcRERG6pp6th
         QJ0JdXgq4CILXXcUFylC+H3p68cZ5hc5ZLMFjOZPJhBBWPDesgLX1Z4jB/UyOHkAdnZT
         UZMOEfmzrFfUQsFltUxx0R1yk+v27RhmyWgZqY0+vpL/OuLtn696eS90SLulEUtjJj7c
         Hoa8FE6DIZ0hfbouvDlJZneuVHxYCNWiRJFO0zb6NZodteTO+k0ZprJcXvov0cx520zP
         b3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202994; x=1692807794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEUQJmCPLmerzzrEwbFkonmpbNVXBI0EafuTDjuODgI=;
        b=erhcZ+D9JdTXZSpnorec+jQkts9+GgyaMh7A4cdk2DsLnDfGR0nYNEQNuSYAZ7TxSk
         /7gUIyR4gdJtrp3xJzVGQH5+PXStwQI9e6j69kCIou2HWYcpdBOgerdYcAgrhiWB++P0
         A1t90162Z+3q7PjK7V5DPsvO21C/TJNLcgVxMuPrKigU+H9Ju0Oie8I3wgA18bbrNeaf
         CRDwUaFRNBGXOmWTk8P7zQ6GDPCfS/Yf+KQY2ypzvl0ux3PnV6sJfIU93Cmx4k3LY1fD
         ij4QzgiDO9+ajisFfUr/8qvqrJzo/5Xf77naDzdvdpvqm/cTEj2is/xpQXkM9/aCplBv
         Eh0w==
X-Gm-Message-State: AOJu0YzXe/GgrJ2ymuvk/7anOTVdWMMBMh+o8faddJdvGA3RBiCsT5qU
        Sk+u5/+FBRNrZ6HkKNJjoaL/O7c/hLECZYjbioxBOQ==
X-Google-Smtp-Source: AGHT+IFyEVVKy/asOtDpBVx6rfWd7O9n3x5WJT4ImKg1bBFkt9Uz1iwi+ExO1c/wLNJE3vcz/vlSiIeyMRplniQ3NoY=
X-Received: by 2002:a05:622a:110:b0:3fa:3c8f:3435 with SMTP id
 u16-20020a05622a011000b003fa3c8f3435mr240089qtw.27.1692202994422; Wed, 16 Aug
 2023 09:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230816091226.1542-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230816091226.1542-1-wuyun.abel@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Aug 2023 09:23:02 -0700
Message-ID: <CALvZod7WrDF8he9djE6i5DyteR5Bz=w35r1q882QDuYb6dWSRg@mail.gmail.com>
Subject: Re: [PATCH net] sock: Fix misuse of sk_under_memory_pressure()
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Glauber Costa <glommer@parallels.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 2:12=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> The status of global socket memory pressure is updated when:
>
>   a) __sk_mem_raise_allocated():
>
>         enter: sk_memory_allocated(sk) >  sysctl_mem[1]
>         leave: sk_memory_allocated(sk) <=3D sysctl_mem[0]
>
>   b) __sk_mem_reduce_allocated():
>
>         leave: sk_under_memory_pressure(sk) &&
>                 sk_memory_allocated(sk) < sysctl_mem[0]
>
> So the conditions of leaving global pressure are inconstant, which
> may lead to the situation that one pressured net-memcg prevents the
> global pressure from being cleared when there is indeed no global
> pressure, thus the global constrains are still in effect unexpectedly
> on the other sockets.
>
> This patch fixes this by ignoring the net-memcg's pressure when
> deciding whether should leave global memory pressure.
>
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
