Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481D57C880F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjJMOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjJMOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:44:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EDD8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so5562465e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697208265; x=1697813065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUwXwdN/92xgfkRGk4NgyBr2C8cERjjyDL8rj/W6Q4A=;
        b=OTwi3wI+M8jjUTqc5p0F5r7ZT5RCM8oKQLHjDuMDUaemswXom+zXtKv4O3HOCU39MJ
         5tDI3YkBLTD5rRMbuoYUmxGqC/mme4ad68tabG1o8RkEYoUhczCY1u+4ETQgrnsWnWjT
         cwPezC+ihNrTYL+kjViU/cIq2LnOZNsUk903LDjUDfcK8uKCxDrG1wzXEkpSl0kQ2Jjq
         P6NoIPnE+e8eRMo6aP6JQJAcgIgjkkALYaOT7K1j3i+q8a0nPMa5vFmnUZE6WBdv6Sve
         CdTwtHJHVjhZog5Sib4ekARMBgjhynLL2CD1jqqGCubqCMW9tMMR/TZ/CrcIkS3o10Ll
         5zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208265; x=1697813065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUwXwdN/92xgfkRGk4NgyBr2C8cERjjyDL8rj/W6Q4A=;
        b=UZCzFFWzEbfhZGBe73mgLm9CjlHhUlgAUyhVJS1p9r1/alubSBaR7PNTyby2qy0Ij4
         ZfsU8+rSzLXu5TBl8aqtXBcM3H6Ns3pfvb5r6tBqFJxFVzuhhLCfOs60JJsxhtL4ZC68
         y7l8bvfmQlOAV9KI8PTsmPM4pXHT8TYpTp2PKIREbMIX8N015BXwD+yI29bwG08quF+X
         /FS2ia0BhQqUiUNFCltuS2Ykwrdvuk0omoj+LfXpQ6ayS6BmNq3xVUTGIwOIT5GleKLF
         qjPnL01vgm4ezQ3kpJBsXzB1l5fITAo63JcNl1cJ9rbXd27f8s+1B0wiHasAg7JnniIM
         7DcQ==
X-Gm-Message-State: AOJu0YwsKl8qHmnpEzfJlfOf1GQLAfNuG3BZaVDn0kaI2AO/TDNunbrd
        2HoLuS8RnOcLhsWTwsLO5vjHMTkr9ZM=
X-Google-Smtp-Source: AGHT+IHLyuSifzxEbeDJO3HER84faNj1Duelt7Do8Cm4/ovC64G4DtsR8Hxp0/615lXKfG//X3d1hg==
X-Received: by 2002:a05:600c:3b9a:b0:3fe:21a6:a18 with SMTP id n26-20020a05600c3b9a00b003fe21a60a18mr24335407wms.3.1697208265187;
        Fri, 13 Oct 2023 07:44:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b0040596352951sm331816wms.5.2023.10.13.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:44:24 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:44:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: rtl8192e: Remove unused enums dm_dig_sta and
 dm_dig_alg
Message-ID: <0aab74bcda5f582a5fe44a4c1405940d0c8261ad.1697127817.git.philipp.g.hortmann@gmail.com>
References: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused enums dm_dig_sta and dm_dig_alg. Remove unused entries of
enum dm_dig_connect.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 80ac77e269fd..84e673452be4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -74,12 +74,6 @@ struct dig_t {
 	long		rssi_val;
 };
 
-enum dm_dig_sta {
-	DM_STA_DIG_OFF = 0,
-	DM_STA_DIG_ON,
-	DM_STA_DIG_MAX
-};
-
 enum dm_ratr_sta {
 	DM_RATR_STA_HIGH = 0,
 	DM_RATR_STA_MIDDLE = 1,
@@ -87,22 +81,9 @@ enum dm_ratr_sta {
 	DM_RATR_STA_MAX
 };
 
-enum dm_dig_alg {
-	DIG_ALGO_BY_FALSE_ALARM = 0,
-	DIG_ALGO_BY_RSSI	= 1,
-	DIG_ALGO_BEFORE_CONNECT_BY_RSSI_AND_ALARM = 2,
-	DIG_ALGO_BY_TOW_PORT = 3,
-	DIG_ALGO_MAX
-};
-
 enum dm_dig_connect {
 	DIG_STA_DISCONNECT = 0,
 	DIG_STA_CONNECT = 1,
-	DIG_STA_BEFORE_CONNECT = 2,
-	DIG_AP_DISCONNECT = 3,
-	DIG_AP_CONNECT = 4,
-	DIG_AP_ADD_STATION = 5,
-	DIG_CONNECT_MAX
 };
 
 enum dm_dig_pd_th {
-- 
2.42.0

