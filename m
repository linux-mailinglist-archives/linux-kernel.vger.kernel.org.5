Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7487ACB0D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjIXRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIXRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:25:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F5F1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:25:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c93638322so1172328966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695576299; x=1696181099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRXyiwDnkcF0zN2JsUwtWTqR+TaAuDaKDz+KJ6kvRrU=;
        b=HLGqwnkyzFQVdgYOXY0i49HeFCR6URzFxfpL1sidrOrd7PMp434Uk0KBW11wXZSpu4
         3HErpiTjei99XzJzZVVKa4rHW7n49LeqZEQPOL9vz5uoFrMV1UXMbokYlOKBrlHAxAXv
         9BQdA++xabk014UiEZT/kMxhZFGNlXbvrYpFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695576299; x=1696181099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRXyiwDnkcF0zN2JsUwtWTqR+TaAuDaKDz+KJ6kvRrU=;
        b=usCodpoNZuBHdAbV5opY6pCn843ocqJ61Al7yvzsH5WoftKR8Q5wfGpNgWTV6uWPKN
         P1o8kCQze/66jHC0jDuj7VonxremrXF/aJ3fHCrcnBSSMvW8fmtpIaqeo/SUXR5Yg27C
         NMdhDxNCp/ZdXl9LaoKUjimJyNRJjDppfZZcD365IJWRjonkkeG2Yqi68s3WM8++ViEj
         uJ0dWHX5b7MFLzlw6bnunZKe02TMaWq0Sf53y6HzFHvERxWETLX4fpA3AltUSNUhVxfA
         gwCSPt/jdWan7sYoxlY4+ExnOJY/tsYI6clbD2HfRvIr32Byo0WSqNULMFGrehUgaxyp
         /K+A==
X-Gm-Message-State: AOJu0Yz43G+f+5jHN4Blm6d8Wy7L5HRK9V+aDhbNdRicEwkC2WLWDqQf
        goAM9TfkKXTu044fE97p+7qwBTSOwREC5fqgWqf1zobk
X-Google-Smtp-Source: AGHT+IFykE8OdMPBvHPxcpjRIVIF+OsJFurmTlZEEgwyK6xQPJ5qs/642gq/FoA6BZaMNOfU7riwNQ==
X-Received: by 2002:a17:907:62a6:b0:9a9:fa4a:5a4e with SMTP id nd38-20020a17090762a600b009a9fa4a5a4emr10148049ejc.13.1695576299387;
        Sun, 24 Sep 2023 10:24:59 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906681100b00992b50fbbe9sm5261067ejr.90.2023.09.24.10.24.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 10:24:58 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so11674462a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:24:58 -0700 (PDT)
X-Received: by 2002:a05:6402:270d:b0:530:bfb6:66cd with SMTP id
 y13-20020a056402270d00b00530bfb666cdmr11388000edd.7.1695576298038; Sun, 24
 Sep 2023 10:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <202309220957.927ADC0586@keescook> <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
 <202309222034.F2B777F55@keescook> <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
 <88707e12-dba9-4a9f-95d7-8d6f3c8f0f58@p183>
In-Reply-To: <88707e12-dba9-4a9f-95d7-8d6f3c8f0f58@p183>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Sep 2023 10:24:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh++R5W1ifuS6YoSb-9ExKGr7cVavo8SHiWtzyR4-hVgg@mail.gmail.com>
Message-ID: <CAHk-=wh++R5W1ifuS6YoSb-9ExKGr7cVavo8SHiWtzyR4-hVgg@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sept 2023 at 09:58, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Most of those in uapi/ are likely unnecessary: extern "C" means
> "don't mangle", but kernel doesn't export functions to userspace
> except vDSO so there is nothing to mangle in the first place.

I suspect a lot of it is "this got copied-and-pasted from a source
that used it".

And even if you don't export, you have to *match* the linkage in case
you have the same name.

So I suspect that if you have any kind of prototype sharing between
user space (that might use C++) and kernel space, and end up with the
same helper functions in both cases, and having some header sharing,
you end up with that pattern. And you do it just once, and then it
spreads by copy-and-paste.

And then about a third of the hits seem to be in tools, which is
literally user space and probably actually has C and C++ mixing.

Another third is the drm uapi files. I didn't even try to look at what
the cause there is. But presumably there are common names used in user
space vs kernel.

And then the last third is random.

We do have a few other uses of __cplusplus. Sometimes just "we have a
structure member name that the C++ people decided was a magic
keyword".

So it's not like this new pattern is *completely* new - we've had
random "people want to use this header with C++ compilers and that
causes random issues" before. The details are different, the cause is
similar.

                Linus
