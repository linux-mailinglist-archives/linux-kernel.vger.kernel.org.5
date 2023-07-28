Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE207672A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjG1RC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjG1RCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:02:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6602FA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:02:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso3889304e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690563772; x=1691168572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HAf0f1T2SfrQfohRytga1xgLxnQTJqNRQWwR6CnDUiU=;
        b=TVl+WJYrvGsGpB323l5pe+F90lKlzEGgHxpHO9BPsNpTu4wYnwMTzhvrVjrbShLnkU
         D13XZ1N2Cy0z+NkKLQJvegXFJDoESEQ4WU40pFB6h713fJn3lVTbnFyw4aPTNxlvcRg2
         0e3cJ7278hBNIihwzHnZkhoVv3eKz2B/RXKug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690563772; x=1691168572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAf0f1T2SfrQfohRytga1xgLxnQTJqNRQWwR6CnDUiU=;
        b=Dq2bbfo8HwrMXC7JALwKy43IiONAClYCBTvLIQf61DGWHJwyTkhhkWuuwx1M8nLWpI
         1jWGaBBy+XVNGhupc5ZaBj9t7yCXuSdfHLSgcKoeMisjxeDZvwKLuqgrx55wytGLTEap
         tAyXezJV0hZfi+XezE5/GtXj1CtIvtrKtYAqiJvnFMgA7cc+mXYvk462AUpSDmzXTwNy
         OQlXIZixzGgAUnlh28jxQcCaTMbj1lOvtjRXbr2JdL1DP6yV+BT5xy8eA3veyTXSVaa9
         PyJsjOaGPXAO+HuJcgMw94BBVYQ9Y492z5JHtHEQZv+9F4rWDPeCNFAxcwWDLqmERstZ
         S0pQ==
X-Gm-Message-State: ABy/qLa6MmqZ372iBQ2Glj3qCV9r9omfMUj9ZHvr/6OnNkbpT268rI6y
        pBRi2ExGKFATRp0IzmGsLNVN1aJ54+n8hNa5wZ+tkJip
X-Google-Smtp-Source: APBJJlGSplOnR0k/wlPJI2a683CmjGDyv/+40rchn/ePBIu2QwAYWFfwueEgcvw8IGL3O//NQTYLng==
X-Received: by 2002:a19:560a:0:b0:4f3:93d6:f969 with SMTP id k10-20020a19560a000000b004f393d6f969mr1834819lfb.59.1690563772634;
        Fri, 28 Jul 2023 10:02:52 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c26-20020a19761a000000b004f8592a5180sm895694lff.17.2023.07.28.10.02.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:02:52 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso3928552e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:02:52 -0700 (PDT)
X-Received: by 2002:ac2:5df3:0:b0:4fb:89b3:3373 with SMTP id
 z19-20020ac25df3000000b004fb89b33373mr2187854lfq.43.1690563771697; Fri, 28
 Jul 2023 10:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twwk0C6kGQXFZdvEhxnLe7DhnwN8doj_yA3a9S3hs7c1w@mail.gmail.com>
In-Reply-To: <CAPM=9twwk0C6kGQXFZdvEhxnLe7DhnwN8doj_yA3a9S3hs7c1w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 10:02:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2A91gCW8U_4zxe7=HY=zKL1EC7_4Z19AhM7sTsj5hfw@mail.gmail.com>
Message-ID: <CAHk-=wj2A91gCW8U_4zxe7=HY=zKL1EC7_4Z19AhM7sTsj5hfw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.5-rc4
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 19:20, Dave Airlie <airlied@gmail.com> wrote:
>
> Regular scheduled fixes, msm and amdgpu leading the way, with some
> i915 and a single misc fbdev, all seems fine.

Pulled.

Tangentially related: where do you keep your pgp key? The one I have
is long expired, and doing a refresh doesn't get any updates...

                Linus
