Return-Path: <linux-kernel+bounces-48932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C283C846352
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76141C250B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54E3FB34;
	Thu,  1 Feb 2024 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6kd00h7"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3F3FB2D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825867; cv=none; b=NpCPjrtsta/t7aCRlWnXxYP1zeL3WsGl3aeu8+2lznl2X+sXp7Y6qhkW3QyoUkp5CP+YvS5QNI/ejRjkKgTgbTfVMguKzHCQPcVp57DM6HLA5bmLL4bhFlmfHfBZld9zuxOkIdzeoJuHN3Ez/8KEQFiBbMQLhrRm/3gChIf83hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825867; c=relaxed/simple;
	bh=iZHKh2zliymJZpYaEKcxSCcIowDn/Ybs7gN4/3MkGSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iBGjrDCFbpWHjoSW1PXAbaohFq0XGjAY/sgniGhzDl86WjyT11KtWNwgdcyUvuTOI+oJyOdDRSWp3WhKq4TNuBJXg56YW2FNvo2OvhHULXPbxQnyf7uPtWwBKi6uTm5pK2w+9YeRWgF4rpQ2I1t7Vq88STdTVTZD3iQQmASCs1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E6kd00h7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so2017720a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706825863; x=1707430663; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5FxhcLv5qt61Bot8nd609pAKj24jXJR+vudDR0/c4M=;
        b=E6kd00h7Nko4NfYOB8yP1pug47OxOJPBAyWDd+KQcB6gF5aALWo3qqJh2184nfufz8
         s1zJJ41IoG1euY0JQDm0qJ5Jxqsk3ihifnU+2IHsSRO024P+LGPeLLS+pUj0EDDngzKW
         i8VHFn7/RrEdmb9q4pd9eXzGiqp+K+YMhZXK05yfsWl/VgBtfY2Q+sM4esjbGsoYeZtm
         qX0GE9qZRbRlZ4/+rRc00sjxn4XomZ5XRQxjlWqo0+pqIj/03JsL4QSHxJoriXhC/n9h
         otq4ZxCVY//y2Bf46f6LWFnbbqqKxwV049LjRsfrdSOYr11f3JBQiL6DYwB5B0E9eip7
         oiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706825863; x=1707430663;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5FxhcLv5qt61Bot8nd609pAKj24jXJR+vudDR0/c4M=;
        b=Ct9TAXoQj5za9Z+58BL/PqgboWS0v5INBB8ZJJOUeVgX9JxA5ktZZJNmq7RNArqW51
         NbNWzqZMZd6YTA6SFipwuw883Uk4AYzQ6eXnFluj9cSPtm4WZVMc2IrsJFUztA72pzSE
         i87oWkc16cd35fps1cmrK9zxaT7fMBh52xg+oy/HKUAuN3yCelOhegrYQw90/L5Jutbu
         nQ5v1cYMN/1FYvDOYFtFn1I0xHJlLCbMvGqy4glPn4Cw0JZNE/CbiRItsWEOSNFRD8V9
         H7Awr+7wxvuoQtXkrjt25T3LMA8KWmNqKI7yO0oaZfqDZAULB/MKMnMmfDEYrMV8tLpq
         QI8A==
X-Gm-Message-State: AOJu0YxxCmkOaiqgfxa0pWArzJO6XomS3T9RCMmLfubNXafS4KlnjFkX
	F6VckB4JEFXZlKx1yq0cvGw5gvaAXKy3UeqRh7DfbaG9RX0dBFOOUgKg/aq6/cE=
X-Google-Smtp-Source: AGHT+IFJ6EHmx0YJ2thZJU4PB6f8gtc5YBURP5MbpmvfA9IxhlEOjKueAP4bvunCOE9xVHZHKrwLZQ==
X-Received: by 2002:aa7:c690:0:b0:55f:b217:4215 with SMTP id n16-20020aa7c690000000b0055fb2174215mr91663edq.0.1706825863515;
        Thu, 01 Feb 2024 14:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1UUR612wXs4/EqcaQQs1drV3Gqekft5m9dM2k6X0PdnjWzRtS0Gwcpt+vYTDu09ug5prp+Ur9E3Rxusj8lTXR+CHyCc1dICjiApnVJrr2ozLp0587KhEGB9ve+7SJ+n+gKWYVDCdB+cGzcYbYrf1e0d6hjF3n0iwMTgpQIjD5Oyi4GIlBB7dcifB1rjgO3j/aMwlE2iAhjHTjZhmrSuXuYChrcnwe7tqBvaOHzSjPne+eHpgXR+grx7RWQWJD0qNhEW6ozJMA51RaEnk65zE9P++Dxg8qbAQXfgPydjhlbQnfaiNgcZU/MngFtyo5xoNc/vvEhctUao8XHR2LdJJmm5aWB/RVLRrhFMOpPgCh0/xvs8yr4vklVUSmF4NyQlTvFQoMcsvMX4+P3tnACh1lS4ScGImPdvt0eypLbQBE
Received: from [10.167.154.1] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id l15-20020a056402124f00b0055f0de1166csm225297edw.26.2024.02.01.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:17:43 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 01 Feb 2024 23:17:40 +0100
Subject: [PATCH] drm/panel: novatek-nt36523: Set prepare_prev_first
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-topic-3623_fix-v1-1-86ee6f20876e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIMYvGUC/x2NUQqDMBAFryL77UISUzVepRSJcdUFiZK0Ioh3d
 +nnDG94F2RKTBm64oJEB2feooAuCwiLjzMhj8JglLHKKI3fbeeAVW2qfuITnXat1Y5eZBuQaPC
 ZcEg+hkWy+FtXkXsi2f5f3p/7fgDqclg7dQAAAA==
To: Jianhua Lu <lujianhua000@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706825861; l=1022;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iZHKh2zliymJZpYaEKcxSCcIowDn/Ybs7gN4/3MkGSE=;
 b=w1RN+2cCKHYNfNmB1ZoJSveJxUYPydExEMBIZ3s/hSAJ+vyUBX0r2tASV9T13V9iiLdwNRex1
 Uwx+TC31FpyCgZKEFIajVnXkYfpYjQozMOmMv6cKrTN1+6K+HE/mTmk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The .prepare callback contains the init sequence, so the DSI host *must*
be enabled at that point. Set the prepare_prev_first flag to ensure that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index a189ce236328..32cae1bc9162 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1270,6 +1270,8 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
+	pinfo->panel.prepare_prev_first = true;
+
 	if (pinfo->desc->has_dcs_backlight) {
 		pinfo->panel.backlight = nt36523_create_backlight(dsi);
 		if (IS_ERR(pinfo->panel.backlight))

---
base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
change-id: 20240201-topic-3623_fix-9198419e5e47

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


