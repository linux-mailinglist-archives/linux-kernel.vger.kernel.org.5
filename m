Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B1778859
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjHKHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjHKHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:38:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76B2132
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:38:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40a47e8e38dso125321cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739514; x=1692344314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kks36w6bHX4unasxObmVyQSJGyfFC2zILJXj+GYVj9w=;
        b=iulkA4nqhtM0XCPIDilNtBx6s5ey4MieRPzycAJ/osCn1Kk7YqUA8Y49+BTycPldmM
         RbjmJvpmh2B7A82P/WMAf8i27pj6PnejGYm9V/MBLwPciDBWVy7sBoWiuAfqEv4uUenD
         NexUG6VrR4Bz5RRRABD2zfgY3W5KFDyvaLR+R3oe5qHlEMNN9jbBuQVQT2cEDSPudAy7
         tDx1HV0I8Nek9A/ecNkK/yQruaf79+/e5zVrR2OBc3PA8kW5lqezqwH8leo+5ojLPTQC
         VV0TwiJ2Le6J0bqeFksLBTzLK+mzf1RLuTNIJkRVcTQ/1uHoWpDTi8Cgq1SZCTWcs3Rk
         m2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739514; x=1692344314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kks36w6bHX4unasxObmVyQSJGyfFC2zILJXj+GYVj9w=;
        b=LAwmSTG7/Tt4xNQV7rn4jCMTnRsIliVYbDB5uI7XxLebeLJzK1DWMKhktxN1ZYM2BF
         7EHApD8LZYMQZeADUQmFnfkeupsaiMQR/yZuxDvM3IyMrHzay6EBT2DI4eP85ylSgU2M
         4v52VO/2Y1Fb2OhQHROIT/k8c0dOEwhpq7GIpig7IzCCuUHYHnf88xniyO51kxpTFp59
         hBKNhhZ1KdPqtUoEtEPdQFmkHWdTcAoc7N2CdCGKntecKdyMDQYxg9B2RPkNJxgdImgg
         A7LYAH6ltgZ5mwUdLcBvekk6PS/odawKKMFUTha3JUi2dM21/0YEaPIhjTu1lUZ8QMo6
         PEqg==
X-Gm-Message-State: AOJu0Yx3Qnzp2kbKU7KIYnZ7B3DJwYStbRUtRhKy3OHeNPLS3Kn0QCE9
        Srla6xuK8V/GSmJshlZfRRqCTxDABQjagrCKEOf4Ow==
X-Google-Smtp-Source: AGHT+IGbJiOj2z3WmBqVI/x0P76Wg2k40LHScHUataUQ88SnJSCvKQIgU36Eq1VZorSd53FJTqj+oPQhO74rb78NEjs=
X-Received: by 2002:a05:622a:14:b0:3fa:3c8f:3435 with SMTP id
 x20-20020a05622a001400b003fa3c8f3435mr109585qtw.27.1691739513628; Fri, 11 Aug
 2023 00:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com> <20230811025530.3510703-4-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-4-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Aug 2023 09:38:22 +0200
Message-ID: <CANn89iJuV1Q3tOJ-UFedQgdfdw=cAWfyE5x=LKE1V-jD5UDf+A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] net: tcp: fix unexcepted socket die when
 snd_wnd is 0
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
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

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In tcp_retransmit_timer(), a window shrunk connection will be regarded
> as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
> right all the time.
>
> The retransmits will become zero-window probes in tcp_retransmit_timer()
> if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up to
> TCP_RTO_MAX sooner or later.
>
> However, the timer can be delayed and be triggered after 122877ms, not
> TCP_RTO_MAX, as I tested.
>
> Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
> once the RTO come up to TCP_RTO_MAX, and the socket will die.
>
> Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
> which is exact the timestamp of the timeout.
>
> However, "tp->rcv_tstamp" can restart from idle, then tp->rcv_tstamp
> could already be a long time (minutes or hours) in the past even on the
> first RTO. So we double check the timeout with the duration of the
> retransmission.
>
> Meanwhile, making "2 * TCP_RTO_MAX" as the timeout to avoid the socket
> dying too soon.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gS=
D2XT8pyAMM096pg@mail.gmail.com/
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
