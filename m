Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356818132D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573424AbjLNOS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjLNOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:18:27 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1409C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:18:34 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cef51efdb6so787108b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563514; x=1703168314;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYmHvjaMcnOxaQfPI0jt2Vd4L/LtrS8+UpyNZqvEuik=;
        b=mpHmVesq0roO8YdbWjNUu51LFY64zAekJ0fKxrr7HnxOkvVKe8/wWo5syQO9NgFP/1
         7jEJFcnP08WppIHxrjv9ChAcMq8jPr22BXDYAJKK04H9EzACYciaHDF8Dt/KOwXRZFM3
         hJHnK2p9ur6d87Yzet1EuLpEfpsJB5d0f3VTjLtn9ZqBp4T2FfJNN4hdJxj1hnBnZvsA
         uqvGuR8Si0o0Xh9mdJL6YsePWEvSP0hSjreVQu6Npf3HFUW+QCgURqXVr4/99jDqNtzg
         2zivOQX3FsiE9AwDsb3Av4wdX8zWVWqPSMu2+dzIBvzty17Tnux6Ora+Y/GlIWpITECm
         9e5g==
X-Gm-Message-State: AOJu0Yz1oZr9DuGpitqsJDzd8XyBjj45Q1X/Uf6yD5R3qs6jCISirleM
        S0b4fX2AektH63OEkThkPQr61guiAQLG2pdxyfT4Ssx5D7sR5Ko=
X-Google-Smtp-Source: AGHT+IGkB8BNYcgpnS9NxnuXj0Wk1Yq69Y2zABTfKU51MLGGBp2U6Yo1FOXoVaM18Q3DmKMxTM42MIC57SZibtnlpasInsyx8eBP
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:c81:b0:6c6:9f26:3a00 with SMTP id
 a1-20020a056a000c8100b006c69f263a00mr1669008pfv.2.1702563513996; Thu, 14 Dec
 2023 06:18:33 -0800 (PST)
Date:   Thu, 14 Dec 2023 06:18:33 -0800
In-Reply-To: <0000000000009b39bc060c73e209@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000759c2d060c78f55b@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From:   syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
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

Subject: [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
Author: eadavis@qq.com

please test slab-out-of-bounds Read in dns_resolver_preparse

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 48e8992e33ab
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 3233f4f25fed..15f19521021c 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 
 	if (data[0] == 0) {
 		/* It may be a server list. */
-		if (datalen <= sizeof(*bin))
+		if (datalen <= sizeof(*v1))
 			return -EINVAL;
 
 		bin = (const struct dns_payload_header *)data;

