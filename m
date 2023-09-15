Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382277A1CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjIOKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIOKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:45:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AF7FB;
        Fri, 15 Sep 2023 03:45:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c4194f7635so10293495ad.0;
        Fri, 15 Sep 2023 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774739; x=1695379539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KASKuJDoY+n+ROnGW2/fJ2gTET1kK/7EqBy0BEtei40=;
        b=mpafJNvIQS6rNhXGOawwDm/hSpSvo+I143u7PoTKvEg8L6dnuH8etqF/E+5y8yutlF
         i0Eb9a6+MSr9hTy4dMwgs2JPPlpHECbpvt0OvxtwGNWfW6FIhLyxRqO6el26+Bw1D8U2
         XkLKraOENebbJzfQYBt2hVODUPeNJet+lUzloV9jpFhTQDZqXZEtMcE8+18b+9rET8aI
         PQ4UPbaB+MuYxlHXkP+0pLpNWi/k8vW4PtbUqEHwqBTvVwzDdaFrt+bOptAKs3XLTOQu
         eBlZjC67MWupDYJeb/e2tNmXmQ3QPUKG96fJWiP8Xtn6HAQ1ElY9apX6MlSj1JqnHGJY
         agWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774739; x=1695379539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KASKuJDoY+n+ROnGW2/fJ2gTET1kK/7EqBy0BEtei40=;
        b=xTnhgRWiUGNSeHEpdAP0Lk3lu+h1wlC5glGG9LKnKYB9tdIDc9cQSVk3PgQmO7uN1x
         lnvJV4IGTSzAYdhQgABA1nmOv0cbaoiUNNzSJkoyqZyhor3QTzaNnPdHo6RKfAHQlJf+
         ZJQ1y86kVkKKfs2B1TcWmxnWkDJtWQ3SSAPKcEqKVXvqpYrvtEZv4ghv+HX4+QOTW5Kl
         g3HjH3kKDvm92uEBtmoVKsyc9iatBRdyk/KCRhE78mTzoBSZrUQDVyL5+GFv7UHEDDq4
         FKUwfETtePDu/jfFgzTP2GZeIxVMhj7QcbxCjfouib9Dg0/AtbGoZI3KgZFaHApd/siH
         eYQA==
X-Gm-Message-State: AOJu0Yx//FuDyfNyI3V+jUsgfcmh5f/ILVocx64EiuVBwWlm+MXVSKDu
        wGl97/PX2Sxo40BjQWvIHS8=
X-Google-Smtp-Source: AGHT+IFMwC7iceoHmBQe230+YM6MJUKW272TFAgwKdGFQCXM/3kUvuMw4LgdPRZ4VlCCPuC2SPZuMw==
X-Received: by 2002:a17:902:e5c8:b0:1c3:868f:5958 with SMTP id u8-20020a170902e5c800b001c3868f5958mr6183252plf.20.1694774738621;
        Fri, 15 Sep 2023 03:45:38 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b001ae0152d280sm3156374pls.193.2023.09.15.03.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:45:38 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:45:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     davem@davemloft.net, thomas.lendacky@amd.com, john.allen@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rijo-john.Thomas@amd.com
Subject: Re: [PATCH 0/5] Add new platform support for DBC
Message-ID: <ZQQ10QeAA6hSMBuo@gondor.apana.org.au>
References: <20230907184846.47598-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907184846.47598-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 01:48:41PM -0500, Mario Limonciello wrote:
> Some platforms that support dynamic boost control (DBC) support it via
> a different mailbox than the platform access mailbox.
> 
> This series adds support for those platforms.
> 
> It is tested on top of the fixes series. The prerequisite patches refer
> to that series.
> Link: https://lore.kernel.org/linux-crypto/20230829150759.156126-1-mario.limonciello@amd.com/T/#m47782729377f6fe5d62130cc701dae7f15306726
> 
> Mario Limonciello (4):
>   crypto: ccp: Add support for extended PSP mailbox commands
>   crypto: ccp: Add a communication path abstraction for DBC
>   crypto: ccp: Add a macro to check capabilities register
>   crypto: ccp: Add support for DBC over PSP mailbox
> 
> Tom Lendacky (1):
>   crypto: ccp: Move direct access to some PSP registers out of TEE
> 
>  drivers/crypto/ccp/dbc.c     |  72 ++++++++++++++-------
>  drivers/crypto/ccp/dbc.h     |  29 +++------
>  drivers/crypto/ccp/psp-dev.c | 122 ++++++++++++++++++++++++++++-------
>  drivers/crypto/ccp/psp-dev.h |  55 ++++++++++++++++
>  drivers/crypto/ccp/sp-dev.h  |   4 ++
>  drivers/crypto/ccp/sp-pci.c  |  22 ++++---
>  drivers/crypto/ccp/tee-dev.c |  48 +++-----------
>  drivers/crypto/ccp/tee-dev.h |  15 +----
>  8 files changed, 241 insertions(+), 126 deletions(-)
> 
> 
> base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
> prerequisite-patch-id: 4bcf7f3ea21472e4e28c2457cc9827f6023ec6ca
> prerequisite-patch-id: 903be53a20306f0188e52015dbfe5196738bb2eb
> prerequisite-patch-id: af396bafb6acaa9c203c1a2c5f4665171cb45e4f
> prerequisite-patch-id: abe450d4bf1de4a5664a41dbf84e72b1d4bfdae7
> prerequisite-patch-id: b0b9cf55fcb73a11de6f3da73412fb090562857a
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
