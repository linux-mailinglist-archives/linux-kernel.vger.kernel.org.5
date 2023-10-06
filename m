Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2F7BB70A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjJFL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjJFL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:57:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678BEC6;
        Fri,  6 Oct 2023 04:57:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27752a1e184so1582301a91.3;
        Fri, 06 Oct 2023 04:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696593451; x=1697198251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KoSF9wvyTQN8x1CfR4FfjTHw+BbzcOr6JcmJZ2YuPUM=;
        b=KO18hdzupEOdFv2Pi8gBdwn5iVAwQoQ1TD/Y/GaO60pSnK0P68/jM3GN+na9GmbNTU
         DvEdGCJxElmHWVv86hVTRsy8PI7CI6/ykiXGO9aMQGzWsrUIsrp1vdpa5tUV8KyvjMqS
         IJMUBJEjKSxXmNx2T11UxDiOH+lnRfInAZKSgTMXl3PK21DlLPMYp1m5nMUjaiuo9r0a
         c446svJySwTfUVgwgE5BRO+MQX9BPd0kkTFCMFTg/5BIDbLBz9canRpIxsBfxZn9+XlV
         Snvzk8YBAEN7rUjsnPu+fbjro1pZx1L0TBIf5lb+r1t5lOn+U85eSStK27igCBhMT/vJ
         jKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696593451; x=1697198251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoSF9wvyTQN8x1CfR4FfjTHw+BbzcOr6JcmJZ2YuPUM=;
        b=bKpnlYPz+SGkX6hwEa2JfQncoIOGid4kt1/Dc98Bt3mwbzx5xRPWkm5XawO8sYSWmq
         ieLvaUQyFkYXT3hrQVeAzUx3XUrZECpbuRJlNCzpp2Sw1L6PTQq7a4qWE9AS1TPPvT+h
         gCTYuDXbkhRALjWM+ebAao3yzj6yslwh94LS31XUBLjJPn7Ac/JqVFpiPUf91crkSDyv
         AKgj1m+cpDemAcAEQ6bj2p+LYCYuFRBCQyXikGOQnBqoSlwkZER3E8lwh9bKc605k8OY
         HBvfdQUaEn8UzsH1DWmqau2ULwfqx3mSCdpFqDWCBTaIW8GjlR6BA3G5h0Xh0ztcUEch
         1tiw==
X-Gm-Message-State: AOJu0YxUUQvRbikHu2m9PZbvf8V/JYFGQlTTCkRCxLwXtL0vtu2nqFxE
        sfpAIm+6KMUnAdG/MbSybFaXYZNPaps=
X-Google-Smtp-Source: AGHT+IG+IJMB4FFbXgv/lKIOgPJerMMb1CfdE72ZGszvaonISNDgMiJKBp/5bdRvkYCqDjapTsTiRA==
X-Received: by 2002:a17:90a:db8a:b0:274:945b:6979 with SMTP id h10-20020a17090adb8a00b00274945b6979mr7763533pjv.16.1696593450708;
        Fri, 06 Oct 2023 04:57:30 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:e49f:b2dc:3729:f25b])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902968e00b001bf044dc1a6sm3652729plp.39.2023.10.06.04.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:57:30 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] serial: add PORT_ANY definition
Date:   Fri,  6 Oct 2023 04:57:13 -0700
Message-Id: <20231006115713.801322-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pattern in the linux kernel is that every new serial driver adds
one or more new PORT_ definitions because uart_ops::config_port()
callback documentation prescribes setting port->type according to the
type of port found, or to PORT_UNKNOWN if no port was detected.

When the specific type of the port is not important to the userspace
there's no need for a unique PORT_ value, but so far there's no suitable
identifier for that case.

Provide generic port type identifier other than PORT_UNKNOWN for ports
which type is not important to userspace.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 include/uapi/linux/serial.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 53bc1af67a41..070e50cf9e1e 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -47,6 +47,8 @@ struct serial_struct {
 /*
  * These are the supported serial types.
  */
+/* Generic type identifier for ports which type is not important to userspace. */
+#define PORT_ANY	(-1)
 #define PORT_UNKNOWN	0
 #define PORT_8250	1
 #define PORT_16450	2
-- 
2.30.2

