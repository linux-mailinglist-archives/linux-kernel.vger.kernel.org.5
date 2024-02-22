Return-Path: <linux-kernel+bounces-76704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E185FB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624751C22C63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014DC1474A2;
	Thu, 22 Feb 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMQy/uoZ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1F4436C;
	Thu, 22 Feb 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612404; cv=none; b=I+PhHyfZFDnTdqMCVg/fU5k1F93l+TYUVl0+nSuC5VYKvT/PVlDioR7GU9zUNoetxEYMVJmbeuFvSJwry5a49HA3WIHQwch0IRdTIsyHvveeYRsoRwMeGDMQmHCWV0uBJKVcHgiA3DZ2kkYEPOQ71AL0TSGBJj3S84pq0lLTAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612404; c=relaxed/simple;
	bh=7Nxd9L0hTx4wS4KdRxCSjT6nCn4X+i13aWUcdkoxH2o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B87Z1aRG+hAIAaXOPWtbYGQTJbC7tU1OX0bkkwb4gzdvNDwSWceXcpeRQF4kmq7Zm12z4daqOZRbRSxXimkUBV6WeMJr6m2SzutFcb+zX+TSGY74tKYAsXfwGluWPWmhXTGiDYZnK2o5c0otiVZBb3V9d1+ZhG9KF/KsCTBn+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMQy/uoZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a293f2280c7so1145202566b.1;
        Thu, 22 Feb 2024 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612401; x=1709217201; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldyzz6/JzuL7eIas6PfwBWLiCcFLpsFRhU47ib609w8=;
        b=eMQy/uoZ7i3VOPPd+/IwRfRO+1+PJDPiLBizbL9YThX0mrnXL4CfcRksN+fUmAYQr1
         c29IcXO7Ue+ZLSlSLNGHVoYDi4JqYR7teXw2GgXPFZ6U7apBj/OnMORsI3S9TX8i/QQi
         jjmk7OvryjKJOHofcIec1LWzXXQiIXMBIUL/9cp4UDz0lEftanY6aoluFePIwdu05+Q1
         6m1i9XFLexxRFJvinV0fhZnsGxUicmjccD2ZrhhSeBpN/kElACrQuzbLKMwtDrmeCGTc
         9VgMfxBScDQ9dwPjhAnGRwemL6hHNcT7D+QvOzkefjxqbp3tm3IP4TCmp3FMUeZq/he5
         Z81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612401; x=1709217201;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldyzz6/JzuL7eIas6PfwBWLiCcFLpsFRhU47ib609w8=;
        b=gAbfHcU2ZlRDmU2bTRnj9+szhP2o05Bp1eb62cT8sUP/Q2XIamGBkKdeLJv1v5skrw
         EpRmcz/E1AYxQtOl5TkeLXUDgSFv3tJUjckifP9HuzNJhztJki5+53KRbpc46KUEJDnb
         3gzC/031/MLRO0lMk3r6cVQF7RY0aOfXWEHiZPvY20TLjE8KOsqvcQrEGOLSPchQ/kn6
         h1tHifuvI5QsinYAl88IK7rXeGqCziHaApwYaux178tmSLFFtCTsY9upO9oFNIiw12vu
         vW3EzVDJqwFq3neCkOeW/ovx/7Oz7PFv166ayMF8ytzOhAc/5i0GoRz+B5gkx4EPhLRD
         YVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBr6h/69lu3vRmV3moOnSRwBPhhytjUyYFOBuIC1uryRYkmm8psPqxapjk5oeM0uTp/5hUeE4IGyKFA/h85a12FSobDi3ULzYdcMkU
X-Gm-Message-State: AOJu0YwYLywiBTC4uUy9b6ghJcFNblZS/vU90TVDi9X/yTrWB7F8h9Qm
	9M1eY01WUAaiUlpGANkjJ39dII5uUqWCXLWNhjyg5DUgpoYXrcD4zZObg0JM
X-Google-Smtp-Source: AGHT+IE/mq6F4oG3XuFKcZ0cPjBTjZcJco4+3Mo3sbwsAXaFVeGGVeSxCh/cb3xzKOmdp5YiV9BS1Q==
X-Received: by 2002:a17:906:69b:b0:a3f:6302:1e61 with SMTP id u27-20020a170906069b00b00a3f63021e61mr2516651ejb.73.1708612400745;
        Thu, 22 Feb 2024 06:33:20 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:e4dd:831d:c00a:fc45])
        by smtp.gmail.com with ESMTPSA id vu12-20020a170907a64c00b00a3f15cb8d9dsm2245506ejc.126.2024.02.22.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:33:20 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove entry to non-existing file in MOBILEYE MIPS SOCS
Date: Thu, 22 Feb 2024 15:33:12 +0100
Message-Id: <20240222143312.27757-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit f34158edd249 ("MAINTAINERS: Add entry for Mobileye MIPS SoCs") adds
the section MOBILEYE MIPS SOCS with a file entry to the non-existing file
include/dt-bindings/soc/mobileye,eyeq5.h.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Possibly, this file was part of an early patch series, but in the final
patch series, this file does not appear anymore.

Delete this file entry in the MOBILEYE MIPS SOCS section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28b2013031bd..19ac6a8e46b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14914,7 +14914,6 @@ F:	Documentation/devicetree/bindings/mips/mobileye.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
-F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
-- 
2.17.1


