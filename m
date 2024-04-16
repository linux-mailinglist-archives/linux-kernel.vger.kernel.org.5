Return-Path: <linux-kernel+bounces-146188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D288A61D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C4F1F23727
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D758E24A19;
	Tue, 16 Apr 2024 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhUe0dAZ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E622F0A;
	Tue, 16 Apr 2024 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239264; cv=none; b=GylLWu/TX7Dg9WrG2l+su8nrCk8TRS8CHHf6EKgs0ufYaBG8NY0XVeNM/7XdhAzr0Dsie9DGAArNsnHYLanhQlVGe6j+qez2zzYYGPl2Is6syToAhX2iv2FG58oGquxkLcrwdFsJTINBDsd/rATRFRxZNCTSxpiKTN/bWNngIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239264; c=relaxed/simple;
	bh=wLtQeaij1UkRJURSiqhWruB+lx4Jwv+x8lhGkvvqszo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6BC1CFbII2uRMQefcR0rQEZywCcsixhztdg/sSTZ1vzIeidIX3lI7TRgbbPwxhhJ9N9WGqtEbuf+icLJNazz4sTI5V808nQ8qhFj6BwaFmiFOl7FPFNWfAv6EaP2Vatf83KSVkoebcA43GIWxJT+LjSdRgfxSYcayuiXTgBiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhUe0dAZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a53a4a283eso3330997a91.0;
        Mon, 15 Apr 2024 20:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713239261; x=1713844061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxqWvddsK3MTcsP5PP2zajM9rLezNvqOsmF2usnJs6U=;
        b=jhUe0dAZf1SA+0xnn2B6z9+9uf3knpIvceNEmaFfKEXMf/j3BzCL8W8ryhJD7f0UqX
         GFEqpuf5rJf7wqzl4wVgP8ns3fFfEry99bvGihUc2RK6OkLz3rRei7sCrgcO25ULImpb
         2CDZU4EC/vtidoITgVHDvCEhZf5pz1lLf8L0O3J6VkgDhHYC/se6xK68J3Wk/OpST+c+
         tCF2IK2rpfVEiwqoHKlgWu4/uhprVBv191MbE05FUuH/2SpmdIFZXYgk7j92FN+J6a2T
         7+SmLCvQcYLtxlXhzYE3c+tm165L7BLFAhDtyquddHhiACfpGdEHlIADYTPRMhJ51jDH
         suPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239261; x=1713844061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxqWvddsK3MTcsP5PP2zajM9rLezNvqOsmF2usnJs6U=;
        b=p7kWSmOZl+fhwtXaG+BTLwOgMZEXVPggkfl2p9BcPSGQV44hPOCPhzZ4A3eX3B70Ej
         HpmhRDR+AZwKG8DljHKGgaG7hyJ3LWriKVfyrTMXoZXzhsUliAbXsPCDiRLTIBVKiHfV
         k+PegDJ/bacv7gRisAYBOxzP1rtY71M96nVspPiTia/5M9UHpUiAUDS0EZpV7ItXPon4
         jfIAjxu/vH9oHIMCFlVYgO3M8AsAdSGY/Ae18JdeHTdPYBOOjI45xtF6hmUp9MwVMhoM
         lEQAxPLF9KcLD8NE+fin9DO1uyed8gNU0GVV27hvmnb3UKg2OPDwFO+GsGhH7Et3wh+E
         +z1A==
X-Forwarded-Encrypted: i=1; AJvYcCVM4oGyP7Eln8shGJHzpLIRziZtIG6gvHZQ4IO8esm58vz+Fxanku03XUwv3m8+fKDQopJp5SFEdGIvWS17Bq7jneThxNotq4+gxHFt
X-Gm-Message-State: AOJu0YwQkeXRXQt+ZAS6WyZENb8kLAaN3vccsa2ozqLPJkg4SElGZOFR
	1xyZf7S25w89288OwqWGhIRwMMGF/k2EmnBdj8MbNCPr4S5GHjZ4QmBDHIij2Dw=
X-Google-Smtp-Source: AGHT+IFSAyh/H7N2ICssOfQ2GAq52mPe+DM5mYfpzUlOiwseqH3p2hzoggxEx5ubCtHWFUkP0rvWIg==
X-Received: by 2002:a17:90a:de92:b0:2a5:52c3:4ca9 with SMTP id n18-20020a17090ade9200b002a552c34ca9mr11313420pjv.29.1713239261470;
        Mon, 15 Apr 2024 20:47:41 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090adb4600b002a51dcecc49sm7748815pjx.38.2024.04.15.20.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:47:41 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Date: Tue, 16 Apr 2024 11:46:24 +0800
Message-Id: <20240416034626.317823-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416034626.317823-1-liujianfeng1994@gmail.com>
References: <20240416034626.317823-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for ArmSoM (https://www.armsom.org)

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e4aeeb5fe..e47405535 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -151,6 +151,8 @@ patternProperties:
     description: ARM Ltd.
   "^armadeus,.*":
     description: ARMadeus Systems SARL
+  "^armsom,.*":
+    description: ArmSoM Technology Co., Ltd.
   "^arrow,.*":
     description: Arrow Electronics
   "^artesyn,.*":
-- 
2.34.1


