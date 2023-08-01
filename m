Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E267D76B287
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjHALCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjHALCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:02:20 -0400
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F694C01
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:56:35 -0700 (PDT)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d10792c7582so4382927276.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690887014; x=1691491814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHcvSmUD5NQH7dlSs1RiodhXk7N/adTKqbnc+6BUbAs=;
        b=neb8lEFM29+M7oIq4ba6eT4rvS9wzWOAOU/MmG2LdtfU5Ka5nYxrYi0MLMR1ZYb/rF
         cqNNxHfKhH2JxQiw20PyUN7toyx8ezotWhIQ6Mk9KA7V+xJUV06wn74CAv/Bqf/6+JmI
         DRrPHZL3zqrUjqgH+yQv9gKFqQChWeu0Uk6dzwZTl9CYfOHKv6pmUb4w0ETQDvG3qWgD
         mNvF4vnhhXoYtMe9OLX0v6x69UnQXWvCK83u7R1Zg7uq12jqVLgbiKjvm8xoqlzjf6bs
         lF9OKiTvbE4FVmaxloHhdi63gZ3ENtnSr+U9mvbtxIiOYlGXqVojorc1L8noznc0XxbD
         I2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690887014; x=1691491814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHcvSmUD5NQH7dlSs1RiodhXk7N/adTKqbnc+6BUbAs=;
        b=ittTK7jQx2DWEl9Q6RVc46ums9HOvce8mZGU5ywUJt+VKRdmyYEc6lCvk8j9x1+/3y
         Mf29opq/wEQ+9vO6KD9ErVd4t5FW5cCCFuFSK4ItYhxvu5W9+dgmNnv9dzSb2YwcsKLQ
         YtiwTT1Kngv5GI2tVDwcI/cPXSSZchtuNa2VW/+yVscjAYiNkchDm5PIOkfHBLF+lycE
         TZsLyeSetYbO7RTy+cuAMboNQQ/kQH9k+LJNKzbNHKlD42jxmC9fPcosFbEH0yfYNy0W
         8WOdFQJeGeotICMhRZTy7VB3dxy4VvhsKKpjbW1YQJMs1LIFchrF+CFwWODA4Jyc/WUy
         DIwA==
X-Gm-Message-State: ABy/qLZ1e2TfrP3kdm3btLht/ObbxrUvScPFgxPYuaJvJASALMk1Jgaf
        +DZE60gqj9/O+MiOfkfSrl/OtapTwmCfGIU=
X-Google-Smtp-Source: APBJJlHzNb6bXB8ltHqQTkoGZq1RSBdB0hBEpZ4BPR57T3IYwV2Hmn/x7LKYrNjzdYQ6tJ5J8b6Zb4tKK4Bs3gc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:11ca:b0:d09:b19:fe2c with SMTP
 id n10-20020a05690211ca00b00d090b19fe2cmr78470ybu.12.1690887013886; Tue, 01
 Aug 2023 03:50:13 -0700 (PDT)
Date:   Tue,  1 Aug 2023 10:50:08 +0000
In-Reply-To: <20230729090838.225225-3-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230729090838.225225-3-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801105008.1585062-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 02/13] rust: init: make `#[pin_data]` compatible with
 conditional compilation of fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> This patch allows one to write
> ```
> #[pin_data]
> pub struct Foo {
>     #[cfg(CONFIG_BAR)]
>     a: Bar,
>     #[cfg(not(CONFIG_BAR))]
>     a: Baz,
> }
> ```
> Before, this would result in a compile error, because `#[pin_data]`
> would generate two functions named `a` for both fields unconditionally.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
