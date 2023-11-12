Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60D87E8F52
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjKLJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:25:29 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64D30C2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:25:26 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-692c0c3bcc5so3045540b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699781126; x=1700385926;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CKo1lrAJSdSuKR8nMx16Hwevq5zOIJ4nqiKTioKzZg=;
        b=xIubslE67+CU3OIOVdJ/UtUec7k4R/+MHphM1jGIjb5XwPmqSzodJUxW2KrwuBdwNk
         TWEdT3TzWiEJytpjFi/I8y9x1CECEfrfrTIPUrC3v+t4Z1UPUF1R5I86/+6OtIGt0oW1
         0TmlIFTf2mvqghvNotFvY975bjjkugNvR45hu/jTk+RQHqDj/U2NAjbyZ2e4MEij1QjZ
         MzfHRTkdI/ume2p9Tym49M4CDW3niNvVDGvugW3t8t66IiY0ArG0xYfTFzYnKb6kq+Sn
         p+ZrY171zdxm+vvn9Ssu/NtpnWO+GaU3jMztpHWhIeyS5XFhGt9RXa8GjD244OE9TZNl
         pOVw==
X-Gm-Message-State: AOJu0YzgmOIdjk6eJ8j5lJE2hrDQoRepWTixNnXE3Jgq8Gh19ZgNOw3S
        Mo3zZ4GIFNJqrO8lbNdjfHbY0V2hihJLfY0I7ehboKq6j5wvv2c=
X-Google-Smtp-Source: AGHT+IH6Mb18TQG3Cz+02PpDCqdoC1y0wAUNIIGVZfpyQk429dJpiBmEBJHpMesHZb/F6oPVE8Yc5ktBJSZYPS7hEjqWqRYjJ6BB
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:8509:b0:690:d251:28b9 with SMTP id
 ha9-20020a056a00850900b00690d25128b9mr995909pfb.4.1699781126207; Sun, 12 Nov
 2023 01:25:26 -0800 (PST)
Date:   Sun, 12 Nov 2023 01:25:26 -0800
In-Reply-To: <0000000000003c31650609ecd824@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000393ea70609f122d7@google.com>
Subject: Re: [syzbot] [PATCH] Test memory leak in ovl_parse_param
From:   syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
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

Subject: [PATCH] Test memory leak in ovl_parse_param
Author: eadavis@qq.com

please test memory leak in ovl_parse_param

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 13d88ac54ddd

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index ddab9ea267d1..735ae0db404a 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -530,6 +530,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	return 0;
 
 out_put:
+	ctx->nr = nr;
 	ovl_reset_lowerdirs(ctx);
 
 out_err:

