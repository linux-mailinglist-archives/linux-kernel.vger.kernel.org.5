Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB267B8386
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjJDP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjJDOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:36:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666EFC;
        Wed,  4 Oct 2023 07:36:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9adb9fa7200so229440266b.0;
        Wed, 04 Oct 2023 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696430181; x=1697034981; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2xO8oSkiTINirvXxwWkAua5IlzQF1Y8ARzBIAy73jk=;
        b=DDZtja2xBasFS6hx3Hkt4NkupZGUX2h2PXoqwBYGfwhqvZBt6mQjzF77E44ym8COBj
         ZVRiL/iJVKz2VLXFQoKIejeLszAp3WqTqg2tj/inubtrxnHIKR/S1tPuT0ZqNAHFRNwD
         Ft8oGS8oJTvppsame8RL1GZQovX9bYgxvrr5KVjktHO5ITTBBJHo096Ttu/DiyhIp9oh
         dd4RGd4YR4/z0pC3KADMsM/N8tyLwdY0A+KsF+jvlASsAnzCdCyI2MKPDE4cOEfIWp9e
         LAMDYWuMsm1V97nMTpBAFdUs/6UV85ONw92Wj4Wcas2OvcMzbSFoQXa9c1JFR9ty9NJI
         ypkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430181; x=1697034981;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2xO8oSkiTINirvXxwWkAua5IlzQF1Y8ARzBIAy73jk=;
        b=Ycd2MwrsoXWEOJ6Gm/Hbc27oA8k9h3uRgV7l1WNb/66NEwByaqodPFW/ZZGi8C//Ay
         UMMzUOULjpMhhI1lK1fNymy/xFFa8H02glGM08g3LO9kgp6SYUdw3FVQ8KFD9aRn16DZ
         XErxk5+ncwVzJHeHDbyAVSBD8YrF+VfyAlbz8z3JhBNhjkX2mg5BFD4DCu5SozsRtGVQ
         ZhT1WBiyKlzhB0QdG/0IoMuwqPdlPDp/FmAvxPFiGhOQVX3mTRs7Q+CR6MermqK54ztJ
         bntruhfewnwvuDAFXEmB0TuzaeAJ97SyT/+ORit4OJgoWRaonkqrEEF5FltAaMKEk5RI
         G8pQ==
X-Gm-Message-State: AOJu0YzMPIOrdi3a7S5CH7wa9lRb/MIZIo35qAOUF+kYB1myis9ZZKMt
        ETYCbBv9i1YtE9d5dpiz2tz6qIRcsxpuj85A
X-Google-Smtp-Source: AGHT+IFvbDrbLp4CccTj4zkPFLxswJqCwgPJN52auTS/VhhLVZqfvNN7GTEECUg8Tg6luR7GN3diKg==
X-Received: by 2002:a17:907:7614:b0:9b8:9217:73f5 with SMTP id jx20-20020a170907761400b009b8921773f5mr1798052ejc.32.1696430181067;
        Wed, 04 Oct 2023 07:36:21 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id i12-20020a1709063c4c00b0099275c59bc9sm2953457ejg.33.2023.10.04.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:36:20 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 04 Oct 2023 16:36:13 +0200
Subject: [PATCH v3] Input: powermate - fix use-after-free in
 powermate_config_complete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-topic-powermate_use_after_free-v3-1-64412b81a7a2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFx4HWUC/5XOQQ+CIBwF8K/SOEcDVIxOfY/WHNIfZVNwgFRzf
 vfQU8c6vnf4vbegAN5AQJfDgjwkE4yzORTHA1K9tB1g88gZMcIKIijH0U1G4ck9wY8yQjMHaKS
 O4BvtAbCqSaFqwYUSFGWklQFw66VVfWbsPAy5nDxo89pXb/ecexOi8+/9RKJb+/NeophiprUsO
 a/YmYtrN0oznJQb0UYn9h/HMleRSpeCUKGZ/ubWdf0AVzaLrDABAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696430180; l=1827;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=KPYYPZGtfceRNSYjVeOZBv0bkIvjfUqnR91rZxcVaTk=;
 b=+L2yMUuZpEXC7YMXYT0MpTphou8mVyRdYec1yWPYQ2jUCy+XMpkPM5bV1EEsXlkxCyJthhH0F
 mBz5w8UDHhCCXHyB59lTA1QNjdLzMiEnQ87HTWLyu3UrOfiQsRRXjOw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a use-after-free bug [1] in the powermate driver. This
happens when the device is disconnected, which leads to a memory free
from the powermate_device struct.
When an asynchronous control message completes after the kfree and its
callback is invoked, the lock does not exist anymore and hence the bug.

Use usb_kill_urb() on pm->config to cancel any in-progress requests upon
device disconnection.

[1] https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
---
Changes in v3:
- Let usb_kill_urb on pm->irq where it is i.e. before unregistering the
  device.
- Link to v2: https://lore.kernel.org/r/20230916-topic-powermate_use_after_free-v2-1-505f49019f2f@gmail.com

Changes in v2:
- Use usb_kill_urb() on pm->config upon device disconnection.
- Link to v1: https://lore.kernel.org/r/20230916-topic-powermate_use_after_free-v1-1-2ffa46652869@gmail.com
---
 drivers/input/misc/powermate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c1c733a9cb89..db2ba89adaef 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -425,6 +425,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);

---
base-commit: cefc06e4de1477dbdc3cb2a91d4b1873b7797a5c
change-id: 20230916-topic-powermate_use_after_free-c703c7969c91

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

