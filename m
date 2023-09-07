Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE51797D99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbjIGUwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjIGUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:52:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA21BD6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 13:52:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-501be2d45e0so2312023e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694119929; x=1694724729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+L9op70z4Tpmb4XlT5693A5llhh03vxW4gvGPs2i44=;
        b=AArLCjcbLc2cQGPDtIHz8MDWZwtvD675aYPWuf/aEjpGAmrBsGa1iSXreWEbR0IgJg
         KGfwWK/+FunAjqoJRXLggPuDbxU9rLDwrds5pR/uCeCYG7jyiOFlQ0pCoMwaZ1cuwS4P
         MZuAmmVNloi19QGas0WaHZhBfEzD1PQo8RYQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694119929; x=1694724729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+L9op70z4Tpmb4XlT5693A5llhh03vxW4gvGPs2i44=;
        b=qbDr9iXgE/Txl3364KFD/IIlExVsEpUG87XHCQHLRVDdkny8h/k3qKiysZAF8wdpQh
         oBKWVGG1iuQ5ldrcKLQd+3/OBCTWmlTW1hKV5LkSW79J4bjXewz+vTPRTw02+MP4umFf
         oFpNwisrb5HbDRzUMTzpIS06MV32UB8LTxui2jukFWaKxx8tolcZQxxsw700DIoxymMS
         3pbTk7z0vm8Je54vugBqdLrc9uVcFeedFAa2uOA9kGvHi8ryrkvCsO4HmaUnJ2c6qq0h
         8uBF40Cpg3fsuUaYjrXtvvaJafEzs+UEYP/PMGs4fK+AFPF/8xIXkhJ3GmpxYlHxIDWt
         ZdjA==
X-Gm-Message-State: AOJu0YylvSdBmh/A0Ewk2ChgNHbCG6aZ+LwyCNpFLBSsxoNwjlzZ2Vwk
        W8YZMwN6ci+wJe/3S7pSXLLQEM4L8bT6O+6LKzVNIBTK
X-Google-Smtp-Source: AGHT+IH1HyNiUy87XKV8D941L9SsIlSTvBJeCk2GpuQk0rEZxflL+djvxSNVF4QMGhsmtlevBrIkbA==
X-Received: by 2002:a05:6512:230b:b0:500:d960:8ae5 with SMTP id o11-20020a056512230b00b00500d9608ae5mr426774lfu.25.1694119929060;
        Thu, 07 Sep 2023 13:52:09 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7cd08000000b0052595b17fd4sm215954edw.26.2023.09.07.13.52.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 13:52:08 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso1835313a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 13:52:08 -0700 (PDT)
X-Received: by 2002:a05:6402:156:b0:52d:212d:78ee with SMTP id
 s22-20020a056402015600b0052d212d78eemr314041edu.25.1694119928158; Thu, 07 Sep
 2023 13:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com> <20230907203718.upkukiylhbmu5wjh@moria.home.lan>
In-Reply-To: <20230907203718.upkukiylhbmu5wjh@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Sep 2023 13:51:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnjyOOU+NDcJy5Q7kQrA65UQQJCYUYADbr1Pz7up-8mw@mail.gmail.com>
Message-ID: <CAHk-=wjnjyOOU+NDcJy5Q7kQrA65UQQJCYUYADbr1Pz7up-8mw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 13:37, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Linus, I specifically asked you about linux-next in the offlist pre-pull
> request thread back in May. It would have been nice if I could've gotten
> an answer back then; instead, I'm only getting a definitive answer on
> that now.

I may not have answered because it was so *obvious*.

Was there really any question about it?

Anyway, the fact that the code doesn't even build for me is kind of a
show-stopper regardless. It's the kind of things linux-next is
supposed to notice early, so that we aren't in the situation where the
code has not even been build-tested properly.

                   Linus
