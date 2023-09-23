Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE57AC2D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjIWOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIWOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:49:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9C180;
        Sat, 23 Sep 2023 07:49:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1ff5b741cso35261425ad.2;
        Sat, 23 Sep 2023 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695480587; x=1696085387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eD2lVLlB4OLw7jI90rwo5u6A+4KqLp/ELPGmjNIkRoA=;
        b=O8BGlc8B957os7Z5tsmDipviv4BD/iqiQmF1g4Wp0HeXDpZ0G89n735etSbhvrdsdC
         y7cqtDL4nr5g1Kjs1GLnU41+m/E7OEzB0XY3Jga+ZP/6sjUFM3xCbET1ZiqWKZcIF8yh
         w4LkDAcT3BixCXrRSiu/VlAdCWsh0guNJ4JRXbcSFhWsMbyJQWcMDUndErD4PGO6WQWg
         12y8jeWKS2V4CvVLWckqoh7/Q4h1iOBDwUvM94BtDzArKzIHzQNhIcGh7CjZ0p8wV2hp
         rLU2EDpofEhACMo4b2UvQKEWf/U19dTpxm3Anj6gAL4Yz3Kiql6zk792tam6Nlfpv160
         YJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695480587; x=1696085387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eD2lVLlB4OLw7jI90rwo5u6A+4KqLp/ELPGmjNIkRoA=;
        b=D10xxcsnwmXHJIlmrLpBVoAvvvs93PISJiAFw3B7RlctEQlZ0QJg46u0sxrYSgYhvG
         NHcNBWYc52BguYLcgYJhrmYFwCDdD5scIVJHOD/s5F14PSmvdHcrr5JkwpQjXlzZ00A5
         OO4HYnDc9b2nGPEgOaRPOJESuk+QHVFtRM6JHrIeyPONYf2u5iJJ9wvAUWea1PR/ARlu
         uyzfiKlM0A4jpCgq5AvIs7csge6yZ0QHztfpl4PN+XTjXnNqABWXDRa68PtJNAHxDDR/
         B13n6XcvbqMNWWjMX3LKQC45tpKrg1kWzhR/YYIjIekRJYidDYN6QQVa8OHfnUk9Y39F
         mr6Q==
X-Gm-Message-State: AOJu0YzTu2U7yCffldDeUyaE8+8EUe4s15db5VX2Ry0LwFYre2s4KABG
        fA0WvexCA1TAPoyvrnBDHBw4TjUoELg=
X-Google-Smtp-Source: AGHT+IFzt8/0XMKvSNig08HSswOaMVfL6evLAH+gjA54WeEXNTvU0QBg3r3emrnnDAIc9cKUDSvIKw==
X-Received: by 2002:a17:903:32ce:b0:1c4:3cd5:4298 with SMTP id i14-20020a17090332ce00b001c43cd54298mr3344030plr.18.1695480587548;
        Sat, 23 Sep 2023 07:49:47 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id s3-20020a170902ea0300b001c42d4b3675sm5392806plg.309.2023.09.23.07.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 07:49:47 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Remove `ArcBorrow`
Date:   Sat, 23 Sep 2023 11:49:36 -0300
Message-Id: <20230923144938.219517-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes v1 -> v2:
* Moved the definition of `WithRef` to where `ArcBorrow` was.
* Updated documentation of `as_arc_borrow`.

Wedson Almeida Filho (2):
  rust: arc: rename `ArcInner` to `WithRef`
  rust: arc: remove `ArcBorrow` in favour of `WithRef`

 rust/kernel/sync.rs                |   2 +-
 rust/kernel/sync/arc.rs            | 146 +++++++++--------------------
 rust/kernel/sync/arc/std_vendor.rs |   4 +-
 3 files changed, 47 insertions(+), 105 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

