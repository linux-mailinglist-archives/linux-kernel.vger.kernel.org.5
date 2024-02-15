Return-Path: <linux-kernel+bounces-67649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE777856E78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCBA1C22B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EE313AA40;
	Thu, 15 Feb 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5UG7MEA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DE6A349
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028445; cv=none; b=MHl6gmeMJj+ftvUbtcKgyOkUokM/Ia/XI2Kxxmx0qONZthlv11I7RaY5oNmyH2Rv8uHULQoDonmiQ4qoW0iuWnXdh15GeCVbmjMgFWq37gikr1iKeDLf34gdCpSUMeH2qaEk6obk/IpwAbwG0j/HbOh9CXF34Og/epWR7a9IdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028445; c=relaxed/simple;
	bh=GUrCuvaMsWj0/xUSDxQpIgV6PY06laSsIUwkJYDKom8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WRui0Im+IdM3lNcjJtmWCYSyOmg5sR/tm58N4f6YADG5e3yf0Dn0SGDhdHIdst6e6w2uSg5CxhtMXT6nRbznutAc/aHHIEK3Ah1IaPzJTIF5HcO7nMu9Z+x9IGqUlkj7bHKareeJVMnLhRDzoVK4bPCc3sE7lu7Kf55Ck6mwFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5UG7MEA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d94b222a3aso12287795ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708028442; x=1708633242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kYT7kMbPEpJ8aaVdr6Fn5P1pdcsBqmTjeLPlCF9d5HE=;
        b=a5UG7MEAdwKhcpxjWn7bthXaVjzQKdawEtykEmAWjVcWIrRavR5U0XHRcYZYt2Sg+2
         p6KNVteWN82TWDYF1kGtk3lbdiIBMUj7pzf+h6surxJF4a5E8No/KVgMJQkxctNoyjdW
         jWgrYBOJ2DK1u29QKHVq4zPcV9h99y3nBhXw54CPgnvmMH06jQnogQ5bjyHoIc0rxFkN
         7kWFojrlmi/GsfNyz4W7Aq3IwNfEvZGfZ8/x4O7tIKqMSwLFkdXLO9ZDaGkf82NvS15S
         6p68AZkNOB0EEJQeHTF1aFUIo1ndFnQbPdxU5wP/fSbvwcs6AmLeLy3OwlUix5k6F8o/
         t4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708028442; x=1708633242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYT7kMbPEpJ8aaVdr6Fn5P1pdcsBqmTjeLPlCF9d5HE=;
        b=rqvf620jky0vmTA3D2kCIVrsLe8qaoxGK0Rf4a8qT5phVxKifoFYui4jcGqfdKzg0k
         7LtOiPB/fsPhuA1WCgRWeHeySdVs1L1rDyZANC1Muo4QBuUjo4ae+fHrFcva9WsM72ro
         tvYSyV4KdsJN/GYqwVugqTfWWbWeU85zgYOpu1pVm0GMVvl3L9cFquSCwmkgMQdEbR38
         u6hDltEvW5gov4gq6SFaBdH3dYQiKekBNH8fGC1J/OHxQYL1Xso2rn9zMqHAihfpAP6U
         Aily6xbkyDP8CiD7zx95lgvSx75wND/Z1VsoF0kiaJTr7xltAncO2S7s5zFhkR/4fcMt
         8NqA==
X-Gm-Message-State: AOJu0YzJDw44FAFk6Ar8lCKJvascMXurrtRBM8KUm+fdWKO55G1ylqGj
	gr6IaFujWSZD4+eH9kcR+uA2+XsJguQZT5AioClr3DMuobanHMb1ZtDoxBu6
X-Google-Smtp-Source: AGHT+IFbKF5If7ECeMtnKjfyd+6SYon8RtXUFlbKAxXLKlHkDKgwlQYzy/k+gdK/89mzvDBxgNiGKA==
X-Received: by 2002:a17:902:9006:b0:1d7:524:a4f8 with SMTP id a6-20020a170902900600b001d70524a4f8mr2817732plp.41.1708028442578;
        Thu, 15 Feb 2024 12:20:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kn15-20020a170903078f00b001da27b24a24sm1678213plb.1.2024.02.15.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:20:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Drop myself as maintainer of TYPEC port controller drivers
Date: Thu, 15 Feb 2024 12:20:39 -0800
Message-Id: <20240215202039.1982539-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am no longer involved in Type-C development and not really current on its
status and progress. Recently I have been doing more damage than good.
It is time to go.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..ae3283f9eceb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22864,9 +22864,8 @@ S:	Maintained
 F:	drivers/usb/typec/mux/pi3usb30532.c
 
 USB TYPEC PORT CONTROLLER DRIVERS
-M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-usb@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/usb/typec/tcpm/
 
 USB UHCI DRIVER
-- 
2.39.2


