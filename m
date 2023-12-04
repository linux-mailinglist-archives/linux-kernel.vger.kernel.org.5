Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D708031F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjLDL5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjLDL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE291129
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so2980333276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691028; x=1702295828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vADgTdHOH5QtPcY1grLIRFFzNQDCm+2zzy4LYtghDys=;
        b=q+P1RRx4nEeNaQhdekSVKW+82pmi93uZAHSa4xg1VoNnqx8oUikF6sx4KJGLQDhGZw
         k8Jz05tds29mnhTzqeGIS/r4VXpt84O5It30FpgvRIT83w4yKG1vfnUx13lps47qbRAE
         ioeK631U+X6o11q4zOxBHZZ0UnNpxvOObYsSHVOulVCe8ftX2JS8MHH3qneLNzx4/v8A
         6QklL0g5PzhhyVmuROKHvPtOrJvQlPnXfAtAvuTxnvcNMNDVUJeJEUS/JoWY6BOPczfu
         IEa+brtyadvmq4dYpI33DVphvo0xrFc749dOwhHEn1dQ5jfC/t5QzEV5guwUjnlGDID2
         o/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691028; x=1702295828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vADgTdHOH5QtPcY1grLIRFFzNQDCm+2zzy4LYtghDys=;
        b=KMJKOvDvUkll9f3o6lyKF3UWFI/f75dub958OTYkoN1ki2+qDJCA7hBazNN08xDjQj
         cGPW6T73FIINo7ZtsdlUyXTnwxV9MYH30nyFH5zw3i79q95Vbytujv0y/ljmdOVw91TQ
         DY3+JHMTInGRonLGlkOFpGMYsJNRdaDu/F54fj//h77UYCzIcrZLQ/coD9/9GTCuC0tP
         oF2C+JbkGcUK2cDKSgvpNpqCfp3VLdGrjv9Ldd/ub0Ez0lCTWjbMrQAnQp+jhwjqMWHL
         ToFhUha7/N7BALschfUAONnJZZJnSm5EkjGuoIionM5GAPQCOpJRbEj1YF4z0dgHwcsF
         eUlw==
X-Gm-Message-State: AOJu0Yw0E5HR6fbDmHRp+2+vvUIfb+3PV38Z/VA16sJVa7Q6Y3kuQQ8b
        09VwnLbYneKjo4OCUmGLMtyaok5F58GGzT4=
X-Google-Smtp-Source: AGHT+IFZyGjhz/Gyk9ThzBbyrckxLPVcWSkTfgIYpIM2qQr9McpdbDcaGLWU169EHfhnUc7qma/ZFKNEJiD4BCk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:ac12:0:b0:db8:557:d615 with SMTP id
 w18-20020a25ac12000000b00db80557d615mr122669ybi.6.1701691028097; Mon, 04 Dec
 2023 03:57:08 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:04 +0000
In-Reply-To: <20231201172212.1813387-12-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-12-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115704.40543-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 11/28] binder: do unlocked work in binder_alloc_new_buf()
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com, Alice Ryhl <aliceryhl@google.com>
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

> Extract non-critical sections from binder_alloc_new_buf_locked() that
> don't require holding the alloc->mutex. While we are here, consolidate
> the checks for size overflow and zero-sized padding into a separate
> sanitized_size() helper function.
> 
> Also add a few touchups to follow the coding guidelines.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +	if (IS_ERR(buffer)) {
> +		mutex_unlock(&alloc->mutex);
> +		goto out;
> +	}
> +
> +	buffer->data_size = data_size;
> +	buffer->offsets_size = offsets_size;
> +	buffer->extra_buffers_size = extra_buffers_size;
>  	mutex_unlock(&alloc->mutex);
> +
> +out:
>  	return buffer;
>  }

You could also write this as:

	if (!IS_ERR(buffer)) {
		buffer->data_size = data_size;
		buffer->offsets_size = offsets_size;
		buffer->extra_buffers_size = extra_buffers_size;
	}

	mutex_unlock(&alloc->mutex);
	return buffer;

But I'm happy either way.

Alice
