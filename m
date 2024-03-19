Return-Path: <linux-kernel+bounces-107488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CC87FD39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D956D283DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28E7F48B;
	Tue, 19 Mar 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaFgi1nC"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7E7EF1F;
	Tue, 19 Mar 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849578; cv=none; b=kbshOgYbq5MWH4yFnbOCeoaj8xLLRFEd9OQM70z+ZGiknTwKfE4H8GvK2rs+DAC7hE10saRUUTcNl3v/R3tPbWkqAreASxKTOBCzxKw+eZfTGHq2puSzMcSpya30s5g8seJskMm5yItTo/b2VYlag3+zcp3rgS9Bi9wd6WpJWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849578; c=relaxed/simple;
	bh=s00MXid7eY745qiwSUlpM1Iq8GdCadfOFE5viz//Rf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TggmG8vAE3eR60vjdmto//boKYrZ+oTb7wPSj9GQ6bP+b0xVvLhTG5f/Is6cOrKM2JCHnFU88L+ruBykUFRAsVJqKktFEB6wLboOr2D9B8EIZx6PDVXIu89urfaCIjqQ0FyUgAH1FePoa0nkM6scoBPZJDhNN3kcRaLRxrRt8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaFgi1nC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515830dc79cso404891e87.1;
        Tue, 19 Mar 2024 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710849575; x=1711454375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mmhkfIVVYKAFIHcy8F2X6Y4C2lsSGnG+2hzObs7jNSE=;
        b=JaFgi1nCw/tTY8apFJ7116TvQooT89NhU3dbGZcpZToFVilXiqpO7jZQlVqCrxqXon
         SHhoE76HrDms+zZz9vJTMvQMRYXAWoAF/uDEyH7dYkXm4mDQ/TgQjtp3vaCw9uL1AFR7
         PcQLrS12JpRQu8ZXotQnGh/A/ZY+lP9DQJjQ+za8mG6dsfE2odu6qqbvT2eKiY4Sd8/y
         gjbvTlT8mv9jnk9tWjGStRvRZpof3eskWUAeSWB3inQYxMYVfPZ/Z2iPROkFsSkgKAds
         UwzHF6BIy4KM8zY5sUrlPRlNSvD55TtMplsfqw9vvR+ecnWm+eoPs+Su65hyUBtm+uIv
         WZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710849575; x=1711454375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmhkfIVVYKAFIHcy8F2X6Y4C2lsSGnG+2hzObs7jNSE=;
        b=pPF7sHjGwve2gV4W8V+q1/VJP8URtQhtBCXBndHxJzK6eHrWaVjQh6coIxZ/heTFkC
         7129vMUbTKEi5u/49l/Y/aeuPB14l+BYeEA+cE6V1LrU6Pzq1PkDKOdQYBds9YOFMoYK
         w0ZOc+oVu2DRpPSrnQjtNEgxVgtg1cGTjvtfhzBo/8CTvzhuKGDJUXfqMLxmG9AUwORm
         jUYzgMGb0Wm5iooqfyBbG02Kvzxn1sOXUiJE5ISU/tMN7J77H6Ylyypp/E+TNknSpcu4
         EZXuaV4j1GzIJuKEvlmnrjb7nEftUAJeToq43ZsZ7Tn9O3PATS25Ru5O/H8n66sYfxXc
         slWw==
X-Gm-Message-State: AOJu0YxaJl/Xn39yVL9MEgU4niMp7aJJDZTe9oELWfDVChOYYdLxJ1RH
	hC+LOJrMxr123kVJmWaWEGSC6TqFa/gL96aSAjdsTes44Yis01zMw+qV7CLlxC8=
X-Google-Smtp-Source: AGHT+IE0ENpM10lJFUnsGgMWSIghPIM6fY92Z0eO9qEbSWgKqTswdhcxJ6dkhXfAH0w8GG/At+rMyw==
X-Received: by 2002:ac2:5b41:0:b0:513:dae2:dd7e with SMTP id i1-20020ac25b41000000b00513dae2dd7emr8530130lfp.32.1710849574462;
        Tue, 19 Mar 2024 04:59:34 -0700 (PDT)
Received: from skhimich.dev.yadro.com (avpn01.yadro.com. [89.207.88.243])
        by smtp.gmail.com with ESMTPSA id d11-20020a056512368b00b00513a53acdd4sm1915198lfs.104.2024.03.19.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:59:33 -0700 (PDT)
From: Sergey Khimich <serghox@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
Date: Tue, 19 Mar 2024 14:59:30 +0300
Message-Id: <20240319115932.4108904-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
For enabling CQE support just set 'supports-cqe' in your DevTree file
for appropriate mmc node.

Also, while implementing CQE support for the driver, I faced with a problem
which I will describe below.
According to the IP block documentation CQE works only with "AMDA-2 only"
mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata'
platform data.

So my question is: is it correct to enable v4 mode for all platform data
if 'SDHCI_CAN_64BIT_V4' bit is set in hw?

Because I`m afraid that enabling v4 mode for some platforms could break
them down. On the other hand, if host controller says that it can do v4
(caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
quirk. Anyway - RFC.


v2:
 - Added dwcmshc specific cqe_disable hook to prevent losing
   in-flight cmd when an ioctl is issued and cqe_disable is called;

 - Added processing 128Mb boundary for the host memory data buffer size
   and the data buffer. For implementing this processing an extra
   callback is added to the struct 'sdhci_ops'.

 - Fixed typo.

v3:
 - Fix warning reported by kernel test robot:
        | Reported-by: kernel test robot <lkp@intel.com>
        | Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/
        | Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/

v4:
 - Data reset moved to custom driver tuning hook.
 - Removed unnecessary dwcmshc_sdhci_cqe_disable() func
 - Removed unnecessary dwcmshc_cqhci_set_tran_desc. Export and use
   cqhci_set_tran_desc() instead.
 - Provide a hook for cqhci_set_tran_desc() instead of cqhci_prep_tran_desc().
 - Fix typo: int_clok_disable --> int_clock_disable

v5:
 - Fix warning reported by kernel test robot:
	| Reported-by: kernel test robot <lkp@intel.com>
	| Closes: https://lore.kernel.org/oe-kbuild-all/202312301130.itEZhhI5-lkp@intel.com/

v6:
 - Rebase to master branch
 - Fix typo;
 - Fix double blank line;
 - Add cqhci_suspend() and cqhci_resume() functions
   to support mmc suspend-to-ram (s2r);
 - Move reading DWCMSHC_P_VENDOR_AREA2 register under "supports-cqe"
   condition as not all IPs have that register;
 - Remove sdhci V4 mode from the list of prerequisites to init cqhci.

v7:
 - Add disabling MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD caps
   in case of CQE init fails to prevent problems in suspend/resume
   functions.

Sergey Khimich (2):
  mmc: cqhci: Add cqhci set_tran_desc() callback
  mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support

 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/cqhci-core.c       |  11 +-
 drivers/mmc/host/cqhci.h            |   4 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 191 +++++++++++++++++++++++++++-
 4 files changed, 202 insertions(+), 5 deletions(-)

-- 
2.30.2


