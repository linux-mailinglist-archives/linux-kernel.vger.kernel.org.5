Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988497E373F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjKGJJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjKGJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:09:15 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E31BD3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:44 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c50d73e212so59096381fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348123; x=1699952923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BAuWCTnwuDSlFD1uUY2dNmkoljlGCWC41ZF9rF00uM=;
        b=uFFSxY/GVFipCeUgaQBHGLZ3l/ZU255q4DHiW1bPFSyraKto7Fcjri8KugqH+XQnaY
         n4DJKtuP0lwm26li4ID7M8mZeuJeXJR1Zskx+3+atsUBe4ZOfLKkdPsHgdLHz3wrjooh
         OEKFKoxnrrV1kEDS74gPArM5vosn0JCXN4u7SraczaWd0bGk31X6TLAukjXhSGP7FA+s
         WiP+J24F33K0o6r1NNoSxsM0UzY+WkbO4/nG8pmgdNz5MklxMMVcVGnwt7+ZanLY3Zp8
         0tdO5LAO1AEIMaHrvFeP5PxHdo1jKvqLrrzljISLHvwbh7KAhnKTe+JdNWK9/fsusdUz
         m01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348123; x=1699952923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BAuWCTnwuDSlFD1uUY2dNmkoljlGCWC41ZF9rF00uM=;
        b=W41YDf97S2eSFPuEW1rKkm3qiDHiCX17qBUiA6u7muzXzF+9JqgfQYM4jlIv/Mw0jo
         ih2uVX2ufYthtXtY3gPP2RV9hd9L9LjwMFL8lj3SjJD7fjDybhVTJrnIyj6bq+hT6K84
         bS0IVgLQTjVPtbUZn9tQld74meT/jTJMDIjLXksfgIAbSoOUHMbzcJfxNMBKjR4tUknU
         aIWgCNh/OjkCvcdpLHW0q+EVcoxi4UcQuSTIkrCdATu27sjF3CU39mLcCjDbpNlW758O
         C2JIqgtuy2qKEdPuXg0bysyLv8iIdpj9QmcelbW/Ju5vTz7CvmypI3vVasGNknqh9mZr
         CWlA==
X-Gm-Message-State: AOJu0YwZvTG4ynHTK23xMUPcNuj02KOsO2Nk7LVwjOEhDjogLOKpGInc
        +X5jCl85n9GKa+5GD9ermoTlTvJh9geQjpI=
X-Google-Smtp-Source: AGHT+IG931hZ+qR0BKxa91yuqFUMVySq851zM5KJt2sKfZz1kC+Ej0+8Cpn+JJEuZRyvKRM4tDsUJPlECJS/U5g=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a7cc:0:b0:2c5:13a7:21dc with SMTP id
 x12-20020a2ea7cc000000b002c513a721dcmr373805ljp.6.1699348123113; Tue, 07 Nov
 2023 01:08:43 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:40 +0000
In-Reply-To: <20231102185934.773885-19-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-19-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090840.261023-1-aliceryhl@google.com>
Subject: Re: [PATCH 18/21] binder: initialize lru pages in mmap callback
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
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

Carlos Llamas <cmllamas@google.com> writes:
> Rather than repeatedly initializing some of the binder_lru_page members
> during binder_alloc_new_buf(), perform this initialization just once in
> binder_alloc_mmap_handler(), after the pages have been created.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
