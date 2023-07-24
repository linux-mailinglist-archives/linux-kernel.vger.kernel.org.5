Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0C75FAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGXPf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGXPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:35:55 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1EC6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:35:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a3fbfb616dso2684482b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1690212953; x=1690817753;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oKZv/rBmUS8jYpb20v0bLOMjZtXNWMA7dW9EuTAoCFk=;
        b=kXfW6CLF0OSdXza+/b10cNHYYi7dagRWPLZb23nfItK9QmOO0FcMPU1H66eUvcqi5m
         bVsNXcfUT4MsQ6YXPWMS+dUmtY8E8GTiNz5KEBVJZMIF3LF/ruzurtduAsbiDsowpTGP
         2d/VlfNHqamUE4ayamTMkT/jzy39DAKXe0idnmfQ8OhhqCRYoI8CQNDMtO2QY57bHYDb
         RQ26AYVeyU+meLr02jrmMkgcpae0j3wVXw5OEriXC4X5Mz46RTCz+KAAWauCYacpIh0y
         iHZe1DrQRBC9GJT8z2t89iuj1ihdutxQUec4Hqi4y1stF472GRok/pziJAu7mjqljp1T
         FJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212953; x=1690817753;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKZv/rBmUS8jYpb20v0bLOMjZtXNWMA7dW9EuTAoCFk=;
        b=P7YzJQe/m4B8WxOBIXEMBgyMreacL11vNRO6U+FDnATt2p2YMdJfpJSLtMa0nY20EF
         cg12dajOgPiExkNQTC8je3GAezKudosDSOmGv9FJFUhoI54NfojPsHukeCECW+0OQXUp
         0zXfI9OnkGmHZTHaisICuPEBNkmUc5Y5BuBxHV2peN3B5WyKqmhdC/E3pBaNoqVJ3pkq
         3d0Mv+pCUT0LD6ZkK84aiqHfGRqTc5O34gqLmWnodzHm7Qv1Nu6vzi3fHXto3aNR6up1
         d7Yqu5bMLF52eIhmRCkwTXKl+o3BuaN8nFyzWG5sD4sO7QFDdcAFLlKUrr8aN3Fd7VEn
         2AAA==
X-Gm-Message-State: ABy/qLaRWAOJKjgRPSLQYuD9jC45BhoUbVsa1WTmDR0BUKupz2g5rD5i
        IBT+xY4gVk93Ysu/zR4HE3ALTF7fAJWtdiojTxI4+g==
X-Google-Smtp-Source: APBJJlFC27Fs2FQEX6/uDWYX3uVjauBNtGtTmosdOo0LpcFraWNWeDabeLTKObjIMXvb/cfgKzxEeXkoh90w1rflBig=
X-Received: by 2002:a05:6808:f01:b0:398:34da:daad with SMTP id
 m1-20020a0568080f0100b0039834dadaadmr13502844oiw.51.1690212953373; Mon, 24
 Jul 2023 08:35:53 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Mon, 24 Jul 2023 16:35:43 +0100
Message-ID: <CAMEGJJ2RxopfNQ7GNLhr7X9=bHXKo+G5OOe0LUq=+UgLXsv1Xg@mail.gmail.com>
Subject: Re: [PATCH] io_uring: Use io_schedule* in cqring wait
To:     axboe@kernel.dk
Cc:     andres@anarazel.de, asml.silence@gmail.com, david@fromorbit.com,
        hch@lst.de, io-uring@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andres,

With this commit applied to the 6.1 and later kernels (others not
tested) the iowait time ("wa" field in top) in an ARM64 build running
on a 4 core CPU (a Raspberry Pi 4 B) increases to 25%, as if one core
is permanently blocked on I/O. The change can be observed after
installing mariadb-server (no configuration or use is required). After
reverting just this commit, "wa" drops to zero again.

I can believe that this change hasn't negatively affected performance,
but the result is misleading. I also think it's pushing the boundaries
of what a back-port to stable should do.

Phil
