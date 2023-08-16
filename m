Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6240F77DC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbjHPIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbjHPIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:38:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7100270C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:31:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589e3ac6d76so48696977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692174657; x=1692779457;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEdGeFmsUUC/uJprhn2HT5+gKzhQtrnOG2IwSFvLLE4=;
        b=Pk5S8QS6qusOG6tsch7rkC7jgwkgI8rAc+ucc3HKe3nwq/eHHY6Xku5UUdnOsXcrlm
         K2JIdWr2qPx0OFIe0D5hFqB2Xb2qZpp81Jxxsi8WrzGa9amZMfcB6onhoK37Xw8/OtnQ
         kjRku4Dsq8Qu5B0+hl1hSlBWUzpNpiGhXKJqUkh9adBAp6D2VXMzj/xkovmTvCN0BF3d
         nDG7kaCG1QozWkiqphVbZcrseITVNtBJNiuQqKFMdCyoCLXeT7zpZU3l4Cc+EcmU/5BM
         7/V1ULw/5jl0O+MukAUNLdp219qGptSf1ZafN3B1apZjGpbKCklKeQACEmFNhXqIPP3v
         4twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692174657; x=1692779457;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEdGeFmsUUC/uJprhn2HT5+gKzhQtrnOG2IwSFvLLE4=;
        b=iMaGQPC0F4m6l2TT9ASAkKBraJ1mN4J5kpDMdpVQqZgBo2l12jpgQw8aqgm7PVie4S
         Khs5rzR0KfUxgBjV+B3ewBPSU85l681b35HQy9TsU3yykgd8Ht5KDftoGMUs44BwrccQ
         ux/ooJPQSfGkCi/PFm2Uf3PVghYgUNIQbvb+ctNU2K2Rm7NeFmlGaUbt4NvWCyY3aEUq
         0cXLmrpZ8WcCMsHsbhozcYalK7lA8DBRQ8ZzI/l/wG+WlSHYl9Z5UgTz7Gdw1NsR67B1
         L7QeFvdGN10A4mxNIknmfJShKKzE2gIL63lfP0+N2r32TQlEFgUAxRXLtQzMVEGGWlbD
         6dGQ==
X-Gm-Message-State: AOJu0Yz+UYuMkygHmAGbSYXpuHMCRoHXd9tBeFl9QJffumm2OXpBXRpb
        xbbE98hwX2VxmhkFReyphg0shzNlFvI=
X-Google-Smtp-Source: AGHT+IHJmzkOgkpRlEAluI2AMUM8MdTrsB7Xl5z8W9c5goY+sGxidZcNEpL4yo8TV3Nbf+Kbuu4epPDmUyo=
X-Received: from hhhuuu.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:c80])
 (user=hhhuuu job=sendgmr) by 2002:a81:ac54:0:b0:577:3b0c:5b85 with SMTP id
 z20-20020a81ac54000000b005773b0c5b85mr11439ywj.0.1692174656897; Wed, 16 Aug
 2023 01:30:56 -0700 (PDT)
Date:   Wed, 16 Aug 2023 08:30:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816083051.132480-1-hhhuuu@google.com>
Subject: [PATCH v3] usb: typec: tcpm: Add IS_ERR_OR_NULL check for port->partner
From:   Jimmy Hu <hhhuuu@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jimmy Hu <hhhuuu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

port->partner may be an error or NULL. This will cause a NULL pointer
dereference as below.

[91222.095236][  T319] typec port0: failed to register partner (-17)
...
[91225.061491][  T319] Unable to handle kernel NULL pointer dereference
at virtual address 000000000000039f
[91225.274642][  T319] pc : tcpm_pd_data_request+0x310/0x13fc
[91225.274646][  T319] lr : tcpm_pd_data_request+0x298/0x13fc
[91225.308067][  T319] Call trace:
[91225.308070][  T319]  tcpm_pd_data_request+0x310/0x13fc
[91225.308073][  T319]  tcpm_pd_rx_handler+0x100/0x9e8
[91225.355900][  T319]  kthread_worker_fn+0x178/0x58c
[91225.355902][  T319]  kthread+0x150/0x200
[91225.355905][  T319]  ret_from_fork+0x10/0x30

Add a check for port->partner to avoid dereferencing a NULL pointer.

Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5639b9a1e0bf..ca9b1f3a38bc 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1625,6 +1625,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
+			if (IS_ERR_OR_NULL(port->partner))
+				break;
+
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
-- 
2.41.0.694.ge786442a9b-goog

