Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5B7D22AF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjJVKlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjJVKlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:41:06 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C0114
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:41:03 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ea05b3f228so1704044fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697971262; x=1698576062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULEzVLtQ2S1zar/fvv2bvXuBMfVambqe7uOvKdP1z6k=;
        b=SpUeMX5iFddGxZJ9skml5n1E1KvUQz0vxS7/x/C8sbS7B3NC10YAyEkdLDGYrp9c9b
         xVCzTqoQXlK/iAqlaiVKTPiH7o25E62AtxF5TpmF7yajksTAwLDcp+Zn8F8tDYcwqKjQ
         KlIYQwg+r7988Pw6FhAg/xr8xN2drQZU6HHwScdRZAX6zYfBn5sxDE4fKMoFjM7b8B6E
         gaJu3szfy8ykxjyTYLZV8J24hV+k1BAyUISc3hg4I2dOUJbUtQJpDJ/L1ABADMxtcbP2
         QszsTEu8IYVExAL54CIspPHZkdzH/St8302ZOoKOG8gVdisKRYz0XfvFA5wyD4Lx6RxF
         BIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697971262; x=1698576062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULEzVLtQ2S1zar/fvv2bvXuBMfVambqe7uOvKdP1z6k=;
        b=h2ER0WNHQfoijgSF2Bw/AqL810aRKe/L6SmeNNYuEqOD4d3r1xBfdNX3U6TIhtQp5m
         kNG2dBrAR/d2p17lIoWejYr63WdA5tvaK7bq9AmuN7MTKMkj5+hQSmWtAjbQ6lPpyTod
         4cWon1R+m2c6T5MSI57GhNo9vScm87CA04Lnh02GJ5gChQXEfhCEpFxoIOEGcknQziL2
         4Yn/TKv748inZEykBgzDDOnrWs7n71KgkQCs1dRUPhAsQYTN68iDhFK/sg9tSgIfY/5L
         +d/U/PmwKb4dvIdaQYRRFZkp8gY+SQ3dylk3gBaplDdtyCPRLorgvzRdyr2w0tDx9GwJ
         +8fQ==
X-Gm-Message-State: AOJu0YwjfYtI1lpLDOSPIVck9Updf/oYuNMR6N8j14IZpf2b5pwmMgEC
        5ALL7pmE05oXgfKDvYrUtjw=
X-Google-Smtp-Source: AGHT+IFgN6/PaswmdUmoqw2OMJKkJCHNeJYp4Hh9ngYJEtLETOtJL7TF5JNX82LpM4SpUYilirG8Tw==
X-Received: by 2002:a05:6871:800a:b0:1e9:f69a:1302 with SMTP id sk10-20020a056871800a00b001e9f69a1302mr6764712oab.48.1697971262607;
        Sun, 22 Oct 2023 03:41:02 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id o21-20020a17090aac1500b00277246e857esm5781338pjq.23.2023.10.22.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:41:02 -0700 (PDT)
Date:   Sun, 22 Oct 2023 03:40:57 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH 2/3] staging: greybus: Alignment should match open parenthesis
Message-ID: <57d7aa177d58384bcc178f6722a8f7f6af78a536.1697969950.git.nandhakumar.singaram@gmail.com>
References: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch.pl:
CHECK: Alignment should match open parenthesis

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/greybus/camera.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index feddceddffbb..40d3b8aca8f0 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
 }
 
 static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
-		struct gb_camera_configure_streams_response *resp)
+				      struct gb_camera_configure_streams_response *resp)
 {
 	unsigned int max_pkt_size = 0;
 	unsigned int i;
@@ -377,8 +377,8 @@ struct ap_csi_config_request {
 #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
 
 static int gb_camera_setup_data_connection(struct gb_camera *gcam,
-		struct gb_camera_configure_streams_response *resp,
-		struct gb_camera_csi_params *csi_params)
+					   struct gb_camera_configure_streams_response *resp,
+					   struct gb_camera_csi_params *csi_params)
 {
 	struct ap_csi_config_request csi_cfg;
 	struct gb_connection *conn;
@@ -782,8 +782,8 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
 }
 
 static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
-		unsigned int *flags, struct gb_camera_stream *streams,
-		struct gb_camera_csi_params *csi_params)
+					  unsigned int *flags, struct gb_camera_stream *streams,
+					  struct gb_camera_csi_params *csi_params)
 {
 	struct gb_camera *gcam = priv;
 	struct gb_camera_stream_config *gb_streams;
-- 
2.25.1

