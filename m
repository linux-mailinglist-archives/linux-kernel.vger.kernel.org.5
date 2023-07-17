Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E3F756633
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGQOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjGQOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:18:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196E170F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:18:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so1031287b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689603530; x=1692195530;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmjgRKbp9Bfg8n+oU4PLGE+EeOXhQe9CxhjO5mOrAjQ=;
        b=h/1vU9v9IFIj0iHZM0L5nziwQySFMCeKZXGCU1oIAHkfo+c8r5yw7A7ZfjkjpkNmY8
         iAASot4yvb8MixQdku43oesne2l0beUWfyAYFDwL2i7RFiWWmzGi8WE5WWpY6xHfvBQ9
         7CGP7H+Jho+zITTKM0/8pPLrTmScKVOhCPxDaiHZd8AtrIc45QI36b64xCf7I48x2N0E
         ceeDHtmtqqKaOtf9o+EXiKGpXG3X3uqznKW0GOToRg9EuCu+zxa89VXWk6N3GeX80QM2
         n3Ob6eYf0JtUwtVasDXzwoN4vA2XhsMdpR/kkdrFqRigpMDWT/ksbXjZYi2IpIbuZQyU
         O8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603530; x=1692195530;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmjgRKbp9Bfg8n+oU4PLGE+EeOXhQe9CxhjO5mOrAjQ=;
        b=ObV4GkHkZz4vGNlJwyEGDDVkeTzUFVBkX7yXN4H0rTcVNVlAaB8fDEWn3JOvKfI+0L
         Jr9M5GPav+C4Qu0n53U2BP3vyfH+LNNW/cAGVL32ALq9mv4rW3LzmaFpBFq148JlKZzP
         ogChVCQvdvEajwHTePkP6i84HYFpBLB9ZEN8Cwn9soYQd07n27+8QYRbfhbBgGg8fONQ
         Xd5WLk+W9Wikjn1Pbi0d2kfsziIxFsKAxuqdryUygsBzAhZRjCoYeKJ+d3suDoUgRZcu
         10x1wjsvI9ffnkd8qiD+RJwpXFYW8oliWOpf72ALHaiMlXB0LCTdkvQbgteQkvxizXv9
         k7Fw==
X-Gm-Message-State: ABy/qLZK9DKPMfaQrn5jqcYZc/FyN9RgYOiPJtbq4lWBCGYQRcwPZzaH
        6FSM05UDUDIbAdf1f9xgO58N1K1omktQH+vTqQc=
X-Google-Smtp-Source: APBJJlGdAGa4ETafgV/Veo9yZFmO91zn/b7SFTRHq6mKXhejtm1CMFHeDA4Jd3jcWcIFhHfLMiPDwQ==
X-Received: by 2002:a05:6a20:3c89:b0:100:b92b:e8be with SMTP id b9-20020a056a203c8900b00100b92be8bemr8556102pzj.2.1689603530396;
        Mon, 17 Jul 2023 07:18:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p16-20020a637f50000000b0055fedbf1938sm4110628pgn.31.2023.07.17.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:18:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org,
        chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230717040058.3993930-1-chengming.zhou@linux.dev>
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v4 0/4] blk-mq: optimize flush and request size
Message-Id: <168960352900.993352.5723079486795964605.b4-ty@kernel.dk>
Date:   Mon, 17 Jul 2023 08:18:49 -0600
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


On Mon, 17 Jul 2023 12:00:54 +0800, chengming.zhou@linux.dev wrote:
> v4:
>  - Rebase on the updated block/master branch, which include a flush bugfix
>    from Christoph. Please help to check patch 04. Thanks!
>  - Add a bugfix patch 02 for post-flush requests, put before other flush optimizations.
>  - Collect Reviewed-by tags from Ming and Christoph. Thanks!
>  - [v3] https://lore.kernel.org/lkml/20230707093722.1338589-1-chengming.zhou@linux.dev/
> 
> [...]

Applied, thanks!

[1/4] blk-mq: use percpu csd to remote complete instead of per-rq csd
      commit: 660e802c76c89e871c29cd3174c07c8d23e39c35
[2/4] blk-flush: fix rq->flush.seq for post-flush requests
      commit: 28b241237470981a96fbd82077c8044466b61e5f
[3/4] blk-flush: count inflight flush_data requests
      commit: b175c86739d38e41044d3136065f092a6d95aee6
[4/4] blk-flush: reuse rq queuelist in flush state machine
      commit: 81ada09cc25e4bf2de7d2951925fb409338a545d

Best regards,
-- 
Jens Axboe



