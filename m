Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311C07CEFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjJSGG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSGGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:06:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA132116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:06:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a839b31a0dso87640137b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697695582; x=1698300382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lr68DklHqj74TxP0eigSuVpguDEeRxq0NgDtMHIH/oI=;
        b=yI1u9WmYCCKp+URianPUqDBeVnJcpjK+b/l1y7cshee5UpH12W5ZZFclN9xChI+5hA
         wmJ8tgei8Vjg/57XbexbFhslugLDaQQkaMmai6/3nQQpXNBL57MdcF2syWViEdrN762C
         ioTh2L+skWoSH75+a8NkCbOZ7rM7DsergA6R++V9/w4MjLwoNSA58NgTDIi1m7nproHL
         gDhSuqHwsTEDwWBacRxb4QBDMml355+b9tKr+zdyo1Az0QirC5WgjVXHuIqq5KomwBAC
         nUCQQF/8/vW2FkC9H7Tw5nA2xNnm5CRCUzdgpyHL8Qd+g3+ux3wcY3gSpJcHVcU6xxMZ
         IIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697695582; x=1698300382;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lr68DklHqj74TxP0eigSuVpguDEeRxq0NgDtMHIH/oI=;
        b=NxVyGB0GQz2Wpnvdmzx/HSnchxBeW6adCEzXvzB+n6X0rTlaAyKMX0e3XstuiPSlkZ
         ZOz9TG8wceW/f7W6iirIqpjAZ16KB77JmPABKdmLkrMDX32/LiXSWoSQCxHuSunFV4dW
         xvVvdp4A3inpimqmJ8I9G55kFtTxLgzRxqj08mV2qkI/abRI9/phhNXKrRjHaDFJoJ1O
         u4FWT47arNSiObAhvBHxMxH5u3UH9/7nRE58U6PetdPFUMRnutXFSSquECAXe3wHq2/l
         IgBOFtQl2GLIQKLTfqG8mkSexlidV1BLTMZLMDmJXN82Sp4jCeqP4Ba4yihG7iO28yZU
         yI6A==
X-Gm-Message-State: AOJu0Yx5/zcFLI1kc+9fLtYUAszue8iEoBgxGpj79VQwsEFeXNdHPl9H
        OZVAUbfCZYRLaBSloaGyozblCMh+yx4=
X-Google-Smtp-Source: AGHT+IFxdAeW7rTbAxtKpzc3xZucRQ3pnnEl53+/pr0bFck1skxCTbWWGVdiz94HSZyqmYP90WNoxGbwyO0=
X-Received: from hhhuuu.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:c80])
 (user=hhhuuu job=sendgmr) by 2002:a81:92c6:0:b0:5a7:afd5:1cb1 with SMTP id
 j189-20020a8192c6000000b005a7afd51cb1mr31144ywg.1.1697695581761; Wed, 18 Oct
 2023 23:06:21 -0700 (PDT)
Date:   Thu, 19 Oct 2023 06:06:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019060616.1988631-1-hhhuuu@google.com>
Subject: [PATCH] usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()
From:   Jimmy Hu <hhhuuu@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jimmy Hu <hhhuuu@google.com>
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
2.42.0.655.g421f12c284-goog

