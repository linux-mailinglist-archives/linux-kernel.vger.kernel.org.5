Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9B7E372D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjKGJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjKGJIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A983010A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so6610843276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348082; x=1699952882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9LivEaG91fB0foH+DF2ftloie0aIVsD7s1NOwgXlJI=;
        b=YBY8DasbM15kHoMfdYrgtl3QGDhJgwkssiwJX/vhQZVPyJw0FmZq/xVhgrv0ABYwvH
         3c/q34cCMVI1jlPLWNOvf3MXdG9aTpJtysW0NBH6azR9Ym3IgGkCptU1sYjEMR/xs2jB
         hrRm/XmGgqtZL+sFBp7n2XLpADz+KMHYbsaTJDoN6S6pJEAJxkPZpHtyeisU8h+jgpz3
         vr/qhwQ8lKWTdMiGUz/SJnvBch4m0GDIOsupLPGRCSPA5bpUgxHpaZeiys+M+2DziIGa
         llRs+Ik2jxH0VIRyjVpeqAFyrRMfuufI18aNtZicF3D8l7fusgaAMKhRVoRNhboa4vta
         jpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348082; x=1699952882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9LivEaG91fB0foH+DF2ftloie0aIVsD7s1NOwgXlJI=;
        b=QquJrJYZYCtJC39kn7RAF/wXGka590vrHI4ZqK422KVfaRaju7CzI+MWeg3EnaKAWE
         Jl/GHEkRxfKH1fAI4PZnLzZe8j7aZb8JKi+ukJwVDapGCD6j6LRjUkCg5lBpJKLDwMzN
         /muzVqPzolL4Je77CI3XPwEirHG9GkiOFaO1sRIblovH9hrfRNBZ1snVqsGOHQYodQLx
         mLbScfd+WDcs8VcqJWauoyjc9J6wlQGzyp0PI3fdDxJj0zyLWFMK0v9198uEwxlThlGG
         nfFEcd9VhNWlVNNz7F/TkMnl2HUzkgwnYybbza9lxiqAG0jzPPsC80w62ASmWe97lwIH
         MqjA==
X-Gm-Message-State: AOJu0YyTNLCqwMOMuMAX/zcm1bjgcF90J7O46wJZXwaa9XmBNk3RTYsL
        EKrb/JQBhu1malCsJjOF+eq6EJAV9lkJBkk=
X-Google-Smtp-Source: AGHT+IHzj/YN/DngOUqC5MehLEkKQc+BpDjuPjvmDWca0V7plgD3nsBxiTjB8yuPp/epJb1mK7CV0o+kZS6Qtzk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:a2ca:0:b0:d9b:e3f6:c8c6 with SMTP id
 c10-20020a25a2ca000000b00d9be3f6c8c6mr607023ybn.4.1699348081805; Tue, 07 Nov
 2023 01:08:01 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:07:59 +0000
In-Reply-To: <20231102185934.773885-4-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-4-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090759.256458-1-aliceryhl@google.com>
Subject: Re: [PATCH 03/21] binder: fix race between mmput() and do_exit()
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Brian Swetland <swetland@google.com>,
        Todd Kjos <tkjos@android.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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
> Task A calls binder_update_page_range() to allocate and insert pages on
> a remote address space from Task B. For this, Task A pins the remote mm
> via mmget_not_zero() first. This can race with Task B do_exit() and the
> final mmput() refcount decrement will come from Task A.
>
>   Task A            | Task B
>   ------------------+------------------
>   mmget_not_zero()  |
>                     |  do_exit()
>                     |    exit_mm()
>                     |      mmput()
>   mmput()           |
>     exit_mmap()     |
>       remove_vma()  |
>         fput()      |
>
> In this case, the work of ____fput() from Task B is queued up in Task A
> as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
> work gets executed. However, Task A instead sleep, waiting for a reply
> from Task B that never comes (it's dead).
>
> This means the binder_deferred_release() is blocked until an unrelated
> binder event forces Task A to go back to userspace. All the associated
> death notifications will also be delayed until then.
>
> In order to fix this use mmput_async() that will schedule the work in
> the corresponding mm->async_put_work WQ instead of Task A.
>
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Nice catch!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

The code really could use a comment, though.

Alice
