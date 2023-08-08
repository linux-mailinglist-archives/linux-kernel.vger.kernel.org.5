Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352BA77435C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHHSCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjHHSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:02:17 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C609CCF1C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:28:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4036bd4fff1so301651cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691512082; x=1692116882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOAkw9vX1bFj+8ur0a4XlOPe+B5XLi+XT1bzG2Ujp3w=;
        b=CYf860r2y957iF60qC+96n1hQzJHovb/pxziMlw/MUNX7mMHcG5UpKG6ok57RX72Hp
         lk6eWyVfbQnA2d3G6+qk49LHBwZptED6C42s4/Z81W9CLBrPdiWDSQj8oCwlnou9+cb5
         er1xnCf48/dNN1/Qis0KCZAnEIa7seDQ5xywWG0yfacstuhbdd7NYabNimFnL2pc8ifN
         wbmmy5QGEVadAXtKy22p1tKfjXBLf+ivW7IhvHIPMCBAiePlKrPPHoXNN5AB9+2RR8kh
         ENYpkWLjPHtv0hAgAKfptnUJ6+oJy5ZprowHXElQbGyOyxHdSWc69iImIUcY/8Hhb0Wt
         IDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512082; x=1692116882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOAkw9vX1bFj+8ur0a4XlOPe+B5XLi+XT1bzG2Ujp3w=;
        b=Ux6yvprImIgMcNAUWsSNLM/tBrtWTEqrjGvoK3TUWUFfQDWpypvEXBrIrCri3qoPPv
         744KXKOJRYDK1nTL0Ia0Vl3hOktX+FraV7b8i/IDjxEg3Kccjz4SmkjrD0/JsPbxKGJk
         0IcO2R/k5f0OnbQ6c4R7WeCLFK47n3lMifJXUi/D4rn5fLfARsN4yDWSpTZGR36K2ts7
         Dr06mMVJTtSY9w9fqjj7ZLUHB5lZrKZG2b3K1oJdpFlpWprZ5n0TGL4JnsQgQVn0UdCx
         ipwqsocFddJ3cib+ZCn/+rohz8kwftvDVuAgxpmns8yDOYeg6ws0FXtx5OO67pfmBjg2
         DmtQ==
X-Gm-Message-State: AOJu0Ywmmc0DCIjU/L7DZZV4b9BPGH5Qh11+PpkPt9v1kZmcqJ/9X+sV
        FomA3vvtk2O7PSMn4XQ0C1gaAGOgjyLOIHGJ2tllVsMrJpCAC7H7ezk=
X-Google-Smtp-Source: AGHT+IFqstGgotZzb4KFoXK1TD3nC1rcdCXQr6OMNvalH3JDWasJN0aI8XT37ZKsEsm8j1LN/OnjGht5kTFZxnPOKus=
X-Received: by 2002:a05:622a:1456:b0:3fa:45ab:22a5 with SMTP id
 v22-20020a05622a145600b003fa45ab22a5mr586164qtx.27.1691479748884; Tue, 08 Aug
 2023 00:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com> <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
 <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com> <1327499ea2f2b43c9de485435e028797198ea2aa.camel@amazon.com>
In-Reply-To: <1327499ea2f2b43c9de485435e028797198ea2aa.camel@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 09:28:57 +0200
Message-ID: <CANn89i+hMLpUD3DtiygnM09jfLcpg1N1mYMqUzv0wXWM3-SAKQ@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To:     "Erdogan, Tahsin" <trdgn@amazon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 3:22=E2=80=AFAM Erdogan, Tahsin <trdgn@amazon.com> w=
rote:

> Hi Eric, I believe your changes are merged. Are we good to apply my
> patch next?

Sure thing, please rebase and resend.

Thanks.
