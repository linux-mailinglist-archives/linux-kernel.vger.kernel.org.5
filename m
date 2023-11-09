Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3ED7E6C46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjKIOOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjKIOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:14:21 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5630CF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:14:19 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5bdfc1bb3eeso714468a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 06:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699539258; x=1700144058;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGxZUmDES9n3X08rI95PJwaqLOOiIQfcnvepBDUCyIM=;
        b=d6mgSe5C5NqlGHJ039IGDnJJRGFAG0OBQH5IHvUMEvLFuw+F9UXVSgMFqCEE/eYyYF
         8IJ33QcvV5ewjvY45q0hodZAqw6vf+bAypCxI+SXI9eZfM4hTbJKy3ftwTfjtzam/Cb9
         oeMaIqrJtPESHvn5Y0lxK+Ei3F7J/bdkE3IOrd2OqwK6KgWJVhGJHVTkTiNublDKHAyw
         4QLQh3hVzSumyRUGLOEo3j6ebJA+7fMRsFj3AtpPyj5IwWhPVdOjQOsJG9GSRUVz+CJd
         bsTPml8MrUEs0BJoR3IkS5Jp4Cw0eAkwUJAahVX21+QWc+AL2wH0QrXK1gCebR3b1NkL
         vAHg==
X-Gm-Message-State: AOJu0YzG5YQxMKVNTTDf6l8gjnZdjnX/Ok4seXiWD3l/RKGaVeAqUHP5
        8HMyP+2ePzQ0lQhvt1MI03JSvueMqg0tYYJmfPOee5gf53AfzE8=
X-Google-Smtp-Source: AGHT+IGzS4mpnKB+kb2IfoWi5pUb8E5TX2DW+5mztWXLICgSQyhW/khn1lXhjQP0hOnOGAaU1B+7X0AN2NrvDV7HHRfDSiHgpW2i
MIME-Version: 1.0
X-Received: by 2002:a17:90a:3886:b0:27d:3322:68aa with SMTP id
 x6-20020a17090a388600b0027d332268aamr405570pjb.2.1699539258482; Thu, 09 Nov
 2023 06:14:18 -0800 (PST)
Date:   Thu, 09 Nov 2023 06:14:18 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8a6920609b8d135@google.com>
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
index 1dac28136e6a..4959163d8dc5 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -113,6 +113,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		bh_unlock_sock(sk);
 
 		sk_del_node_init(sk);
+		llcp_sock->local = NULL;
 	}
 
 	write_unlock(&local->sockets.lock);
-- 
2.25.1

