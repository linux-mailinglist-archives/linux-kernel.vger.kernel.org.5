Return-Path: <linux-kernel+bounces-96395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4C875B99
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39FD1C20FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE20B648;
	Fri,  8 Mar 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="nJEX4FqH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288C6AC0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709858894; cv=none; b=rFNiQQLhHBsNcYLJyexiY4vF1Oo4VLJwlZz9cv741D+9aoY6a5KVqLMknrSVotM1ulJeG0im3vv5Fs7Dw/xJLDB3D9q1Y8acBo8nqd+FA/3G8UCbIO3VULukvFFOdF3mwpXpgng/Hi7s7CL41kEsciS9ecWya1XyL9PvUpmfDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709858894; c=relaxed/simple;
	bh=x7i795oc4v+t1eVSTstgC0hgt1XNgHMNLBknwKT8gn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+84MmYfnIwz9e45JdUNsyg3T/SKGkvv+f3dz+ZJWmohJN3RUPCxv0urLnd4tC3S/qhU8X5jweT6tXtlQ+5+DgOusC+687l8lVSF83uG1zdH+3++NZgL2RAwLapJcGnRUw+V3cBgXh9vcaqqmXmumGnJ1E5IzX6MhUi03Iadu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=nJEX4FqH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d944e8f367so13139855ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709858890; x=1710463690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRm8D61etT1wEE9ZqTXPR465tYE154OjnBr2zkyvLfY=;
        b=nJEX4FqHrGjltlxLD73vtmkl0M3EHI+vCIf9xQi9a7zNkf7mMpuncQisYybtaA4M2e
         liyiPN+1QbaQ5Ujiyd4yhXiRBJZ6sctn9YzG0b53dGGkOqYsyIo3TKdo/SoVzCPAoDCY
         wQTP5rOeoaPhedpr7HJ3QWNwF2sGtg/tiOD6vuVb50v7KkGX0Oowy6jUcFWfUYikHNVC
         gjSF6DZD3haaEgGe0gilWykHKhaCI5OmvPG757uas2plUTe+/nUyiiQ7Bt3wTIS8foKj
         sUP0pHvGWz6pibdG+ABBXzKpn1b9B3+8+XEBoC6/jJD92k8X5kxGWM85dIYJ5el6+XoU
         ZPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709858890; x=1710463690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRm8D61etT1wEE9ZqTXPR465tYE154OjnBr2zkyvLfY=;
        b=SjVyYdaXhb1esOa7AWGsFYHKWIIOy2mbM/kX9blvqnrhlbOLYNTnWBgn4yjAOpqdN5
         ciehOWM4flA4sqXsdS6O/N7PtCU5FJEMWateWN1svuW9/b8l4gpFdJFZKG1bxbgIQ9AG
         PGjLjdQ+reC/39XNNvcGrK5boVTnCdco9TmbTH0BhprL1ge8oce2nX+O+Sq79mohqVd+
         3TVoorop2EKHZN0iqTl5h7v8GriWdPjMklLrA/G/IbBsOauMekisQ8I/sG0VpJkrw3L1
         Jjnu4XhthNoGZ9mPb24QX+B9KFY58hVSHD7Vb+dTsLs2ExJpteTQoLyn7CZtZmleeie+
         Vl3A==
X-Forwarded-Encrypted: i=1; AJvYcCXtK6iCkXhD/JLs+EypQDxpd53bXhzFVoHJdICYaDYMEVc3EvALp4Y2+e9A5kZf/lOWZHGTPfZ9/bIkRslqgO61kh089kPxhpFDzNtg
X-Gm-Message-State: AOJu0YzWA19IwbL3baB+NELG2nToR+OnxI1X+eOmtUlOsTV5LFVKtTod
	HwFrNZ1fuHxtflTT9KFPyDx9BScrokPy80Zx2UnCiKxgDOyqvOJlwPbSiGPWeeM=
X-Google-Smtp-Source: AGHT+IENi1OtAYtCq66iswHj76HX1V9umjMChq2vno/A5VuNp8Xeqzs/a0D0DwP3R6xNOwINfRfFcg==
X-Received: by 2002:a17:902:f705:b0:1dc:a844:a38b with SMTP id h5-20020a170902f70500b001dca844a38bmr10788072plo.67.1709858890503;
        Thu, 07 Mar 2024 16:48:10 -0800 (PST)
Received: from xu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001dc819f157dsm15233055plg.251.2024.03.07.16.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 16:48:10 -0800 (PST)
From: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [V2] drm/panel-edp: Add BOE NT116WHM-N44 and CMN N116BCA-EA1
Date: Fri,  8 Mar 2024 08:47:57 +0800
Message-Id: <20240308004757.1048284-1-xuxinxiong@huaqin.corp-partner.google.com>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---
Changes in V2:
  - Updated the subject of commit message.
link to V1: https://patchwork.freedesktop.org/patch/msgid/20240307094433.3440431-1-xuxinxiong@huaqin.corp-partner.google.com
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


