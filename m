Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3717707AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjHDSPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHDSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:15:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE9246B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:15:00 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bba5563cd6so20398715ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691172900; x=1691777700;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q94YQ4m1RpOBVpV4Urmwt7uotZ6ulzRcLdnk/RmjocY=;
        b=AD2TjdoEwlefwUOHQKQjw/Mm0dTddNRQog3MtraqMm8W5fOsA/Ro6RIVPQjT41cfhF
         Kqyp/QGi8ZpJDfnyOx6EgmHwef6nAUKROFLKpLSeScyxmQ1zYQ8noik4gZp9lQ/ZHA1d
         /cGLtVdTJjYX3A91bUED6oWmn4pFcL0AXUeZDVLHfN7ZI5T/ziK0VynV/KwEyc/oThdS
         qyGB9hg6w0fK0ozd8R2fkIguhfDIXM2ProuMvH5K/fIRSfpJQ0Z47GVTTKKoy+DzAm9I
         Xwsy4Pz0NPwitGcIFhKU8DjaErzna35PzVqce3OKluwTuG3PY6ntCgmXM9qGx7XsVRQW
         J65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691172900; x=1691777700;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q94YQ4m1RpOBVpV4Urmwt7uotZ6ulzRcLdnk/RmjocY=;
        b=I2eLyWLO26kD7QafutFH/5T2xk0MZ/6wVPxnHb/YSTirdOnASMoxFusrRa55XlGb0K
         Qfg8rzxkFGcNZ/DZqgLcCdJGrB3edbp2wLNdJ8tvtGgzBCgryWM/53v9gkouBQdE9mtA
         hYE0rWRAp+ThrdgD9oa2CTL7CRYUqTsWkYkeZO/JNV4WFc/vrB9CLi3WMhnAWk+1U0sO
         IsRKxWbzUctxq1CNmcECHRRY3kXbB74Fpt00pp47gF9MyXPq9nt4Ak1R2kGJ5XYGX3CH
         AwcNEPM1hS+shuYl9z6ENfkFuU4HXkxssUS8j8V6gii8UWoy/PcLSgjsEaEdz09x6rJn
         xUcQ==
X-Gm-Message-State: AOJu0YwI3Foeg4YazUEQNEEGY966REqffkoAH53udx21C2w6cAFVC1cY
        Vc+y7815dJnxzyLnEZpeGuJ0RdlGWHH5gw==
X-Google-Smtp-Source: AGHT+IHkeK5Q/jMj7Q856dMfXGQooFLTZ1+1VGCU93/IM837o50AwZVXc07p6Gmbly7RwnsLTUN8GTMsmQioRA==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:903:41c8:b0:1bb:1ffd:5cc8 with SMTP
 id u8-20020a17090341c800b001bb1ffd5cc8mr8698ple.11.1691172899750; Fri, 04 Aug
 2023 11:14:59 -0700 (PDT)
Date:   Fri,  4 Aug 2023 11:14:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804111444.1.I43aa4bd799a3cf9102f9de8c365ccb3d8e53a9d1@changeid>
Subject: [PATCH] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KSAN reports use-after-free in hci_add_adv_monitor().

While adding an adv monitor,
    hci_add_adv_monitor() calls ->
    msft_add_monitor_pattern() calls ->
    msft_add_monitor_sync() calls ->
    msft_le_monitor_advertisement_cb() calls in an error case ->
    hci_free_adv_monitor() which frees the *moniter.

This is referenced by bt_dev_dbg() in hci_add_adv_monitor().

Fix the bt_dev_dbg() by using handle instead of monitor->handle.

Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0fefa6788911..c602cfb5be9e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1957,7 +1957,7 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	case HCI_ADV_MONITOR_EXT_MSFT:
 		status = msft_add_monitor_pattern(hdev, monitor);
 		bt_dev_dbg(hdev, "add monitor %d msft status %d",
-			   monitor->handle, status);
+			   handle, status);
 		break;
 	}
 
-- 
2.41.0.585.gd2178a4bd4-goog

