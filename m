Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC77E3737
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjKGJJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjKGJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:38 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908DD78
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:28 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-507b9078aaaso5855593e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348106; x=1699952906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTdxHKFXUFdTnseUyBSIVC6mLOP2wgMSNYd0z2FJrSs=;
        b=Koj2Yy/wtfdZ47ePj/S9itRYmYfP0N3ibnko8/DLWjtT46gn2JkBZOhTYLckJO7VY1
         3YPvz/scC3wQsCNcqtJi6zWJeYvch4hctc7VYdIhXxWn9gU4wlF2LKqcPMlGDyXy1ObN
         z9oHf//d4I7uwnCDnKpeZfeHO9KVdQ1K8jCTNDtKWsgxilUvFpVvmO6JUq/cv5ndAM0R
         uU9IKd4C/9qpnkbpSFtIoszZh2YlA/lYpWI+HiOu7U6JXlcbct8ToJtJyoRmvU/JS8Q8
         gUixFilZWNbucyxBU6JgXTOHeddDzTIEprPKL2lMQj9zReyVw6hfvLPdZmIwCawnGDAA
         1+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348106; x=1699952906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTdxHKFXUFdTnseUyBSIVC6mLOP2wgMSNYd0z2FJrSs=;
        b=nPxa3MVEYS+KgWsphUfMW+hiYTgZBf90tMcrDi6+qI3VY/5+U6kH99WxiQ3fILi0Yz
         WAoAWXxWgK3JqlQXA5A/Hgx22khy1A8C6ZlRLcn+G0DkJ4FXL8+FqccjNithEghItFhw
         IM+NjohqOBzb7ZPu9uOIf6KlUahirq+9/AyDlZNxZkehJ/JD8IFHXYXTA5W3q581hOvF
         xf+HWZKU5Cb4uFuecLhjfN5XI4k6iFI/FbPplRDFWZlqj0xyfM/nsNhDb0UifN3H2Zpz
         bbKlHjg5I89k1xxDBFnf83GwyMkU/aXoNC5xvPqRIe1L4FV9HikSwiVO60F9v0a+Ujrv
         hc3w==
X-Gm-Message-State: AOJu0YylCYXKz7MRs2nNs9PieFJHWqHeQpRPQhZiDSdxgS5zjkjV9EZe
        zWihHOlzBjGLDU24fJG8Fd/svDCm+KRyxH0=
X-Google-Smtp-Source: AGHT+IGHcbWOtls5fUez+pU10zZZ//fIpduCD+VNjCvQhm6xVTY6AwhQEnvFjqRFNrKqQq1h5HDmgXkS1znvDxU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2117:b0:507:93bd:1339 with SMTP
 id q23-20020a056512211700b0050793bd1339mr311697lfr.7.1699348106541; Tue, 07
 Nov 2023 01:08:26 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:24 +0000
In-Reply-To: <20231102185934.773885-13-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-13-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090824.259218-1-aliceryhl@google.com>
Subject: Re: [PATCH 12/21] binder: separate the no-space debugging logic
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
> Move the no-space debugging logic into a separate function. Lets also
> mark this branch as unlikely in binder_alloc_new_buf_locked() as most
> requests will fit without issue.
>
> Also add a few cosmetic changes and suggestions from checkpatch.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

I double checked that this does not change behavior.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
