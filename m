Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15D7E3739
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjKGJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjKGJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:53 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E4199C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:33 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-507a0904cdbso6103405e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348112; x=1699952912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUp2vxkRVXShAPX8Kn/BzUnfBAJ8WldHu78v3mTmLUA=;
        b=EplEXdFlxyRLpUuw4QKy6KKfrg/Ic99HemMMpKMSH45jjis5ycMb/qTSDOqroem7D4
         iLCgzNuzf402Z2CavW/PnknggL819wbqHHC1IkPXsNCdziJbXpBo6yNpFqorqTBvNoZg
         +73hGseH9Rynkc7qOFcOFg8szg0pbLVH35oVDU1Kg2ei3ZiXLzTIHI951hRTvci9VIco
         4uf7CEzelrmTm97oHtdQ00bHuci84iKmoflrswMXUs/ftt/Hf4hj0GOrEIOQcoOgC2nQ
         0QjI/VsFcjb7+zGR78HPh/9QeKJEDmLP/w8VInOYC9YBZGv2yjihprdJSvH5EPu5IdGM
         CpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348112; x=1699952912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUp2vxkRVXShAPX8Kn/BzUnfBAJ8WldHu78v3mTmLUA=;
        b=cd3fp3hvlQhblnjkGxk93C9EXKZqgeZVvfVNPj+kvYMWUh5bH+6J2GmmwOe+oKFr6X
         x0tBvB9I/nX2x2wZAgUEIElohB31ZpJz0LarggJMS9EyobyT2/1Tl8gNuxZW2kwJ3uWG
         kQhHORufh12oMKP1A7uPu/hMCRF2s6hUT+hWx2qFVnabxMGLcESMWs9PQDha/reBHLj5
         njgBjmAurXeZbDf43U7Dwt97Wz31iJiTws729cK4U9MHKXEetQwjyg9AmwpUFpl5xDRh
         PPFoQALnlbD76XUBCLfoVn+WHV2ZSZ60DHFZVsJwu8R3QV65I9jRpZrE+KOtYsZ+LV8Z
         bfrg==
X-Gm-Message-State: AOJu0YywN4+CdqnUJ+gNvB8FGWGTXB8F4L6M7Jt06IjbcItvhqEZQL9z
        zTQlf//zGXKlMgCovfSJ5Rrr+N3WMPKzk3M=
X-Google-Smtp-Source: AGHT+IG4kbirlmp+mqq+KfZu9IunQ/KHMtfOt4JmfPbi/Qsriwly3X4tUodTvU4q95ZJN0qWj8sjm+rfUWAUlv8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:5d4:b0:502:f469:d4ca with SMTP
 id o20-20020a05651205d400b00502f469d4camr267427lfo.6.1699348112142; Tue, 07
 Nov 2023 01:08:32 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:29 +0000
In-Reply-To: <20231102185934.773885-15-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-15-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090829.259753-1-aliceryhl@google.com>
Subject: Re: [PATCH 14/21] binder: do not add pages to LRU in release path
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
> In binder_alloc_deferred_release() pages are added to the LRU list via
> binder_free_buf_locked(). However, this is pointless because these pages
> are kfree'd immediately afterwards. Add an option to skip the LRU list.

They aren't freed with kfree, buf with __free_page.
 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

The change itself looks correct, so I'll give my tag for this:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

But I'm wondering whether process cleanup really is so performance
intensive to justify the added complexity of this?

Alice

