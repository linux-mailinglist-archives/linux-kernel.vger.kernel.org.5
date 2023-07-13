Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E9752BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjGMUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjGMUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:38:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0261E273E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:38:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89b0c73d7so1495175ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689280680; x=1689885480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1Q3QVXuA3e+9GjXcm3jtTXFaZS47K/0EuW+3XlNfNc=;
        b=Su8Wda2t8a9fyq+mKQcL/x7F/nORxih5QNN3QcI8gU6tafMcFTpXJ/JwTC+hoKIAet
         UZMsZJb96148P+d+aPws2YjRiYEf/edVpyjk4+wpEJ9M1XzqIucAg9yImocZFmYK9wJK
         xaE29kKpjDeCOxxq0rQ+6whCvhArs3pZ84vH3p/ZLNWFeACVq7oihBFPE5g9PWRpVt62
         m/+T4BW1NQTA7qrHOcSd4KuKrl9Spcm6bLiz8E7RZ/f+rVQrLrv9scU9gZNQlE9kebGZ
         0RGTY3HPcbhwteIksfVKa0OxCoVWRm5KTkbDlcno5Uv52JGfmdZij+dF0jwVK882tSpc
         Hovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280680; x=1689885480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1Q3QVXuA3e+9GjXcm3jtTXFaZS47K/0EuW+3XlNfNc=;
        b=IeGs6VpaTs4lpTsvSluZpf6DA1sZ4BKLEZcR24JhAC2O6xaL5Kvx0WWvPaRDvNdXJN
         S92i09C2l5jMcMhmCHEM7MM7cG4AP2sVSCjAvhblDQtLEUAyX+TtDEviDHuCIDhmL2VD
         LJsM4uz7EUtvBn+z7ut7VRHPNGaX/YeZq7ciM+RH4w2sbFFDbw3Jx6PbRlm4Ru9TdnlU
         SMs5lB5p9+ou38aKKLuBxzOmHbOfonKcuvsW6NBKhqeAEzz9iRC/SJUxkE/PfvQ7q7cq
         R5PrYrDrM27mH7Qmnb0ok0wmFPOoPmex+Qj4E6nmYcL6bM+hn8YsY355nl7cc/MmzVCO
         ROSA==
X-Gm-Message-State: ABy/qLboaCD9p36MRVPOkonCUPj7r9fU1FePUqG1FHZOd4neHaw58/Oa
        2LmNzuNqbks7LWoBZh2y/kZwOw==
X-Google-Smtp-Source: APBJJlFtDbDfCH1QZYudWC+aygAHdxLHIdPeg2AQ0LHcswNN+FtzghG6W1WdomahIOIyN5rpCIt89g==
X-Received: by 2002:a17:902:e549:b0:1b8:a8e5:e8bc with SMTP id n9-20020a170902e54900b001b8a8e5e8bcmr3342583plf.6.1689280680481;
        Thu, 13 Jul 2023 13:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902988a00b001b89045ff03sm6258074plp.233.2023.07.13.13.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:37:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
References: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
Subject: Re: [PATCH v3] nbd: automatically load module on genl access
Message-Id: <168928067935.580122.1235240259614744275.b4-ty@kernel.dk>
Date:   Thu, 13 Jul 2023 14:37:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jul 2023 21:29:35 +0200, Thomas Weißschuh wrote:
> Add a module alias to nbd.ko that allows the generic netlink core to
> automatically load the module when netlink messages for nbd are
> received.
> 
> This frees the user from manually having to load the module before using
> nbd functionality via netlink.
> If the system policy allows it this can even be used to load the nbd
> module from containers which would otherwise not have access to the
> necessary module files to do a normal "modprobe nbd".
> 
> [...]

Applied, thanks!

[1/1] nbd: automatically load module on genl access
      commit: 82e37f43c37845b69955a0dfa5e0d1a2a830bdb7

Best regards,
-- 
Jens Axboe



