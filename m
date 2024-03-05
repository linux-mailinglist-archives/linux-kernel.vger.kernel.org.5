Return-Path: <linux-kernel+bounces-91874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566C8717BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A4C1C21334
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442C8060C;
	Tue,  5 Mar 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvAtfn06"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D27F483
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626342; cv=none; b=amw+kRsBayyoFRaxzv/WhZ7pbhHLFW9i/dvcJriNVhr6SH2tP15LGie2j1kHT9nAbJDLBW0kUGgR3iCt+tK97mGV82ViFapZ+9hUrOM6Ql03UBr6sfYvAtYudE+ZQ7zjD1AOOT3YFWsyVwNMNMfAhDfKt4RbFMyHMcz1k/tNLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626342; c=relaxed/simple;
	bh=rLcNWyHrJ59PgQVMQdROdn158veQsUOWpOpARELHPHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoF429LragTRWmOR8L/j3U1rbJPAAJ22hZYVNgubTUC5LbhMjXS9/g9hfgowYeU8REm3E5WDSHKvneXnAvWxtIQDPcZJn2rG27iROooVgqwJsxkwm5at+QyDE8Jhgtd8T27NtoPyI841C4lUNOcKGN2HY0USMFXefcte7xHfHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvAtfn06; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso6769502a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626339; x=1710231139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POVvCdCwqgBsDTzLmq+xlV1vSpeRHUQ3tEhlOTxlYcU=;
        b=QvAtfn06hEOHBpAMfE3/7kgoGVh4zy1rORx419jY+4HqbmgU5soklIL/gLPkLVBsgA
         1B0reUcaWoJs5C4HXl01KeavQtYhuimdgh2+iWxcrWIlVP/fQcAhe0QfegdAGt4dTyWr
         uJucD5jGULN8nr/z7sP47+RSvK5WRzJ21bLrOcIYo6Ajbps4amTtcL6iIbA8Shl+LmrD
         9CI/dXkmA+wRYV/uD0IyaVOBjJeeHJC5aSvlAMU8v486b4uuzQzZKkClCGl9PQFuIYEa
         QsUlyG7vUJm1CALR8m5jIeh+xcwFMx/9D1LlQ4Z7T25ltR2DP932mswo0tcXZApQMNIv
         C/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626339; x=1710231139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POVvCdCwqgBsDTzLmq+xlV1vSpeRHUQ3tEhlOTxlYcU=;
        b=NHIIu3m/8lToBw/NteN3pTKt3dshX+zir7dHPa54KuInPwuhufknGLmLFs/32BSMGw
         Qv1xsQQ16BUIXE5454ai2YWJDAPPS5Uvmd6+xTFvZBN6+2gW3+43Ba2/+HnO/Z4RJJPB
         +0tFLz39RnR8Az8tGhcAETa7GmExNSdXObV+ZfURiWLdEtOQ+LibSKKG5E8YhkfT3ffA
         wXSr22W0hg4/FTUUzO6l5vh57vjV2V1Uf++XJzNhAnXd5a0c8a7CQI7VaFVzg+cNfA8I
         pOw36mgg7s5Ya/ikGx0m7lLK8957gtvIcnISCOzsKMsJDx0QbDbWtipz/7RzzL3BIJuo
         KETw==
X-Forwarded-Encrypted: i=1; AJvYcCVHMmqJU2XaB2bmMvSlnhujStBOn7He0mWwbz1EHWEWzL1rqSh0JpDYA53187c0NrwVbcrLSvXpmXvolApcx1MHVePBLppJDQdo3Wh4
X-Gm-Message-State: AOJu0YwqwWaQGhABqnMbifjBGTZFpnFF2Bra8WYBmorzF+lsO9Cma+9j
	Ftq379rfymLDGPAUq4mh/das9JdsNtTfl5rE9WFvW967004TLndtEXRbPkHwAqmA294OrCNs2Fp
	a
X-Google-Smtp-Source: AGHT+IGOwgFjm9p+7mY8WcaCSk3d8VXb2bBW8TuCFZ36DSxBXROjoRrcLWhEMUftUIgCJZt6zZLL7w==
X-Received: by 2002:aa7:c3d9:0:b0:567:38db:8076 with SMTP id l25-20020aa7c3d9000000b0056738db8076mr4309804edr.21.1709626339498;
        Tue, 05 Mar 2024 00:12:19 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 05 Mar 2024 09:11:59 +0100
Subject: [PATCH v2 4/7] backlight: as3711_bl: Handle deferred probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-backlight-probe-v2-4-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rLcNWyHrJ59PgQVMQdROdn158veQsUOWpOpARELHPHY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPYiTvjPqEeJttKrU7WiswuUE0dpbgygo9ZR
 33m9uiM1euJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT2AAKCRDBN2bmhouD
 12YgD/9IXBNCquP3bPqgvY8F0d6uhoxY77XF+TciANVjhfSwKpU37EewVGovz0Iqnt6HWaDWN6j
 F21SWV7MUAEoUrnIsLHKojTKz8CSXamKEGAjPAtUUXOMgjFneB7r1biTAbhkdeLR98b4MUJOdel
 816YAtPIwC6d3RgCF19e5h8rGj2fxWNnb/qJTK/DKsNNN8L3m+lczzFyE3aFdcEcW/IrPEFlZ9r
 M8s6i3GDwbVINPBfSTKmJLYUJyLuyJiohQTgzlU7Nkcp6G2I4ufyiAmZP8/kmMG8w2ZAJ/M3y0e
 PvQ1z/ZuFfFqLvNZZiuL7IkG5UQJ3FVLtCIsure9tkDLyGUNsHIFutW4dHczc9HvFvi9pVzt6LK
 7T6rw/26yrYKfCaBJEGn9zpVaxiAIl2XczCIo3Gz5Aygy/8U4p7y+oUa9qUawoutjLXtTCDbKIt
 OgbZlnYagsZCtaQGiMG5aFwX586KxBz9a4td3TUSq7L1Osa1d93WVbNetGeaLTTfoB1Rsu0SnSV
 YgXBWi7SbTL45BS82xRTGDrf+jctkC0oVC1qQELCRTwBzwH6QHUzn8lBPh+mJgViOMMWlqTpblo
 xumCSjPITNs0L4Yz2T6PqFn/0xK7RlnvQbgPxII4GvtnVm4lCbuJ0yCedULW9uBWchL02hx8wbK
 R9FlO8clmcCQD2Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Don't pollute dmesg on deferred probe and simplify the code with
dev_err_probe().

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/as3711_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 28437c2da0f5..e6f66bb35ef5 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -383,10 +383,8 @@ static int as3711_backlight_probe(struct platform_device *pdev)
 
 	if (pdev->dev.parent->of_node) {
 		ret = as3711_backlight_parse_dt(&pdev->dev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "DT parsing failed: %d\n", ret);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret, "DT parsing failed\n");
 	}
 
 	if (!pdata->su1_fb && !pdata->su2_fb) {

-- 
2.34.1


