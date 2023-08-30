Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2BD78DBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbjH3Sjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343613AbjH3QPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:15:48 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D3D1A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:15:43 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34bb0e34fbdso1892035ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693412143; x=1694016943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84+SP1mxCxPsszug4wWaDlsL3ZFBxN4ycBABvZrJaYs=;
        b=hmUElf4JG9R8Kjx9ZWVWNw+hT/pPkZgpgWENArPKg/gWpP/k/gpKOqMC4Wi4kdG7kJ
         I1gK8bx9hsfXv+uthThnLVcDepqXJz0TR5VAgS6yyF0sBD6En11UR6zITsyKD8m1r5ce
         4reyFvRGZjYHP3V6AoU+Pq8SJeObjQGYXeE32eD4pYpcw2BeDvNoU0oU+6ATpswJdkVr
         dpbIbQJfsWZ8BeqgBR9I5yh1xXE5tqenXo8ViY2eLz6nf+lxq2mS8N5Mo02kr/MQ4hz3
         75abj6z1ioLre/Cj0qk8lS7vEvkJ2f770J1k/m9KYxAYT9jrLduWQjoSXfQ8lsfJVwQa
         iDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693412143; x=1694016943;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84+SP1mxCxPsszug4wWaDlsL3ZFBxN4ycBABvZrJaYs=;
        b=GVIzHlXVKXxj/3/0WTK063N3klzM39W6YIMYlDIcR7QO+VT7xydTXoDQYuUNrHgQs/
         Cm7Vsv9OgjrYZ58e4T714cb7xsxj/DoVvQMU83s4jd8+HJMtmp/xhldLxTSkaW0YcPht
         7NcDEREbkR2s4ZpShAmluY+WIZX896smtLgiNJToy1XgIZ+yg8/EiWoJd/7iCFZqIAet
         IcthX185e85PnZzbGyMIfDJBZyVMNJlPOymPMRSPkvA9i5zUt4yO5zoJQlnCdZLN5GJj
         DZxgoeHhhMCFaZWbQ4IOVUJ9Vx28t4BEJnKdh9li6b3p1ichbg3adEbToWvv8F7iLkcX
         /DeA==
X-Gm-Message-State: AOJu0YyrD9FiJvF1HVHbclF0/MNNCfkm5SFAKSgP0vu6T4xbsc/Iab3L
        2iqUeBLGv29ofVpqAH76wzM4OQ==
X-Google-Smtp-Source: AGHT+IEl8p2IgLICIsJT+23ZrmKW3BqwOkbzIiIU2IlnywZSRPG4k0lU/hHjB2p+kNiPS+cFrjhaaA==
X-Received: by 2002:a05:6602:3789:b0:794:da1e:b249 with SMTP id be9-20020a056602378900b00794da1eb249mr2751297iob.1.1693412142788;
        Wed, 30 Aug 2023 09:15:42 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n26-20020a02a91a000000b004165ac64e0asm3996341jam.40.2023.08.30.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:15:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, yukuai3@huawei.com,
        mkoutny@suse.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v2 0/4] cleanup and fixes for
 'carryover_ios/bytes'
Message-Id: <169341214128.126809.887499172246974697.b4-ty@kernel.dk>
Date:   Wed, 30 Aug 2023 10:15:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 09:27:04 +0800, Yu Kuai wrote:
> changes in v2:
>  - fix missing adjustment in throtl_log().
> 
> Patch 1 print signed value for 'carryover_ios/bytes' to user.
> 
> Patch 2 fix that comparation ”unsigned value < negative value“ will
> pass, causing that io won't be throttled in the silce.
> 
> [...]

Applied, thanks!

[1/4] blk-throttle: print signed value 'carryover_bytes/ios' for user
      commit: ef100397fac3e2e403d5d510e66f36e242654073
[2/4] blk-throttle: fix wrong comparation while 'carryover_ios/bytes' is negative
      commit: bb8d5587bdc3ab211e1eae2eeb966f7a7d1f9c0b
[3/4] blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
      commit: e8368b57c006dc0e02dcd8a9dc9f2060ff5476fe
[4/4] blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()
      commit: eead0056648cef49d7b15c07ae612fa217083165

Best regards,
-- 
Jens Axboe



