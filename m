Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A98106CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377887AbjLMAjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377843AbjLMAjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:39:46 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692BAAC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:39:52 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1da1017a09so760605366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702427991; x=1703032791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vbEQ0KJGdaL7UqnKRRl9MeOERVPcRtBuLGCRgVFRaFo=;
        b=HRqBps9/RM7log+30PRlJuUCddgtcc+8DQP/pSC/VXZ3Ab1gjmGtlWkPanrFPEjaVC
         +q1egYkLO1fcKxtA33LqZ/esbRnzj1uLzwfy77oxm2BIBcpT0oZin2BENupfkVHk/205
         M1mGIU3zOGt3h72WccV2wwEQaVnrktpw6KjT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427991; x=1703032791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbEQ0KJGdaL7UqnKRRl9MeOERVPcRtBuLGCRgVFRaFo=;
        b=B7Jc6/sOxJpwvgbmkD++77T/run+BcQe3tpybEML+mPEyn6fpYxSpGVc9cWQR1PFxZ
         SUV3ENUFhTUQXVEHxI5CcajSUJlvDIsIuAhsQDj8Y+KktZdN1UU/ZzxcET1gRP8QCIFr
         VM7k/abZi2tySGTT6upyd+UvaY+JQuso8E1cxtxVPW3UDjNv/0uOMmOjDGsgNqdJRU3M
         djWeIlwjdo0ovbxGIMiQktkFTm8bUXqc+f0MlE3bDtJiSV+sNWRh23Q8y2QmWheSPFzb
         Wh3MB84C/ITtgA60rLslm9gU8fKPSaVCR2Z4bPKbCwyVuznWFgHEP3aa8Jziu7gYhgvV
         bydg==
X-Gm-Message-State: AOJu0YyW6Kz67ftLPGfRhACXPfsadVSYALWZOt48npttq/AIVPd/4ZE4
        nFTrK4ounoQSfat4KzNxMpfW89uD2T+FlWfw3exRxhol
X-Google-Smtp-Source: AGHT+IFYYR4KPMZExf9OHrNMkByIy1dP/U9MexXcj3HjAr975M3e7bNI+BPHuUF/mdUzyuUBDoCc9w==
X-Received: by 2002:a17:906:741:b0:a1e:36e0:1c7b with SMTP id z1-20020a170906074100b00a1e36e01c7bmr4115592ejb.19.1702427990865;
        Tue, 12 Dec 2023 16:39:50 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b00a1f6737be65sm6689737ejc.82.2023.12.12.16.39.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 16:39:48 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso762813966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:39:48 -0800 (PST)
X-Received: by 2002:a17:906:d8cd:b0:a19:a19b:78bb with SMTP id
 re13-20020a170906d8cd00b00a19a19b78bbmr3094683ejb.126.1702427988541; Tue, 12
 Dec 2023 16:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
In-Reply-To: <20231212231706.2680890-12-jeffxu@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Dec 2023 16:39:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
Message-ID: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
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

On Tue, 12 Dec 2023 at 15:17, <jeffxu@chromium.org> wrote:
> +
> +**types**: bit mask to specify the sealing types, they are:

I really want a real-life use-case for more than one bit of "don't modify".

IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?

Or when would you *ever* say "seal this area, but mprotect()" is ok.

IOW, I want to know why we don't just do the BSD immutable thing, and
why we need this multi-level sealing thing.

               Linus
