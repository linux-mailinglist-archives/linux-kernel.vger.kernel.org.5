Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A09178FED4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349932AbjIAOTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjIAOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:19:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F66CC5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:18:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77dcff76e35so17835439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693577938; x=1694182738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKW1nBpS9Q1X56VwSVFjCsUpOjQeYfRziNFoaW07QFU=;
        b=OdyR2l3NjsHiGUqHvapLNx/ge4OdMUccs7484R+VEENqMDBqwgke3wB1WFBqSU013n
         vkfDVhWFAKOjr9QHFbQRr6GgG0UQR5QlYM/bmHgwObTcUJOTHCz0OIgsZoIdlUU45UFN
         1W+EbHzq69HXnWIVbCPR040dKrlXlGtDIItpzm82HEgy4tq0jMSSEouA2lil2dU0QXnF
         TT5Nk+EGPSpFXBzS1PcrXYzHr81jBq7haxC47aHCeciQB9KHBWrEf9fISs7EeDZ+VZJe
         /aQqo0OgiINXa01r7YBbHoxP2FfIdZCYItKN0umlA7vijIoHCEig2C+uNeYWAlWZfMKi
         TNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577938; x=1694182738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKW1nBpS9Q1X56VwSVFjCsUpOjQeYfRziNFoaW07QFU=;
        b=cinz/SczMgxOuj+kUKAQXlN0h5sT5nFuPhwkPOVc70Qi4/a1ZhrYnPRIT7E7WdWjvb
         xZHzQxweP64U4FLw7oXVUSzKHhzdF3MPUMnagpBc9bPP/EOMd/eZD/t61LaJ5EhWpRdp
         2Vvl7fC+zgAGn7HOsXmXOkvGT2cm2Oimc0ShDaTTWzUys9JXb6ufnA/q97N+fQ+vC9Kn
         vF2WrNhxe5Dl0mRYIpwH/fHRYFVYJ7gWD4ocP4/BJWezFFlt1EZNvmGErQOTbACQo0/k
         6rpd5Ct4zbLRJC6QudiJHU5O7VDug3U69pkGBFAelp9fPb7MKO/NKbW85RVuVthSqBSX
         3DZw==
X-Gm-Message-State: AOJu0YwPmam2mqRHiJVzqGeZSmyMZpDy03vqaR4YKIf+WvjGHwPuTiU7
        3ToZlf+PGh9mZ8MYtj4RIRQuow==
X-Google-Smtp-Source: AGHT+IG0FShxW6UI1rD4z3lHhMt+9RIs9nN9WfcpkcaP7pSgzZyph0R8n1EkmyMxNwZ7byZTuhPHtw==
X-Received: by 2002:a6b:1495:0:b0:790:958e:a667 with SMTP id 143-20020a6b1495000000b00790958ea667mr2645886iou.2.1693577938521;
        Fri, 01 Sep 2023 07:18:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fq24-20020a056638651800b004182f88c368sm1080139jab.67.2023.09.01.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:18:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, dhowells@redhat.com
In-Reply-To: <20230901120306.170520-1-chengming.zhou@linux.dev>
References: <20230901120306.170520-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v2 0/1] block/null_blk: fix poll request timeout panic
Message-Id: <169357793753.310999.18144823981209368799.b4-ty@kernel.dk>
Date:   Fri, 01 Sep 2023 08:18:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Sep 2023 20:03:05 +0800, chengming.zhou@linux.dev wrote:
> Changes in v2:
>  - Improve the commit message a little.
>  - Add Tested-by from David Howells and Reviewed-by from Ming Lei.
> 
> The 't/io_uring -n4 /dev/nullb0' is easy to trigger poll request timeout,
> then panic the kernel.
> 
> [...]

Applied, thanks!

[1/1] null_blk: fix poll request timeout handling
      commit: 5a26e45edb4690d58406178b5a9ea4c6dcf2c105

Best regards,
-- 
Jens Axboe



