Return-Path: <linux-kernel+bounces-89837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7812A86F648
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E7A1C21F3B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560976E5FF;
	Sun,  3 Mar 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqmwi/Pl"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1B6E5F2
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484977; cv=none; b=jE5I1ojaXmi2xJs/ig/vp+wCwRZeZOl7oTkq4QqbOpjjiJriIxG9Bdo7HsIHLJhNvM+tl93vZwNHLprjJiOFLjRmMAt8GUxM31Vuo0s0rKAJWXNCjJBJfOAgiWc+5aYmBLBLfguULaCJ+s1STTM+Jl/u96HZL9sVSNEAVrLuhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484977; c=relaxed/simple;
	bh=uB8M5ZFqU823RPwkCme41wqgW8S1MAohoBHD2f/FRBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=odr/Amoujlf9h5IG8AKxvSwEQcyiQ+/yoLDZ8Y4uEqZqivPgZ/aW+ifi40CxkeJSuKtv4+48FnCjh3WhFqB1zWHYRcfsTzX6Ri93JTsprdF0n4VxdV8XJwPSRIctholX29O9+h3psQSZIZvFXYV+8JRxIvLore5RiebaQEkdOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqmwi/Pl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4467d570cdso355832266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484974; x=1710089774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5trdsWXQ1l+BmpkQ2xBDJEcjKE6ifeu1ZxitnKw1Sr0=;
        b=cqmwi/PllCioeUBKq3Rhwew0j0bOzZX1ns2zSLAQI1w5pYe4FHi14HQEPT6fnLVdEu
         QEY2m5sBs2LfJ+52tx+ZAVLi9OyXjkraqN7PB36NiAsdmyRuFzK/2bYUXGa0EbC2eT6g
         jd5cXk9pk61szw+6mxqxnSxXnmiS685SHAhWblJLjSBW2LiI2C4O0thDMX/NOH1PhWMC
         fuuv4H3aogNtN/0MBs30DPpbr4kZTJCXDCd4fn5LqdXHlrL0qyHohOYZUmy8k8Ep/klh
         W1ImZdy5q4fZy6S49t+oxDO7WiAsoUh+zuBgxlrT8lta7Jl+5BwX6TkQoNvEyYeHqVnP
         JMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484974; x=1710089774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5trdsWXQ1l+BmpkQ2xBDJEcjKE6ifeu1ZxitnKw1Sr0=;
        b=N8E5w8IzdHkAar5qbHTyanPFKCZLP94t4zPkUHOQH1l2gLmm3+iPwq+JK+7mksDNM4
         qmrbDZ2ZgsZ6G2ViOyhIhvJwqkGyFMybyXj5Khuu+bnZuHJrm3bAkR7Wyq/RxbMzV/uS
         THFeUHG01pDVL4tzXV9Es5cmZCAhCPd/HpjyHwBNw5PguiRcYs+sqiHzbBPoZK2d/gVd
         4g5w81bWbIxLySqBkI4NyTxEy32lIteV7urqPf51vKKfgjuIjWAIMoaQlg1Ju1697Vmy
         u5K7YPpGLViQie11Zbj6gMEEKNDBMu9GC7pGaP6hXnf/Kg8+CUX0EOevky7bgZEoezPA
         buSw==
X-Forwarded-Encrypted: i=1; AJvYcCXypSU5/LzuZZrnD1KamzZFQ2nfMm067q16DgKs5p+6K4wqp2PTMRkFt428R51jPDOR7YcNZhchiMoa7V7nxTjjkECgeyd2YoK+mC/d
X-Gm-Message-State: AOJu0Yy5IJts2UdyDwZX5XBakleYVea7SmVIdA4f/Lquh8R2vB1Qo3qN
	o+VUcOpeQxXqkMHz3WbMHZyER4kaDNR9tRHjPR1ZPNW8MaqqiVOX58P8viLZfwUZnw==
X-Google-Smtp-Source: AGHT+IFr/+Q5FwilXYnFHkS0oVria4ZfBK0SJnLPrIG33Hdow0H6P536dcBvJTBTiocc7mUIugoG6A==
X-Received: by 2002:a17:906:d20a:b0:a44:505f:bfa9 with SMTP id w10-20020a170906d20a00b00a44505fbfa9mr4354830ejz.58.1709484974130;
        Sun, 03 Mar 2024 08:56:14 -0800 (PST)
Received: from ubuntu-focal.zuku.co.ke ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170906e94b00b00a451caaf82csm715904ejb.65.2024.03.03.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:56:13 -0800 (PST)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [PATCH] Staging: octeon: match parentheses alignment
Date: Sun,  3 Mar 2024 06:23:19 +0000
Message-Id: <20240303062319.8779-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct parameter alignment in cvmx_spi_restart_interface().

This patch aligns the parameters with the opening parenthesis for better
readability and adherence to coding style guidelines.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..44cced319c11 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1362,7 +1362,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					     cvmx_spi_mode_t mode, int timeout)
 {
 	return 0;
 }
-- 
2.25.1


