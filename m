Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93D37FDF15
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjK2SJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2SJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:09:21 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C6AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:09:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so733a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701281366; x=1701886166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YPZxso0QzNj3gqcGGnNvHk0pzKPfOYD5SPW1T+A/ws=;
        b=04b8Q81KSvsKQJIr2Te+mfZoEcAHDHyHsjycrRAolZzPGhXM25XYFF1Uqs9MjADf/t
         dyZ4Xdv4ryaQE6/ar2C5pnG96McgeQwyODgjbzxOTmpkHf+V4EZNM4OhQL9HBnqVmJ69
         hGeAjtpmrCHm24SZU1qmm4euTEsMkYN3qEs0rGVJ81wrkS0Nlso5vFmFNa0SBoiUKs8Y
         IQxib3K+ZZ6e5BSzkL7C3jFOfL57KyB/oODB/pkcGoPXejC1h2mzuwtFGlH5fEKJd7Px
         0R6xmQcNWqTyIjK8gsbZumazpyZwpG9NV2Yckrq3mHN253isf7XN1yPZpM5xWRb0Vlv2
         NYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281366; x=1701886166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YPZxso0QzNj3gqcGGnNvHk0pzKPfOYD5SPW1T+A/ws=;
        b=kuwBXJ9hBEy5qdwtXOoTs472L4t16QdjlZIFX2LB83ihrgmY3ge8Sg3cqgRW3w7eqU
         9CALYZz2oDlbGOWidMwXj66wcAoC6X5MHXSgiTOj7+Cpn9k6lJkvn4XOD3h8NPyr7PXb
         xCbOXmecgR20+WTkR0GdPpGtre8vLxU5ndzDn6bgIGFV6WV8aSIQpmuY0Cxbln0Jj3Ed
         vrdoka30SCv56lgBM6HVdCgn26QTmR0cpK4aGuErrPFK+oRjTorH9C09g2OKBv3k3TyY
         KgTd9ygDr1UoyhEhnqRTOE1prxuqWUpY9MCLiqMfEwJ9PkgqybIBEQGi6ycIUnntSSVo
         3Zsw==
X-Gm-Message-State: AOJu0YwzSnMr1sR0JcWCfj2nOVsd86rWOzyPxOfUUKaTEtTR3jAoTZov
        ftIdYNkgg8f4IDTtDLJ98gYev4IJqYP5KO+NGshrEw==
X-Google-Smtp-Source: AGHT+IGiyVfo0h1STetqMMeNh8jBnd+AcgPt9CyQh2xWsa4CcDK38D7CVSk+TcXDS8kdKV2WvAN1e4fYH4EH4oFMgT4=
X-Received: by 2002:a05:6402:430e:b0:54b:67da:b2f with SMTP id
 m14-20020a056402430e00b0054b67da0b2fmr635103edc.7.1701281366310; Wed, 29 Nov
 2023 10:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-7-dima@arista.com>
In-Reply-To: <20231129165721.337302-7-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 19:09:15 +0100
Message-ID: <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> RFC 5925 (6.2):
> > TCP-AO emulates a 64-bit sequence number space by inferring when to
> > increment the high-order 32-bit portion (the SNE) based on
> > transitions in the low-order portion (the TCP sequence number).
>
> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
> Unfortunately, reading two 4-bytes pointers can't be performed
> atomically (without synchronization).
>
> In order to avoid locks on TCP fastpath, let's just double-account for
> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
>

This will not work on 32bit kernels ?

Unless ao->snd_sne and ao->rcv_sneare only read/written under the
socket lock (and in this case no READ_ONCE()/WRITE_ONCE() should be
necessary)
