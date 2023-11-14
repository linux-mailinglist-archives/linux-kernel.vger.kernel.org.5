Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392897EBA14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjKNXAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjKNXAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:00:42 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E1F100
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:00:38 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a82f176860so71592837b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1700002838; x=1700607638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpJg20SvqJHFde7hdRwbQhfmXK7eKDJA+6y+igvktAk=;
        b=CaIrtYL5zP0EobCPzSK6v6WsO7JTWvxsYT2Fk+qkRLqrw8VCSNwwlWuBlhvXZMTRp1
         TqAZbUOTuW0OOJvdX5DTGc8ow89MFeXVDCwzfS+z1QqnZhroFynj/pLQfTkjUvTqv/Xl
         lNXfDC7TbkWDJUYCtrihj7tMBipBRxaAmts6TAtUaspKMyHjkvD2N7G5gH7X+98NliLA
         tp/yXHHr36EZxroiykF33hgrv25gzDV4cp3qge/d14LASuA/eCq8z32bUbkkjzPMlzpq
         oSYkENDpt3F3JyDHDbSZlBYSjk2V2GeWmsfumMZUOFNKZibTv7YNaAtgG3iDqbynJ6y0
         EKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700002838; x=1700607638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpJg20SvqJHFde7hdRwbQhfmXK7eKDJA+6y+igvktAk=;
        b=Vn7YtOzBDZeLBGOJfeP46ILbO8Qn5mWxPLqQw5QuPgeCG0bgnUOG0Hw0IBfENmgmlu
         W/SjigRAJvurLwZpwKUFup042u7W4PYc+eCPqRp+yimjoQ6vEiheC7US4vqvQkHiuB76
         RT2Rw9zrYBNEX0p0ZuBpTSNJM9XEi25lIoGH7p/RO3uf1EPnXHrliuC3haQlSJmeGFNu
         j64Ue63+WnVzmC9DNDplc2l/4IdyttcPakInHUtyecNsZUqF+q0LTAMkHdTxvK0KfU+V
         q5/2gQURwu2mvBhRaioD5KYskLipifompfVKnklG3KCz7vjB2lkV/xoxMDGtzWtYDjfS
         S6Gw==
X-Gm-Message-State: AOJu0Yzr5EWPHUTwRM7sQzgIFlTQhkVqTOj3BirsYTdXDgQLP/wiA/ES
        UWmiZF+JkAJp6HI1aLxgdQWuGQ==
X-Google-Smtp-Source: AGHT+IF625S3cBQuZUFbUGBAhZkGCmiGu+ZC9noNuDSK6oc2pQ7dDTxwb4mFW7Ih4VTIW4LqjLUQKA==
X-Received: by 2002:a0d:ca84:0:b0:5a7:bfbf:1bbb with SMTP id m126-20020a0dca84000000b005a7bfbf1bbbmr11185827ywd.17.1700002837716;
        Tue, 14 Nov 2023 15:00:37 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id u2-20020a05621411a200b00674a45499dcsm25274qvv.88.2023.11.14.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 15:00:37 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] drm/msm/dsi: add a comment to explain pkt_per_line encoding
Date:   Tue, 14 Nov 2023 17:58:32 -0500
Message-Id: <20231114225857.19702-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20231114225857.19702-1-jonathan@marek.ca>
References: <20231114225857.19702-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear why the pkt_per_line value is being "divided by 2".

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 66f198e21a7e..842765063b1b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -877,6 +877,8 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	/* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
 	 * registers have similar offsets, so for below common code use
 	 * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
+	 *
+	 * pkt_per_line is log2 encoded, >>1 works for supported values (1,2,4)
 	 */
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
-- 
2.26.1

