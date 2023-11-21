Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A897F34E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjKURXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjKURXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:23:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003AE12A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:23:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so6220097a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700587408; x=1701192208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/ZO4yKs3VhkhylSYQ9J7OGN/6CUEfOejASnyNs/Dbc=;
        b=H7jCaKAAc1bYxl8WhWgC1m9NA2zxATRdjcH5sEsOHVSalBGa0+CzUMkII+/M9nfweT
         AoUKw7PQqyO87ob24gTB2H2BhIxyZlmhgHTYkh+nymh++CgRxKriNMrQB7wPLRsR5/pF
         EQ8U8563bfvzb1z1QQqgwXaU58fiHCYDmoSUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587408; x=1701192208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/ZO4yKs3VhkhylSYQ9J7OGN/6CUEfOejASnyNs/Dbc=;
        b=LWwPV6RXEvCwAqrwCCwu1jXK8gjLtKOO/hQG68DD+X7z1rJcFDzU+t8bJpRW4HBZGP
         d/WI+IwJdPaLKoZv2mfgQd9JfPn+P9sBpfpB1h41W3JmgyF11qB+zKwctp7VMDfj7fhE
         t0xv6FRVk5Lgs0TT/HdPkkJYOQFxThb4yiZH0bu/uDoROOgqhyadQmjInZD+mvt4O8PI
         z9r/eFCYNLw4g2dvDrZD1GMi4o9arWhOSYKN918cQffF3RunEyQgq0367eGesg54wNYj
         KBmC2A7p0cyMz/Yuc1OdAyschxD4OhVek3lyiF9lO+M0yVC15WVwYyhCtE9j56JtZSEc
         8AAQ==
X-Gm-Message-State: AOJu0YweSFWIkgJiMyzOHYWTxJv0D3neM58eZPsL/RgOLgTSlcPfpLkb
        vNqCYibyXC7Nh7c2n1x6pPKlVh9LwYuv2S1c+73XPA==
X-Google-Smtp-Source: AGHT+IGk5uIGPVxIRO4Y5AzDAhu3uMrk2xaf4NahY/v09qQJvFbj3xRv24UGuT5OK9DCQKcE+WWRZA==
X-Received: by 2002:aa7:d68e:0:b0:548:4774:e59c with SMTP id d14-20020aa7d68e000000b005484774e59cmr2398366edr.35.1700587408192;
        Tue, 21 Nov 2023 09:23:28 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7d5d0000000b00548aeeb1a9esm2763925eds.89.2023.11.21.09.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:23:26 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so8456792a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:23:26 -0800 (PST)
X-Received: by 2002:aa7:d68e:0:b0:548:4774:e59c with SMTP id
 d14-20020aa7d68e000000b005484774e59cmr2398277edr.35.1700587406073; Tue, 21
 Nov 2023 09:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20231121010318.524570-1-nickrterrell@gmail.com> <20231121010318.524570-3-nickrterrell@gmail.com>
In-Reply-To: <20231121010318.524570-3-nickrterrell@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Nov 2023 09:23:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
Message-ID: <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] zstd: Backport Huffman speed improvement from upstream
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Yann Collet <cyan@meta.com>,
        Nick Terrell <terrelln@meta.com>,
        Kernel Team <Kernel-team@fb.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 at 16:52, Nick Terrell <nickrterrell@gmail.com> wrote:
>
> +/* Calls X(N) for each stream 0, 1, 2, 3. */
> +#define HUF_4X_FOR_EACH_STREAM(X) \
> +    {                             \
> +        X(0)                      \
> +        X(1)                      \
> +        X(2)                      \
> +        X(3)                      \
> +    }
> +
> +/* Calls X(N, var) for each stream 0, 1, 2, 3. */
> +#define HUF_4X_FOR_EACH_STREAM_WITH_VAR(X, var) \
> +    {                                           \
> +        X(0, (var))                             \
> +        X(1, (var))                             \
> +        X(2, (var))                             \
> +        X(3, (var))                             \
> +    }
> +

What shitty compilers do you need to be compatible with?

Because at least for Linux, the above is one single #define:

    #define FOUR(X,y...) do { \
        X(0,##y); X(1,##y); X(2,##y); X(3,##y); \
    } while (0)

and it does the right thing for any number of arguments, ie

    FOUR(fn)
    FOUR(fn1,a)
    FOUR(fn2,a,b)

expands to

    do { fn(0); fn(1); fn(2); fn(3); } while (0)
    do { fn1(0,a); fn1(1,a); fn1(2,a); fn1(3,a); } while (0)
    do { fn2(0,a,b); fn2(1,a,b); fn2(2,a,b); fn2(3,a,b); } while (0)

so unless you need to support some completely garbage compiler
upstream, please just do the single #define.

               Linus
