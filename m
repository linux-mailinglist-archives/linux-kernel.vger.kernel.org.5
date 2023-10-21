Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3547D1C68
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjJUKPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjJUKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:15:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8DD55
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a3b8b113so2369561e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883311; x=1698488111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6i+6Zk+Ae4u3p5f0EYLwQQbZ/ZK0ytUZDMopEzD3lw=;
        b=UL1ymv8QBAATvZ8NcsXAgBvff4xeaZBpNaeEkGr8k340XfhFJzXaaDsDx0XkQkeWvt
         qVZfFKp+wZx5pTrbi0VzI6votedZkaCbdw6m2r70xkGOhxDL/iZFK18gs2+5wqvXQ6ZZ
         p99gBWWnDBtBhnEx1+ZhM2CpdYZQEmCX88KjSKYvx54jjfisq35q82lvpd3+1blNsfC4
         KOwuTzpBC/PjqhFp4seYgkLG4qlxGS9a4SOVfqG1wez21ZjTXCj2VNeQseU5RYC1CaLf
         iIJ6rm+wBKbTtNEo8sBN0GhDE60b9XjlUNi6FRKm+s66aLxUuM8qnV5tQm0EOPJ4/sH8
         GtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883311; x=1698488111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6i+6Zk+Ae4u3p5f0EYLwQQbZ/ZK0ytUZDMopEzD3lw=;
        b=hFndHe4p9Yiws8CVaItIdNcbKF7jj5YXNf/MQcHMv/H8OiXKLAHXBiMCDjLEgXMMv7
         AJcx49XGL7fd2hM0gKNp1ZuBwz8nfkcM2H88d/se4KVJCE1Tk5eXn0EtwXjrZvmkke92
         /+3Vpv8gjEHmFzLD9spJEfcxFULW5w3KGh2Nnu9bp5WZEPQs7VQpOgp22gd2ZZCC28ck
         /ylHrKNGdEU+s1HfvlxQcpfJuyppc9/+GhPSDTKTATqziKwNdog6QoA+STEv7wHp8vkB
         sBoTeBhXo7EMQ9S9hDXvewgOnxVcyAg2UbSI0Z4+OnzBHt95gLf13hJAsTSEqaeYSmKa
         LoUA==
X-Gm-Message-State: AOJu0YyqnSuf9L1bGz/M0pWiqBXQFdSnyv25kC8GXUv1mVHQZSqb3YJz
        JcZSWgKvLRd/bAAF1ZPWMUA=
X-Google-Smtp-Source: AGHT+IH/l8Jv8bNGei7moOM9J2kF685y5VbgHCx+tiAV9AliL1SBJQQcShZdUEh/IG+XDb099XOZ7w==
X-Received: by 2002:a19:500c:0:b0:502:cc8d:f20a with SMTP id e12-20020a19500c000000b00502cc8df20amr3052017lfb.27.1697883311508;
        Sat, 21 Oct 2023 03:15:11 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:15:10 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 6/7] staging: octeon: Fix introduction of new typedef cvmx_pip_port_status_t in octeon
Date:   Sat, 21 Oct 2023 12:12:37 +0200
Message-Id: <20231021101238.81466-7-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231021101238.81466-1-bergh.jonathan@gmail.com>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
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

This patch removes the introduction of a new struct typedef
cvmx_pip_port_status_t in the octeon driver and then fixes instances
where it was used.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
Changelog:                                                                 
v1 -> v2: Fix breaking change spread across multiple patches                
v2 -> v3: Break changes up into individual patches for each removed        
          typedef

 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 023b107e077a..8c48acab49e4 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,7 +201,7 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
+	struct cvmx_pip_port_status rx_status;
 	cvmx_pko_port_status_t tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 529a75ad7c67..33a0e1d5f961 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
 	} s;
 };
 
-typedef struct {
+struct cvmx_pip_port_status {
 	uint32_t dropped_octets;
 	uint32_t dropped_packets;
 	uint32_t pci_raw_packets;
@@ -407,7 +407,7 @@ typedef struct {
 	uint32_t inb_packets;
 	uint64_t inb_octets;
 	uint16_t inb_errors;
-} cvmx_pip_port_status_t;
+};
 
 typedef struct {
 	uint32_t packets;
@@ -1258,7 +1258,7 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status *status)
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-- 
2.40.1

