Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32527AD7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjIYMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjIYMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:17:26 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CE10C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:17:19 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c268676a9so75384997b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695644238; x=1696249038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xx+A8zxruuR8KUakSK/9HIOv4z00NBVJ+Y4StkVxo7E=;
        b=pvus8fSsHRDAaZn11TuwPXyTED9nSPwK4Swh7AjepBkVdK8j6i8FxPrP5ZWGxDkw9/
         5XiGKPbuLEJm9mClIHg57fZgTTTW9vunlJS0fJbs8LVlm5D3InLPn1qy9IAUTwnLjCRq
         zt0/pV7RioN6GWY+FcRUohJdtJev14MXAdJNVtQ8n4bqVGv01X4kH+QsMQTjMb/Qv8JF
         /DM2NAAPAVDgCU+SRlR97o28FuIlsMafM12JGGPIO1gXKO14hofoYmBQS4JQ2q+3gqCW
         6bWU8O/zGls6AlgZkkBBlOeC/IpTIjlWbQ8YL8Sj7oiDwVG1xHsm1FOv069fZ5Lor4uH
         d/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644238; x=1696249038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xx+A8zxruuR8KUakSK/9HIOv4z00NBVJ+Y4StkVxo7E=;
        b=n/VwoWR0djT1SFzvkDAVafWd1Wx7xGpKy6qlQgbEAf3rCGnMXPglNb6NIl0yStZMDY
         NnTX7yJmXxJHEAf13zsvBbFZeW/te2ob5UAYDSdHvOWNIDTi0I9DP88dBmqew2RiSTsp
         cvE4t2ozlv2WH+70T49l5lCQMldX64XV3RoBOi5tlRtRiwZrSn9YOzw/uYJIPEJp9M+t
         ONHS0A6BU1nU05dflaRCflaBpSgmGvXtvYciAwryDiwBl9Fb7gLjOIAMKaHi9lvCIDR0
         +KS3LNeSzOtuDvYrr5VDQtQQjCIHUEgu420FAajFmup9SZeNvmcFIaWat9e5OFXiwB2k
         qWeA==
X-Gm-Message-State: AOJu0YwioJLrB0bwEIVTQj0e5y9J55thFP9FermfIYmsTWwNJdxXlQMv
        TNiMwx4JAkDUpjkz5pwfk5f+gAp7LrRUwI0bejXZfw==
X-Google-Smtp-Source: AGHT+IEZVVMYG8tLWvvrz8sPIYdQ1KJOTncEoLVCzBF8eUvwD3eWNACQY6mQSCaANlaLVI3+Wa0X7ueN/e1NoJ26ixU=
X-Received: by 2002:a25:e016:0:b0:d85:ad8c:4bf4 with SMTP id
 x22-20020a25e016000000b00d85ad8c4bf4mr5661511ybg.34.1695644238375; Mon, 25
 Sep 2023 05:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com> <20230922080848.1261487-3-glider@google.com>
In-Reply-To: <20230922080848.1261487-3-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 25 Sep 2023 14:16:37 +0200
Message-ID: <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> +/*
> + * Test bitmap should be big enough to include the cases when start is not in
> + * the first word, and start+nbits lands in the following word.
> + */
> +#define TEST_BIT_LEN (1000)

Dunno why this didn't fire previously, but CONFIG_CPU_BIG_ENDIAN=y
kernel reports mismatches here, presumably because the last quad word
ends up partially initialized.
The easiest fix is to make TEST_BIT_LEN divisible by 64 (e.g. 1024)
