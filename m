Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6F7C5927
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjJKQbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjJKQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:31:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3EC9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:31:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6969b391791so5071817b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697041908; x=1697646708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+MMx8yPQF+8HcCzQjqdZnLD/WD4YyZebT9qiOBQ8gg=;
        b=DCUCJVOdtsgwD+XFhC5rjJ/2yawUhJ8I5aWSZ6N3+cycUsL4ZQ1aepWAD2auyjLJtc
         qKsk5so7IzN4YKc60U4rymWANux/juBb6BaXT48VrREVDF48kBE96UtkwQYbMK8CL5jl
         Fn4fRposp6Baiw5I8+nkphoqXKV36pR551Izk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041908; x=1697646708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+MMx8yPQF+8HcCzQjqdZnLD/WD4YyZebT9qiOBQ8gg=;
        b=q7eAPvPAClhYSG6gLg72P2HFPH7JiuMMBAcZkH+pFyL9DWtHfpuNyvUjh5XauSLakF
         bAfaLjWBKtjXBFO28O8SdE99JgORhlP0AU2znmchkB+WYDPBSh67kNpSkOoEhyQhK/n/
         JwIqL1s/U+11rNPzK7LUzfJCKrr94kQjWXS9DXduNdF37GjIoEcyAS+tTaAOiaYNVjEK
         688kIYlb2rqxFsoFZKslvT68LFqW7J2+7apu8s+CCMrrg81rR5HHJzX1xQ9skowM7FB+
         Yp4ftI9uQZdnJg+4uNLKyyWha3vsGRYgOpNYYAhOTsDwAiY+h140Um0PpamyskymgNw+
         rC1g==
X-Gm-Message-State: AOJu0YxSOapb/41lyhLNGBwWmcvEmQ7VFriL1n7KiB2+2rhvX8K+b18R
        0z6WpTMoexqGMlOzUUpr9cALHw==
X-Google-Smtp-Source: AGHT+IES01ZbXdY6aRhuBKS26Q5mlzP46k5cW0I7syaN7Gn4A+8DmL/xUNf667TCEWUfCACCDgb8xQ==
X-Received: by 2002:a05:6a20:dd9a:b0:167:af7d:9e8c with SMTP id kw26-20020a056a20dd9a00b00167af7d9e8cmr14523020pzb.56.1697041908446;
        Wed, 11 Oct 2023 09:31:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a656a84000000b00563df2ba23bsm66090pgu.50.2023.10.11.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:31:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, Edward AD <twuufnxlz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name
Date:   Wed, 11 Oct 2023 09:31:44 -0700
Message-Id: <20231011163140.work.317-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=keescook@chromium.org;
 h=from:subject:message-id; bh=on0TcWQI6be5JbFS4MvZB6HiilmbXCZNq0hVdsTZcTA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlJs3wuHKC8tFUYtd66UFMEWlaF6VGRB0wyy4r4
 v0kXJ9+LcuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSbN8AAKCRCJcvTf3G3A
 JuqXD/9HcIT6Ydof+BGGggd18PoUB8YhhWaiA8oKdvxkbk3Iumw5829rLzHYLeXZFlNYjAGHJ4w
 YGdSNyjF2lzjbJFZ6wLTuVN7zy0aK9MeyNiT1ch8f3EewDWqA9+P19sq4aSINnJ6L4IIysOPL1J
 Tp7pmoKzWngdKXAXARarmZ0G05FOIyyhnkmJXRuEyiv58jcsvLZTfcpuwJ1gUcJsiK+LFwLgRih
 1JpDT7C2MQTzrLf9gzsEeFabAQwczaq5l6Kf2BTerw5trq03upcF6Vme6OAlyTCjwUxnxzpS1c1
 ofPNtp18esK1fHIrptpkuEyx2jngkEHn/MQwZ9WlhNC2UtiDgPgDlTLuCW65uA38lNzJHW16fcp
 tISkBl6vPUkmux1FOIDab1LKa149zIZRVPjYg6oDpKSQP3e5rdBTHyEU40aNRJe90uEaOUOOqZQ
 m50d99pztGFeDJ7Pfdz1jKBI76dDKJXjg7wzHNYe8vlmFyjDnV5oMWaIa2Or2ZU3qGQfeQkQhI+
 Cj6oI87eX2uaqqzAb1UO/Cb55BVerNIIbDTHnNGljfQ2rihIKChwA3SIfrwkrukcwGcVtVo7JF2
 mWProGQLXUAVvM/+G0FSQlt99cKkJryGbF5/5KbqNpaORdEcOuQIqt//SPEQFLcVRbuJSAY5dJ5
 d25ys4e FE7RuudQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code pattern of memcpy(dst, src, strlen(src)) is almost always
wrong. In this case it is wrong because it leaves memory uninitialized
if it is less than sizeof(ni->name), and overflows ni->name when longer.

Normally strtomem_pad() could be used here, but since ni->name is a
trailing array in struct hci_mon_new_index, compilers that don't support
-fstrict-flex-arrays=3 can't tell how large this array is via
__builtin_object_size(). Instead, open-code the helper and use sizeof()
since it will work correctly.

Additionally mark ni->name as __nonstring since it appears to not be a
%NUL terminated C string.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Edward AD <twuufnxlz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: 78480de55a96 ("Bluetooth: hci_sock: fix slab oob read in create_monitor_event")
Link: https://lore.kernel.org/lkml/202310110908.F2639D3276@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/bluetooth/hci_mon.h | 2 +-
 net/bluetooth/hci_sock.c        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 2d5fcda1bcd0..082f89531b88 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -56,7 +56,7 @@ struct hci_mon_new_index {
 	__u8		type;
 	__u8		bus;
 	bdaddr_t	bdaddr;
-	char		name[8];
+	char		name[8] __nonstring;
 } __packed;
 #define HCI_MON_NEW_INDEX_SIZE 16
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 72abe54c45dd..3e7cd330d731 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -488,7 +488,8 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, strlen(hdev->name));
+		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
+			       strnlen(hdev->name, sizeof(ni->name)), '\0');
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;
-- 
2.34.1

