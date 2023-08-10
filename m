Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20597770BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHJGxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjHJGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:53:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3710C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:53:35 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so128431cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691650415; x=1692255215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SXCT/2gawCNMaorMZ7NOA4GCE3vpl+t+8z7dja7EwU=;
        b=k/nJYM/0P5WRKY/9FrmaDZqWiO046TENSs0xMrdnfbdDUxk1mPNrHRR+cDjydD7NFd
         b3r6XMSR08E1FyNZBCwZ+lqaW6ytPEi1335respAKmqyRdd8G1mE1xGXU6AHDEd9SrcB
         Zj+Pl93ymf28tiTRT0rZ6NEsQ24KCnSMKkqQWfxzAFkJphGAKs2cfXR1vYi3FQbmXrFg
         tEGT/W3paPeVWn1BJLQSfjajgb1B6A+Wrhwop1xlHWPBTFiqlH25yRrqBItvTS4GN0p/
         MVBx/NZ7ULlL0/y1dohbBztjkFahpK/bOZdbDP0IDnwM7xz8ihwBoFGCiU3YeHjwU+lH
         PlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691650415; x=1692255215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SXCT/2gawCNMaorMZ7NOA4GCE3vpl+t+8z7dja7EwU=;
        b=e8664Mtt5v4q0ndJ+inop3vJB2d840BqLWw00y8qPesN2cT1+zxq9l2QTTE8a8cmOW
         zTi1jdmIEqc1jlHi8/Kw8FV1ZyrMKecq1JzT4fT9kVg54ifO3RjrOxI6E6KOjnurgs6h
         bnVIlWk69/DSGQRqxIqjJpi0Ra7pKr0Yz10BKVxpCxuUpmIGIPIBJQIoZS2iLvbqGeoL
         2zPSd38Tu1cgZznrIfJZ/Z7om2Oy982hFdRCY5tyGln386M4hRuBkOCRWaaHZUN0bAJY
         V/8dIacdn7iXDQdUeZsQVY+htPAHOIRDLbFp3EDjaPW0gcwo0qTASIByZPNqRH05sa5V
         eOSg==
X-Gm-Message-State: AOJu0YyKJmO+xm4ahqkaHcsAGFkzLZu80aMQFopzmeiqJKEIYfR5I7aF
        /2b21EmMtF64CDJ2z6Czpjh6KRPjsmmtBWFnGqlAoQ==
X-Google-Smtp-Source: AGHT+IGjbLMDBw3eHhD81jqgbpuCV6OqepVleEETJMwmfJagyg2iKtKs4dRp3YvwhOullwESxhhqV0aKqClwBtSdCyM=
X-Received: by 2002:a05:622a:1816:b0:403:aee3:64f7 with SMTP id
 t22-20020a05622a181600b00403aee364f7mr288282qtc.6.1691650414804; Wed, 09 Aug
 2023 23:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230809164753.2247594-1-trdgn@amazon.com>
In-Reply-To: <20230809164753.2247594-1-trdgn@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 10 Aug 2023 08:53:23 +0200
Message-ID: <CANn89iKvh=da2uRkGn5dTX5Yxvz-uZdSJoKf0+pPU16XVDt=fg@mail.gmail.com>
Subject: Re: [PATCH v4] tun: avoid high-order page allocation for packet header
To:     Tahsin Erdogan <trdgn@amazon.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 9, 2023 at 6:48=E2=80=AFPM Tahsin Erdogan <trdgn@amazon.com> wr=
ote:
>
> When gso.hdr_len is zero and a packet is transmitted via write() or
> writev(), all payload is treated as header which requires a contiguous
> memory allocation. This allocation request is harder to satisfy, and may
> even fail if there is enough fragmentation.
>
> Note that sendmsg() code path limits the linear copy length, so this chan=
ge
> makes write()/writev() and sendmsg() paths more consistent.
>
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
