Return-Path: <linux-kernel+bounces-164892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C329B8B8492
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778D02839EC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493942D600;
	Wed,  1 May 2024 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn9IR/sI"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666922F19
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536485; cv=none; b=dYEG4U26GpcWJAjd30QqLyhSf92Kb4HiHCQRqjjACTlJzLFsyOeoIfKlCMTZRef/DeEY2VC1z0DyT1qIWIuClyrrAuzSbIye+mK3b9gG+Suo+Gx9gECrYHKVjEqlApIKDpdA71X8imSx+iYMw7M6j7LBYWRuyGTOmuDlcIkmLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536485; c=relaxed/simple;
	bh=a18PhYqa1Ej+q1OW2kx0iTG0IBRCQUyahBHrRUAGLSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvycsEvjHs83nXYiEe3rZts+0kYIzyGF3f06yDSQtiHQKFdAAuAH+m//woUAroj1ALWVNjc7woyQi1SAhzmq6EgmueLgvR4fx6k5S+OrReULYnf6RKDAriT3ByWvdxmqhUbKQgXOxhE1pGSzHYhWfgjNsrk7EQAEKo82IudoH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn9IR/sI; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c74a75d9adso4257397b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536482; x=1715141282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/yrOQ0omRjz6OrQxZBXvYp0VMAxHDJp2r7BXxsg9K8=;
        b=Fn9IR/sIjo3+OT9H01TE6sSFa8m5zAFadCh2RzirtZ41vT7LLyGtS57e1dU6KhWPez
         0UMxW0kdYAfSLkfrZHLNMVB8cZZ7PpPDD6vmCepNnT+kgl+YnsgFLDVNJYv5K3iZ8JlG
         GF8gLgVsHu1vxNQgJK2ZZv13ZhilWaGB0fJuWmq7+GgJag5F5VcVx8tAKPzv1oxvEtiK
         dlvWmR61yxPrqj6ZpEPUAiqEEyUhtW5N04rOVD74Rzt6Iyj2LCTJ/FSS14PFMfDBUJvA
         hyyDJ0vIYvCc3ITa5vLcPV0pVgDC/cG8lltQbz6lC6fh8QF5Q4MYdhwr9j50fg//U+u4
         aKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536482; x=1715141282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/yrOQ0omRjz6OrQxZBXvYp0VMAxHDJp2r7BXxsg9K8=;
        b=b4r7SILIJvP3tOXAJ9nnk/dEAAG+BnaOlbPgERnswc97CPzwZFHhH3oE+YiO0XIate
         QSQNdU7SSBJeXpi0JHNjMO1bqJz1yPoJoUxOMogXi/jMRzUYfbTtijNTrBL6vmx1L6mk
         WDkkRYXI8V3T/dUyI5dA0czoGN+AzrlvJvc8c0KTcE2wWG0CdvmkwA0eC4XZn6dpbOvA
         pXsfHkQGBN3LYJDcaGCh1AdOs0KvpfSje1FHKIpPi8t9D/ceP5txbVdzYuTW/fPS5frD
         QMFu9Hfkw8U288J5Kygj8FZJodkWDQvZRdS1kIJ5ExZeMDARMkiTI8nJToFTFj7fvCtR
         ir6A==
X-Gm-Message-State: AOJu0YwA8tN0ZcPZPSdexbWeNPB3RIlFJMOABD6U7YhHsDOBmqDqBdo+
	7/dB1NwgF31SZ20Gk++ylNq0z5Y9oW2g8RoA1T7lsHtCQqTpxO1f0puldC7MZVM=
X-Google-Smtp-Source: AGHT+IH1wk8EDAQbkjS1Ypn9a3wZRLzIaoQfOUdPPG5HXv6zSQC9wPtZkfbXlJl6CGClTMnuw/zlfg==
X-Received: by 2002:a05:6808:1a07:b0:3c8:4d79:3c5d with SMTP id bk7-20020a0568081a0700b003c84d793c5dmr1962429oib.47.1714536482197;
        Tue, 30 Apr 2024 21:08:02 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:01 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v4 0/8] ipq9574: Enable PCI-Express support
Date: Tue, 30 Apr 2024 23:07:42 -0500
Message-Id: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
addresses pcie2, which is a gen3x2 port. The board I have only uses
pcie2, and that's the only one enabled in this series. pcie3 is added
as a special request, but is untested.

I believe this makes sense as a monolithic series, as the individual
pieces are not that useful by themselves.

In v2, I've had some issues regarding the dt schema checks. For
transparency, I used the following test invocations to test:

      make dt_binding_check     DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
      make dtbs_check           DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml

Changes since v3:
 - "const"ify .hw.init fields for the PCIE pipe clocks
 - Used pciephy_v5_regs_layout instead of v4 in phy-qcom-qmp-pcie.c
 - Included Manivannan's patch for qcom-pcie.c clocks
 - Dropped redundant comments in "ranges" and "interrupt-map" of pcie2.
 - Added pcie3 and pcie3_phy dts nodes
 - Moved snoc and anoc clocks to PCIe controller from PHY

Changes since v2:
 - reworked resets in qcom,pcie.yaml to resolve dt schema errors
 - constrained "reg" in qcom,pcie.yaml
 - reworked min/max intems in qcom,ipq8074-qmp-pcie-phy.yaml
 - dropped msi-parent for pcie node, as it is handled by "msi" IRQ

Changes since v1:
 - updated new tables in phy-qcom-qmp-pcie.c to use lowercase hex numbers
 - reorganized qcom,ipq8074-qmp-pcie-phy.yaml to use a single list of clocks
 - reorganized qcom,pcie.yaml to include clocks+resets per compatible
 - Renamed "pcie2_qmp_phy" label to "pcie2_phy"
 - moved "ranges" property of pcie@20000000 higher up

Alexandru Gagniuc (7):
  dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
  PCI: qcom: Add support for IPQ9574
  dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
  phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
  arm64: dts: qcom: ipq9574: add PCIe2 nodes

Alexandru Gagniuc (7):
  dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
  PCI: qcom: Add support for IPQ9574
  dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
  phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
  arm64: dts: qcom: ipq9574: add PCIe2 and PCIe3 nodes

Manivannan Sadhasivam (1):
  PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks
    from Devicetree

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  37 ++++
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |   1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 178 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        | 164 +++-------------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 ++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 8 files changed, 469 insertions(+), 141 deletions(-)

-- 
2.40.1


