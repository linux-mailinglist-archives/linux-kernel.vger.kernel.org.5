Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68877E3743
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjKGJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjKGJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:09:40 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E49B172C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:53 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-507ee71fc4eso5600059e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348131; x=1699952931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xFMLem70HhYX6nRkbkKvKTWxCL0yDkauEaz3DzbPvo=;
        b=hnjzFTZAXhdOY6Fthq1RZEukW3xlcF6a9BhrtC3K33z2sAVKengGCVmhjwGLvsw//C
         4JFJrfbR15fczPwL7m0Kdyaw/z96acqz+GCZCcYBNOkJ64jqsoKjhUMue7l0OCwmr3+U
         CjED/16b4SOlJFvkMavJIeGoh0Fawe52vXgXjd0re+/OOwVkQrK+YUHHRYox52OGb07C
         R0o78jncSfWSSX0RSWDGH+Sr3AoGJYMXIRUJfi/3gj9JmIAl0iyMfV84VqK8el/7vyqw
         g+19Z0hoL5XgiEUIAPhGDI/iZRLD7734hTsEk+YBS6ird/pFSrrB4SpkMTLkXX1HOH0p
         gb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348131; x=1699952931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xFMLem70HhYX6nRkbkKvKTWxCL0yDkauEaz3DzbPvo=;
        b=Sdd9NuqvNapOqDofv2X+gntC74wW8CW2s2pHyYx9rQE761QfGLSz9CYsaEgEd9KN/7
         vnbxZTId0R28mTlHYEZzpQQ7dUF5jvgkCnk4d9w2UpoaobZGn9K8SssifLAquhQPtBgu
         8HdJfciE2m+H57L6sTgFsbBW/4PhDTe8bS3ouO/UohlLVl8r8WzN7VUnQ5IE90d5zPSM
         8u23LnwfT10cORlo2RbkUzib060O4g+eJgZyWe9lcikDnczYqBd6S+akLHcUzAweX1Xn
         vNwcoCbi2EthCuBHsp5EPMfbJwQexoHCIe5LgWVnQqkROCszNQ/H5I1fhFy45VL2y+gY
         KA4g==
X-Gm-Message-State: AOJu0YzA4Sh7tCnjh73/vMSzwI3TxGyuv9gOgcMrIAAh4SLRbIlHYAyh
        pBqolZ5hwpdr+Ltp8schgYQXzHgZo4ZuuA0=
X-Google-Smtp-Source: AGHT+IHN7wQPceBPLuoJnA3rKiTrr+D0LIGTZ8UiA6BwJX2KnDvqCrX+E13FjJLa5896VLuVQnoxClj5GYMd8dI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:53b9:0:b0:509:440f:3c5 with SMTP id
 j25-20020ac253b9000000b00509440f03c5mr149140lfh.1.1699348131534; Tue, 07 Nov
 2023 01:08:51 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:49 +0000
In-Reply-To: <20231102185934.773885-22-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-22-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090849.262070-1-aliceryhl@google.com>
Subject: Re: [PATCH 21/21] binder: switch alloc->mutex to spinlock_t
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
> The alloc->mutex is a highly contended lock that causes performance
> issues on Android devices. When a low-priority task is given this lock
> and it sleeps, it becomes difficult for the task to wakeup and complete
> its work. This delays other tasks that are also waiting on the mutex.

Grammar nit: "to wake up"

> The problem gets worse when there is memory pressure in the system,
> because this increases the contention on the alloc->mutex while the
> shrinker reclaims binder pages.
> 
> Switching to a spinlock helps to keep the waiters running and avoids the
> overhead of waking up tasks. This significantly improves the transaction
> latency when the problematic scenario occurs.
>
> [snip]
>
> Note that it is only possible to convert this lock after a series of
> changes made by previous patches. These mainly include refactoring the
> sections that might_sleep() and changing the locking order with the
> mmap_lock amongst others.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Nice!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  	 * binder_free_buf_locked(). However, that could
> -	 * increase contention for the alloc mutex if clear_on_free
> -	 * is used frequently for large buffers. The mutex is not
> +	 * increase contention for the alloc->lock if clear_on_free
> +	 * is used frequently for large buffers. This lock is not

Grammar nit: Shouldn't this say "However, that could increase contention
on alloc->lock if clear_on_free is used frequently for large buffers."?

Alice
