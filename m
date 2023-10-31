Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56037DC672
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjJaGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJaGUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:20:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F23C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:20:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so8498862a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698733220; x=1699338020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iDMKed0nzokCCbEBIpnlAR25vjS6WyJ1gGNxVZ8+dQM=;
        b=XtsFaoN9rWKi4F7Gg+wVu/NPKrXkorYOhaH05rrymdJiDuvWh13y0HdWphZ+hGx/GM
         VwJ5Lc5bkF7/2euchP1nlm6bncFgxsYZXm2p9b1hhLqzsFcgRTw1rrfpOGiKjyf5HtMf
         QqJPUTX61k1o8LpLMPRzdyWNWKW98gDodhZ20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698733220; x=1699338020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDMKed0nzokCCbEBIpnlAR25vjS6WyJ1gGNxVZ8+dQM=;
        b=KkSHa1QASw5YsG5MggX7havGObBD6iaHRIl6dqD9tGVcfwFnNn2SqomA2Ds9lkqk8j
         RkthevBMuRJOjEXzs962lGOPhuqQPyGFEkdtWWaJWLUNaimAsYqtZkoo7zA0+naaYEIr
         udgE8gBduqUrijdw3nVTmbspyIfGB9n1yAHmvWow4E4RrSREOElE9O46izYPHRns0N1p
         BPB/3POXnUOhXumKGYpebCJqdi/aeEIYo+218MFBjgnfAiAD0hWN7zs3kHw3j7eQOMeJ
         igw5T++8sTGqCzPvddDAOTJtGkUFoAU+I4v2N2HOnc/vfTb7Afi6iCttfs1xK02S6UDJ
         YXKQ==
X-Gm-Message-State: AOJu0YzLhzipOuY5h/JpQxuOsek2oqs4HUaDVVL8c/EO0BfeqKq+9Vk3
        fXvCiJUunFl3oilO1RJONbktbFW9cTpDV3jh9UEszy1l
X-Google-Smtp-Source: AGHT+IG1O5NGMzjglG+M56H4nySmS5wkuioLKDh79FPm8rAmvBoIkhyFobq1/4ejsCxXm9VPINFwYA==
X-Received: by 2002:a17:907:9286:b0:9be:68db:b763 with SMTP id bw6-20020a170907928600b009be68dbb763mr9980629ejc.71.1698733220241;
        Mon, 30 Oct 2023 23:20:20 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id dv16-20020a170906b81000b00982a92a849asm398085ejb.91.2023.10.30.23.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 23:20:19 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9d216597f64so385860066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:20:19 -0700 (PDT)
X-Received: by 2002:a17:907:6095:b0:9c7:54a1:9fe5 with SMTP id
 ht21-20020a170907609500b009c754a19fe5mr9489304ejc.49.1698733219178; Mon, 30
 Oct 2023 23:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 20:20:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
Message-ID: <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 20:08, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> As Linus pointed out [1], lockref_put_return() is fundamentally
> designed to be something that can fail.  It behaves as a fastpath-only
> thing, and the failure case needs to be handled anyway.
>
> Actually, since the new pcluster was just allocated without being
> populated, it won't be accessed by others until it is inserted into
> XArray, so lockref helpers are actually unneeded here.
>
> Let's just set the proper reference count on initializing.

From a quick superficial look this looks like the right approach.
Thanks for the quick response.

              Linus
