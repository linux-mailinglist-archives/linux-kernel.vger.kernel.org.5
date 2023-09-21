Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED57AA31C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjIUVsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjIUVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:47:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF349180;
        Thu, 21 Sep 2023 14:35:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c4586b12feso12215735ad.2;
        Thu, 21 Sep 2023 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695332099; x=1695936899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfdWAah/rQV8TkFynBG0Mzmb0qRkIJsvRrSkxa/jpZY=;
        b=UhwWGP1DRX0T+Dh+kFm3u8Ls4aUXJErPtRJZ+ACtTRNPD2Sb+FddysDZkU9s8JMZMx
         M0qo2rRiuSMUl+Qu1qtw67pxvMmQxC0TP3PjoFvlDss9MxgaPlnH0UPp3kxeSjZxJTR9
         wQYX7OIaTFVQCL4RXULbVidfTwxkKg3DRJzMxItkWKxYt5pdy7Ewk7+gzU4fLdJ9GdVf
         VJ5AWq0mPBCDbnj9i18uSSpkFf0T5urLC1kw8rtzQLSjmVaH17Zqwd1deuW57bBtJfdN
         Pc9gp93/FmDeNkI2ylJyN+ekRdTN3JcBpzTibm97nI5NKJC+Tl0m4cytTUhnQPaAJUcT
         AkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695332099; x=1695936899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfdWAah/rQV8TkFynBG0Mzmb0qRkIJsvRrSkxa/jpZY=;
        b=GYESkzC/GUv0Pek0yGeUxpQ6uxY9gbAV76YSITEjHFZdYiqRSCmYVlDlVvXVm+OUGc
         nRND6vh3axfUtiqviexOIWposjI9Rvthzwu9+I30xIE31dm4XY/Ajy5Dj2sOBxwkLqAZ
         Uf3DYQI90E6uwMNRffrPeF4nl5mKh8yjsaJq3YovTTTRf8O1pnPKnBqhrABnzxyTu6Qo
         qC+ooHrxummNbMI3p9B9rdUuldKO4XjOp5hdVRKKD99I1KRqnK3JjUZsfE4vLaSfEYNs
         aLRxT+8xatbRVyoWkyD16HlvjivpPESzZpWEI3UgQJu+LywixdQpcZk6lfpxep+YSz2h
         QoAw==
X-Gm-Message-State: AOJu0YxEjd0yPcH9ySLadp+fYjnOf17Hsg9YWyEBs5zLFdgMX/Gxu+1E
        6wh0Eqb5O3LsPmreyYhR2LXrnDS1+ss=
X-Google-Smtp-Source: AGHT+IHYl4AX4Cnax15olSkWmwzL8NxhRhx6v8O13m3b5DiA5/P+h/aIdw0tnHpVdg3L48wvPtyyOQ==
X-Received: by 2002:a17:902:ef8f:b0:1c3:e5bf:a9ec with SMTP id iz15-20020a170902ef8f00b001c3e5bfa9ecmr4174406plb.51.1695332098857;
        Thu, 21 Sep 2023 14:34:58 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id jc6-20020a17090325c600b001c567dcf22dsm2007981plb.281.2023.09.21.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 14:34:58 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 0/2] Remove `ArcBorrow`
Date:   Thu, 21 Sep 2023 18:34:38 -0300
Message-Id: <20230921213440.202017-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

In this small series we remove `ArcBorrow<'_, T>` and replace it with
`&WithRef<T>`, which we used to call `ArcInner` --  it is renamed
because it is now public, so we chose a more meaningful name.

This simplifies the code because we remove a type and have simpler
syntax to refer to borrowed arcs: `ArcBorrow<'a, T>` vs 
`&'a WithRef<T>`.

This became possible when we adopted GATs in 2021 but we only realised
it recently (thanks Boqun!), more details on this zulip thread:
https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Isn't.20.60ArcBorrow.60.20just.20.60.26ArcInner.3CT.3E.60.3F

Wedson Almeida Filho (2):
  rust: arc: rename `ArcInner` to `WithRef`
  rust: arc: remove `ArcBorrow` in favour of `WithRef`

 rust/kernel/sync.rs                |   2 +-
 rust/kernel/sync/arc.rs            | 192 ++++++++++-------------------
 rust/kernel/sync/arc/std_vendor.rs |   4 +-
 3 files changed, 70 insertions(+), 128 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

