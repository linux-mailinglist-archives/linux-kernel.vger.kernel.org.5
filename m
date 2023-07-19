Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E39758A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGSAvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGSAvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:51:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9393198E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:50:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-763a2e39b88so624562585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727818; x=1692319818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lELx1Jor3ryyghgQ+HYk7Hk999TnyRY5ELpyAOdCAo8=;
        b=kh51wAObPhNEmOAF6xUu3EksFG8Jzcd7WXjvKK6sY85ydx0oCAjbKfJr7SfAn8ZIn3
         OGDI5Sza40VPT51V90ZS6M8PG8voBghdWBcI5NkF1Ln/E2NjdGFfN7ylSyhZB3H/2qSs
         Eux2cQM7uyHorES3YiVvkdVicwQZiumEj2S/+chWRKgcpZyK9fkMR/CLDlpe+s84ardD
         AKBPhERrtDXd34zmfEnd3tYdQcRIeQYrqvfg1/Y0DzpVit92JSl6lqih2sFM3FuYrzAZ
         fDskheDYTg3t3x7D1pKzM5RwsL+n/HiUxZZYtcVnsMAhT0q+Xp+oLec11WIcU0wG0jf8
         03Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727818; x=1692319818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lELx1Jor3ryyghgQ+HYk7Hk999TnyRY5ELpyAOdCAo8=;
        b=BirYATpAIsNkQ5CIYOTHtfv8pWB3SLZJt7fSlv663YP/QMeUvJCjKCyk6sTuwxGwVI
         5kU4/8pl6qsXF8myK1wonmrQRyNB/dXZD4hFi8WcPwGbKPMpwLJWnLNeW0HBF5DrmKTk
         FAR7jW3I6kWXTUDt5u/HXbyrwaOSoOHHdmc47O7rK8700bMqcLmpp5/pOa3KxjwCxpZ1
         LEWGFuYI8F+mN+6frAJN5HgGQsbKoa0Sf1CjbQe0x2CD+qNL8jRjq2JhOodG5OTu/Pbr
         7NWkZ45D9dy0HgdSPn8zFnzQaplMiz93q3Or8QHD/MI92dIh0C1GH6aNTQJ4lO1U0oH1
         vXjQ==
X-Gm-Message-State: ABy/qLb5T9bvlQTWrjOCny4g5YugNmOB1INc5obMSW9KxmECyd/UtOPM
        jPYzv42/pQ4wViFlhLaM1oW10w==
X-Google-Smtp-Source: APBJJlHUp6yi3x2n9nRDT4fU8CPFc7u1hcZSiQvsFocXnMLLx8X+n9M7kAdjrUgvmbOkC1g5qOsF3Q==
X-Received: by 2002:a05:620a:8c13:b0:765:9e6b:139e with SMTP id qz19-20020a05620a8c1300b007659e6b139emr1162065qkn.16.1689727817783;
        Tue, 18 Jul 2023 17:50:17 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:17 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Wed, 19 Jul 2023 00:50:14 +0000
Subject: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a feature bit for virtio vsock to support datagrams.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 331be28b1d30..27b4b2b8bf13 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;

-- 
2.30.2

