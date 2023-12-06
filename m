Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD1806916
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376792AbjLFIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:07:45 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFB18D;
        Wed,  6 Dec 2023 00:07:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so48401811fa.1;
        Wed, 06 Dec 2023 00:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701850068; x=1702454868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z31u/YAwA2e8+zwxuhgrUXJzmhr+xuMP2ChU2OO8dhA=;
        b=PnxVg1caMOw4zXBcnDl1dU/sdygVavZP8b4WR7QnjxvzsDNVNlwKEvbs8sGTAUs6hn
         CehTkO66kbAf0oxEorJGLwtd9WhoEWtENR9ZjdT3Ll0JBAWww4riO7SZfcrz2IA+7AB6
         HPaegrgy7kyQsBJ9pDXPzPVeb6B9s2mGGr/IByzyj0ir21lwcb7YhFmQw7uIFKxXitl4
         NW5eN2WUjBMNDnmVtMs1tgt8Qn1C5t7KQgAJNqa8hnB50gYFdkSBrczXkbPvA5oB7QrF
         Q9yZq9pRoyEr1jZZj1QwY7rEdnpKQJcf9p7Cz0ncbF5v/iqB2RES1LW0jrCxAsTSt9cL
         BHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850068; x=1702454868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z31u/YAwA2e8+zwxuhgrUXJzmhr+xuMP2ChU2OO8dhA=;
        b=ciS/OqN3LJQ1/h56ZyRNl1fgL0ZAAlsAj97O/4Dr94G6vxaHVTL8l9D1j5u0/SzX1x
         JznuyUiaIKT+3tGIR735IrCZgsnAJeVgaA8Nq6k7LGEwgdffEC1khqPHKUc/0JaJ1EIU
         ZvpFzxj2UAsnp0QGda+hXFP8Ty0F/76jmdENtp/qLktl9xPKmtiCQ9FxQfImWvObfogP
         HUyXklxL387y/fr1XR5sqUh9/sJJ7dvbBamFL4memMhF8SsAoyS2GsgVCh+EL2jsgBJE
         zlC4A8pjkV5mwZr1W/9s4LyAX84H5oqpu72Bl2aEIySjEpVKJcAtBV5AUv4Hv/6Fe4aO
         Nsug==
X-Gm-Message-State: AOJu0YxcDIvRzXXo8PDBUjkwlFZrGpvy1NU4ikj0M5JMKZO2/fb0pTcJ
        jU28kf1OY4jpW7ejDbTZUQw=
X-Google-Smtp-Source: AGHT+IF/kC4mns+8tjDe++tE5Xua77SOCurAapwIltaBOGl25TWJuiAc/vmWPoYjou8D6GEx2Wbapw==
X-Received: by 2002:a2e:2e09:0:b0:2c9:f560:4a5a with SMTP id u9-20020a2e2e09000000b002c9f5604a5amr261989lju.17.1701850067587;
        Wed, 06 Dec 2023 00:07:47 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id w3-20020a05651c118300b002ca044c17d0sm864780ljo.62.2023.12.06.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:07:47 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     gregkh@linuxfoundation.org, benjamin.tissoires@redhat.com,
        aladyshev22@gmail.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@keeping.me.uk, lee@kernel.org
Subject: [PATCH v2 0/1] usb: gadget: f_hid: fix report descriptor allocation
Date:   Wed,  6 Dec 2023 11:07:43 +0300
Message-Id: <20231206080744.253-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit "usb: gadget: f_hid: fix f_hidg lifetime vs cdev"
(89ff3dfac604614287ad5aad9370c3f984ea3f4b) has introduced a bug
that leads to hid device corruption after the replug operation.

The usb gadget driver bug was observed in the KVM functionality of the
OpenBMC distribution. In the test environment BMC provides KVM
functionality for the host (i.e. virtual USB keyboard) via the USB
gadget device.

The bug occurs when the KVM page is refreshed (i.e. USB device is
replugged).

Before the 89ff3dfac6 this opeartion was working without any issues.
Log messages from the host for this operation:
```
kernel: usb 1-7.4: USB disconnect, device number 3
kernel: usb 1-7.4: new high-speedUSB device number 4 using xhci_hcd
kernel: usb 1-7.4: New USB device found, idVendor=1d6b, idProduct=0104,
  bcdDevice= 1.00
kernel: usb 1-7.4: New USB device strings: Mfr=1, Produt=2, SerialNumber=3
kernel: usb 1-7.4: Product: Virtual Keyboard and Mouse
kernel: usb 1-7.4: Manufacturer: OpenBMC
kernel: usb 1-7.4: SerialNumber: OBMC0001
kernel: input: OpenBMC Virtual Keyboard and Mouse as /devices/pci0000:
  00/0000:00:140/usb1/1-7/1-7.4/1-7.4:1.0/0003:1D6B:0104.0003/input/input3
kernel: hid-generic 0003:1D6B:0104.0003: inputhidraw0: USB HID v1.01
  Keyboard [OpenBMC Virtual Keyboard and Mouse] on usb-0000:00:14.0-7.4/input0
kernel: input: OpenBMC Virtual Keyboard and Mouse as /devices/pci0000:
  00/0000:00:14.0/sb1/1-7/1-7.4/1-7.4:1.1/0003:1D6B:0104.0004/input/input4
kernel: hid-generic 0003:1D6B:0104.0004: input,hidraw1: USB HID v1.01
  Mouse [OpenBMC Virtual Keyboard and Mouse] on usb-0000:00:14.0-7.4/input1
```

After the 89ff3dfac6 the KVM page refresh (i.e. USB device replug) results
to the USB device corruction and the following messages from the driver:
```
kernel: usb 1-7.4: USB disconnect, device number 3
hid-generic 0003:1D6B:0104.0003: item fetching failed at offset 18/63
hid-generic 0003:1D6B:01040004: item fetching failed at offset 32/76
kernel: usb 1-7.4: new high-speed USB device number 4 using xhci_hcd
kernel: usb 1-7.4: New USB device found, idVendor=1d6b, idProduct=0104,
  bcdDevice= 1.00
kernel: usb 1-7.4:New USB device strings: Mfr=1, Product=2, SerialNumber=3
kernel: usb 1-7.4: Product: Virual Keyboard and Mouse
kernel: usb 1-7.4: Manufacturer: OpenBMC
kernel: usb 1-7.4: SerialNumber: OBMC0001
kernel: id-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item ag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: item fetching failed at offset 18/63
kernel: hid-eneric: probe of 0003:1D6B:0104.0003 failed with error -22
kernel: hid-generic 0003:1D6B:0104.0004: item fetching failed at offset 32/76
kernel hid-generic: probe of 0003:1D6B:0104.0004 failed with error -22
```

Reverse device managed memory allocation for the report descriptor
to fix the issue.


Changes v1 -> v2:
- update commit message


Konstantin Aladyshev (1):
  usb: gadget: f_hid: fix report descriptor allocation

 drivers/usb/gadget/function/f_hid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

