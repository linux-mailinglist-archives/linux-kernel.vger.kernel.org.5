Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB97515E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjGMBnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGMBnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:43:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7ACB0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:43:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b89c09521dso317865ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689212594; x=1689817394;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RQRuIqZ5NVi7QJufPT6Q4wx/18CXySRzZCJ6Iw5j0s=;
        b=dMQUrbfnmydZo0MkmBFR1PAx8JTnYgHAc3yLB/K29hYjM8mQeTLhmB4Jpi5P4hofXS
         eOh6lRBcoWgKh07yvb3rmf9GjwaTk48kvmT/KwJ2Y6a3mY0tiPFQfrx5D9nNrvwiZr4O
         UfxbgstG8oX5Qo+pKb/crnPWDwvlrizdPBIfxha5Rg8xcaIt6+ODVB0ysHe8YYALamx6
         3oyY3r/0k0UQ9BDsfT2ZaW68nqxTeJWJ4XCBtLi6DgjuoLx6Cg/sGsTjt2iX7W6wm0KV
         I31ojrFVAATSZIoSA3jPYavxQymIpOIzJxoqtpObhIPVoJOEQUdfZQLTNPwF7DVULv9z
         kayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689212594; x=1689817394;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RQRuIqZ5NVi7QJufPT6Q4wx/18CXySRzZCJ6Iw5j0s=;
        b=A6utOeIEo4T0s7JYzu3U8g/GIkQTeOQgObjD7C0HJa//DiWyKslfQSKUYhu2S0WDRk
         Mh2f5N9anyW/DsaNc+SjIt1rKhg1K38Rdta0n2KdBw5Ee/bozAhMM6WqIt5T+RNePDXN
         9qbj49YB8UGfw+OcA7cfoiJLJXosmJqVp50luexX07NIOp57eIjI7o39kJB2WyGkYrut
         ZWbbVtGpQ6Fn6y4k4mUCBjS3iksKKyCjcf0DGElVsyYekwiBqBoZaE7V43n+Gl76tuA0
         9wAk1uXDEwR6iDuZRoyhI7qiKFLFxREyiGIG6SY8bIeTFhcdgPtIEisXznEnngAs1IlT
         uzJw==
X-Gm-Message-State: ABy/qLY8g3wKrY2unSHMdzdfIACH3K5WYqFoFpKVNFU5Th7A6CLrVHQb
        eq98tqB3CQQjzxEJxy0Pnesrcw==
X-Google-Smtp-Source: APBJJlH3eINFi58kLpyTeLA96uAiPaoKtgYsKnAKwx9PMsu+CNcnyU7BB3Ze66LtdWTzZif9wQN+OQ==
X-Received: by 2002:a17:902:e752:b0:1b8:bb6c:9ecb with SMTP id p18-20020a170902e75200b001b8bb6c9ecbmr403479plf.4.1689212593740;
        Wed, 12 Jul 2023 18:43:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902b09000b001b8422f1000sm4617080plr.201.2023.07.12.18.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 18:43:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Kees Cook <keescook@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
References: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
Subject: Re: [PATCH 0/2] kyber, blk-wbt: Replace strlcpy with strscpy
Message-Id: <168921259242.435341.16221170585643217037.b4-ty@kernel.dk>
Date:   Wed, 12 Jul 2023 19:43:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 17:21:57 +0000, Azeem Shaikh wrote:
> This patch series replaces strlcpy in the kyber and blk-wbt tracing subsystems wherever trivial
> replacement is possible, i.e return value from strlcpy is unused. The patches
> themselves are independent of each other and are applied to different subsystems. They are
> included as a series for ease of review.
> 
> Note to reviewers: MAINTAINERS file does not specify clear ownership of
> these files so I have addressed these to the latest committer for these
> files: Jens Axboe <axboe@kernel.dk>.
> 
> [...]

Applied, thanks!

[1/2] kyber: Replace strlcpy with strscpy
      commit: 150b5f497df6bdb4730cae1eb98f13017b2eef6c
[2/2] blk-wbt: Replace strlcpy with strscpy
      commit: 3abf6029341f2fd2ea6e48289662e8e4e3e96945

Best regards,
-- 
Jens Axboe



