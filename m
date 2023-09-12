Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB879DA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjILUsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjILUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:48:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F2E64
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:48:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so8063617a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694551702; x=1695156502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hv80f3uDeX+bprELwtiGX3ZT6QuXvl6UBldMet1HOC8=;
        b=Qgm7UD/m6C3eI16BxwSQ21HHIUDMy1phexISrSCIjdT7AW1TO6idtmOmUKqtwwmWVR
         pwtMGaAc3KjyiySboshUUIkZ/51A/tSfMZbImGr3sIoqHq/lDJo8pDIl8GuozP14j0a6
         uKVwK8pDNqoZHavCzTK2AHhLfDaAgWTt/2DdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694551702; x=1695156502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv80f3uDeX+bprELwtiGX3ZT6QuXvl6UBldMet1HOC8=;
        b=SIY5kb7VLJE79Q8MFz2eYSw1B+K1bjV8V7m37znbI3MN+4HrOK6Op/ezp4qx4Ngd+O
         G+9wE901WCSDD7c8sYHA5kfBieCuVX/PJ2HkN6Zpu80WGieBd4TeI8VuPN+ZYlkePoZO
         hGq2mSY4hzDGuuyWogHs+FWXgPnDXTgyIl9PO1+QofcXXLrZlS0U+BN5f3aEhWJs3dJm
         sOgJl9SqLSdHuXE7swW7hVJSMYaXk1BTAv9el7jl8nXHny541MbhhzrhNeT1B1Kqygss
         tHtuWZcYTjh4SGXVEvTLMj3QhiqQyJIYjIRSLT79UI1bqY15QdlV0dhk/oWg+FhTVRfC
         /vBw==
X-Gm-Message-State: AOJu0YxfIIzZnppLG5bKEOJjbGxYJI3cAR08XzgdCF83j65XKOXt09zB
        UXQnDhsnClTdZwnCZ1nuXrUK5PyG4sVVh5rHvMosqeBj
X-Google-Smtp-Source: AGHT+IGE6TlSW2Wtrai1DrCwuwduWsampCGHO56gdYDawXfrAMBAQzxfK+s7v03vzHHHZTVBaaQHsg==
X-Received: by 2002:a17:906:2212:b0:99c:441:ffa with SMTP id s18-20020a170906221200b0099c04410ffamr356719ejs.29.1694551702661;
        Tue, 12 Sep 2023 13:48:22 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id op5-20020a170906bce500b009a1fef32ce6sm7423643ejb.177.2023.09.12.13.48.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 13:48:22 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so69211865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:48:21 -0700 (PDT)
X-Received: by 2002:a05:600c:2288:b0:401:d803:6246 with SMTP id
 8-20020a05600c228800b00401d8036246mr553079wmf.2.1694551701487; Tue, 12 Sep
 2023 13:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
 <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
 <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com> <CAGudoHEuY1cMFStdRAjb8aWbHNqy8Pbeavk6tPB+u=rYzFDF+Q@mail.gmail.com>
 <ed0ac0937cdf4bb99b273fc0396b46b9@AcuMS.aculab.com> <CAHk-=wiXw+NSW6usWH31Y6n4CnF5LiOs_vJREb8_U290W9w3KQ@mail.gmail.com>
 <fa01f553d57e436c8a7f5b1c2aae23a9@AcuMS.aculab.com>
In-Reply-To: <fa01f553d57e436c8a7f5b1c2aae23a9@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Sep 2023 13:48:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC8TaarEhz2ie_w01r34hQHNCTiZLAs6e42ewP7+cvoA@mail.gmail.com>
Message-ID: <CAHk-=whC8TaarEhz2ie_w01r34hQHNCTiZLAs6e42ewP7+cvoA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     David Laight <David.Laight@aculab.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 12:41, David Laight <David.Laight@aculab.com> wrote:
>
> What I found seemed to imply that 'rep movsq' used the same internal
> logic as 'rep movsb' (pretty easy to do in hardware)

Christ.

I told you. It's pretty easy in hardware  AS LONG AS IT'S ALIGNED.

And if it's unaligned, "rep movsq" is FUNDAMENTALLY HARDER.

Really.

                    Linus
