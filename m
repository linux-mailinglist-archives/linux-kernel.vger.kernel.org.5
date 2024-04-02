Return-Path: <linux-kernel+bounces-128826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DE896009
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DCC1F23B63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C24316D;
	Tue,  2 Apr 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KKz74Jyp"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E791E531
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100227; cv=none; b=N2daG33yFAHIgSlPMuDcvzPT7Udd+QNzzTSWumy3dRXNAfx+Y1Dtf/C4tlHNhKe6NquhDkPV/PCzuCP6vSf+H121Y3s2XBmLWCDoWhAW7EvwtQTdWmh3mgUha8FSdkl5gGzI8mRYbeL/0BsSu5YFpbV+ZJzk3Ms5U3ZaNR7pUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100227; c=relaxed/simple;
	bh=FqmDIWAuuNgxhuaI+lrwDwVXkXA9vVM36hJIkCc3aTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lRZxqOEIJyeqz3kv2vY82UhYnbd8U9ZTB244Kui1uIa2Vx65Rte9+oFAb5Raw68QcgHIxNIcOTHcQA6PXcJ/nQhXts77u5orZ0JdlQStLHj5zF/qfY67vYoPU/DOYq77KeQCKTxUXq+rSc4scrEDrUDoPwe80b4/giQSNt45Des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KKz74Jyp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so2641999b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712100224; x=1712705024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3CJUHt5BK+geoIl3sqlKRqO4MeeWL/9252qrQSk+cE=;
        b=KKz74JypiyxkiwMcwxvcpPqTL+kuc2RlDP5kmMe8EaICGPJ0agYi5647Hl8wbs2sZA
         6OXKLOdtGBBp+NHpPoD2mO/kMPOI2lplW0dvYFbPHOBI6HvcotMWL9SvWKKutLUxzZwg
         LY1WESLMUQDKPYuziLm9ZXJtXNoZpg8WYrIc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712100224; x=1712705024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3CJUHt5BK+geoIl3sqlKRqO4MeeWL/9252qrQSk+cE=;
        b=LhtxpvQ9yGpGV+zuNMZdsP4OJsbkaVTj4WfwYv31SHuwDHJQD4zjeUTtIs73GHwngp
         M0viuPXgJfoDjnDJ2e3p6Z0/bGkgTuoJxsFM+F9ULnF0b/5r8xhSt+SCpQ933Te2JfhN
         k7KBImaiu0UKT0/Xj3M17zN67pmvK3hitXPh/RjyLARwdtNPH9moj7+pEbopVFFDe8G2
         UaCX1cwSUEeU08KwZZ1sYSkWTlUhlA5zGWnaMH6D3q+/+S532oM2PT3o5QUZ7I5sbKNy
         FkC1HwWKMrHIctO7L9mJWZMcxL2SbP7xbMuipyEdD3T3EfvNEB7lnPoua81U909W0ryp
         2CoA==
X-Gm-Message-State: AOJu0YzgYaBB37zRZYaAFOsJUV+hpF+UN5ONf7JRbzTh2P5HoIKl826F
	sP9eSLFvyX9KrU7aDKuYnelzKYu22OfAsMVoLdPhyd6H2AonesxFODn48nMjhLVf2zjUIS64WOS
	h7hyYjWLwfaeOPxSxHJbt1pIeFVXURn3noIzuUB0pmtsVTCxMt7Fy4U+K+jPrVoTZ0XCLoYZve8
	kPh8OigxRmLvD/a5Djc+CENriAqhX3+dakJGsXgKBJnjunBYcf/7ntudI=
X-Google-Smtp-Source: AGHT+IH62Ia5IT9HQRqU3qRgeeLZuB6ahM06JqZO0bL1ibZHpVHX7nUKOqRkOJ4mECfMVmJyjSEMSw==
X-Received: by 2002:a05:6a20:100c:b0:1a5:7309:a81d with SMTP id gs12-20020a056a20100c00b001a57309a81dmr1243247pzc.53.1712100224342;
        Tue, 02 Apr 2024 16:23:44 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090a678600b002a25bf61931sm1937074pjj.29.2024.04.02.16.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 16:23:44 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Ronak Doshi <ronak.doshi@broadcom.com>,
	Nick Shi <nick.shi@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH] MAINTAINERS: change vmware.com addresses to broadcom.com
Date: Tue,  2 Apr 2024 16:23:34 -0700
Message-Id: <20240402232334.33167-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update all remaining vmware.com email addresses to actual broadcom.com.

Add corresponding .mailmap entries for maintainers who contributed in the
past as the vmware.com address will start bouncing soon.

Maintainership update. Jeff Sipek has left VMware, Nick Shi will be
maintaining VMware PTP.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Ajay Kaher <ajay.kaher@broadcom.com>
Acked-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Nick Shi <nick.shi@broadcom.com>
Acked-by: Bryan Tan <bryan-bt.tan@broadcom.com>
Acked-by: Vishnu Dasa <vishnu.dasa@broadcom.com>
Acked-by: Vishal Bhakta <vishal.bhakta@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
---
 .mailmap    |  5 +++++
 MAINTAINERS | 46 +++++++++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/.mailmap b/.mailmap
