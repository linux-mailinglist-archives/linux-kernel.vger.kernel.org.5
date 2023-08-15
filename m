Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFB077D4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbjHOVAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbjHOU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:59:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AB10EC;
        Tue, 15 Aug 2023 13:59:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso9670582e87.2;
        Tue, 15 Aug 2023 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692133187; x=1692737987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcfBBP63amJI+2Knvmdm7Xmx0dkadUY41ZExmnzwoQA=;
        b=plSO8RmRDtn9PACBWBzZcr1Zj0PMcZZ2oA/lAXoNo1/9lvrc27O2Lc7SEFZOBfXGgW
         vLFpDC02NlbWrZHRRmYZeBjagUf4D2C77Z2SpuQ9BzX2Q1E7JAwkZ0IvrURNU2O2EaRJ
         p1A0VDHF+uHb+HTZ4DSMmVMoyVbiQbgst2WJfIMpv7ibxrDr5fmBSUXqiAqWNHnuAhUJ
         DYHaZeFxC4vH4eOFh1hsgPj/l9oq0Fo5PA1omL4Xu41Q8/+lH6pSGeJORRMa2oKRXFCL
         81kfxaQq+yzmzPBJ6mktmpkwbykiha7r1Qs7v7bHKHsCsG7kI7l9boCxVYfdarmLd6AI
         tDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133187; x=1692737987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcfBBP63amJI+2Knvmdm7Xmx0dkadUY41ZExmnzwoQA=;
        b=dW0scKAGHNHmroD421cVE2526e0I793e/c3RRvwrW1M74hN5AJYfJLMi5+WsWCfvfb
         DateW3CTEHDQvsul348snXrLQfyCUDaOTNM13DNdClBmewUB3g0rk5kgLbjmLHkHVLnA
         MAEliwIDEbpZqCR98XZMokheiKr2OjD7HHq51S46roo+usoxuXMq3aYk9hgLNDsAi8y0
         zbw0ZnjRUXIZDhEWbGkMmfla7yQDIwk2b4KC3C82C///ZhKsKf+OE5uqDfOqUHShKYvE
         iHyk0VY35auCdi+E7NwD2nmXm51uL7IkVPLH6MxnHgyJ7E72enNLDEVrzjFEQdkDLgrP
         d3rw==
X-Gm-Message-State: AOJu0YxVzCvX/a2j+LvI2AVbV+qmoSxlOebGjmW2a8sL78NvPnQAKgRH
        bc2QvI63hGYRJvGJ7YXYB8Q=
X-Google-Smtp-Source: AGHT+IFe3neg+tf+qmavL8vQyO3chWhq4IPBWg+w3x49hj5qqvpDmwggWbkGVfHLhIvG9qZHEw7hWg==
X-Received: by 2002:a19:2d47:0:b0:4fe:2c6:1d76 with SMTP id t7-20020a192d47000000b004fe02c61d76mr18859lft.21.1692133186502;
        Tue, 15 Aug 2023 13:59:46 -0700 (PDT)
Received: from dev7.kernelcare.com ([2a01:4f8:201:23::2])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906695100b0099297782aa9sm7469235ejs.49.2023.08.15.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:59:46 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH 1/1] selinux: netlabel: Prevent KMSAN warning in selinux_inet_conn_request()
Date:   Tue, 15 Aug 2023 22:59:17 +0200
Message-Id: <20230815205917.1504837-2-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230815205917.1504837-1-andrew.kanner@gmail.com>
References: <20230815205917.1504837-1-andrew.kanner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reports the following issue:
[   81.822503] =====================================================
[   81.823222] BUG: KMSAN: uninit-value in selinux_inet_conn_request+0x2c8/0x4b0
[   81.823891]  selinux_inet_conn_request+0x2c8/0x4b0
[   81.824385]  security_inet_conn_request+0xc0/0x160
[   81.824886]  tcp_v4_route_req+0x30e/0x490
[   81.825343]  tcp_conn_request+0xdc8/0x3400
[   81.825813]  tcp_v4_conn_request+0x134/0x190
[   81.826292]  tcp_rcv_state_process+0x1f4/0x3b40
[   81.826797]  tcp_v4_do_rcv+0x9ca/0xc30
[   81.827236]  tcp_v4_rcv+0x3bf5/0x4180
[   81.827670]  ip_protocol_deliver_rcu+0x822/0x1230
[   81.828174]  ip_local_deliver_finish+0x259/0x370
[   81.828667]  ip_local_deliver+0x1c0/0x450
[   81.829105]  ip_sublist_rcv+0xdc1/0xf50
[   81.829534]  ip_list_rcv+0x72e/0x790
[   81.829941]  __netif_receive_skb_list_core+0x10d5/0x1180
[   81.830499]  netif_receive_skb_list_internal+0xc41/0x1190
[   81.831064]  napi_complete_done+0x2c4/0x8b0
[   81.831532]  e1000_clean+0x12bf/0x4d90
[   81.831983]  __napi_poll+0xa6/0x760
[   81.832391]  net_rx_action+0x84c/0x1550
[   81.832831]  __do_softirq+0x272/0xa6c
[   81.833239]  __irq_exit_rcu+0xb7/0x1a0
[   81.833654]  irq_exit_rcu+0x17/0x40
[   81.834044]  common_interrupt+0x8d/0xa0
[   81.834494]  asm_common_interrupt+0x2b/0x40
[   81.834949]  default_idle+0x17/0x20
[   81.835356]  arch_cpu_idle+0xd/0x20
[   81.835766]  default_idle_call+0x43/0x70
[   81.836210]  do_idle+0x258/0x800
[   81.836581]  cpu_startup_entry+0x26/0x30
[   81.837002]  __pfx_ap_starting+0x0/0x10
[   81.837444]  secondary_startup_64_no_verify+0x17a/0x17b
[   81.837979]
[   81.838166] Local variable nlbl_type.i created at:
[   81.838596]  selinux_inet_conn_request+0xe3/0x4b0
[   81.839078]  security_inet_conn_request+0xc0/0x160

KMSAN warning is reproducible with:
* netlabel_mgmt_protocount is 0 (e.g. netlbl_enabled() returns 0)
* CONFIG_SECURITY_NETWORK_XFRM may be set or not
* CONFIG_KMSAN=y
* `ssh USER@HOSTNAME /bin/date`

selinux_skb_peerlbl_sid() will call selinux_xfrm_skb_sid(), then fall
to selinux_netlbl_skbuff_getsid() which will not initialize nlbl_type,
but it will be passed to:

    err = security_net_peersid_resolve(nlbl_sid,
                                       nlbl_type, xfrm_sid, sid);

and checked by KMSAN, although it will not be used inside
security_net_peersid_resolve() (at least now), since this function
will check either (xfrm_sid == SECSID_NULL) or (nlbl_sid ==
SECSID_NULL) first and return before using uninitialized nlbl_type.

Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
 security/selinux/netlabel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 528f5186e912..8f182800e412 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -198,6 +198,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 	struct netlbl_lsm_secattr secattr;
 
 	if (!netlbl_enabled()) {
+		*type = NETLBL_NLTYPE_NONE;
 		*sid = SECSID_NULL;
 		return 0;
 	}
-- 
2.39.3

