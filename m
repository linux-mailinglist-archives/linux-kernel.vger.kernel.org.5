Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4287EFD66
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjKRDZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKRDZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:25:41 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC52D6D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:25:38 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-280051630e5so3707889a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700277937; x=1700882737;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lJX9VLiMTARWq1arcsjI+i8RGb+ECKhQ48xSI7yj58=;
        b=UOYTc+BiRr9yo0O9AMc0caXzChjErG4qrAUufgHXQgj+4Ds2Ihre+HfxDYZmuscNFy
         GGA1NW0OLzDJBGDKzev9XmNOkQDKL4i95Ux7/WOIu96Gwapob+eRPW4wKg405Ipf7/E5
         Ix0fkDTnnji1wItxrSOmOB7QsdC6zzZ3NJEmDdSFOXAgEAdtHDebs3aZmz11U28jX6mw
         3fdcrkGl5Y9xHjJj3ye9ENce1eiwpwmkJ/IN/towcYWdr9ljSSi8yv5HYt/HS3WPJ+98
         cNZnpU+qWGwbZCtE1hUzBPa93OePeHtIswG8QsfrTu4X9kZq3eFeYiSLdqeyKkfNWpYE
         o9+Q==
X-Gm-Message-State: AOJu0YyPwAtxfgAwI947tqgzspDfxonSnlntsDZgIWx2nIVIL/uTQ9j6
        FDMNLyaV7StLefqR8PEp+UR12zGxyMo+jlu/14Ec6wrYDFlmdgE=
X-Google-Smtp-Source: AGHT+IHQLqOgPZO89knosW29YE1pbTA1/OdsmOMa1h1nywxdvcU1BVv8mRsPPCREJ/47sbvrW/yaRx6cuoQnMXfLuV84VRfOIUpp
MIME-Version: 1.0
X-Received: by 2002:a17:90a:65cb:b0:280:80ff:1c86 with SMTP id
 i11-20020a17090a65cb00b0028080ff1c86mr353175pjs.4.1700277937836; Fri, 17 Nov
 2023 19:25:37 -0800 (PST)
Date:   Fri, 17 Nov 2023 19:25:37 -0800
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000811884060a64cec2@google.com>
Subject: Re: [syzbot] [PATCH] Test uaf in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
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

Subject: [PATCH] Test uaf in sco_sock_timeout
Author: eadavis@qq.com

please test 8de1e7afcc1c

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8de1e7afcc1c

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c736186aba26..c05fb9d41a63 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -300,7 +300,8 @@ static int sco_connect(struct sock *sk)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	if (err)
+		hci_dev_put(hdev);
 	return err;
 }
 

