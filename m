Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713297E1830
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjKFAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:46:57 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073D1A2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:46:55 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b40b5f2274so4829995b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 16:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699231614; x=1699836414;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4W4Upbl8FU1dF7PItwMQ7LkcwTM/nTnOvVDdq+SYns=;
        b=Aw2lSTYFWR0PcJL/tpjgD1jaB1d6EFo3g72blLT4kmM1O5akaIpqs7NPzEQfpF6mtz
         psuYinY/j394WKnuTq5dkP70/3KVMQYA0umebWzFghmeQrEN8KoBAzeyMcIrSawA6a5t
         HlzX6Ai4WhwgJ+lu1sf6MdxEMRSeJ3IySJDnHxCX/tRVp0MG1cAP69O4RHnesgTHWqiT
         ONv+qp+SOnvRDenUK84eGnK5QguzNMiUyAKD+WwhuuKc5I1MBl++0A9FDL8mKC3ifQht
         Opjj2fDe/EFWCInsgLxGBZNg+x+kFE7oAuypE0YEpJOY1JJgk0hqffpEHiqbm5bZbv3P
         VUAQ==
X-Gm-Message-State: AOJu0YxW2Dy9KYh4ibjDRATgmL0kcbDlZrsXL8r/k5Faw/NRU+n6isUM
        zm0pUbERfZLFMgPk4DzhyI1Hm1Be9akwKnvpFFE9cpf5IWTzJVE=
X-Google-Smtp-Source: AGHT+IF40xtLD7jP1hOBQAXqUjwzJFHE+kBJm4z6Liyb02umsGSY/ZhjQlSRvodxS9OMfsnrrdrTHHt6/a0SeZne91FS1vkEGDvi
MIME-Version: 1.0
X-Received: by 2002:a05:6808:360a:b0:3ad:29a4:f542 with SMTP id
 ct10-20020a056808360a00b003ad29a4f542mr2685197oib.5.1699231614457; Sun, 05
 Nov 2023 16:46:54 -0800 (PST)
Date:   Sun, 05 Nov 2023 16:46:54 -0800
In-Reply-To: <000000000000e7b62806096c7d67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c55bd50609713078@google.com>
Subject: Re: [syzbot] test general protection fault in ptp_ioctl
From:   syzbot <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: test general protection fault in ptp_ioctl
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4652b8e4f3ff
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..27c1ef493617 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
