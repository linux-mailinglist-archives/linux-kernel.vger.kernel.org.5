Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F95C7E372B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjKGJIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjKGJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:01 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B136012A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:07:57 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c6eec16401so57386531fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348076; x=1699952876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6/xOK6X5TGooZBMYIhNU2fWAKuUyP3R0hUyjuuDTvA=;
        b=MFIpRKBzyDrC1txg7IkAC5xpA2oQ2TxQXgv9Gc5T0kzksnTesbocfPzgHJIU5lrL+B
         JaBKUQAWX6riumytVgKHYIrTSEUifvdQHJZ7a73cWPEgEPocScreTO+xMfTdikTAT5HK
         h36n8Ld/E8VSmZy6SjbEnvaXUegKiXTf6nwlGbSiMTDkMaopKYbzVICilFRxKyaA2wYm
         Y9hcl55R63gdQFj1q+JsmRA5gTVJ/5gVdhQYJf7/vra+jDzsMkmlg69AwM5k5FSkRVZT
         C89oxsYxGB+wQjMUcjvUjjR/P5/IgQChV+rf55yCjuecyraVs07cgtd56MHyMWdb6LnJ
         l5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348076; x=1699952876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6/xOK6X5TGooZBMYIhNU2fWAKuUyP3R0hUyjuuDTvA=;
        b=NQfy3thbtKZgvrv+VN91xKnvhKN2ILF55BZ7H0XCRbzqTNFS8YEi2BqQh10DTyMzIA
         5JxULri9gSjnJ5NQQIwl11YTI2MFjed7kqA7KnOi9AVvpZb99IA9tKCWXGFwRZplcr5j
         MGhVUhK1CEr08EOkTpPg8TQHi8YrhW/nf98s8EL6KBxnQhCn1lfZfCuOPWtFDwK04hcB
         U2G3GOk5sLymAr6720+B+Dz9JHcjJcUQEs0VcD56O6PMMnZztkm9SDjoLbajbNJx96gp
         +wLL8scRUCGHNZakLVrrlbSpOm2ny83dbLgfwr5RRf2fTQvBLo5bFsgDUf8H0FlVozZ0
         GMFA==
X-Gm-Message-State: AOJu0YxC0jXsUP2uekMUwF0N79x2csKFKIQpSlFvlqJrQt4m5eYhRwB7
        K/MTpmMVdKfXejSGdjG+Bjg2YWalK0mxerg=
X-Google-Smtp-Source: AGHT+IGi2icKcYmixzSkUzlBh1znsR/mdtx2/ztYGMA0gREhOnXWccDsFLutiWYJy/ojkKwZe3y97UHmaNPI5fA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a58c:0:b0:2c6:f16f:6a96 with SMTP id
 m12-20020a2ea58c000000b002c6f16f6a96mr241591ljp.8.1699348075596; Tue, 07 Nov
 2023 01:07:55 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:07:53 +0000
In-Reply-To: <20231102185934.773885-2-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-2-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090753.255700-1-aliceryhl@google.com>
Subject: Re: [PATCH 01/21] binder: use EPOLLERR from eventpoll.h
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> Use EPOLLERR instead of POLLERR to make sure it is cast to the correct
> __poll_t type. This fixes the following sparse issue:
> 
>   drivers/android/binder.c:5030:24: warning: incorrect type in return expression (different base types)
>   drivers/android/binder.c:5030:24:    expected restricted __poll_t
>   drivers/android/binder.c:5030:24:    got int
> 
> Fixes: f88982679f54 ("binder: check for binder_thread allocation failure in binder_poll()")
> Cc: stable@vger.kernel.org
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
