Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E27E439A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344073AbjKGPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbjKGPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:38:26 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B0128B7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:15:34 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-778a25cad6dso25619285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699370134; x=1699974934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSo2uHzA475zg1anJM/RFwUnIs9F8vQ48D/x02K64wM=;
        b=Nk02B5Fp7jtkBtCEjeJc0gW6rHkaAcJurdgMAU5EHi08tQkHoNl8yLhjRsuz5wZ1zr
         ZLWvXuYWkzGDIdoc7BmdikAKtNjMwEjJeEJyZUm0NtXGdllFoYxKqW1F3FP0CL5+GmLN
         UMF1brx+luBkREGTkRJ22fSx2b8tSJwztJKrobbTjTS2JodKwENlM8G/gqQRCI9LM9/S
         3duTO5rGaI+94Zw9FCbURYgbDq9sUmDahq1rIpG/mi4gs/c6FWm96BoHokmOgBY1JL85
         d0x0lETHHH27XG8YA3HWY99suL4BXwSUzKhmZdKaITUsefoixTWqbPTOaFQmDTemz2RQ
         IYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370134; x=1699974934;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSo2uHzA475zg1anJM/RFwUnIs9F8vQ48D/x02K64wM=;
        b=M83wz8XuYkdOGMDfFDTDdEwvM8+QJDmsgYetMi6fTtGZLw1jtsMwcODgMtUz8lMFej
         E0cJVqUQ54+/tZyU02UeI7dcZttjKbq5FvSo9RWcw/HwCiz7Q6qtW70OAitL3/STi6/E
         ZwKdSLnLuZ/YEUWhRmR0R/EtWABtzcI/e5NYznblpygCRfs9EKkSE8Io/uv/J3NuD2gW
         T2vuFRh2viSh2USb1v3dhvjcy4iLSFfNhNpLK+ka0mHebRLiJl831ip2Scf/736Ke9fl
         ccIzjLhbvpl7M7Uw1y403FzYy8ISsTohmu36SwF2v7vroi2b+9AYtptMoruJJWjYuwov
         Sv2A==
X-Gm-Message-State: AOJu0Yxv0lxHuz/bDwo8DURautNoaMRl8lU66NKobmJGYB13DuyyuGeh
        xzckRUHm8Kyd3Rn/2U6oAk4vkw==
X-Google-Smtp-Source: AGHT+IGJa06jbPvLPTKkjguuvMggjPIeEu5QTDeqHbmw67+dg1/UxbCzkpBE+F8xjlTqdqK//qjGhQ==
X-Received: by 2002:a05:620a:19a1:b0:778:8ae9:2247 with SMTP id bm33-20020a05620a19a100b007788ae92247mr39219338qkb.5.1699370134013;
        Tue, 07 Nov 2023 07:15:34 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c091:400::5:f968])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b007759a81d88esm4215667qkf.50.2023.11.07.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:15:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com
In-Reply-To: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
References: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH v2] nbd: fix uaf in nbd_open
Message-Id: <169937013187.545643.6485076095455389311.b4-ty@kernel.dk>
Date:   Tue, 07 Nov 2023 08:15:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2023 18:34:35 +0800, Li Lingfeng wrote:
> Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
> blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
> disk->private_data as NULL as before. UAF may be triggered in nbd_open()
> if someone tries to open nbd device right after nbd_put() since nbd has
> been free in nbd_dev_remove().
> 
> Fix this by implementing ->free_disk and free private data in it.
> 
> [...]

Applied, thanks!

[1/1] nbd: fix uaf in nbd_open
      commit: 327462725b0f759f093788dfbcb2f1fd132f956b

Best regards,
-- 
Jens Axboe



