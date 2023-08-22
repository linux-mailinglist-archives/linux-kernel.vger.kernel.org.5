Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BD7844DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjHVO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjHVO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:58:34 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F87B126
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:58:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34bae11c5a6so4462115ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692716312; x=1693321112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB1Ww7Xem8WGw089z88YFa9W21ZWu8LSbkqc+/UePgk=;
        b=Wa/Yyd/kaC5r3r5yj8BC1U3nsT5jPqnb4GwBnzTcs3H05Y3QdTqX/2NLwI+JPq1Jue
         +WwJsSxc4NYmg3cMmhJVbKAL+Ul52iRp8WKzJK6FexeWCg3rfZ4CKa7XhZR2+St+ynZx
         0b6POKHXLNtb+eYvi8RQlZT1Q/5xmMwim3Fr3sutttDD6tNXvKV2kuhC6OYocMmXhClL
         bf/zO4bHSGibmad3sP3G/Hvw7HPnjybr//eOrl7yC/MZRDJp8D0v/g3GA0a/wYuQUSFP
         Gdy+XTMfU+zx1f11YIP0FA+XADzQF0wL1B9udx20Wql3H1ZjK9DWO8voXBc5mlFCpqEb
         R36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692716312; x=1693321112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB1Ww7Xem8WGw089z88YFa9W21ZWu8LSbkqc+/UePgk=;
        b=NSgAwDB2InRWltDhDx9LkxbK5wi+ARJ5Xq2vxiVkzkxRKk3dt89X7OgVB0pUXvyn+T
         Zhh9nMGbJpUscQZgKbWx0XvjAFsjue1yULAfQ8jXGFuJxmFJ3qmSy1vnWev0lr3N33tn
         l06EjuJcqF8P7Q8nRfD/aoTK56KBMphmrzPzGgR5pDz7rZMv13mgtUNZBhNXaMj57dcy
         BbTnblRJCXNiIiRnRjzFMFg8S6KSuwXIPr+2JdIOBWVePkJ5DBDoEluKxAyle0lQicRP
         b26QEXCq8n+l0Q/ves6OkS15S6F3YSHhm6TFGM8brz/GGfYRIyETwqSiO108N8HWw0zs
         wgqw==
X-Gm-Message-State: AOJu0YyGjmqEL17xCtSL+9Nr0Ij6ZlzGwrReFPhn5enm+zaG4SRGZxuS
        Mt2mk1eXPmi8QUU2jDZjPBYaRY30z+ps2H+gC0s=
X-Google-Smtp-Source: AGHT+IHr+XM33y4EusXFmXmeCjm9xQ3Z4ae/IlSxx/Fyh+yXTFLSUazav+XXl49xnpqnVLrupr7AKg==
X-Received: by 2002:a6b:c8d1:0:b0:780:d65c:d78f with SMTP id y200-20020a6bc8d1000000b00780d65cd78fmr11704836iof.2.1692716312011;
        Tue, 22 Aug 2023 07:58:32 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8953000000b0079199e52035sm3245417iot.52.2023.08.22.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:58:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, ming.lei@redhat.com, bvanassche@acm.org,
        chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230821095602.70742-1-chengming.zhou@linux.dev>
References: <20230821095602.70742-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH 1/3] blk-mq: fix tags leak when shrink nr_hw_queues
Message-Id: <169271631079.42104.4944668728331842875.b4-ty@kernel.dk>
Date:   Tue, 22 Aug 2023 08:58:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Aug 2023 17:56:00 +0800, chengming.zhou@linux.dev wrote:
> Although we don't need to realloc set->tags[] when shrink nr_hw_queues,
> we need to free them. Or these tags will be leaked.
> 
> How to reproduce:
> 1. mount -t configfs configfs /mnt
> 2. modprobe null_blk nr_devices=0 submit_queues=8
> 3. mkdir /mnt/nullb/nullb0
> 4. echo 1 > /mnt/nullb/nullb0/power
> 5. echo 4 > /mnt/nullb/nullb0/submit_queues
> 6. rmdir /mnt/nullb/nullb0
> 
> [...]

Applied, thanks!

[1/3] blk-mq: fix tags leak when shrink nr_hw_queues
      commit: e1dd7bc93029024af5688253b0c05181d6e01f8e
[2/3] blk-mq: delete redundant tagset map update when fallback
      commit: 2bc4d7a355a4d617452eaf1b21d6d261194b3667
[3/3] blk-mq: prealloc tags when increase tagset nr_hw_queues
      commit: 7222657e51b5626d10154b3e48ad441c33b5da96

Best regards,
-- 
Jens Axboe



