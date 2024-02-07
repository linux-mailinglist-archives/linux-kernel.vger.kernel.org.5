Return-Path: <linux-kernel+bounces-56380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4084C97F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D14F2841A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEA199B8;
	Wed,  7 Feb 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="qENNfVFe"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A251B7EE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304728; cv=none; b=AFLdsz5+9DVxKivcUuO6l0k09mCWyCQqrF9ULwszLnpt4PWylEW0SqXZ5kxwSNMFnJTUcePD9HI4b1xL7K6u3bkRuf8nmvgyH88C+txOlpND+KjqJVOSrFgHe6zI/WgvGisRDftn6W3pHMHM7C4Kih/11J1lxu30+10kx43nK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304728; c=relaxed/simple;
	bh=s3WTcI1IzbnotT+6dXJtqKdBOVBRXYxNAwhJyvsJF28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Va7zknPpA/PnuPUS9/C7HMhaDb/vi/oZ2QEnZqtiIO/Tf8eOR7knuzpUPl7OmUp6WvE79N8krIcOrDJtpnc0xQSrpI0I8Z4hIeKIi1DrWbJ1zNXYforQxigIwwB2uHga+ykNFofbcXD8/ZUYWFRRCzJDm1a6NhLJq1Fbczd3VK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=qENNfVFe; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e141ee9c14so204760a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707304725; x=1707909525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIqTMBlwECCoaCjtSPu7GBMR63K3xYDhekgHdgyJ3Uw=;
        b=qENNfVFesUHYbzwpT3BDEyzFcoz58qmGVjjApob/E5LXmPDwTyLepmi8F0ZP77Uyeb
         eB3GbtMpSQ1lAXVaxk/WooOE1Ww8vWuYeq5jje0gZnZckC9pFldSQm2x6LNq85Ilxj0E
         Q3MyfcTBl8ZPPDAw/5+x9mbZxvcew8kRtfdi4dY/WEBehMKMaELhCa8AXtqWbvFDhdAO
         qaahOIWZ7ejMZYNNB8i0mHmUH7nCT6EmSr072XDgBLiSM6+e7cjlQ5ClM9vlqtZmZDth
         q/kuyikDjA1MwstO2kJ/OluVWIKKsyDm1PV/INU7ZfN2DiS9cj6GulCdgB8yKDW2Sufq
         B9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304725; x=1707909525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIqTMBlwECCoaCjtSPu7GBMR63K3xYDhekgHdgyJ3Uw=;
        b=jzjegRNQ6JpG2l+acKWgYp6qTdmUjhAidK9+gPeLAelZW8/qfTDgr1qIMy6syazEME
         ynzL505VNLKoljbMHBAzGuf2wdWO+1Ahh/bM8Y21PrH2/hO7BAeujN4uiNNsOFy1ah2c
         AJellLbvK8xkq3GYqSrMbH9JFquSKsL/Xpw3htNc6Pojwbk2vFtS9Fi6uxyskPnsEqy+
         yjk2CGz0oI33w4zwH9iSwNUjGp1knHPsqY4Zgnw79lnaqXiwiYur3C6zE3YHICgz1K1u
         WvrEN6Lomq+9pFdDoZsPeA2iRMoBadM6IKzPQzkt275StqkV5EwPZG0qD4ZEU6ZLoL4p
         OvPw==
X-Gm-Message-State: AOJu0Yw3yZQ8Tsl4IqcOvIcgoxwxJgndv5uFGhK7S6Iyf0HX1AKY+29I
	rbGDJ/3+FVF4SOqh0L8ugUyrqkkuaSGwX71oDjJ8cKhGVi9/HOF4Y4QxXiwA8LI=
X-Google-Smtp-Source: AGHT+IGtmyjS7XyMK6mPlTBruiGOzta/vYcZqzFVH8gx2GKAR4MUHNsG7nk/o48FxHTKfeX8I5r7zQ==
X-Received: by 2002:a05:6358:a1e:b0:176:5d73:34ef with SMTP id 30-20020a0563580a1e00b001765d7334efmr2300769rwa.24.1707304724801;
        Wed, 07 Feb 2024 03:18:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDBZCqcU/ecjQFFfP1Fws3n8TlrjNFryuwLPxlTqdCVYrMnCBBXxfUkyHK/WGAHh7R821tL1nBH0Krw1wdwFkcxI1TcgsdG0qVVMep+k4mNLwoC+1Rnuh5Nvc6N9B4Epa4BrMW7/qxCg2Xk9zXVp4+ruO8p9V9Rr2bez48P9wSQgfJ/xOCO51cgF6uYzt0FMMAGTurzzygILHrwjN960mB9/ca05xbqCGSlC/r8lIwq0JZMiGtMWhYybPCCvcOBIYDNecQM2QcYmz8Sx5DM9aozAcsQa8anjRJL2Q5SkDdOSCEr03LHMEyhbfJQ7VvJkgqOVBwdkp7EhXg+ZHD1GyhRp2KQMoTqOsosogCheDiR5XmXosLoKE=
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id z6-20020a17090a468600b002961ccd55e4sm3492799pjf.31.2024.02.07.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:18:44 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Wed,  7 Feb 2024 19:14:04 +0800
Message-ID: <20240207111402.576152-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to PCI Express Base Specification Revision 6.0, Section 5.5.4:
"If setting either or both of the enable bits for PCI-PM L1 PM Substates,
both ports must be configured as described in this section while in D0."

Add notes into pci_enable_link_state(_locked) for kernel-doc. Hope these
notify callers ensuring the devices in D0, if PCI-PM L1 PM Substates are
going to be enabled.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v3:
- Fix as readable comments

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7f1d674ff171..a39d2ee744cb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1416,6 +1416,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1432,6 +1435,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.43.0


