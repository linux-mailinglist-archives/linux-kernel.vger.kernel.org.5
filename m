Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D9753FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbjGNQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjGNQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:12:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D94205;
        Fri, 14 Jul 2023 09:12:16 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-345ff33d286so9113405ab.3;
        Fri, 14 Jul 2023 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689351135; x=1691943135;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrsfyCDc362ZOk8G+hdDknV8vcvoZotbrYN7+icfWWY=;
        b=FCmnXuSUbF8wFvPrwEnZHb4ia/jzuQmRgaJ9fY8TwgCL/WJG1/CAJTVfb4eCsP6gJR
         EWgGxoCBECYoOUWegn8sHEvITYqRXT8A6KV1tm9o/aDxiWeXqmC/YDgUCM6n2oLNEls5
         IN6ZQCgbpZrRQEpgFwg5U8JRJ17DsPaWYRVKTgQF2TJj2axZgzimG5vik572MRMhWNOh
         +cI7i/nguAeJ5hS2MGFKYXJUcRKEIKDHu7AYPUF+JNKghWNZtS2FjfLh7QEMapigX3Uq
         pZnOI9cPCUH23+HESzV5Wila1ZWfbLJu1Ywzdf8OwMfuFcGdN7J6TosbuAatTHoYqWbW
         j/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351135; x=1691943135;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrsfyCDc362ZOk8G+hdDknV8vcvoZotbrYN7+icfWWY=;
        b=GAGcN7S8/2+qmhJXijeY/VRgoOkTARI0bUSnbjBULh9jKmd9T84bFZ4Od176n3oxSo
         6faIUNBe9e6eEz6wFPXOfgL00SbaiGpyUBk8yVMq/Mf1u9xv6VhkkNKv2Vb95kcLd7uo
         P/YTKCsF92Lo/ZhZsXdsOLowYjyoK6gO9EAywxXqgYAzXNGdSEV1BmqMsLk4D5/1QcRC
         A2hPN1EtIcztE3UAVe4EXuHSEXZ14g2tpIRHtQHQWupXQvUViZoYEfX3WSacJLlJ0t9r
         +bMQoWTHCoz0ARHX5Rt0ZySVvMGZDomPxXqjOijLL6ujBknsHL/UJqL82DttyWN81ttO
         4yRg==
X-Gm-Message-State: ABy/qLa578J/Sxujz9vGhpHENh6jSAbxG7JVNof6h74euWuzHr9eqGzq
        McW0gKgxBy6CRVwj/aClEDw=
X-Google-Smtp-Source: APBJJlH5jagiDNkXCVSrljA6SjEIaEZjgdkN8qamT5K28UX9hB31eN8e4pvLUp37Dx4USUqH6s6ZLA==
X-Received: by 2002:a05:6e02:4ca:b0:346:77f5:87ee with SMTP id f10-20020a056e0204ca00b0034677f587eemr4259186ils.11.1689351135459;
        Fri, 14 Jul 2023 09:12:15 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a598b00b002657aa777f1sm1263050pji.19.2023.07.14.09.12.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 09:12:15 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH] Bluetooth: hci_event: Ignore NULL link key
Date:   Sat, 15 Jul 2023 00:12:10 +0800
Message-Id: <20230714161210.20969-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is used to relieve CVE-2020-26555. The description of the
CVE:

Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
1.0B through 5.2 may permit an unauthenticated nearby device to spoof
the BD_ADDR of the peer device to complete pairing without knowledge
of the PIN. [1]

The detail of this attack is in IEEE paper:
BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
[2]

It's a reflection attack. Base on the paper, attacker can induce the
attacked target to generate null link key (zero key) without PIN code.

We can ignore null link key in the handler of "Link Key Notification
event" to relieve the attack. A similar implementation also shows in
btstack project. [3]

Closes: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Closes: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Closes: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 95816a938cea..e81b8d6c13ba 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 	bool persistent;
 	u8 pin_len = 0;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		BT_DBG("Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
+		return;
+	}
+
 	bt_dev_dbg(hdev, "");
 
 	hci_dev_lock(hdev);
-- 
2.35.3

