Return-Path: <linux-kernel+bounces-98869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C1C87807D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EF61C20C59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FFA3FE55;
	Mon, 11 Mar 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YBgKCB/2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF43F9F8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163403; cv=none; b=SwXeqZQ8TOnXOykvYjKJ8j/FER4JUJgGdc4P4OWAbWBwVOeOS/Cp2LnC82ZvyM6Os2bF9AJ1UG6RGwnQ3B9zeHDQ7ZMtdi1PCtpMBI3cm/3qb+7KJYSU/Z7dCZZrH5ZwJwVPsVkRbHkucnuyAFzAl96XXxDUpSVMxS+7hO0vEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163403; c=relaxed/simple;
	bh=KAB6hhZAz6A8i0BnoCpdZg6DUxWcJAZtEBcm2aaeNXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQCOAXvcs6AHOtfoUDHNow72rLu8p5xr/EvWPL7ZBciUcrkwxCBKVjsbPAZ+ujbes1MlvhOehVgkObbKjskPOZu/CPw10VKamhOTZ8b5AReKx8DReGo/41v1yun7kPVSqa2og8jwZS6jdBfO3Y+b9o14C0oft+ceawzIt52C3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YBgKCB/2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45cdb790dfso454925566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163400; x=1710768200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvd6aj0X2hBUl6mM6641rETJeDz5pw6wHYPDi/FbNkU=;
        b=YBgKCB/2W9AZu+aynlOK0YReY0bJppgOhyj6xbm7mxniHTIefUjiCUBNiVSAjf6Cy9
         Suw8b2qhzytr1eKWLb7Rn/Ol9Z1HSCV76yvRc+vXd9wCfqaK/l2T9Ck4DRciO+O81EXb
         yu21hVQ2yjp8s0zp9pSF6+wxLlKCV0zjIj7Hi3pH8kAmi//Q0jG/FxnH2GlJlKDspFkE
         jV39QvmedZTaL8gLg72+F5GRgMBVOBjqMwiPRRO/GilIYgBbqwbvU/qfvvG+aiNJYuZR
         1pRYo7r9KM1LKgN7tlE5Cc8fqM4WSfH5ZKQqLqZWQ841DRBY3UqzkccRl/AG7gvz2K70
         o3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163400; x=1710768200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvd6aj0X2hBUl6mM6641rETJeDz5pw6wHYPDi/FbNkU=;
        b=qpuFguoabd2B+zPhALt8YvYdq3NQATMpi+RgaNKJ5oxl4+sRveIB3DKn8dFfqksodh
         JUPbrWnCwGM98nieXYVckmzV4m59bStzIJhZ0RxjVEPaDyIx+40ltBG1oD0VONOob3PJ
         EwwL2cm2zHLN5atpt/8o1u8mJ5fAmMracDx0N1qFeAjdJ1qC2GDcU0fRPXPbAUPpYVzz
         kj7mPqICB+axCiyKZqdX0UvulxkOT/AxwjP+UMHZImCpDFQqiIKTGHhqdxjkWXk396Lc
         t9JKlT4Fjs3oNp/RKS6NK4606tqo8Uflb77mybzV78sUtLSOztweqGtCmfk11stEjoWV
         Ze0A==
X-Forwarded-Encrypted: i=1; AJvYcCU2JXGMghKKVPaevlY3Yt1jBEtyPSK5/Hfiod8SPG35w/8INUMFYo+Yz+KcA8JTWVJlZZ943eMYZMpJ2nY4FIU/yTy0IDFV244i5vxu
X-Gm-Message-State: AOJu0Yzy2H4wMyIIpTW0TtJLLc059XTGrH50Ql16XeEfY7jfh6bRmFpb
	P6RegEEj+EnNt4zLO39kWlvhrVjdTYPkshbxiznG4+6Eki1TP2S9TI03Gasrp4Y=
X-Google-Smtp-Source: AGHT+IGeboUs/c/b90bnp2CO6TazhO2bLzxUqB3uAeCN/iOeWl9yRmjEm98YOo+49/4l8Arc5W0CNw==
X-Received: by 2002:a17:906:b14e:b0:a43:6cd2:7bb7 with SMTP id bt14-20020a170906b14e00b00a436cd27bb7mr4381632ejb.47.1710163400110;
        Mon, 11 Mar 2024 06:23:20 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm2861075ejb.79.2024.03.11.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:23:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 05/11] arch/alpha/pci: make pcibios_claim_one_bus() static
Date: Mon, 11 Mar 2024 14:23:00 +0100
Message-Id: <20240311132306.3420135-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311132306.3420135-1-max.kellermann@ionos.com>
References: <20240311132306.3420135-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is only used within this source file.  Fixes
`-Wmissing-prototypes`:

 arch/alpha/kernel/pci.c:285:1: error: no previous prototype for 'pcibios_claim_one_bus' [-Werror=missing-prototypes]
   285 | pcibios_claim_one_bus(struct pci_bus *b)
       | ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 4458eb7f44f0..71495b1354eb 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -281,7 +281,7 @@ pcibios_set_master(struct pci_dev *dev)
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
 }
 
-void __init
+static void __init
 pcibios_claim_one_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
-- 
2.39.2


