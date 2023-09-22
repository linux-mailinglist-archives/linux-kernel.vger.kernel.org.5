Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075C37AB422
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjIVOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjIVOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:52:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA7DCCD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:52:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79f96830e4dso16632239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695394364; x=1695999164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGBYO+nGsfARnhytIjtXueAfrl2OO+PPabMy9Va5wj4=;
        b=Gsozdjr0yB6Dukx9DZaNaIoQQGxkGWQr0NlfaevtP6a268LG0IUOXFm+vUA50udr1e
         WY3Z7E+8/wPsY012JCscRuy/PMc2CzjiyLbjSgaE29wHvqXvVkD2HIqZM9WBLBDbgZvN
         MirjtCmZghtqBN6TXVc3St6eg0VYwWVxXYXFbZpSGF6KM7vBs6dEgyc++lqiVHv7ywD8
         u971FtQUiGTFr/46V+cWuRHFh5Xt3lzycCirO2DfGFCmFqZfHRlyjsJncMpneyXzTiS6
         jwe/XYPEEhSVPT1J1ZzixcVk6Pyt62Gmt2C/qyHH9hca+wvBVOlE/YoslVj6yDOeNSNA
         ljoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394364; x=1695999164;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGBYO+nGsfARnhytIjtXueAfrl2OO+PPabMy9Va5wj4=;
        b=MU+0bAKB5Gm+I118IluPNU07GnLMEmN5FU2I6cncLDXeDFyn2K2rgcegOsyMdJWUxO
         wjpAyUYiq9vYj67muIEsizDYQaZeoIH86KXnZSY7Eoye58Al4UgD5YMAC99Ohb39Dlnc
         JwoB1TLbzghsVJUoGyTRc8ur1IxF98JISm2HaIbmCpbe95PDBHI7giuLoMBtLwaoMBQX
         rFlj/LhDKqtpZ62Zw2BWRVdZrAT/HYOS/0uuKE43YWCkUtCFuipACPWYH5+4JOb+olZN
         aBNyryG+XbBIEFB83IhYMO3h1X2bRPUFgRLCRd34MkBFbECYD7glT2mVr6ZEc8MbEzuM
         bkQQ==
X-Gm-Message-State: AOJu0YzFNY5CZavVVzid5s1vKcmyXOzoEAa6SuoXG51sGoFSX9kFV0bm
        mmpA95/3yKQPwOjsXqHLeMKhXUTArdnwBuhCvnxuoQ==
X-Google-Smtp-Source: AGHT+IHL+yk7dBzL5o0l69gGgjqHjcXQNUnZMdMJ4Sb6UB7QjvTxV14vW94S8kAVl6A/F98FWOzisg==
X-Received: by 2002:a05:6602:3788:b0:792:7c78:55be with SMTP id be8-20020a056602378800b007927c7855bemr9005827iob.0.1695394364539;
        Fri, 22 Sep 2023 07:52:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638022600b0042b2d43ee3fsm1017020jaq.82.2023.09.22.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:52:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, ming.lei@redhat.com, bvanassche@acm.org,
        chengming.zhou@linux.dev
Cc:     kbusch@kernel.org, mst@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230913151616.3164338-1-chengming.zhou@linux.dev>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v2 0/5] blk-mq: optimize queue_rqs() support
Message-Id: <169539436327.239461.11694929564219340558.b4-ty@kernel.dk>
Date:   Fri, 22 Sep 2023 08:52:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 15:16:11 +0000, chengming.zhou@linux.dev wrote:
> Changes in v2:
>   - Drop the patch that fixes a potential race in request timeout
>     from this series.
>   - Rebased on the newest block/for-next branch.
> 
> The current queue_rqs() support has limitation that it can't work on
> shared tags queue, which is resolved by patch 1-3. We move the account
> of active requests to where we really allocate the driver tag.
> 
> [...]

Applied, thanks!

[1/5] blk-mq: account active requests when get driver tag
      commit: b8643d682669994b3f57c3440df3d4f9cb735f35
[2/5] blk-mq: remove RQF_MQ_INFLIGHT
      commit: 48554df6bf2b1e83f70749bf4b4d7914f8b3c01d
[3/5] blk-mq: support batched queue_rqs() on shared tags queue
      commit: 434097ee375fff36bc5037524609ffd6199f11da
[4/5] blk-mq: update driver tags request table when start request
      commit: 217b613a53d3a430aa2e5d1523819dc271f02ff0
[5/5] block/null_blk: add queue_rqs() support
      commit: d78bfa1346ab1fe04d20aa45a0678d1fc866f37c

Best regards,
-- 
Jens Axboe



