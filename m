Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3A7997BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbjIILyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjIILyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A5E46
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694260394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Brd09ChjlGcm33tn5aaPV7Dgfxku3U91yIO+34U0Xs=;
        b=F4aktB2XjRu8T2agOXqDQvaLtlnvOiG83qQSHV+YpSZ5ytT3RVeUW0TxVLR8d3tlBDHvpJ
        AVrEgblxS6qeQlTO8MNbNfSxIz23PfylZJhWwf5ybWkt4+Zrensqhx6s5LW0n0UgfCLsD9
        xw9Ta804pjJDajrCJFiyfeTz4312GjI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-pYKiScUIOYCYB6weopR4kw-1; Sat, 09 Sep 2023 07:53:13 -0400
X-MC-Unique: pYKiScUIOYCYB6weopR4kw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76f29f14e0aso297503685a.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 04:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694260392; x=1694865192;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Brd09ChjlGcm33tn5aaPV7Dgfxku3U91yIO+34U0Xs=;
        b=wg0GyPuG5GvcZaeDDTHdYmqEsNpvWlMnzeZcbSsVlFdMiND1oqQkqv5YWMMqPF7Abz
         RCdMtG7fD2uxXHiF1Y+AYM0jv6mPV+9PAXIQutGBhyiMIob5unh0xjJ4Be+BbZHdyjVI
         VcpXKY9MNG9/QtiZhmMqg+7OOrTA5I8QLnUGmZ0aiCBEolW3nsA0HbFQwt6CgVLwa5st
         UvEy6eRliRi1udoXSMWfGhKoRC5imED1Fr8nUsDzocN0Eig54zwGhKfSc5RQFnx4ehDw
         bVe7tRul86KoSRum57ucXRTr9wC4zqImJUDbA5KCV85fqOpmTUYadi49lB07aOV9FrL3
         YCOA==
X-Gm-Message-State: AOJu0YxSSbpmbuPLsRr0SKgOzLTlLKAogSa5vwv3mt5q4B3w2q49GPQs
        KxoFfUDc+aOyVa8h3dIPKDDI/hBbgHOsnCTZVklkxk27fX+WuVkTctSnoo8dnueO3n8ctfJ+uG1
        J7DlWpNGLYNyDWPE2sbuc6YTH
X-Received: by 2002:a05:620a:3d1:b0:767:96e2:a9cb with SMTP id r17-20020a05620a03d100b0076796e2a9cbmr4880708qkm.38.1694260392553;
        Sat, 09 Sep 2023 04:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzaPjdqQmtJK0AQn4B8TqeeRtKxwtYxBagaljOo1lDC4D12dp4dP61e64rcoFNOk8YVLcX7g==
X-Received: by 2002:a05:620a:3d1:b0:767:96e2:a9cb with SMTP id r17-20020a05620a03d100b0076796e2a9cbmr4880699qkm.38.1694260392288;
        Sat, 09 Sep 2023 04:53:12 -0700 (PDT)
Received: from [192.168.50.193] ([134.195.185.129])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a136500b0076f206cf16fsm1250131qkl.89.2023.09.09.04.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 04:53:11 -0700 (PDT)
Message-ID: <46d929d0-2aab-4cf2-b2bf-338963e8ba5a@redhat.com>
Date:   Sat, 9 Sep 2023 07:53:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     song@kernel.org, yukuai1@huaweicloud.com,
        Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
From:   Nigel Croxon <ncroxon@redhat.com>
Subject: [PATCH] raid1: fix error: ISO C90 forbids mixed declarations
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a compile error when this commit is added:
md: raid1: fix potential OOB in raid1_remove_disk()

drivers/md/raid1.c: In function 'raid1_remove_disk':
drivers/md/raid1.c:1844:9: error: ISO C90 forbids mixed declarations
and code [-Werror=declaration-after-statement]
1844 |         struct raid1_info *p = conf->mirrors + number;
      |         ^~~~~~

That's because the new code was inserted before the struct.
The change is move the struct command above this commit.

Fixes: md: raid1: fix potential OOB in raid1_remove_disk()
commit 8b0472b50bcf

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
---
  drivers/md/raid1.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a5453b126aab..4f1483bb708b 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1846,11 +1846,11 @@ static int raid1_remove_disk(struct mddev 
*mddev, struct md_rdev *rdev)
      int err = 0;
      int number = rdev->raid_disk;

+    struct raid1_info *p = conf->mirrors + number;
+
      if (unlikely(number >= conf->raid_disks))
          goto abort;

-    struct raid1_info *p = conf->mirrors + number;
-
      if (rdev != p->rdev)
          p = conf->mirrors + conf->raid_disks + number;

-- 
2.31.1

