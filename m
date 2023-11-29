Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0A67FE1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjK2VS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjK2VS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:18:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F39910C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:19:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so2915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701292741; x=1701897541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rdop8jujlsq38j+c7NGxEa2QjOJzSNmSB+B/S+mFwg=;
        b=skHkOTvv8uUBVxZ3vfl+wDZ3VrCDcJOQy9bhFPNgdsZ/EgGQ5wP+4NnVJpanmWSTQB
         TwwB+FgwTzMyibzNtSvcBDj9v/iAOH2xpTPhDhirFOuLSWybFftpHbR1gcvrd6YjEkd3
         DX3IMgL5Z777bI8YIdoPW7+sD84gJbpLa6KyEh9o5DWgVsUZWPX/NoREZuk7sZSEd0U6
         N7OtRA00qLtkzBpCSylnzgUIDRSxco5Rx+3aogv2xiyYUNkpZUeTh7Qz6jcEzmRhjZgS
         QsiIWuqiZYaAgzuvVJfnC6OI+E+HX+bwUTR35oMF1pomhYQRt2TL8j7vwA9K+dKavWp4
         AEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292741; x=1701897541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rdop8jujlsq38j+c7NGxEa2QjOJzSNmSB+B/S+mFwg=;
        b=fw8WvyXJ0KYb8DNu76o6Fq4P4qg7yLrV4Y7bpbYxHA9JcsyIJAiD5WzqQfeKwm7zgd
         5CzOEIJnO75g7BrhQNictuRt8itlTjcEaRG9pQkrY/wQBBdFKFSi0VY2WckxBx1GqkAx
         EO7f0Qepj8I4UUcesWDqVc1HmcI4lTfaA5Syr0SU5lbG9Um2iZAoJGjpLgosj97RwH9T
         csE+qhhMIOQzObPqXlv+/s5wsKSyx6vkji2Dw2W934sgeMG4yX41jDAubcDhzAGuW+RR
         TS2d/LUWe6zml0KdZuuIfIaSIR9KcAXnIOf31XcZ2HV0M2e9xdR7BEmGPgpRG2WuYnpi
         eFNg==
X-Gm-Message-State: AOJu0Yz6gv1TMyjQaP0FLPdorKP/EeqLsb6Hfac/Xy1oO1ei6hlMj5Cr
        zr9W1A11egye5DQOx6mmEw5QkPuRTasUR2wva9lSTA==
X-Google-Smtp-Source: AGHT+IHyO9c4yie0auocSQkL6hivcgNhN6tW76pQ5z/ufkohVvgVzXQvW4qZ3GnEDZBUV5HP0qJbXbHG2m8gA/7WD+k=
X-Received: by 2002:a05:600c:c07:b0:405:320a:44f9 with SMTP id
 fm7-20020a05600c0c0700b00405320a44f9mr31506wmb.5.1701292740717; Wed, 29 Nov
 2023 13:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20231121162457.17703-1-rf@opensource.cirrus.com>
In-Reply-To: <20231121162457.17703-1-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 29 Nov 2023 16:18:48 -0500
Message-ID: <CA+GJov50r+0vPj6gtgXXuaKf8nQqt9CVM8dGUsJcxiFupxo7Sw@mail.gmail.com>
Subject: Re: [PATCH] kunit: string-stream-test: Avoid cast warning when
 testing gfp_t flags
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:25=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Passing a gfp_t to KUNIT_EXPECT_EQ() causes a cast warning:
>
>   lib/kunit/string-stream-test.c:73:9: sparse: sparse: incorrect type in
>   initializer (different base types) expected long long right_value
>   got restricted gfp_t const __right
>
> Avoid this by testing stream->gfp for the expected value and passing the
> boolean result of this comparison to KUNIT_EXPECT_TRUE(), as was already
> done a few lines above in string_stream_managed_init_test().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: d1a0d699bfc0 ("kunit: string-stream: Add tests for freeing resourc=
e-managed string_stream")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311181918.0mpCu2Xh-lkp@i=
ntel.com/

Hello!

This looks good to me. Thanks for fixing this!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  lib/kunit/string-stream-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index 06822766f29a..03fb511826f7 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -72,7 +72,7 @@ static void string_stream_unmanaged_init_test(struct ku=
nit *test)
>
>         KUNIT_EXPECT_EQ(test, stream->length, 0);
>         KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> -       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
> +       KUNIT_EXPECT_TRUE(test, (stream->gfp =3D=3D GFP_KERNEL));
>         KUNIT_EXPECT_FALSE(test, stream->append_newlines);
>
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> --
> 2.30.2
>
