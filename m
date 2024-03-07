Return-Path: <linux-kernel+bounces-95245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A8874B31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC751C20BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5E83CC1;
	Thu,  7 Mar 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="uUanPWAE"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4B42044
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804697; cv=none; b=gvS6x4bhMhGbV6nVs2meaBjIiWg3l26vjooywLKRE2piK/+xeY3KwKjw3R421ZBxw+VUr0DTyNbiZuydEW5kz1N1tJdTRitNuv21VUZCuUewJSrbzYCXkMhs+OP18RJkAqrEoCYsXi+TPcLC9LE14ap33LBsI336JBRyfjri3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804697; c=relaxed/simple;
	bh=mlNJg7C70jArZPU5qH010Vf/ACiUSBiUEralcFgEVpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MfaIH1B5AasdCkUNPJuUdVhWqBlg8yyiKZGZ+zuCobCb3gVzgYLRfX9BVDpPc8BCmfRSre0Gvvcy9I9npggujtRGcbi3iiTNhxOnB3V7MT2cFFdvEu16eXthg1NLig2rn9hQGlx67gm7FRYF87yxL2m52cs3i9EG55pLKahjf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=uUanPWAE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e617b39877so570191b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709804694; x=1710409494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo1HUbKQuJ0voHBjj4WM/4fo0S00UmuP10DfZ9KXDLk=;
        b=uUanPWAEvyIF1jl51Hli4OFJ38QiBZDBa5E97/A/tf7otEiw7G9U0c3lJlt9IAw5FF
         xwrE183SUUs6waZN9mZ9d+p1Xlzz0sKqWKu4RCz4IHxdIe6gETTE9pjERUUKFi3L7PDI
         +New0DNirkl2jGmJaccVBIk+15o24mCtdAHiVKmnhIfTY9XALXk8YQh/8E6no5THdbBv
         5H9LoDnfVIwQ8AqCijtiMkQqBCMsOPW8P4TgkzyVQ63sRxSkeGpvg5V0LJVRqQ+EJ98j
         foFjHbZBCa7fl0XJhvrjPi2tsIzckW0/0Dn9d8vyhaLmHNtf6LvfOw6TJdGFjlydOb16
         N2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804694; x=1710409494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oo1HUbKQuJ0voHBjj4WM/4fo0S00UmuP10DfZ9KXDLk=;
        b=LJFG42+c8Nc5hnFiF/O6wQylFPf1aHIUEXe1aoDJ7VMNatXcE2HxeB3iYtDBBMRXeI
         D1KdWCUpkntEROMiY6rrk30zgTuCxyPYw1lGWY++1BTd6LRxi21eMxgJTKtLdU2r4aic
         rGugrIdNWsBkWt1/56qaN1Xtjoi+f91kWli2LLdXhwfnc6qD7gmaClmlNnsj/LbuOXrg
         ZszyQoLFfm4YOB3yHmEfMDzHTq5qHxIFwuvkgHICsFLdNHnWatHD0lxfGUWf86qbCVB0
         NwO7ETzltdMjAfdDI1aeE8rqeDdOOJbo5HW6mSNceDWXSHjMtkSbCh4y8qY5d5gv1jzt
         0dOg==
X-Forwarded-Encrypted: i=1; AJvYcCU8SjTta8hMB+So46m98AaPhnVErd6Xt1xP1ULcT+rTaKNs5NGvupnmVYKv8ru4Z6hZ3fDfhHHmcc9ieMI4jv2BtZknSH7wyYLsmRQm
X-Gm-Message-State: AOJu0Ywx3SjMm+p5Syt7fPMW7btrK2DJSJkubuJ9KE7ezKv9yAOsD6JY
	jPVfwG+WKRdXlSJqzeNVp2iEelHS3wsrLVOaHi7gNz2okcakYAyK2u65GCg3zC4=
X-Google-Smtp-Source: AGHT+IEL+fybhARE+7Cp+PNzK40b0NktWZ2XX8e9+dzkx1Vftd0Ty9R044Lr8GiLB9eCUGDR+2Ikdw==
X-Received: by 2002:a05:6a20:2447:b0:1a1:7787:d489 with SMTP id t7-20020a056a20244700b001a17787d489mr301736pzc.6.1709804694271;
        Thu, 07 Mar 2024 01:44:54 -0800 (PST)
Received: from xu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001dcfc6c3116sm10083353plg.65.2024.03.07.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:44:53 -0800 (PST)
From: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add several generic edp panels
Date: Thu,  7 Mar 2024 17:44:33 +0800
Message-Id: <20240307094433.3440431-1-xuxinxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the following 2 panels:
1. BOE NT116WHM-N44
2. CMN N116BCA-EA1

Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index a0b6f69b916f..e21b4bb2bb3c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1952,6 +1952,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1138, &innolux_n116bca_ea1.delay, "N116BCA-EA1-RC4"),
@@ -1963,6 +1964,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_e80_d50, "N116BCA-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1157, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115b, &delay_200_500_e80_d50, "N116BCN-EB1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115e, &delay_200_500_e80_d50, "N116BCA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x144f, &delay_200_500_e80_d50, "N140HGA-EA1"),
-- 
2.40.1


