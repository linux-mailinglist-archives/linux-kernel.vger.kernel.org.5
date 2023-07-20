Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046675AF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGTNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGTNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:19:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F310FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:19:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c850943cf9aso692303276.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689859179; x=1690463979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgZ9ooT3DeE5RLk0xNDZM8mZvor4qfJnspj3DvnmXwY=;
        b=DQ7IEpOnPYiHUaa+8JjGvD1NOOcrlYTeDHN/Kjveazs6pBW+LEE6G25+hhR2lzY5N4
         kAe8FDtMHmBH/3LsVQOghfDYy9WAol/nMK8le4LYeVPm6oefDze+MntUDRNWpqeapqke
         GLPoqDe+INYSLntdzYeo5oy3zH/Ei7qSLugfmFlFHYDVwHF0cYoBDmw/ne+S9VLaeiG8
         0SFAt75IFx6g0sgVXCCXwP42xeiaDc0i52GK0S5CdfW7dNoNnODPDknlctUxMdcm2pH0
         zRgqGkBh6CUL7NOyvbwVIjXrCQaUGz3Hr/4uTcE3zm9ep2JEuWnfdI09C7IXxOgsuX0v
         Nq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859179; x=1690463979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgZ9ooT3DeE5RLk0xNDZM8mZvor4qfJnspj3DvnmXwY=;
        b=JxlzY6iygsegluA1peWZFq+UbVuuO0TuIBXl4ogek9iENBvriHNIJCFszTP/jjTBLv
         vXuelwxbfslc2o+Xody1nbjhZZ+4fqJX/PDvTrAfbrkgxpwwCDN8E/9i6r6t0VDEvZR9
         t6e7vrCQZSfLuue3Hq2ORBw1xWXkEFo4+6RIOwoFA5vjqNyv07up6Qr9m43aVVnaRzW4
         ssICyMYRbkdhmp4UsrMbhF3Za0YrWF9yuGdupaPV9ulXTilN0E5x2DUWyF/olE8rhpni
         GMn/XeUW+PPu3OnR486stK5rfv1xyswq18lpNGW7BE7v3RhVGzxNrjWVvm+dJnRII7J4
         JhxQ==
X-Gm-Message-State: ABy/qLaZGweYEWRFJhElueQiz3VejLuMqSGF382G8oOJZzCmUI5u38WF
        o8m2/PyiUyqAG0QML6SakJ2YMQhtITRvdmo=
X-Google-Smtp-Source: APBJJlEMchiHRAUU4IO9gxpJzGtYZzkACtFDgPV6hRWNzaIn3ajz9EJPnHsiDD25WWzLGV2F7AofIcFTPhEL4WY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:2054:0:b0:c85:934:7ad2 with SMTP id
 g81-20020a252054000000b00c8509347ad2mr14890ybg.8.1689859179232; Thu, 20 Jul
 2023 06:19:39 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:19:35 +0000
In-Reply-To: <20230719141918.543938-6-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-6-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720131935.3542850-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 05/12] rust: init: make initializer values inaccessible
 after initializing
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Previously the init macros would create a local variable with the name
> and hygiene of the field that is being initialized to store the value of
> the field. This would override any user defined variables. For example:
> ```
> struct Foo {
>     a: usize,
>     b: usize,
> }
> let a = 10;
> let foo = init!(Foo{
>     a: a + 1, // This creates a local variable named `a`.
>     b: a, // This refers to that variable!
> });
> let foo = Box::init!(foo)?;
> assert_eq!(foo.a, 11);
> assert_eq!(foo.b, 11);
> ```
> 
> This patch changes this behavior, so the above code would panic at the
> last assertion, since `b` would have value 10.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
 
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
