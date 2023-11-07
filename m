Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3F7E372E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjKGJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjKGJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:09 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C14125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:06 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so5403197e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348085; x=1699952885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5LRlMrrSSAy+CZC7baLmatbGXyfCrpMFg+wMEcHD2c=;
        b=3Hf0NFatsOsZzuqTXCkf4NnctQJlMMUiqZqNpma40LNDjl9AAMjD7wo5s49t7O7r5F
         KGy6ZBCezpnPFqccP2mxKmKjpte58Oo18mHMWrSDKR1DkiGZ6YZ8O2lg4u944X/Fje/R
         9Yy3tt4ZlGbeVRenxB3KfLm3BK5Jgo891Y9BIni+dhu5ns5bawVP3fJgi1uGAlTGKS0S
         qdjaxECXEIZii89E3ukAXoNiYwz8+y+jiKu/LUs5bRT1s8s66BiTnKrWhaGH2Cp0ke3h
         wFBTRqSkVjAFQQlx62L/zAX6foH/tjPM14Hjfiu9YB7zRJwPHpn/zVD/ZCTvmILmBQB+
         sECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348085; x=1699952885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5LRlMrrSSAy+CZC7baLmatbGXyfCrpMFg+wMEcHD2c=;
        b=xI3tnLXfQRgHze9ndhUEMwnVSDBJxb5IfDw1Sn/hzcQ67QXIErzSs9DMaL8zScKx8n
         7fWBgC6rsYW2EOAtkOExovv1R6t/VJaqZiKzEl2tjwypf1Siqq02/dzO8jOVrenz76m+
         DCOHdU8osGVFUJpsCYq79Esta+8fspGyAREfANBUD8ap4fRmwlNNyageYs9escI2RKQV
         T9ptsSZmtZzZP/sffW1CmWYrAh+A7kJxk1g/owBMbeo9T8BhIsQ8+cGyPrvhzj5RO2nH
         dCdoDaMXHbPYQzpxZ62NQb+xKgWwJgT/GcDABCPmnQO5yZCfMJuM2S33Iy5KkEs5yH2J
         K41g==
X-Gm-Message-State: AOJu0YzGBoQn2W7AvTtB0RAR7LZDWi0KwxIEQ30jpH1Eq5pBns+VOxPk
        o7zw0ppzC8GGtF0XeqDMCmD6emu40FlUPfA=
X-Google-Smtp-Source: AGHT+IEet1hoCCDTcDEMok9TewQggl/fATVsnxvPGRc5fuo1E48zRIMQsig8VG7lK+w0nt5HgBFllcTzY4c/+O8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:58c8:0:b0:507:b8af:c118 with SMTP id
 u8-20020ac258c8000000b00507b8afc118mr280420lfo.10.1699348084798; Tue, 07 Nov
 2023 01:08:04 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:02 +0000
In-Reply-To: <20231102185934.773885-5-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-5-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090802.256817-1-aliceryhl@google.com>
Subject: Re: [PATCH 04/21] binder: fix async space check for 0-sized buffers
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, sherryy@android.com,
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
> Move the padding of 0-sized buffers to an earlier stage to account for
> this round up during the alloc->free_async_space check.
> 
> Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
