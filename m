Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149CD7E3741
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjKGJJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjKGJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:09:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87481700
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da033914f7cso6329436276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348129; x=1699952929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyjuIwS8DXlMA8OOhB3dLCS9Tx1Xwnk4/6ufn8lkCPY=;
        b=gCmR/QM/LicR12e/AaTxiOp0m6gC/kMJNDL0+8XNoSXZ1DRnY/CM2ChOsI2uzpOGJP
         blCrAwntyy5dST2bgDZMxujSKtZaIIHcP1yPkgrMHnEV709/be12ycfN1s9AlTOdOSxD
         X2Yo11VwywfxQUYYie7jqZ9N6TfCYpivYLq0Tep9qw0uNoWNRa3xSQ2LMGw1AhGJSPEa
         dFos8K/YL5YCkCRs+btDDQLg3u+E9jCT0N//wrx7iOrXW7aiiQAM2fVmYeYtSDAL22Vp
         eN1KQ3ZhI4f0E1BpJKvYD48Ykd3Bt9S4eA1DsGCzLyin9y+lKlM8N6DFM0UM18Pr+8fH
         MJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348129; x=1699952929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyjuIwS8DXlMA8OOhB3dLCS9Tx1Xwnk4/6ufn8lkCPY=;
        b=uknxjc4h23QJ9Kpnhic6XM2W4Wka9gNnWMC0b4RNSeY+p4Ilfv8xSXmyfYEyXzSznY
         pihDKeeK1Y5dbUvUC5dgGlM10oS0q8SDzNO0/fG5s19Ws1KLUeL1Xnx7wbq5NCGlmcIo
         tVAswcS78VEBiEnKt9HuAMl//s9vTsMyUJeLDCELxYNh2WgPvxXNjUPAiiX9Jt1r+wxM
         QBM8KSKcBF2XiYwnw0yybZ71rBZHohoCwKCpNOFXd1BBX/eyozPFmkZ2YcJhKT9wCseR
         zfxyrBWeJeTcupQFhneJ538/lK2z+qnB0JlS7pkbGEvSq+QqDpW8zndoSeCqJtfueK0i
         +sWQ==
X-Gm-Message-State: AOJu0YzkoYOCdYp8EhWKo2XH4+pQJbp8abbBKMz5CHPLjnp0ixtMQg95
        0YjWxig3UzwgUsg8UY/mEMLVR8vK79YGVUM=
X-Google-Smtp-Source: AGHT+IGuhnUWK0DuSLwJ/3vUYlfhSq39/3vvecg/ELXTUtEDFfi85hm8bwvPjofEufiygH5kWCpq4Eq0d5eq294=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr723865ybu.7.1699348128817; Tue, 07
 Nov 2023 01:08:48 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:46 +0000
In-Reply-To: <20231102185934.773885-21-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-21-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090846.261721-1-aliceryhl@google.com>
Subject: Re: [PATCH 20/21] binder: reverse locking order in shrinker callback
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
> +	trace_binder_unmap_kernel_start(alloc, index);
> +
> +	__free_page(page->page_ptr);
> +	page->page_ptr = NULL;
> +
> +	trace_binder_unmap_kernel_end(alloc, index);
> +
>  	list_lru_isolate(lru, item);
> +	mutex_unlock(&alloc->mutex);
>  	spin_unlock(lock);
>  
>  	if (vma) {
>  		trace_binder_unmap_user_start(alloc, index);
>  
>  		zap_page_range_single(vma, page_addr, PAGE_SIZE, NULL);
>  
>  		trace_binder_unmap_user_end(alloc, index);
>  	}
> +
>  	mmap_read_unlock(mm);
>  	mmput_async(mm);
>  
> -	trace_binder_unmap_kernel_start(alloc, index);
> -
> -	__free_page(page->page_ptr);
> -	page->page_ptr = NULL;
> -
> -	trace_binder_unmap_kernel_end(alloc, index);

This reverses the order so that __free_page is called before
zap_page_range_single. Is that okay?

Another option would be to do something along these lines:

    page_to_free = page->page_ptr;
    page->page_ptr = NULL;

    [snip]

    mmap_read_unlock(mm);
    mmput_async(mm);
    __free_page(page_to_free);

This way you wouldn't reverse the order. Also, you reduce the amount of
time you spend holding the mmap read lock, since the page is freed
without holding the lock.

Other than the above, this LGTM.

Alice
