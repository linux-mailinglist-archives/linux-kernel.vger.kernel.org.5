Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDA7E3742
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjKGJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjKGJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552141724
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:22 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afc00161daso63765487b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348101; x=1699952901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSKgABfKin0QFWodlZljA42NEOuJivSk0X0VqFGlieg=;
        b=IqoexA586XrJmxf230PVY0NqjfR134AfvED5ajfCrUmMhhRYN2mcEhG5xOIh+gvzST
         1eJvZBf64Y+vJB+yoPsnMfIwXprZNS54fx6g6OANNif4BNg0Jx8tvbLYEU8GcETVNMmh
         nJD2RcATIkWEE2UlvmcvhmJxIfnBXQSXvWdbZsb+v8bH4GmXg3IyHl8rmVa1tyAUpIFu
         kvtdcA0QMMJSvXoyE3wkhRxiqZLwmdm3p/Kc2nMCFXzgSGzgEKUCcMWuNOhhADI3Nbvq
         uV+7CvcO59AutF22+pQs6/eg6NhJp1EG+r3ew/Fg9R2OX4P2LcEntZmuafW4jK17Bdmi
         HvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348101; x=1699952901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSKgABfKin0QFWodlZljA42NEOuJivSk0X0VqFGlieg=;
        b=XcrCSL2bMA0A8/A+riggClQT+bdropRBLXAjpvjKVbqbeiTh5q5LVMUWb1fZkaX3Td
         YqCrAEVeaOvaXqvjCab7PZlpIE8J/iNy5pb8LwHcalHB53FdnC7fGce18DLitmZpMJBJ
         rjIO93IGzKtVseIUgq/MVQs3rupE2C9lBPMNWM2oEX5s36RUffHezpYQfUqkQQBNjlAQ
         b6ZrcE/l7G9DMBFWfCHpa6v0CHjZt7exRFA4QQ+OvemW2Lys0UoT3FzLdxbHUwG60E5i
         Hy6mn0DhX/fcZcRbUJ91q1yQMW90lZMYD8CBAnG7wKfuYejND7D2hPz5SrH1h0EiPNez
         4xoQ==
X-Gm-Message-State: AOJu0YzApIt92yjs+9Gr5F75XYgpcDbOGCRwadYEUs9t8C9phzdC3jVc
        7vMXWnyR+H7tRI3qoUnEv6XGRMLoL+3EhRM=
X-Google-Smtp-Source: AGHT+IHYcIYTlCLYoI0xSblajexRHspS6I52oG0dryYVEPFtWNNcZIMtmnp2bAIfdCa+SDvcKLwizAaIs/ZaJsY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:ae0a:0:b0:da3:b880:180e with SMTP id
 a10-20020a25ae0a000000b00da3b880180emr309599ybj.2.1699348101374; Tue, 07 Nov
 2023 01:08:21 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:18 +0000
In-Reply-To: <20231102185934.773885-11-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-11-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090818.258621-1-aliceryhl@google.com>
Subject: Re: [PATCH 10/21] binder: do unlocked work in binder_alloc_new_buf()
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

I found a few issues in this patch:

Carlos Llamas <cmllamas@google.com> writes:
> -	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
> -		ALIGN(offsets_size, sizeof(void *));
> -
> -	if (data_offsets_size < data_size || data_offsets_size < offsets_size) {
> -		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
> -				"%d: got transaction with invalid size %zd-%zd\n",
> -				alloc->pid, data_size, offsets_size);
> -		return ERR_PTR(-EINVAL);
> -	}
> -	size = data_offsets_size + ALIGN(extra_buffers_size, sizeof(void *));
> -	if (size < data_offsets_size || size < extra_buffers_size) {
> -		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
> -				"%d: got transaction with invalid extra_buffers_size %zd\n",
> -				alloc->pid, extra_buffers_size);
> -		return ERR_PTR(-EINVAL);
> -	}
> [snip]
> +	size = ALIGN(data_size, sizeof(void *)) +
> +		ALIGN(offsets_size, sizeof(void *)) +
> +		ALIGN(extra_buffers_size, sizeof(void *));
> +
> +	if (size < data_size ||
> +	    size < offsets_size ||
> +	    size < extra_buffers_size) {
> +		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
> +				   "%d: got transaction with invalid size %zd-%zd-%zd\n",
> +				   alloc->pid, data_size, offsets_size,
> +				   extra_buffers_size);
> +		return ERR_PTR(-EINVAL);
> +	}

Consolidating the overflow check into one if statement like this doesn't
catch all cases of integer overflow. For example, if all three sizes are
9223372036854775816, then the computed size will be 9223372036854775832,
so this would not trigger the overflow check.

Carlos Llamas <cmllamas@google.com> writes:
>  	mutex_unlock(&alloc->mutex);
> +
> +	if (IS_ERR(buffer))
> +		goto out;
> +
> +	buffer->data_size = data_size;
> +	buffer->offsets_size = offsets_size;
> +	buffer->async_transaction = is_async;
> +	buffer->extra_buffers_size = extra_buffers_size;
> +	buffer->pid = pid;

With this change, if there is a concurrent call to
debug_low_async_space_locked, then there is a data race on the
async_transaction field. Similarly for print_binder_buffer.

Perhaps these writes should be moved before the mutex_unlock?

Alice
