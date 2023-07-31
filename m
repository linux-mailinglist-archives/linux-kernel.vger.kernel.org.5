Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531B676A0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGaTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGaTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:06:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAE01FCE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:06:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d20548adso4357665f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690830360; x=1691435160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l2WxsWAHvSSljtKQmToghU/ZBm1ZT8P5v2Qhy5RjWOk=;
        b=FivhBWf5dm+70AtLuhtGSDQWg5T17ddlB5XsAt1myLyxWnKFK+8Xk7iV1BUtuFBhSU
         ZrSydZjVrkpQbWaZJhZJq+tEpQExDh5AB2N8rT9kJJrbMgXZl8P95YSKDKTB8S2vEBeA
         v1YOpMOWdBt995jFr1PtnzTDjoeJMPF/hE9QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830360; x=1691435160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2WxsWAHvSSljtKQmToghU/ZBm1ZT8P5v2Qhy5RjWOk=;
        b=Ri+mbDbwNFzvv5ugQnjcKIp1sF18Eo55OmSMZcHctbagn+oNE8RjS0Y2pftXg7xUV+
         G8zveswvoFWvL/N9fbYMQ4kehClQ6rKX2833df061b6m7UUx+g54dzAPiK5VQjB6P5YW
         0bWyr8nE8arnlO90sc8lqlxWAHK/ouTXtNbml4uhVit0sGOE8KRT0aQjpVi6dRaO13mq
         2MXsZcqpV61bv/YQGYGdHOFYGARq1M5N6hMk3TBk8/tuPb/scit6HRP3eJ8nRWBmnrRy
         feovs9UEf2bVbitch7JdBxHFF+KqcYfGlxihiDoTxlWOzZB/fXADtbyVT6N9vjEmd14I
         bYag==
X-Gm-Message-State: ABy/qLY9Toqs4yXs4tZ16M+aMdO1lr17H3kx9WJ9pD6Ijp2TAmQDhucY
        JbVjAb/UdIpZ5HwhCEJpbAQgbsp1qnXgSNNUl9EWKFUd
X-Google-Smtp-Source: APBJJlE4Csyg0yMK0OdDeJqYDhxPVHdvkldwBz58psy24sBvc/NHgEDwsE25EiDdAin7ACOHwnGUKA==
X-Received: by 2002:adf:e50e:0:b0:315:adf3:67db with SMTP id j14-20020adfe50e000000b00315adf367dbmr462795wrm.59.1690830360585;
        Mon, 31 Jul 2023 12:06:00 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id k19-20020aa7c053000000b005222c6fb512sm5729036edo.1.2023.07.31.12.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:06:00 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so7234077a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:05:59 -0700 (PDT)
X-Received: by 2002:aa7:dcc3:0:b0:522:31d5:ee8e with SMTP id
 w3-20020aa7dcc3000000b0052231d5ee8emr691287edu.8.1690830358999; Mon, 31 Jul
 2023 12:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
In-Reply-To: <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:05:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
Message-ID: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 03:53, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I quickly carved up a patch (attached), which is only compile tested
> because I do not have any AMD hardware at hand.

Is there some way to just see "this is a fTPM"?

Because honestly, even if AMD is the one that has had stuttering
issues, the bigger argument is that there is simply no _point_ in
supporting randomness from a firmware source.

There is no way anybody should believe that a firmware TPM generates
better randomness than we do natively.

And there are many reasons to _not_ believe it. The AMD problem is
just the most user-visible one.

Now, I'm not saying that a fTPM needs to be disabled in general - but
I really feel like we should just do

 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
        if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
                return 0;
        // If it's not hardware, don't treat it as such
        if (tpm_is_fTPM(chip))
                return 0;
        [...]

and be done with it.

But hey, if we have no way to see that whole "this is firmware
emulation", then just blocking AMD might be the only way.

               Linus
