Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA688031FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjLDL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjLDL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:11 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC34D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:17 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2ca0cf837d5so2702991fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691035; x=1702295835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OE3B+eJC+W5dSghfOiTmA1KLvp/ho7zp/Xmtzwbmc+I=;
        b=QRT9i9wS3SGxzG2De6Vr3QOLi+mjXCKllmQo0ekN+TJByCHz+MwLYuA2UE9wfqdLsR
         SyEjp1tHQrYeOI+zYqG8xAF4aZNfU9xkrNBFytiCGXabGhF14aJsIjVnjizzUa9r8NEN
         swz9B+jgXoFA5yPyUYAy6mxGDZ32thRNKaQsRS5vIYtqPXaskqhyYq0d5LeKzb63ebhK
         fq7isueMxL3t3V09BiUFmJBgV1z2LvzZ5nB+9XUNwC6++OHfTqp/a58P3dG39mWJvLh0
         WBE/KEA4alMWUNqe386hkSdbS/KzSbrgOKTTpsbrUx0rVFABHerx/O3I0QyvQfGvwkrw
         LceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691035; x=1702295835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OE3B+eJC+W5dSghfOiTmA1KLvp/ho7zp/Xmtzwbmc+I=;
        b=tgMclSUeaE+e9ilUoK8I0QDfDii+ZqZZETnB8JNH/okhtH27LF3qzkUjgBFaSTiGxz
         3NfL0M7B2fBIJd6pmSPMDOughZJjlqqT9A8XawhMOlEsSKVdV5NtI1dtDm4jnREwwwd2
         v78QrLZhKRx9uhaCeT13QEl5prhA/n9I/Y2hcO4F9qi4fQ1TKzakdr37GoPTMFjEHk7e
         Hrdev9MMHB3GpoF4hj7I/CI4rOJEM23gwPQdF9Vm76sfRF5d+6pTvWKrGR6amWx3nzHe
         xCnl4IvGMgDfpwreEwBAZJU0dAj/V1XiZSdhzo8dnI0iTbyK4ma0eHAb7M5zrQSwRyqB
         m0cw==
X-Gm-Message-State: AOJu0Yw886fJAziIyOwzs4UGqdUArlEMvYZMPuijqDnyr/EDaxvhGjww
        pn6zjwyC15gUk91eTf4A/XLVmz+sBNdTMeA=
X-Google-Smtp-Source: AGHT+IFE8JTGuydiEgwLqMds04antUf4hJyBJVyJ32D981uVHXVlO2eiXr9QQOjsUL6BJuS059SiBWVnNaHsgLA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b751:0:b0:2c9:fdc1:cb20 with SMTP id
 k17-20020a2eb751000000b002c9fdc1cb20mr51505ljo.8.1701691035433; Mon, 04 Dec
 2023 03:57:15 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:11 +0000
In-Reply-To: <20231201172212.1813387-20-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-20-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115712.41114-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 19/28] binder: perform page installation outside of locks
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Split out the insertion of pages to be outside of the alloc->mutex in a
> separate binder_install_buffer_pages() routine. Since this is no longer
> serialized, we must look at the full range of pages used by the buffers.
> The installation is protected with mmap_sem in write mode since multiple
> tasks might race to install the same page.
> 
> Besides avoiding unnecessary nested locking this helps in preparation of
> switching the alloc->mutex into a spinlock_t in subsequent patches.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +static inline struct page *
> +binder_get_installed_page(struct binder_lru_page *lru_page)
> +{
> +	/* Pairs with release in binder_set_installed_page() */
> +	return smp_load_acquire(&lru_page->page_ptr);
> +}

Technically some of the uses of this method do not actually need to be
atomic (because they never race with `binder_set_installed_page`), but I
don't mind using it anyway.

Alice
