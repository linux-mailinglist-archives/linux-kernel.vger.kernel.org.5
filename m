Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A31754361
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjGNTou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjGNTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:44:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC82D65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:44:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-780c89d1998so16013339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689363887; x=1689968687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veFKUMZBQrX/Dj8inbuI++veCSXQIqVt2O+DqAlAqSY=;
        b=nI/ZAOQV+22/fvMKdASmAS2SLR9eTK2unZNTUpvZw/A/zJidy+4aCVns6AEKtElt0C
         TI90FTvp67Dbr9Qp8foTg3k/whZFGH3wrHjcTpGaM+5A01LFuZnaMxuNqH+fvGUN+ftT
         2Zg24dm1e2Zmn6JCnTLUZnM3si7Dy+ctAWpZP86X2l72fqt/Mj7pStO4ak6Bh85zmuXG
         TtUPdpVwoQ9qT5vXxmRUs7+T+imGLj7dKZblJT6G9YRE03zswHcVrH5OjViWr/PSZJCc
         qr6J7Ntj7aWafAKtoe9HYjXrtTpYbSJFsrvEn/cw3vxvOS0O5z2aEoQlfWwbdhKKoFIb
         oHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363887; x=1689968687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veFKUMZBQrX/Dj8inbuI++veCSXQIqVt2O+DqAlAqSY=;
        b=OyLXzIKeclj4a4f4UXTTes0BviyGU+QKaRrIKBw4XtRShnpzgNtpeBTOnJcSaDhvbw
         tfGSXtiRnqE6u9RI8RpG6+FIp3HgkLPHPB1yvHDLLMDbMV2c0w5NQkawXMtNLXZsTCxj
         yKW6CGfn1QCP4paBT0HNys2udbSHqrH95G9XRJY8ocSpDpYUjckn8wTxk1d/oBPGfehH
         Ka0uJXOeRKVZdeFcOsN/fKWZDkx6gBM+qik3Q57dns3ZNy0038zUlWl1dT6+b3btH6Nd
         DBvHtLMXDVis+eTrTOIBXSpMxJppS6uN7PKUnZ83QMdyrVENrv/ls6t23P+fKL53IDVo
         61Pw==
X-Gm-Message-State: ABy/qLbhlgepYXkCZg0foqFbTf260nuPpHPDjwoG4qivXFzTNduswJiV
        oljYjtQx++JtTFWN8XFLT5tx5rlw665IvjAMbY4=
X-Google-Smtp-Source: APBJJlG27kU39KKaVWGTaq5CRYEHuODaHBkyLwAjTzymnofWUm93qrBD6npjvYvi1P7RfNjMUISuhQ==
X-Received: by 2002:a05:6602:2c93:b0:780:d6ef:160 with SMTP id i19-20020a0566022c9300b00780d6ef0160mr197778iow.1.1689363887060;
        Fri, 14 Jul 2023 12:44:47 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o27-20020a056602125b00b00777b94e8efasm2880017iou.18.2023.07.14.12.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:44:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230714101106.3635611-1-ross.lagerwall@citrix.com>
References: <20230714101106.3635611-1-ross.lagerwall@citrix.com>
Subject: Re: [PATCH v2] blk-mq: Fix stall due to recursive flush plug
Message-Id: <168936388618.743920.17372805107217904539.b4-ty@kernel.dk>
Date:   Fri, 14 Jul 2023 13:44:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 11:11:06 +0100, Ross Lagerwall wrote:
> We have seen rare IO stalls as follows:
> 
> * blk_mq_plug_issue_direct() is entered with an mq_list containing two
> requests.
> * For the first request, it sets last == false and enters the driver's
> queue_rq callback.
> * The driver queue_rq callback indirectly calls schedule() which calls
> blk_flush_plug(). This may happen if the driver has the
> BLK_MQ_F_BLOCKING flag set and is allowed to sleep in ->queue_rq.
> * blk_flush_plug() handles the remaining request in the mq_list. mq_list
> is now empty.
> * The original call to queue_rq resumes (with last == false).
> * The loop in blk_mq_plug_issue_direct() terminates because there are no
> remaining requests in mq_list.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Fix stall due to recursive flush plug
      commit: 70904263512a74a3b8941dd9e6e515ca6fc57821

Best regards,
-- 
Jens Axboe



