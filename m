Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98A78CD90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbjH2U3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbjH2U3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:29:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5851B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:29:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6310270a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693340969; x=1693945769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4hYKlpw10RBDGcFQ+pNFTV1sFojiOV4eZlWuNv1UaE=;
        b=SNcHHTWfALy73lTOFIgEsqev3uYhucJ3xORQAOWM4mrOBis467U3qoPWe3WGdFWjVr
         9Xc79U6UoLfpsTQelG9TJiD1HDVUyVh0W7mb7QArdP3PZhwd7nrk01xC4RSjNQs8hSXV
         fye7k2vN+Ahla7ILAr2G3jlyEtYpXXR6e1GCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340969; x=1693945769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4hYKlpw10RBDGcFQ+pNFTV1sFojiOV4eZlWuNv1UaE=;
        b=WsFzdN5QYrzqL+7NjTepbzzmZzzKQfpLBIZ+GETtmsSKORol6R4RamXOeM1B2GHt/Y
         o1/dPtHDQzyzQzRAuDGJAI/RkU1ssFEo7iTavXehQSVaSAS+xtW6BTgnIiGKTyWETjzM
         lv/5Fzr+Li8nCSqg/Y/tcG7DxWO2XSzWSAms+CAh7RlffVvRXQs6ugQ2UcihGHP9BjIh
         msNYwQg1iRahSYEOJpts4ziZbegPAI1715wQiZaIcfhizY2mznNjOlfpPIe8CfWrCTpz
         xcjCE6+Ez/t2QRcAB7iHKQ/DoZ1SKKiMRsNdrjv91hyuu4cw5vRO0akMtSFKgIpe3Dbd
         LBrw==
X-Gm-Message-State: AOJu0YwpLpY2ccjC9oQOdsGn+g//VSD9hyAVGO6EzY4CvBAvk719y1SA
        vYWCbfxZa5rj6+exB8TFI4ZC8SNBa1R8HPzgm31iTo1e
X-Google-Smtp-Source: AGHT+IE5Spk+/et6Zu3ddCi5UeNsIUwhqn91w2Bl62Tc9QaX7rpFf5VUavirMDg+xzZIbJ/WrBhAqA==
X-Received: by 2002:aa7:c6ce:0:b0:51e:362d:b172 with SMTP id b14-20020aa7c6ce000000b0051e362db172mr257861eds.32.1693340969334;
        Tue, 29 Aug 2023 13:29:29 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id f2-20020a056402150200b005233609e39dsm6048829edw.30.2023.08.29.13.29.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 13:29:28 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-997c4107d62so625688466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:29:28 -0700 (PDT)
X-Received: by 2002:a17:906:5347:b0:99e:112e:7708 with SMTP id
 j7-20020a170906534700b0099e112e7708mr62717ejo.76.1693340968340; Tue, 29 Aug
 2023 13:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230829114301.10450-1-brgl@bgdev.pl>
In-Reply-To: <20230829114301.10450-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 13:29:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigZt6kVkY0HU1j_LJ5H1KzwPiYnwwk6CbqXqT=sGenjg@mail.gmail.com>
Message-ID: <CAHk-=wigZt6kVkY0HU1j_LJ5H1KzwPiYnwwk6CbqXqT=sGenjg@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v6.6
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Tue, 29 Aug 2023 at 04:43, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Driver improvements:
> - use autopointers and guards from cleanup.h in gpio-sim

So I've pulled this, but I'm not entirely convinced some of this was a cleanup.

That gpio_sim_config_make_device_group() change is "interesting". Doing

        return &no_free_ptr(dev)->group;

looks a bit crazy. My first reaction to it was 'that can't be right".
It _is_ right, but I'm not convinced that getting rid of one kfree()
call in the error path above it is worth that kind of semantic
complexity.

I guess we'll get more used to this - and it will look a bit less
crazy in the process - but I did want to just note that I'm not
entirely convinced we should encourage things like this.

              Linus