index 59c9a841bf71..8284692f9610 100644
--- a/.mailmap
+++ b/.mailmap
@@ -20,6 +20,7 @@ Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
 Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
 Adrian Bunk <bunk@stusta.de>
+Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
 Akhil P Oommen <quic_akhilpo@quicinc.com> <akhilpo@codeaurora.org>
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
@@ -36,6 +37,7 @@ Alexei Avshalom Lazar <quic_ailizaro@quicinc.com> <ailizaro@codeaurora.org>
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
+Alexey Makhalov <alexey.amakhalov@broadcom.com> <amakhalov@vmware.com>
 Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
 Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
 Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
@@ -110,6 +112,7 @@ Brendan Higgins <brendan.higgins@linux.dev> <brendanhiggins@google.com>
 Brian Avery <b.avery@hp.com>
 Brian King <brking@us.ibm.com>
 Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
+Bryan Tan <bryan-bt.tan@broadcom.com> <bryantan@vmware.com>
 Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
 Can Guo <quic_cang@quicinc.com> <cang@codeaurora.org>
 Carl Huang <quic_cjhuang@quicinc.com> <cjhuang@codeaurora.org>
@@ -529,6 +532,7 @@ Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
+Ronak Doshi <ronak.doshi@broadcom.com> <doshir@vmware.com>
 Muchun Song <muchun.song@linux.dev> <songmuchun@bytedance.com>
 Muchun Song <muchun.song@linux.dev> <smuchun@gmail.com>
 Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
@@ -651,6 +655,7 @@ Viresh Kumar <vireshk@kernel.org> <viresh.kumar@st.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.linux@gmail.com>
 Viresh Kumar <viresh.kumar@linaro.org> <viresh.kumar@linaro.org>
 Viresh Kumar <viresh.kumar@linaro.org> <viresh.kumar@linaro.com>
+Vishnu Dasa <vishnu.dasa@broadcom.com> <vdasa@vmware.com>
 Vivek Aknurwar <quic_viveka@quicinc.com> <viveka@codeaurora.org>
 Vivien Didelot <vivien.didelot@gmail.com> <vivien.didelot@savoirfairelinux.com>
 Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index ae447c08a11d..2658c4cc22b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16731,9 +16731,9 @@ F:	include/uapi/linux/ppdev.h
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-R:	Ajay Kaher <akaher@vmware.com>
-R:	Alexey Makhalov <amakhalov@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+R:	Ajay Kaher <ajay.kaher@broadcom.com>
+R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
 S:	Supported
@@ -23666,9 +23666,9 @@ S:	Supported
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Ajay Kaher <akaher@vmware.com>
-M:	Alexey Makhalov <amakhalov@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Ajay Kaher <ajay.kaher@broadcom.com>
+M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
 S:	Supported
@@ -23677,34 +23677,34 @@ F:	arch/x86/include/asm/vmware.h
 F:	arch/x86/kernel/cpu/vmware.c
 
 VMWARE PVRDMA DRIVER
-M:	Bryan Tan <bryantan@vmware.com>
-M:	Vishnu Dasa <vdasa@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Bryan Tan <bryan-bt.tan@broadcom.com>
+M:	Vishnu Dasa <vishnu.dasa@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/hw/vmw_pvrdma/
 
 VMWARE PVSCSI DRIVER
-M:	Vishal Bhakta <vbhakta@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Vishal Bhakta <vishal.bhakta@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/vmw_pvscsi.c
 F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
-M:	Jeff Sipek <jsipek@vmware.com>
-R:	Ajay Kaher <akaher@vmware.com>
-R:	Alexey Makhalov <amakhalov@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Nick Shi <nick.shi@broadcom.com>
+R:	Ajay Kaher <ajay.kaher@broadcom.com>
+R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/ptp/ptp_vmw.c
 
 VMWARE VMCI DRIVER
-M:	Bryan Tan <bryantan@vmware.com>
-M:	Vishnu Dasa <vdasa@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Bryan Tan <bryan-bt.tan@broadcom.com>
+M:	Vishnu Dasa <vishnu.dasa@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	drivers/misc/vmw_vmci/
@@ -23719,16 +23719,16 @@ F:	drivers/input/mouse/vmmouse.c
 F:	drivers/input/mouse/vmmouse.h
 
 VMWARE VMXNET3 ETHERNET DRIVER
-M:	Ronak Doshi <doshir@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Ronak Doshi <ronak.doshi@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/vmxnet3/
 
 VMWARE VSOCK VMCI TRANSPORT DRIVER
-M:	Bryan Tan <bryantan@vmware.com>
-M:	Vishnu Dasa <vdasa@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Bryan Tan <bryan-bt.tan@broadcom.com>
+M:	Vishnu Dasa <vishnu.dasa@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	net/vmw_vsock/vmci_transport*
-- 
2.39.0


