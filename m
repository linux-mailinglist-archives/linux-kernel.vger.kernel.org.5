Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D77FA8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjK0SUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjK0SUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:20:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31CD4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:20:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b422a274dso98055e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701109205; x=1701714005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa2dZ1fsBMo5kJDdACp6J5U0uIcQdtFHFrG7A9PMYSA=;
        b=nEdB9N3jxkdEEVHkAsIu2sZolH9vc9OFAENOGc9AG5rcfyKwf00rifWm33o11MbJJY
         IXMgNdP4/GExGq7VQ4hWqSZXubE6AFYrOrV7Ue11nmTuo+Na/dFlFZm5k7hj6WzxsuAx
         5kAsVnnFyJPgfAJNsva2/VvFcP2tUn7hXK1pbQBgug5cdV4HV96zJrVh42piP0CVgSQ0
         n1cQ9EFwBAKcJ98GLJMuEx/W514Vz041k+8G5m7okXArdK+D745ljNapIEmkogEqYq5f
         oJyWPTE5+XF6c5VO9+eHkeAhseO2na1LFa4bwA5v2ciTxnD43jMh58B6fFrhIt+Hsqwy
         0wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109205; x=1701714005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa2dZ1fsBMo5kJDdACp6J5U0uIcQdtFHFrG7A9PMYSA=;
        b=bKM3zJOWmiRIL+clbJ108Gz7mPiMVE5GQ1i985LKl5nhtT8eyW46FRt+78NWNy/ToS
         c+tpyWieaqKgT0C7ZJ2T5qk3mruVpUNTaNxV1T2GcUsXMmaHTP27oeJxDYCyqWeO2/4w
         tHQauAOh4xzpVNooHPvCbViFcdGCB/hXHU1VoVV0zHSk6GYrhOWeJWEDC1DnM9MY8vIv
         hkubyxztLQRXSdyKl8jkvQkNAff0osC0dW3tWhPrC+g7YXJFgT9BGaf8/N+DmhxHc63t
         T7nm4hODKjkX0Ega6Prgt4E3ES9SX0wgFMw2fFpiW1wJsQiCDEECAUh7/SHtLNw8ho9/
         f0VA==
X-Gm-Message-State: AOJu0Yzzh4vTf6GYAXlWtXpIxzGS8Gin8zcJY/5AuO/yPqrgi+TZ1Txq
        RUNNc6WesF9r6TxnnV7BV+Em2u3NnysM8bJjt2S3IA==
X-Google-Smtp-Source: AGHT+IGt4OpK0H5fdVVr8LMIIAdpLxLFqhGAN6JhuXA/NKvDFJV7zqwg8I0/mdwrfk9CSXjvo50bdFZqKfd8wWKep3I=
X-Received: by 2002:a05:600c:3c83:b0:3f4:fb7:48d4 with SMTP id
 bg3-20020a05600c3c8300b003f40fb748d4mr630841wmb.3.1701109204833; Mon, 27 Nov
 2023 10:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20231115162054.2896748-1-timvp@chromium.org> <ZVokO6_4o07FU0xP@slm.duckdns.org>
In-Reply-To: <ZVokO6_4o07FU0xP@slm.duckdns.org>
From:   Mark Hasemeyer <markhas@google.com>
Date:   Mon, 27 Nov 2023 11:19:52 -0700
Message-ID: <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com>
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
To:     Tejun Heo <tj@kernel.org>
Cc:     Tim Van Patten <timvp@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Van Patten <timvp@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Applied to cgroup/for-6.7-fixes.
>
> Thanks.
>
> --
> tejun

Thanks Tejun!
As this hasn't been merged to Linus's tree yet, do you think you could
Cc: stable@vger.kernel.org?
