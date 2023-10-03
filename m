Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644227B60C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbjJCGaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjJCG37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:29:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732BD8;
        Mon,  2 Oct 2023 23:29:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-327b7e08456so588544f8f.2;
        Mon, 02 Oct 2023 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696314595; x=1696919395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c477/OLls9kiskA+Ywm7NX/i0eASEk7X2ymM3GHIjjY=;
        b=XIP8VzzPj+irx14q073CHB8HdAhLTD/AHLzQVtw0bfb3ZrtFC7xfGhIEf57V5eADhl
         4Pt//VOJ8DjOW7CUCSnNVsRkJZsK5VQry/QoF61ZldwqkhZ8miaN8z/9ck0eM0ohUXHF
         5mTJmuWUfFAYx/5FVhYbVJvh5ygKyE8Yf6gdzdzZbMp+8jtuqSlInWslIZI8qPnJwUB0
         T+3KNOSfpEbHwK8NNJVXIbR3DURT/0wfX0KwBM5z3i8zbIuRuUX9OUmymdtbZjLsCI/r
         5DT8gRtQydLWaesUT5yg38xSHf0VR1SJTvcf1gk9AhuaQkCWBAgyA04oWLN8G2jpyKMH
         +Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696314595; x=1696919395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c477/OLls9kiskA+Ywm7NX/i0eASEk7X2ymM3GHIjjY=;
        b=SSTiml9TrYy5q5LpohqYv9f5rNVrekRSf91NZpEIwsSWmJszXtIsFSGKG4i66IlB/4
         36ujpZbTNu7rRm3YQp1Mmj3Zui1vHNSngtst8+BSpEzUaBPa8nJ/VraDQ9W0zJMlvvIt
         oXCtfpfmli7k71JcThPUDFXdQrNhIlbwOGD2BWS5p4yHm4kXtYHClkGqqN6wyuHZrYvU
         fwuuvHmBvMwk2o2a7Wy5gz4X6V+ZoDwhlZN2K+FbLrtcVJ8S8SB+wofJet5uh1Abdgvf
         TTcq/kw83HyCVzkKfJiXF6pVVg/AKh7g+zV2dpDdT5+jt7eZz6AOlFsYx/TolQInxYWk
         nqJg==
X-Gm-Message-State: AOJu0YwopFE30UFC7rtrei3TzaIuuk/ll9JWSx6A+bQBqsXQanTvfBA8
        BvHhrN112NxRt7OW0+Noa50Ib8z61SaploV8SQU=
X-Google-Smtp-Source: AGHT+IGI1PZ8b9EpIBue+7qAEGK/FunsTjxd8K8lxBg7iJFrfeQMmKHVyoH2Azk+O5KGu/yOpz71q/xI3PVqS9i1Ci8=
X-Received: by 2002:a5d:4533:0:b0:31f:97e2:a933 with SMTP id
 j19-20020a5d4533000000b0031f97e2a933mr12283598wra.56.1696314594362; Mon, 02
 Oct 2023 23:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230927181414.59928-1-dg573847474@gmail.com> <a2a43d5a-678d-129b-d258-d559df42431f@redhat.com>
In-Reply-To: <a2a43d5a-678d-129b-d258-d559df42431f@redhat.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 3 Oct 2023 14:29:41 +0800
Message-ID: <CAAo+4rVyszEhD1wujd_8_tgrUuJDEgLES4YWoOu36s9UL4YFAQ@mail.gmail.com>
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
To:     Jon Maloy <jmaloy@redhat.com>, Simon Horman <horms@kernel.org>
Cc:     ying.xue@windriver.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks much for your review.

Regards,
Chengfeng
