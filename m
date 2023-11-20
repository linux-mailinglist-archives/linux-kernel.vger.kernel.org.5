Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C077F19CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjKTR0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjKTR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:26:52 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D71E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:26:48 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a9541c9b2aso41574339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700501208; x=1701106008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4NKMxSmS203pqGjqep8cbifAOK1r66CeK+tH5/F9fk=;
        b=Xz/bK33rhNQ7TSMbIZQ8FG3MxgydJ2GY9MytsvTWpt1aaWZcmtwrjK83Raf953cc1m
         yKK8rC500w3CPJAdKiY905uqwarcbAe0bSX/knqixbowLrLnXar3S0Y3DS+lHek/+iGc
         XYgEXcNcTAnPBSwtsOh0UW611qkGVMmbIYNxFMqsPWT5ggwDnTw3AlKFNEbylorDQUUC
         CPb0fpTpptveWWclPV58o1/TvdHzUPA4ejhBGrchA/0SuOII+OEmDvYolhSo6fsBz0zg
         waufe6MJvXC8YRC9gnJI1ux++2A+wABnU+uFpHTcJft7dmV7qlhnM9IP1oivpmYR6dBR
         jddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501208; x=1701106008;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4NKMxSmS203pqGjqep8cbifAOK1r66CeK+tH5/F9fk=;
        b=hwswB0ADdzm0wwDeqTFRV6d3w2ypixh5j2PahXneTo6tj3CCVsCLoPbJNfaPyumRk6
         cPAayQTQVxdGuLLW6BjGpRXoijtab2MXN56jbksfCa6GQSag1eM4zM+ZrZ3S36wWQ/4/
         Yoi9Oa3gAWmyhVuhAlcLMMmFzwVItO75wdMB9RcKebIVGbiQBsgm0hmZGTJY+3QebM+l
         YEqE1pAAU2qTlXIS9VXJPQAsC4YgQa0FyE5zbXoBZvQAhkLuDfhrw2Xfr6XCNs6Yig7v
         RX7kOQdN0zmE06afyeFWFt3oIakv8AUxJrBL2Hm7JQsKB9DB9gxrMCzrQCq8vlwdNZvN
         S81g==
X-Gm-Message-State: AOJu0YzSPjnfBHPwzQfIdvrgrlxbDmf52iHj4nOSw+BvZ494nTCsSEUf
        bQakE/beybjtJT53Y4JgJVaPPw==
X-Google-Smtp-Source: AGHT+IF74W5PDCNxklMdLnj1M/hiC+Xck8Tm7RKtQ8Fq+jRQx1O862OeeeepzEh0vBaEg469qXYLeA==
X-Received: by 2002:a5d:8d82:0:b0:7b0:ae97:cdeb with SMTP id b2-20020a5d8d82000000b007b0ae97cdebmr4864211ioj.2.1700501207830;
        Mon, 20 Nov 2023 09:26:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r7-20020a02c847000000b0046455c93317sm143008jao.92.2023.11.20.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:26:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org, chengming.zhou@linux.dev
Cc:     kch@nvidia.com, damien.lemoal@opensource.wdc.com,
        ming.lei@redhat.com, zhouchengming@bytedance.com,
        justinstitt@google.com, shinichiro.kawasaki@wdc.com,
        akinobu.mita@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
In-Reply-To: <20231120032521.1012037-1-chengming.zhou@linux.dev>
References: <20231120032521.1012037-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] block/null_blk: Fix double blk_mq_start_request()
 warning
Message-Id: <170050120665.99906.16634161281918179381.b4-ty@kernel.dk>
Date:   Mon, 20 Nov 2023 10:26:46 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Nov 2023 03:25:21 +0000, chengming.zhou@linux.dev wrote:
> When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, null_queue_rq()
> would return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE for the request,
> which has been marked as MQ_RQ_IN_FLIGHT by blk_mq_start_request().
> 
> Then null_queue_rqs() put these requests in the rqlist, return back to
> the block layer core, which would try to queue them individually again,
> so the warning in blk_mq_start_request() triggered.
> 
> [...]

Applied, thanks!

[1/1] block/null_blk: Fix double blk_mq_start_request() warning
      commit: 53f2bca2609237f910531f2c1a7779b16ce7952d

Best regards,
-- 
Jens Axboe



