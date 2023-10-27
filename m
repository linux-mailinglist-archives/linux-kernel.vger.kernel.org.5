Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E037DA42F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjJ0Xtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJ0Xtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:49:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267BF1B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:49:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso38901511fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698450576; x=1699055376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/6MVE0JwBSnmzOc2InO3D2kXgpWf8h6/Vrw0EUtdQhA=;
        b=e6ua2/eb1DFaKiqBF/qeNy1lKa1VRqbtw3+3/sOwRU6bCdcoTIsCmzbvL4oy17pxr5
         vPBZUGsPFg2ZzM9xCdNg4VzNc3+DCc1zHECJW4dzSM0tnq3JWdP43uzl52P29L8H+sg4
         Oos68IyszY6FmMyZ9vCqMY6d5Kmam+QB3FWvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698450576; x=1699055376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6MVE0JwBSnmzOc2InO3D2kXgpWf8h6/Vrw0EUtdQhA=;
        b=Xj+XFR6Oq9kNK2bcjZL2HmbgSPGDdHmRAfHLjkWAJe8RZsThc4C75T9gzbgbNwzRxQ
         z0fxuI9PCvDt50fslV5cYUknnCCVNd1niPQObDJcv8/maTrl4Fu1uJptBkDJHVOHDVqY
         52DmFHsE7dzoEQUYAKh8qpw3J8+xXCEOhHd1k/V057gsIjaPzLoXfqGZS4sg/gyuJiMt
         6xoA+BA/FuH1pDg0W20OTXbqAg6xJESKf+Fc8l4t9FTtf2wTht1UEIwpbqWEpPxOScCR
         irt5+D+EDlUiM+7p7CCCHiXQTTXdE+l0Bu73OW5WDCrFodrGCA/IWE570dLSChClF9vQ
         ZxCg==
X-Gm-Message-State: AOJu0YzWkDsUZrROygWUmX2UgmAo592V1Bo9UNR37RdPP0cdwfPyKg0o
        ozyHDLQcSCfosqlCPx7eyv/bZS7LzjBP2IjVTvNb0Hrc
X-Google-Smtp-Source: AGHT+IEvxjZeigRsdwjNaOWWK8l2qM2XJ/QvhVwrjfeuoxyx9vFQAG00mkAzQdSPMM9jfASbkRDKqA==
X-Received: by 2002:a05:6512:5cc:b0:503:7c0:ae96 with SMTP id o12-20020a05651205cc00b0050307c0ae96mr3012103lfo.20.1698450576048;
        Fri, 27 Oct 2023 16:49:36 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709063c0900b009ae54585aebsm1846222ejg.89.2023.10.27.16.49.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 16:49:35 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so4069575a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:49:35 -0700 (PDT)
X-Received: by 2002:a50:d616:0:b0:53f:b758:22a3 with SMTP id
 x22-20020a50d616000000b0053fb75822a3mr3200840edi.3.1698450575132; Fri, 27 Oct
 2023 16:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <00ebd650-72c1-0901-27bc-ae18867ed4b4@redhat.com>
In-Reply-To: <00ebd650-72c1-0901-27bc-ae18867ed4b4@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Oct 2023 13:49:16 -1000
X-Gmail-Original-Message-ID: <CAHk-=whDg86U2PdJ3bH7L3_fnUU0UK3Bx2Eo7zcdXH_X521z0w@mail.gmail.com>
Message-ID: <CAHk-=whDg86U2PdJ3bH7L3_fnUU0UK3Bx2Eo7zcdXH_X521z0w@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.6-6
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        David Lazar <dlazar@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 at 04:55, Hans de Goede <hdegoede@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-6

I'm not sure why this didn't get the pr-tracker-bot treatment.

So here's the manual version...

              Linus
