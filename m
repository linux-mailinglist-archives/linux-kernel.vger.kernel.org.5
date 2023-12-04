Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5E803201
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjLDL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjLDL5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A300187
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a541b720aso3192416276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691031; x=1702295831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGbDvPTppjzUr+bhKS1k9mpF9Lv5asJ6LrkOKuKl7jc=;
        b=KHqsrjgD1n/xuR3sqARtpi6FU3ScBJyxAtmtYLcfCH9IhjBthoj2TCaq3neiRWLToG
         KpeLiuZqNw6IfMDYNB32L2ODLstNg74+hQ52IDi6WjK16UlQelOh2YTMwUz/HYzK/24E
         py8mWSRJn8eh7Mi08iVksoSm83CBI/ywTkOup4ZImZmeyIII5ex8J8NAYoZ6t2KszWL/
         n9JFMrq34lPyYvoyHALxi08qxuIwcSUaQ30CMm+ZnpDw+m4fB4cB3e5SfgJmw+090Yzz
         8xxU3gunWVWgzc5bAAdDeq9N63uyQscnt7KF1cmXiSh21qtiHAOdXPffQC3jhyTvuShe
         i42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691031; x=1702295831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGbDvPTppjzUr+bhKS1k9mpF9Lv5asJ6LrkOKuKl7jc=;
        b=qHx5Bz2/Hv3CIbhdoR3zMYQvcvDHt1cb0itkgnjwCMOPSeBwToDN9NSXtM50qp2CxS
         eAQKCeI5Lp3Y1hPhEaMogcAoKNMrR0TfJhI/S9ach2TkTwfVTph+XcE7ZMs/2XcC51wy
         udGm+gqr33/FdLyuUyMxMlTE3x1LikPB+/RCcATpdGCNTvJ5hXM+XPhqH8RFDDORj3wO
         EW9q7Elb9iJgwuLZU9VV7MXA9m50DvQ/pRYuP0b8k8owRUjl9W9yZtosM44ZT80+DZ5Z
         Tc6/SuYssMpKAA6bjMz5mIYSL7BD4YRfA7aUQg3SfM6z2JqVzo8+QhSeZ4xzDgoA08kg
         zILQ==
X-Gm-Message-State: AOJu0YyCf90Dt9yk7+qf/P2vGqcQKEmoETwEsu/mOC6SzolLkubBQXHw
        eqn1JXFEy2rlWRLenTJv3j6Fi51SeTByBgM=
X-Google-Smtp-Source: AGHT+IH3Rl11RmaHrqsuRBBmEnZiAgRt6w4vNkIuZ+ykP1neTy3aOWFo3aC9ydGpth1CWESActMFpV61i2Fh9v8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:3d05:0:b0:d9b:e3f6:c8c6 with SMTP id
 k5-20020a253d05000000b00d9be3f6c8c6mr936462yba.4.1701691031701; Mon, 04 Dec
 2023 03:57:11 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:08 +0000
In-Reply-To: <20231201172212.1813387-18-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-18-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115708.40838-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 17/28] binder: malloc new_buffer outside of locks
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

> Preallocate new_buffer before acquiring the alloc->mutex and hand it
> down to binder_alloc_new_buf_locked(). The new buffer will be used in
> the vast majority of requests (measured at 98.2% in field data). The
> buffer is discarded otherwise. This change is required in preparation
> for transitioning alloc->mutex into a spinlock in subsequent commits.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
