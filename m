Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008EF80AD1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574682AbjLHTdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:32:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591001706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:33:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so8545e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702063983; x=1702668783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra9vJuTInRrpamBBEJ9LmrEW3hYoB09CBBvxN/oJ2+Y=;
        b=SUwEC5xFvyL3QDodvRud/4eaGIAtEMP7zbj7xDJFx/avnxwykn0lyvpUdPFgBNM63Y
         jDRoDYxBqsl4AwlKUu8zweKfSbPCl3+GDwvVPg9zY5aDyOYv5AR928vA1V0jlyNW8yLo
         WPZCGT43X2ltD4XzSZEhNr5SjS6BsyPCjGFgS57TpdJOQaGHTNmxt2wg4wYicvMarsKZ
         YFEZKjBBc1PCP7HcUhbdYwH9JyjbIwRx24sbWEjXoJaNWGoKIFOSJg5wFe9HcKRhp/2f
         VaeQTevTvUG60yOFjqpGyduRLZ3gUKwkyaIEIZlCl7NEX9O1HxY6DXawTZV70i18KGux
         5PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063983; x=1702668783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra9vJuTInRrpamBBEJ9LmrEW3hYoB09CBBvxN/oJ2+Y=;
        b=xDoNDkYiuJCdD28IFqVeud5IjGP60n/+gmsJXkX3rcPVDemKRYi+NTPIoA6M87cbS6
         LoURy2g+i/ZMmrM0O+XGs93aMrqlFpamUux/pB4kdrsFlEfxwchMcBK7+mZRGmZ6oemh
         KaMN6WfR8SGNR/uSogskW4Y6NqMlRc0g5SC2hup3AdOqo33b9Sw/U9pM2L1jRZ7+UoLe
         LFU9Y2qA94k1LLKCULTlNQlBd6ETBS9U+U5UuIT2KzUetrunLkFe7KgFhE2R1O/lO6xb
         mz57NAghpdYb9zdQ+yEmLVctOOzZxcO8hjpYjFuAoOyfZSfHmzdlt7Y5+tpMlGSRHRKy
         gZ5A==
X-Gm-Message-State: AOJu0YwwqNZy49i6DatVKQr9weFJszRMYdxSgyoEW9dT9bewl4ZMsKhg
        mezCDarbKXUFlIoUzKgcBNKM4W1QHHuQM5dyxfL6Mw==
X-Google-Smtp-Source: AGHT+IGdOUZJcWkF1Q/IPZf5TuqHSwtcgFDnUkDzI2G5sOp+gsWGwRfPac8MwWtVbp+GO5kIg5Uloat2UDw51JfXlxg=
X-Received: by 2002:a05:600c:286:b0:40c:29a1:5547 with SMTP id
 6-20020a05600c028600b0040c29a15547mr86714wmk.7.1702063982671; Fri, 08 Dec
 2023 11:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20231206082251.586204-1-davidgow@google.com>
In-Reply-To: <20231206082251.586204-1-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Fri, 8 Dec 2023 14:32:49 -0500
Message-ID: <CA+GJov4H8DJgeaxus5BTS=Y0iR9M+BirLVht8fB9jxjWGODrMA@mail.gmail.com>
Subject: Re: [PATCH] kunit: test: Use an action wrapper instead of a cast
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 6, 2023 at 3:23=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> We missed one of the casts of kfree() to kunit_action_t in kunit-test,
> which was only enabled when debugfs was in use. This could potentially
> break CFI.
>
> Use the existing wrapper function instead.
>
> Signed-off-by: David Gow <davidgow@google.com>

Hello!

This looks good to me. All ready to go.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/kunit-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 3e9c5192d095..ee6927c60979 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -559,7 +559,7 @@ static void kunit_log_test(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
>
>         full_log =3D string_stream_get_string(test->log);
> -       kunit_add_action(test, (kunit_action_t *)kfree, full_log);
> +       kunit_add_action(test, kfree_wrapper, full_log);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>                                      strstr(full_log, "put this in log.")=
);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
