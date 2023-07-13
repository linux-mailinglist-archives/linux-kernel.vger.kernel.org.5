Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAE6752A50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjGMSbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:31:20 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE25E2D4B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:31:18 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so12476639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689273078; x=1689877878;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sg87cEYeWMB6yYseQ4SjGuYhfzXrqT0VWVgvI9gUao=;
        b=5G66KJ5FDNm9G2/e9SL9UO1FqJdRu76kki5mG3ANpiwrA8TfvoEVHKoTv++bPUJRv0
         KuB0ML+nzEzOhLi7YNeX+b3mKSBE9NyqTVNiiUX5ASXKCaU0maSbTWKF2T+aNbO1b//1
         LI9W6/jcGGTP/YnZkF2iOvg3NTOVQ6IYavIQ6TWnrrEKFtVIeqvEYAas5a/sMXzvtgMN
         vwaBKRHJ2BnDrq7na1UJreDe7knpCr26myl2TlXujtTdPO8S33CSftmozbmsc/czVwby
         QNoHdDu6TK85gf1DKOBTwSxshxwtYpUlS5SJtpF1J8/h+8Bq27e+ppiaGSBiEGx55ZwF
         pbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689273078; x=1689877878;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sg87cEYeWMB6yYseQ4SjGuYhfzXrqT0VWVgvI9gUao=;
        b=GWeaal9ygxg6qyTMFpkf3KlmzI9T2ZH90ow/u47OSS7FS7Mdmk2MZgN8pYJ2UAksU/
         68OpK0pHT1K2MSeTemxGv0hOyZOuY9uT4GtII7jT5Q8OhzvaM9E5WAeiWT1LYve+Gi9o
         RWP5zxlwGC6GEUNyLWwEpYB+/hZdOoDXl1ELjlyr1ent/aViazsnUA/OYjrVHVihfTZ6
         xgWnXxD6uanO8+EyGzwcTYl/vf1UWWNdBJOU61uFg89/7Zl3DhztDmJG8tIgqMUlTNDW
         Cx1KjdJBmyRnnsXHbvtACyWnDQdxlxnqk8Ie/a7EL1669y/OsgoCQknHHr2Zmq0Tue4T
         j9QQ==
X-Gm-Message-State: ABy/qLazcOPF8Uy+1O5F3/NQuTuPLrUBnG3bScNyJvBpSNS8yu771fAU
        pNGFi5Snv3f7WYtoUM8mfPF5Wg==
X-Google-Smtp-Source: APBJJlFg744e8fSspcr/ts17lJ2WHR9lKLwe/Kn5bBBmB113WrTkm3T6wK/+pgh1jRF//f2xT2nYYQ==
X-Received: by 2002:a6b:b7c1:0:b0:783:6ec1:65f6 with SMTP id h184-20020a6bb7c1000000b007836ec165f6mr2264242iof.1.1689273078146;
        Thu, 13 Jul 2023 11:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g10-20020a02cd0a000000b0042b28813816sm2078332jaq.14.2023.07.13.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:31:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, tj@kernel.org, ming.lei@redhat.com,
        chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230710105516.2053478-1-chengming.zhou@linux.dev>
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-Id: <168927307722.553980.1947848634070794553.b4-ty@kernel.dk>
Date:   Thu, 13 Jul 2023 12:31:17 -0600
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


On Mon, 10 Jul 2023 18:55:16 +0800, chengming.zhou@linux.dev wrote:
> The iocost rely on rq start_time_ns and alloc_time_ns to tell saturation
> state of the block device. Most of the time request is allocated after
> rq_qos_throttle() and its alloc_time_ns or start_time_ns won't be affected.
> 
> But for plug batched allocation introduced by the commit 47c122e35d7e
> ("block: pre-allocate requests if plug is started and is a batch"), we can
> rq_qos_throttle() after the allocation of the request. This is what the
> blk_mq_get_cached_request() does.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
      commit: 5c17f45e91f5035c1b317e93b3dfb01088ac2902

Best regards,
-- 
Jens Axboe



