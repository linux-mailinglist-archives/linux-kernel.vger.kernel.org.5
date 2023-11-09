Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CBD7E6B35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjKIN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:28:44 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E56D30CD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:28:42 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6bfd5856509so962239b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536522; x=1700141322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77d2zaEFmdh0l/LYyhH7KPBUajrsAXe7vasVXV9o2FU=;
        b=N1TH0qNrXZLh1JLavfXhPIrqW1ygrkveLODGS6p3lj3mbTT9guHIKc6zLOnUD+Fw3h
         aQeYoPKKX2W0zdBWValxRcgWaf/oh3ZpILPHadVy3SlBUw/Zc/bgIB2eoqaAuUo2k2N6
         QIjYyt2cq2r82W63gogizq1H65viRnZP2XQmM8v1zf85Hp3b2hpLOdYRg5CIKiUcZopD
         iA8fQ39cds7vY4eSX7FXIg47249/gz5Z6b2hVwFcrXLuN1cSl5Tu25y4ZjT5NnccVwAs
         byduBnWHsg++EKwhnoFsARfNpDonfaI4eAEKvjTFEvS0VvLU6DPfY3fW8RfNceLwGfmW
         fLNQ==
X-Gm-Message-State: AOJu0YyWCKpCwYqsGuEOj45zWDxzK0aW4sSLWvsw8xS+yngSzwtYXrtZ
        sMVgZWNnWO3G+wjaorggHhsTZ6dgff32l9B1L6nyouiQUj7OdyY=
X-Google-Smtp-Source: AGHT+IEJyvQy7iDOm3eg1hNS5GtpuSUzc8JAt65nSTivbz9uAQuTKFXjskRruBQJjXCFCn9k9Uoi7C8+arzBt9jPenSQZEqB9Uga
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:be1:b0:6bc:ff89:a30e with SMTP id
 x33-20020a056a000be100b006bcff89a30emr453111pfu.3.1699536521896; Thu, 09 Nov
 2023 05:28:41 -0800 (PST)
Date:   Thu, 09 Nov 2023 05:28:41 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abaaef0609b82e32@google.com>
Subject: Re: [syzbot] [PATCH] Test for aea6bf908d73
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test for aea6bf908d73
Author: eadavis@qq.com

please test uaf in nfc_alloc_send_skb

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git aea6bf908d73

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..016364890357 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1640,11 +1640,14 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 void nfc_llcp_unregister_device(struct nfc_dev *dev)
 {
 	struct nfc_llcp_local *local = nfc_llcp_remove_local(dev);
+	struct nfc_llcp_sock *nls;
 
 	if (local == NULL) {
 		pr_debug("No such device\n");
 		return;
 	}
+	nls = container_of(local, struct nfc_llcp_sock, local);
+	nls->local = NULL;
 
 	local_cleanup(local);
 

