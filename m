Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391D47D1C66
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjJUKPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjJUKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:15:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B9D71
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507be298d2aso2376653e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883303; x=1698488103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDD9F7uN2VF2x8OMQSha4YCHZj7a+MjcYdmT4MBIiD8=;
        b=Fofh6PcK/tXHtq1T7/l5ouEp4O6YxqLygHn2ja1Ict1G3RD1ooyUgNMkAsDLzo11rx
         i8IaQ8U3JFa9mVI2Q1vCvhmcMoFYlqEJQ3MZd+uI34feZDCC0ij0iuecZ+Ya7Vq7NCkE
         oLiwYizvUHXKrk+Kdmqf97cS8ZhVNrCUya3Bub9+CtjoLL3MsFxtrbvZqKkfwMeTbPWY
         gBevCoeqX5YNgw7YlFjsZ0E6LPdZFMEIZOZ4AXAuKe0Oc0PDTVBRd4lc0mTk/Zz3zDzC
         vBaVwYG0SvmNLTjUaozGl6rELF8Juad/6KrIvAU+obVilS9Tb7S3y2i8KlAhwNqjQbTK
         nQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883303; x=1698488103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDD9F7uN2VF2x8OMQSha4YCHZj7a+MjcYdmT4MBIiD8=;
        b=snE5BGfPV2Purp6eY6HQBhO+kzStHfNCZuFUTQrtkR+QbDEUYCgt66goYA38WOrwsQ
         hcAHU67mQCwqeJuo4HL74eWnrQiWv7twnn80Q6Qt6F5t+SRa0/fTPj/wGsWzK3vvn1Af
         0StopQnYpl2JzmNl401qYk9N/pC1Zu0r7D4+Pb8+4nMy34qP2BwVLJIZfStp2cpWfH2h
         13tqE91HnEVlxMAGu7BQbwRIXpX57xXNyfeUBN2ovjrmU0TcxHTtPBThZ13QVTTbDCuR
         Q1q8xNraE34DHAmwELgRirr+nH3Wl78do5Svw+FkfmVBMkyeVzVQ6mnkB5Pr8Aw4PDZW
         7yBg==
X-Gm-Message-State: AOJu0YylT9ML3wsZfHL9ULj8lMqv5MnQ526gN1DxFQNd0z+gHR1l8WG8
        vjiuzHvAWXvpi3Ypc0JXFqg=
X-Google-Smtp-Source: AGHT+IHX/Zvu0tJGvGX4KDIKit63ur6XFlLYyXpV8M0aVj608kZOXGkZi/aD1tKjQy5Ej7fNm+7NpQ==
X-Received: by 2002:ac2:4a66:0:b0:507:9f69:e8d9 with SMTP id q6-20020ac24a66000000b005079f69e8d9mr2877890lfp.49.1697883303127;
        Sat, 21 Oct 2023 03:15:03 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:15:02 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 4/7] staging: octeon: Fix up introduction of new typedef cvmx_pko_lock_t in octeon
Date:   Sat, 21 Oct 2023 12:12:35 +0200
Message-Id: <20231021101238.81466-5-bergh.jonathan@gmail.com>
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

This patch removes the new enum typedef cvmx_pko_lock_t and then fixes
implementations that used it.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
Changelog:                                                                 
v1 -> v2: Fix breaking change spread across multiple patches                
v2 -> v3: Break changes up into individual patches for each removed        
          typedef

 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index a11cbfec4d35..6c0196c1a9f6 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -238,11 +238,11 @@ enum cvmx_pow_wait {
 	CVMX_POW_NO_WAIT = 0,
 };
 
-typedef enum {
+enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
 typedef enum {
 	CVMX_PKO_SUCCESS,
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.40.1

