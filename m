Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D57FFE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377087AbjK3WAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377100AbjK3WAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:00:20 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532321711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:26 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso1273997b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381626; x=1701986426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS+xZFkauPj5AGx65h3+Kf7iUVStiVqpHLg3qeSM/lc=;
        b=FdkbCL6b6isQxB7ZLVpja3MFdedZ5Ts+Yg9oNbNx32cVbq1Tnx1H8P6/k8TgrdLb+E
         egjZCOFmD2yx50DGAGybT/z3osVAICDFX3m3dn1Pm/csZUxaMju150DBpocb9+Ry7gQn
         3sNlcGn2pqhT1qKjVwiwwWnKHqxWHLjFTgMrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381626; x=1701986426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS+xZFkauPj5AGx65h3+Kf7iUVStiVqpHLg3qeSM/lc=;
        b=BBJVOC7wEq+j3QUEgwy5V4LRrZBOopWsn7rOmpHxj21J6YBlFfe1Iu2edE8HKJpOWI
         czt3eGk879ly590zB3qiRm9uI/Gq/OK/gshEB1pYmZddpX8Y2Q367ar6b1cAL7fcHTrF
         Rq5v0xgdUySkwWO14rFC8TyxBvwvM+xvFfhISHeUyX6Eo5KOWKy7+dI5MM2TclLKikFu
         JCH8XnRZdtE4xWeoKXeK5cbIawVVA/4XixqFTDVNlrMpHabnzL5UGBeiA4/9gOQa9TXQ
         ybr3Xm+OjBxWHhE3qb3lzpRIZEv1ZRcIhonBGHDOwYoM9l4BORizde9cP29HRQJkqHfZ
         pxGQ==
X-Gm-Message-State: AOJu0Yy0b5gboP0DFSOMWsMjmzwOZTDplxI537nZz87/tzlj+SXGyhSa
        m/AlXJhukqaNex8xmAc7fnfz9Q==
X-Google-Smtp-Source: AGHT+IFvg3rt5HT0uZoTR0TCtDK9qT29w6HrEKwrACLRv00otPgC1j74T2H6xf8MsdG2Z6cRmkPsFQ==
X-Received: by 2002:a05:6a21:328a:b0:187:15e2:fdd9 with SMTP id yt10-20020a056a21328a00b0018715e2fdd9mr23858335pzb.39.1701381625674;
        Thu, 30 Nov 2023 14:00:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx12-20020a056a001e0c00b0068a13b0b300sm1743924pfb.11.2023.11.30.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:25 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] afs: Add __counted_by for struct afs_acl and use struct_size()
Date:   Thu, 30 Nov 2023 14:00:19 -0800
Message-Id: <170138161643.3648998.10002287194260761975.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSVKwBmxQ1amv47E@work>
References: <ZSVKwBmxQ1amv47E@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 06:59:44 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] afs: Add __counted_by for struct afs_acl and use struct_size()
      https://git.kernel.org/kees/c/7403e688f0c0

Take care,

-- 
Kees Cook

