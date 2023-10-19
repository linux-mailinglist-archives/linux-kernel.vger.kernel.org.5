Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F1D7CF103
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJSHUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:20:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51C9123
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:20:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9b1e3a809so53037235ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697700020; x=1698304820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ8K0FN0Qpyz/8G/jYt1sKfnOsJUIjYOYEd3rSEKCTI=;
        b=Y36swdJGa+L1dp1R0w3vn7LRz/SqYI249DQHo35SPXgRLm/ay8Js+FW1qO95qZrQDw
         gFsr7NgD30mXpEui62gLYrQiieak0OlR9oLUm5KCrZlG5GTIp1gv3baguAj24dQsS+1n
         pilmbkEMXtGxSZiTpzqUcTnZq5tV1IqVQf+dZa0LcmR3SesoRwsoafLySyWKEflOn7E9
         qCXknOsSN0oNj9eUHuKVF02OaaQtuCBj5Lv3KRpOUHkn7L5GAsMlx2K2BzQZEHhZutBX
         WARBO6eVNKMHazzvBmRWEMOt4A00jStRQ5h6ld3jHskIdKDa7Je5J5rHS6Rwj2hubV3t
         FvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700020; x=1698304820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJ8K0FN0Qpyz/8G/jYt1sKfnOsJUIjYOYEd3rSEKCTI=;
        b=go+bXV6VIGbSv4E1oYkuJgaTJK0IJpDxq9+3PvePxLWqO9ggbrDhK43Ma7A93dByBE
         t1FPPWycIuvbSvp790TteBmA6bcwRNy5YW5UgF+h36dynsCG9g987Yo6/9xNLrh+I+Dp
         wobPrpUtl1/rdMCQifuBrdr3ea9JAgdou+WhE0SextsVV5z/6ZL2dlBTO6/CGPCSsOjE
         bkwOTWwkro2kJfKOfeKufrcHFdCECGdmDIE48eIRuv1rYnyx99bkewJ/bFLlvWDqAUsv
         KoEGMS8z0IuNNpDtG35eb5g9TlFG2necK5/kOMut9f9JCqmKT4VnbIGK9oxG7//0DDsN
         kDUA==
X-Gm-Message-State: AOJu0YxzKMDCsofNZKNw5W0dVSIo4Wsi9aGuMPDVbfNikr4YIKnTSIWK
        NNcNwCAoTrnwvjNvokJxKEOqYx5AAMGnbQ==
X-Google-Smtp-Source: AGHT+IE6mU6qXpkdMqXl3bSFTtKXy50t1qwvAy5M+NVCJV0u99P1HxZPkhpYT80egprsqK6qkol5sw==
X-Received: by 2002:a17:902:da8d:b0:1c7:495c:87df with SMTP id j13-20020a170902da8d00b001c7495c87dfmr1971350plx.53.1697700020238;
        Thu, 19 Oct 2023 00:20:20 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001c1f4edfb9csm1141686ple.173.2023.10.19.00.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:20:19 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH v2 0/2] staging: vme_user: Replace printk's & clean up log messages
Date:   Thu, 19 Oct 2023 00:20:08 -0700
Message-ID: <cover.1697696951.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Staging driver vme_user has a bunch of printk() calls in vme.c which
triggers checkpatch warnings. Remove all printk's and change them to
the appropriate logging mechanism i.e pr_err()/pr_warn(), or
dev_err()/dev_warn().

Also, clean up the messages further by using __func__ in the string
instead of function names.

This patchset fixes all checkpatch warnings like:

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
             dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
&
    WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
             this function's name, in a string

Patches must be applied in order.

Changes in v2:
 1. Correct "cleanup" to "clean up" in cover letter.   (as per feedback
    from julia.lawall@inria.fr)
 2. Patch 1: Change the pr_*() calls used to replace printk's in v1 to 
    dev_*() wherever possible, as it adds more context to the messages.
    (as per feedback from julia.lawall@inria.fr & 
    gregkh@linuxfoundation.org)

Soumya Negi (2):
  staging: vme_user: Replace printk() with pr_*(),dev_*()
  staging: vme_user: Use __func__ instead of function name

 drivers/staging/vme_user/vme.c | 193 +++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 84 deletions(-)

-- 
2.42.0

