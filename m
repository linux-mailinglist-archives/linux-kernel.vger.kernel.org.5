Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD775B7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGTT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGTT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:29:43 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542DC1737
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:29:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-785ccd731a7so15291039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689881380; x=1690486180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6EPe9CKzSess5IGZS9/zarMFMwQLlIFSDbX+RR9h8I=;
        b=aWwdjxzLe8UQTuinjOdE/RaORTrgWSS+tJUStZMWSCuTGUocGzJfPMDFggwMrMAyup
         PmpG9WzHPLE71dd1sqEDRVtR0wTeS6qXtA7HNY77JSM9aKIWAdbimeldoKWH3T9gUphZ
         T9RfqNwp7KF5i4X7muppFm/bSsfXvlkwcVgkZj33/+Zg68haFkini3v0Wx6p/HaOtXUf
         HweVRFOeiWlQrxa4orkyepH+lU7fO9O5hBpeV5ErsUD6NqJrmAD1xUpsH12HjzdSQ6aV
         72y9NNGonZXMjaxPUf50DxyRh29f3GuP74ybPdXa6YNrDhrR3Ou3Mvv6zSQOJgRJFxs3
         5bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881380; x=1690486180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6EPe9CKzSess5IGZS9/zarMFMwQLlIFSDbX+RR9h8I=;
        b=AbhD2Fw5onoiwRH953E2y8t0YGV3jwpte/RllYmexiwxOwSoQDoxtSWgnlcYST4pBt
         zbpNTm89NFhO+5pXSgNLnohcm7sovMXKkTi2Y+SKq2qQTLB/6cs+Ghs386j6XKedMUUa
         HBZ3Rc8FE1oCcpYuKCDoqMZkOxAGHW14Y5ucQERkAoHBydqnYY+MPs/ID7E3b9/DZdH7
         haU9YOYlvmG0oZjXLdSX1TAjhFGwzPfSk1WuZb3f/KGa3VXes2Qmomk5c8AE4mXl6wWR
         t0EH+yToi+pSuKalb/hVxYw1vjccaW3CKDJ/SF/u5AG9p92aldxAUx8xhosL/QU5dRGC
         vwzA==
X-Gm-Message-State: ABy/qLZ6KEoahH+egG/+Rf8vo8bNDWUaRZqUfxD8SjeBDPm/YN7YUdhJ
        zZM9GRICpGgqNWIsZPYXcV5oycvXZBWMejBeKe0=
X-Google-Smtp-Source: APBJJlGA7R3/equ2bBUMJ8Kkqg8rfcu4hag98cml2ZNmdagaHpgjf6OhPoxNf0YMowttsd06JFG9bQ==
X-Received: by 2002:a05:6602:3423:b0:780:d65c:d78f with SMTP id n35-20020a056602342300b00780d65cd78fmr4831718ioz.2.1689881380773;
        Thu, 20 Jul 2023 12:29:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm515494jao.64.2023.07.20.12.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:29:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230720095512.1403123-1-chengming.zhou@linux.dev>
References: <20230720095512.1403123-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] blk-mq: delete dead struct blk_mq_hw_ctx->queued field
Message-Id: <168988137961.115425.9247701067643903062.b4-ty@kernel.dk>
Date:   Thu, 20 Jul 2023 13:29:39 -0600
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


On Thu, 20 Jul 2023 17:55:12 +0800, chengming.zhou@linux.dev wrote:
> This counter is not used anywhere, so delete it.
> 
> 

Applied, thanks!

[1/1] blk-mq: delete dead struct blk_mq_hw_ctx->queued field
      commit: 3641c90c4e369c8d0af5483e879174400a152cf8

Best regards,
-- 
Jens Axboe



