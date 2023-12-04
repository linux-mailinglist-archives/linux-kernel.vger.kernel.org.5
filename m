Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAEF80321B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjLDL7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjLDL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C39D49
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daf702bde7eso1917625276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691065; x=1702295865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbtwwv9tSK+nbMZceLLk+rFtyGZZTNEqHzjoCTb4mMQ=;
        b=TfZq2tQVVm3gVMV+dTb7vv/Y3POnm6Kb6+mxKz+mDJSnkA42zPPfLm5+gqNWmoYSdm
         It/WLPpvqZw8GOuyXl2v+SZAZQPws3pO7IHta+5XgCr6dVirZoRnBd3ivpMNr/l/XYEr
         srgXjuF5Cq6YtySc29Dls4F24m5blioyd6DcGRdde/fisq2H4OuY33wvHdqvkQydP4Vy
         3bL6EkNYNElRZTd4tKOQy7qGnYbUgZK/L+/btI7yi/UNgFC4N3Fcnjp7E+d9aJE9k4+2
         U6rHmnzAB6VYqMeP4gPD6K/R09nRPW/9cMUGJR2bT51wasFZz92gkI78sZYHvfQYpiMs
         A5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691065; x=1702295865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbtwwv9tSK+nbMZceLLk+rFtyGZZTNEqHzjoCTb4mMQ=;
        b=rGLZ6LplkKg/ArAXN4P31THQ1yMvyWCjd1bHrdHEMqX+zY7fz3fEWbpckVlruUoAqd
         XBAF9udxyB+Wzllczus+Z/zjc2c++WLzCMWAhgPFMeLxSyoddkeH2PXGibKKmYQG9iEM
         i26oGcvwWomWGNgJTevbVFjfMPT6dzO72O9NzggQaxI/aQv7P4voaA5iLyetwddNkXVQ
         nwxBykCJsDAldVro8y+DDS/O5IPmIj43CZpmWHf9eE1TmdUcAOII9WFTA9NF2UFzCRAS
         MGHAY3qXxo560mNwSWXhkFIawufp3irXnXxQwnRM1R5HuqUjnJxjSZ6RnBi1AqjPutnL
         EQag==
X-Gm-Message-State: AOJu0Yz03pWP1zIzN/VqOm2PT3N9ZJA/3GEipLfTHCzckmlZSOw/H2Js
        tggKhFffjbhDqh3T5x5/kV2R5yEAM2jo3xg=
X-Google-Smtp-Source: AGHT+IEgoDx2tApxhcKeToxnJ+KdC75/IX/cI9AiT72EkM84QUvKUVBfuXDG/lVLQOSkCFX1+aNBlASay2Iigxk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:74c4:0:b0:db5:4692:3aaf with SMTP id
 p187-20020a2574c4000000b00db546923aafmr286253ybc.6.1701691065607; Mon, 04 Dec
 2023 03:57:45 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:42 +0000
In-Reply-To: <20231201172212.1813387-28-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-28-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115743.43597-1-aliceryhl@google.com>
Subject: [PATCH v2 27/28] binder: reverse locking order in shrinker callback
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
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

> +	trace_binder_unmap_kernel_start(alloc, index);
> +
> +	page_to_free = page->page_ptr;
> +	page->page_ptr = NULL;
> +
> +	trace_binder_unmap_kernel_end(alloc, index);

What are these trace calls used for? Previously they wrapped the call to
__free_page, and happened after the `trace_binder_unmap_user_*` calls.

I'm guessing they should be moved down to wrap the call to __free_page.

Alice
