Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E378E13D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjH3VM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240818AbjH3VMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:12:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE0E0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:11:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so9851f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693429841; x=1694034641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe9mE2/R7T8IPvBnOwTKQXiumtbckNH2e0XcU/p62Jc=;
        b=Xa7vLajBBN4Mz9gpCj6Ttmrp95kwDJZ2+9FF7xaAHh4Su/FpXEPpJ8wxuy5w3JuxsK
         SpUrSucTnH7+v4Qw7I3pninJmJA50odGBTFViRFudHwcqsPsQ08nMCbMwncE9PfOE5K0
         9kiekSx9dMMtu2OCc0Mt+7lpdZqnqVfZJLBTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429841; x=1694034641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pe9mE2/R7T8IPvBnOwTKQXiumtbckNH2e0XcU/p62Jc=;
        b=MqMWR6uXvqZaCYiwfe7ArVkOg+ZrrvBYS1dr1u4IBVAxApZUTISIzptbNDXE4WL9n7
         +wPCaN/r/zDRgtppkh2yx5iktkOybKsJ2t96CJyYhdZchftsul53IiS8D2/1xr0l2rK9
         QsTpxMlnN19PvOt9pDY/Cgpd7ODQ2Ld7AbTxRGXPN5TuOMLiQzLKTak0cz28pCu1EGXz
         utjRFR4EMwjA/ow3uCFgtBfkLZGZEJNIOM6WjwlqEdHXZXltFbLFvSkbKyhlKQP6ndOq
         xTlWUarc4+2Kw5I3nKoW5nuBnbxpOyIE7q9ZfUpGATsdHKpMUJw5jbNeeRPrGd+VI8S9
         pw3A==
X-Gm-Message-State: AOJu0Yw+8e9BUN1efg6Jrat8J13cF03w5QvFCtkGD91aZ8lbAqPXVNRT
        fOsGkOFvbzrjxBiQMPMaaMMqK2Txj8CAVNF8rUS/ogZ/dvDc87Qp
X-Google-Smtp-Source: AGHT+IFD5g7uHW+PQQ52fzmo9RpI5X5M7wL4vmNsfIm0JgfxAR+W6KxZL+c8nYTvzXsc+N3Kl99q3/5CFIX0GKdazGQ=
X-Received: by 2002:a19:504a:0:b0:4fb:8bea:f5f6 with SMTP id
 z10-20020a19504a000000b004fb8beaf5f6mr2160145lfj.34.1693427798584; Wed, 30
 Aug 2023 13:36:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Aug 2023 13:36:38 -0700
MIME-Version: 1.0
In-Reply-To: <56ae0bf828d942c92ca867afb3aae95fcabd5498.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl> <56ae0bf828d942c92ca867afb3aae95fcabd5498.1693416477.git.mirq-linux@rere.qmqm.pl>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 30 Aug 2023 13:36:38 -0700
Message-ID: <CAE-0n53a75cgRNJOdn1=19OG_yJt9DDXHZ4quhZwCtZiQ1RUxQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] regulator/core: regulator_lock_nested: simplify
 nested locking
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Micha=C5=82 Miros=C5=82aw (2023-08-30 10:35:31)
> Simplify regulator locking by removing locking around locking.

Maybe this should say "Simplify regulator_lock_nested() by removing the
`regulator_nesting_mutex` now that rdev is locked whenever rdev->ref_cnt or
rdev->owner are modified"?

> rdev->ref check when unlocking is moved inside the critical section.

rdev->ref_cnt?

>
> This patch depends on commit 12235da8c80a ("kernel/locking: Add context
> to ww_mutex_trylock()").
>
> Note: return -EALREADY is removed as no caller depends on it and in that
> case the lock count is incremented anyway.

Where is -EALREADY removed in this patch? Perhaps "removed" should be
"ignored"?

Note: A return value of -EALREADY from ww_mutex_lock() in
regulator_lock_nested() is ignored as no caller depends on it.

>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
