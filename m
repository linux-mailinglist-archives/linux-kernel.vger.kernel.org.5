Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE937FA892
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjK0SGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjK0SGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:06:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF535191;
        Mon, 27 Nov 2023 10:06:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50babce6ff6so2677408e87.3;
        Mon, 27 Nov 2023 10:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701108388; x=1701713188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DT40gvGBf/eM8IJ2UaCbuM7rGTg9Ams4wqAFywuOGQg=;
        b=U83Cp9QAYPsR8y8BFvWQAlWLGyNJkNBENO7EgVym2VdArBgtz9N0iB+UwZqk0QoOAc
         wTrvILcqAZU3aqNSA02Vcg9mZ9P6tgIodK32BPZ8IvH60wcEF4GKG579JoAPgGSAWmHd
         Np/+lbGQDWJAZEVNcl2jHtAkqkvD17YdgynPzFUrUTsfnduDY5H303jSYysE2mUshT07
         bspI23rdp1mn16lDAqP9MFNOwBOIkwEA55pkU2yIeTVtjAj+/Sq4emWAOTpPLQHw3ngp
         TLPZNZ3gmg+UBncjo1XSjuykRuuFqwAU0NXkCbIJ5RE7A0YnKPojangVj+3AEsY4JEyH
         gtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108388; x=1701713188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DT40gvGBf/eM8IJ2UaCbuM7rGTg9Ams4wqAFywuOGQg=;
        b=lv/pMsHHj9IUF8O1gNl5xy+0BK2bLKxxOS4WPz6hI9TVPX0yOMnX63C4MhPodKepB2
         w+amJ35hFs1Obva/wOmtA9nHrqbDb75P2PGkhGmj5GYLgo7crDMU6JasYDruhLbkgo+l
         zymMp5K5xnuE/jAUI0Y3dvYajsjhzlJG2/tt1BPui6t7kvL4UMR2jilof4dqXNKh3GMp
         5S1+wiqM4SmCewRlU51/7OhA6/O44mBfsQR2WJHJhXmsKURVtycqPV8KrHF2/lJDZ4Dz
         nshSbvbVrnasBDmI4xc+gpXQFwG0vlUFE9OVmlcnwaWRqVqn8YWmKql7VNThYdcR+7WX
         l9/g==
X-Gm-Message-State: AOJu0YxqcQjUpC+X90CdGsXC954SsbM7dgRj8UvqgD+R/JKPuulpA1Mo
        RcxYTHdyeJRyYvBIYd50r6Y=
X-Google-Smtp-Source: AGHT+IH0U0hrGxgiqxbvTxJgMetsDCw5i7Yn7rA7X0J8Zw0WgeHRZr19HnuLIIdh6N1eT3DHYBFoiA==
X-Received: by 2002:a05:6512:684:b0:508:1edf:92f with SMTP id t4-20020a056512068400b005081edf092fmr11089362lfe.40.1701108387855;
        Mon, 27 Nov 2023 10:06:27 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003258934a4bcsm9795304wrq.42.2023.11.27.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:06:27 -0800 (PST)
From:   Nicolas Escande <nico.escande@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org,
        Nicolas Escande <nico.escande@gmail.com>
Subject: [PATCH] wifi: ath11k: fix layout of scan_flags in struct scan_req_params
Date:   Mon, 27 Nov 2023 19:05:59 +0100
Message-ID: <20231127180559.1696041-1-nico.escande@gmail.com>
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

The is a layout mismatch between the bitfield representing scan_flags in
struct scan_req_params & the bits as defined in the WMI_SCAN_XXX macros.
Lets fix it by making the struct match the #defines.

I tried to correct it by making the struct match the #define and it 
worked for WMI_SCAN_FLAG_FORCE_ACTIVE_ON_DFS / scan_f_force_active_dfs_chn
so I'm assuming this is the right thing to do.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 100bb816b592..0b4e6c2f7860 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3348,17 +3348,17 @@ struct scan_req_params {
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

