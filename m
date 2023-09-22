Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B217AB18F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjIVMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjIVMBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2C5122
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4cy021/toY323+D3zOQB5/xvXNwICCVgZEWVintFSi0=;
        b=XTkIssruDOmBi2HtcsxQJVeYPPSLi+8/99hA90bfih3f1gRaMwGfvlmHE8hE6+wBM+d+1D
        v1VdPdtxB2U8Zwag+21xfDj5Z2Lq5wXMXMfSM3BQcMZo3X7SSbUHDjeNMOV769e14bgOZE
        iP4qAHrMdCUUVkgLRTdjPWfy9yPlJgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-STLtHhTrNj653BGVMwqeow-1; Fri, 22 Sep 2023 08:00:43 -0400
X-MC-Unique: STLtHhTrNj653BGVMwqeow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E9763816C82;
        Fri, 22 Sep 2023 12:00:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72615492C37;
        Fri, 22 Sep 2023 12:00:41 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jtornosm@redhat.com
Subject: [bug] mhi: ath11k: resume after hibernation is not working
Date:   Fri, 22 Sep 2023 14:00:16 +0200
Message-ID: <20230922120040.15460-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have several machines with QCNFA765 wireless card (WCN6856) and with
the same behavior: although hibernation seems to work, post resume is not
working due to the wireless card (if the wireless card is disabled or ath11k
driver is blacklisted, everything is working).

After hibernation, when we resume (power on), we get the following related
logs:
...
[    9.631426] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
[   10.673834] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
[   10.683137] ath11k_pci 0000:03:00.0: fw_version 0x110b196e fw_build_timestamp 2022-12-22 12:54 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
...
[  123.323689] mhi mhi0: Did not enter M0 state, MHI state: M3, PM state: M3->M0
[  123.323693] ath11k_pci 0000:03:00.0: failed to resume mhi: -5
[  123.323695] ath11k_pci 0000:03:00.0: failed to resume hif during resume: -5
[  123.323696] ath11k_pci 0000:03:00.0: failed to resume core: -5
[  123.323696] ath11k_pci 0000:03:00.0: PM: dpm_run_callback(): pci_pm_restore+0x0/0xe0 returns -5
[  123.323702] ath11k_pci 0000:03:00.0: PM: failed to restore async: error -5
[  126.331726] ath11k_pci 0000:03:00.0: wmi command 16387 timeout
[  126.331730] ath11k_pci 0000:03:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[  126.331732] ath11k_pci 0000:03:00.0: failed to enable dynamic bw: -11
[  126.331734] ------------[ cut here ]------------
[  126.331734] Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
[  126.331749] WARNING: CPU: 4 PID: 1967 at net/mac80211/util.c:2568 ieee80211_reconfig+0xa9/0x1660 [mac80211]
...
Linux kernel version: 6.6.0_rc2

Could you help me to fix this?
Why is M3->M0 transition not working? Could it be an issue with the firmware?

Thanks

Best regards
José Ignacio

