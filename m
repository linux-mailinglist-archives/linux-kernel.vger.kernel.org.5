Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674BC7FA88A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjK0SFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjK0SE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:04:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC39191;
        Mon, 27 Nov 2023 10:05:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b40423df8so14757895e9.0;
        Mon, 27 Nov 2023 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701108302; x=1701713102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1934cSuFEZa/QpxYtbFsxsS+BH3mxuJt8bzAlPuOtYQ=;
        b=KHW0q2IX1EXM1WAGXUxB4FkXqAoY3C/cBZmSZGmFt98KA5hFH/UmzKEYV1E7O5O2lV
         7zyGWA4gO/YnwOyx/93EHlThZFglERFoOrdFOYblHEdquHQ9SVq20gRpXzqIjECHbykU
         xGnsXZDPhP560FIRxkw83LC3krL5rhf7/yHZZdbBXbW+P4mJG6diq5f8YE1Ds8X+BfCl
         ujA8FHj2eYq0Bke3vFb7sDgxM3Qz1vvrnEO8e6sQZMheWLeK6Cg9YQRoMWNrAondMg7Z
         RGieMWaUVJs/DADgtqYuEpOf7SLQKpt1o2xdG2En71ydOi5zzrvEtzCDU3IQYP/QVu18
         30/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108302; x=1701713102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1934cSuFEZa/QpxYtbFsxsS+BH3mxuJt8bzAlPuOtYQ=;
        b=E+tn9IlxuYGE8ae0mnRDepNfOP3iYtyluyfo91hiecsIItsTNqrPyT7BYV81GGWFD1
         SoJ9kpw58ac3iHvNXRwBedDs1t/qRCSlho1G89aBtyohjvBAgG6kbLaUkp4Tj7ifrEeE
         JlFzvg8vMg0LFvWRxAd+23NBroqLRj2J6F4Uuv3kzxQJql1QuziH/XklZd25EJt/mCzM
         eyGql0nyT6GCp737U4sVjtNyzRRN92ceh1ITYmSUn3UpVXoNyc//N75nCwDNgENxn5W1
         vMAHGpQyG3ngWZQz7NoRCHd83mbeEWWWE2Nr98a1110AGf/wXjFrHuZ/pfVtoQvToYyM
         aEQw==
X-Gm-Message-State: AOJu0Yzp1TB04hYl8RvtGaty43iS7kzC003m+usyucuYs0RW+VzuKITo
        ajSkptVXwtuccZac/sNHeTE=
X-Google-Smtp-Source: AGHT+IEvv0dVpgrozPUZbamw2BQh+QESpgEaEgRdXpXqsUJqmal9Gi29fQ0TBhjj6b+DKbx0lz/zdQ==
X-Received: by 2002:a5d:5442:0:b0:332:f01b:32f3 with SMTP id w2-20020a5d5442000000b00332f01b32f3mr6179969wrv.68.1701108301847;
        Mon, 27 Nov 2023 10:05:01 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id v19-20020adfd053000000b0032f9688ea48sm12469369wrh.10.2023.11.27.10.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:05:01 -0800 (PST)
From:   Nicolas Escande <nico.escande@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Escande <nico.escande@gmail.com>
Subject: [PATCH] wifi: ath12k: fix layout of scan_flags in struct ath12k_wmi_scan_req_arg
Date:   Mon, 27 Nov 2023 19:04:25 +0100
Message-ID: <20231127180425.1695427-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a layout mismatch between the bitfield representing scan_flags in
struct ath12k_wmi_scan_req_arg & the bits as defined in the WMI_SCAN_XXX
macros. Fix it by making the biefield match de #define values.

I especialy checked by adding WMI_SCAN_FLAG_FORCE_ACTIVE_ON_DFS to
scan_flags and the firmware started to unconditionnaly send probe request
on DFS channels during scan.

Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.2.1-00148.1-QCAHKSWPL_SILICONZ-7

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 629373d67421..2b5b46f8898e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3307,17 +3307,17 @@ struct ath12k_wmi_scan_req_arg {
 			    scan_f_filter_prb_req:1,
 			    scan_f_bypass_dfs_chn:1,
 			    scan_f_continue_on_err:1,
+			    scan_f_promisc_mode:1,
+			    scan_f_force_active_dfs_chn:1,
+			    scan_f_add_tpc_ie_in_probe:1,
+			    scan_f_add_ds_ie_in_probe:1,
+			    scan_f_add_spoofed_mac_in_probe:1,
 			    scan_f_offchan_mgmt_tx:1,
 			    scan_f_offchan_data_tx:1,
-			    scan_f_promisc_mode:1,
 			    scan_f_capture_phy_err:1,
 			    scan_f_strict_passive_pch:1,
 			    scan_f_half_rate:1,
 			    scan_f_quarter_rate:1,
-			    scan_f_force_active_dfs_chn:1,
-			    scan_f_add_tpc_ie_in_probe:1,
-			    scan_f_add_ds_ie_in_probe:1,
-			    scan_f_add_spoofed_mac_in_probe:1,
 			    scan_f_add_rand_seq_in_probe:1,
 			    scan_f_en_ie_whitelist_in_probe:1,
 			    scan_f_forced:1,
-- 
2.43.0

