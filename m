Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AE7B09B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjI0QOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0QOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:14:18 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258BC92;
        Wed, 27 Sep 2023 09:14:17 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57b72cef02bso4948917eaf.2;
        Wed, 27 Sep 2023 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695831256; x=1696436056; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPVMsO4dy15tYkSfR0MZiY/PHHrdbRR00gTtlnDNepY=;
        b=BLDwpMklol1jmIEJYT3ruSqqGAa2vVtSGfCSvp7zH2t3hqDiixv9qQyEYthiUolVrF
         PLHHrxpPYZ9z87w7AI7aTXnCvQw4GF0x1wwT4HTNZM1suJYNZa2HIVgHGjOcxiBOVABF
         4ttICcE+zwrR1uemsjyn3GPlBs+kH0NN/FmdbDFOvrubJ6vZhR6rpv1VMETOqf2f4isb
         eZQWtX2cx+i2YvdGaEm/M5VOg1qh/fU/IbhtoPSziP200AaftE70ymMsEd+rKp6ECXe4
         wESal9+rLf20Tk+e05qtrUMArxG+XUjcDBZb5SBbufQCrxBXswuWW7xIaHPBldt71NLK
         UKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695831256; x=1696436056;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPVMsO4dy15tYkSfR0MZiY/PHHrdbRR00gTtlnDNepY=;
        b=GSroGbGjmYtmnUzIiUtjUJaSjN5HY/+uoZVHjRHtZlRAcsKZz8OlSD4EDrAbaX9NHL
         1O4cUD0Pj5G/BQIAg8z78cRpZw1voOUZR6XKKSjBRrWKG2At7LabSLufDVjkiAcPwF16
         wBS6Reggu56n0Q+IMqwFJIs4iewwHHz/MXFcg6nCyRl2A3+AqlZojIPETi+cBI0jSXdu
         NrwNxh12zVWpAlVCUBIShOl8IDTyiqias22weVRbOP5MVX7y7EVkG7uIw4D+qHLKXfDg
         5HwmVOOohtEwN+wnv8M3FZXuhi2W0kZZPZKT6JBMaqfUwCXD3Ov9S9R0M7ypnEMotX7r
         E4CQ==
X-Gm-Message-State: AOJu0YyzPbmZ5797RZWTQwo5NvF8MQ5gfo6F6k+p+m1+bBjxZ1Fluh7r
        BJXS0oRkR727ypsiUmCRlNs=
X-Google-Smtp-Source: AGHT+IERYckSTdynsb5Q47O6bCj46USZVHNjVEuDCfUetctnSSqA3z3HZFtreeJt9toHG6UE3v5A5g==
X-Received: by 2002:a05:6358:5e0a:b0:140:f6ab:b11e with SMTP id q10-20020a0563585e0a00b00140f6abb11emr2544687rwn.28.1695831256011;
        Wed, 27 Sep 2023 09:14:16 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id e24-20020a62aa18000000b0068fbaea118esm11951040pff.45.2023.09.27.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:14:15 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] Bluetooth: hci_core: fix potential deadlock on &hci_dev_list_lock
Date:   Wed, 27 Sep 2023 16:13:58 +0000
Message-Id: <20230927161358.32353-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&hci_dev_list_lock is acquired under a2mp_chan_recv_cb(), which I
think should be a softirq context cb. So it seems that the
write_lock() on &hci_dev_list_lock should at least disable bh.
hci_register_dev() and hci_unregister_dev() are exactly that two
functions acquire &hci_dev_list_lock with write_lock(), and should
be called under process context without disable bh at most case.

Note that I am not sure whether this could happen at real, as I
am not sure whether the rx callback could be invoked during
register() and unregister().

<deadlock #1>
hci_register_dev()
--> write_lock(&hci_dev_list_lock)
<interrupt>
   --> a2mp_chan_recv_cb()
   --> a2mp_discover_req()
   --> read_lock(&hci_dev_list_lock)

<deadlock #2>
hci_unregister_dev()
--> write_lock(&hci_dev_list_lock)
<interrupt>
   --> a2mp_chan_recv_cb()
   --> a2mp_discover_req()
   --> read_lock(&hci_dev_list_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential problem, I change to write_lock_bh().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/bluetooth/hci_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a5992f1b3c9b..dd3107daed03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2670,9 +2670,9 @@ int hci_register_dev(struct hci_dev *hdev)
 		hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 	}
 
-	write_lock(&hci_dev_list_lock);
+	write_lock_bh(&hci_dev_list_lock);
 	list_add(&hdev->list, &hci_dev_list);
-	write_unlock(&hci_dev_list_lock);
+	write_unlock_bh(&hci_dev_list_lock);
 
 	/* Devices that are marked for raw-only usage are unconfigured
 	 * and should not be included in normal operation.
@@ -2720,9 +2720,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
 	mutex_unlock(&hdev->unregister_lock);
 
-	write_lock(&hci_dev_list_lock);
+	write_lock_bh(&hci_dev_list_lock);
 	list_del(&hdev->list);
-	write_unlock(&hci_dev_list_lock);
+	write_unlock_bh(&hci_dev_list_lock);
 
 	cancel_work_sync(&hdev->power_on);
 
-- 
2.17.1

