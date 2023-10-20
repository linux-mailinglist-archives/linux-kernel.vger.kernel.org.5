Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60227D061A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346807AbjJTBVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbjJTBVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:21:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A119116
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:21:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so3786397b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697764897; x=1698369697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=svgRlD+xMxXKSNv1D21nXe/Ukb4M7OikQcdxYN6vhEQ=;
        b=E6w/HQLu+MM7ZPt5y0dka0jHHkkNewlbZNJFvK/oeRDHncOpdSXgod5JH2BVF8wm9h
         MPiXB70QD9hXN4nxMNLkDxblaJ0lYMB2LfxHA4faV+1OUfPKiBA8qXnqVkJEdWdRBxJO
         NKIVD2OGfOua6m9uj0A32Wc0LulJ8aiBredMlKg9rH6if+/OCq82VeUwAg7FcMo0Wiof
         WCKzy9DmqJepUD/ycFXd0/xqSjiTeC1/HjxGGIji9TKXofO0ba42Cj8t0+0H1aH+pugL
         7foHYl9Jcz5wcD2qAd7oyEJKpjw+RAKYIJiERoU3xeLgPgpxtVaS8g3BaMtuakRR7Azp
         ldbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697764897; x=1698369697;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svgRlD+xMxXKSNv1D21nXe/Ukb4M7OikQcdxYN6vhEQ=;
        b=Do5lh+iJi1vENBCX2PPO/w8OH/m5EInC0T+tLrpYzL2zTZqRZazohSkSio8Z+KQqHu
         V6muh3CbrT2zeHaFoeOjTtWCUVhWQoB9LBtRyC91wflXCxARkH7nN71XRiMf8w9Gjxzv
         +h+4hHQ8T2XOkjMzFa1khV7t4UKMTAJvb8ngm/c0hNYBPAGy4qcgxqtrHc3k62Wt7pVV
         GUZRMNEYPpPG5J2heScZh2a8rE3L2OmwjrGXJJp0GX0hMsPSno7Xwwr+wnZ0bsQJMe+R
         eCCVLgaJcaFlk04Nx7eeABzkYbNArDxbx/mB8PAoREcJ0DmtW6Jy1+5kUyt7SILEQxzB
         7QTA==
X-Gm-Message-State: AOJu0YzDdS3FGoK/NL3CHnAsE7IJi6+ac6JwptunpAnf+/M/J6Yaq856
        ujPE/VlnLBpmD4ggrRSBvvwbiP4Wo9g=
X-Google-Smtp-Source: AGHT+IEVeJk3Qi++5fKSME7qdO8CAO8j6CVkisf6RVyyQg1hEpWsD9DIRASMsOOPNhJdtTnJfDNyeH2MfO8=
X-Received: from hhhuuu.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:c80])
 (user=hhhuuu job=sendgmr) by 2002:a5b:b06:0:b0:d9a:3a26:fb56 with SMTP id
 z6-20020a5b0b06000000b00d9a3a26fb56mr9102ybp.2.1697764897525; Thu, 19 Oct
 2023 18:21:37 -0700 (PDT)
Date:   Fri, 20 Oct 2023 01:21:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231020012132.100960-1-hhhuuu@google.com>
Subject: [PATCH v2] usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()
From:   Jimmy Hu <hhhuuu@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jimmy Hu <hhhuuu@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that typec_register_partner() returns ERR_PTR on failure.
When port->partner is an error, a NULL pointer dereference may occur as
shown below.

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
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6e843c511b85..792ec4ac7d8d 100644
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
2.42.0.758.gaed0368e0e-goog

