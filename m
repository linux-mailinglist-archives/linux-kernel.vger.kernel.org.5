Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A447ED8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjKPBOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjKPBOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:14:53 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE2192
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:14:50 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6c7c6ae381fso263108b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700097289; x=1700702089;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21E7e9RhSv6D07zzIzwFZc3l/Yr9Y30fEeH+mcQUYOM=;
        b=d+MaaKvQ+uSFV08IMXpTHe0LP1SvIHw3tKhelPWGXx9rSnVUMlsUorPcMBnMqVcF6E
         3E1qv5vUfSWaHXUBf5ZJ1JBhFac6DgwkqkE7CDp7fnnb0oO2ywbcUUq79R6eSulAlp1+
         5sy7SNMFQZ79uKTs37WyVceaJDKAzwh+Lu31rS9ujVMwGcfkEmfHooAcs+r8eTNRLEiL
         265PZA2pqhLgb/66MaE1dVNfY47NZAXw4WP/03i8t8Zu+eqflhqYXO0f+EdTcCrsQwkh
         v5ZkAD1qbuJjSSDCVQQ8KMNHoVppqui7auTzeXSaAnKRVRQnWsE/U9M6of2JgIB84Xyo
         m/9w==
X-Gm-Message-State: AOJu0YwESb8+4oNTMYewXgjsEj0/+ShQ+m8T7J39fCpABfwxw70922nS
        7pPVWkCTDpih17ZzUTo+fOTYscXS9tq3W8hjFxxjqNuZOaJyeXQ=
X-Google-Smtp-Source: AGHT+IH1Ea2M6lYMLfMhEaGMVi2vG//gKFL17GWqGR+5zEzsuR34wgbxYia3ZB8+JyKRKoumWETQwdNw07kBlBK+JoeSB12nGtn7
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:8509:b0:690:d251:28b9 with SMTP id
 ha9-20020a056a00850900b00690d25128b9mr3513941pfb.4.1700097289638; Wed, 15 Nov
 2023 17:14:49 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:14:49 -0800
In-Reply-To: <0000000000000526f2060a30a085@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000085ad3060a3abf6a@google.com>
Subject: Re: [syzbot] [PATCH] test warning in squashfs_read_data
From:   syzbot <syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test warning in squashfs_read_data
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ac347a0655db

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 581ce9519339..cf21494e3994 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -330,6 +330,12 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	if (next_index)
 		*next_index = index + length;
 
+	printk("l:%d, i: %d, ol: %d, mbu: %d, %s\n", length, index, output->length,
+			msblk->bytes_used, __func__);
+	if (!length) {
+		res = -EIO;
+		goto out;
+	}
 	res = squashfs_bio_read(sb, index, length, &bio, &offset);
 	if (res)
 		goto out;
