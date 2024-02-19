Return-Path: <linux-kernel+bounces-70991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3A859F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B0E1F22FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B6224ED;
	Mon, 19 Feb 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="upitwn/C"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F00210E1;
	Mon, 19 Feb 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333490; cv=none; b=LFQnPvg0IPLfLPVy55aM4XEd12nGKfThZh8axWaAMpj/Sk8ekE9evPMnjEqH13UlOafXbVZLkWj87KL+oSQ2qWIM6hYawQnuAYBdRIXugD954nwb/e0Zo/CDzbZWVXLEIwpkIVK3vUOw/0R2mXD3DjX/Qw7eBNNyvONraWAjFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333490; c=relaxed/simple;
	bh=PV2jwbKP2gvymiEUlZh3/QkNvNEHx4g/+1/AVkg50vU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xrd3LZQO264AF12CB/OXDuWyB35LGVASYnjsvXSH/Z9wK04zvnvIavp4GexVsT/y3+UUzdNLQ9tN3HFDYFgHwdK/CorDRBoQM83+AWJu9lyrWBnDjQuAreKVx5OfyNQCYRo1bALzeLZfrUHWN8z9S2TkuLIfCvtyGkoCmIYXwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=upitwn/C; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J94dTA060504;
	Mon, 19 Feb 2024 03:04:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708333479;
	bh=/ma8tqzSbtHdZlrL/dDS7UMvkDsXMNTTocHQA9khYO4=;
	h=From:To:CC:Subject:Date;
	b=upitwn/Cwh3zfsaj4likHSZWjpTpkc8zG+kFsK5pE1hj+uzz86OuH/k/nNnfyby5B
	 3hK8Sa+D+4PwhM0UxATfjOTqsU69b876fqCAgFVCggkpgEgModlXOOhB5632MdcDKK
	 qRuEsYE73ii26drTbo8FR4tj52jXumntm4g2Hgig=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J94dUM084292
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 03:04:39 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 03:04:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 03:04:39 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J94ZnU011977;
	Mon, 19 Feb 2024 03:04:36 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add OSPI and Ethernet support on J722S EVM
Date: Mon, 19 Feb 2024 14:34:33 +0530
Message-ID: <20240219090435.934383-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

This series adds support for Ethernet and OSPI NOR flash on J722S EVM.

V1: https://lore.kernel.org/all/20240216135533.904130-1-vaishnav.a@ti.com/

Changelog:
V1->V2:
  * Update comments indicating PAD numbers.  

EVM Schematics are available at:
	https://www.ti.com/lit/zip/sprr495

Test log (6.8.0-rc4-next-20240216):
  https://gist.github.com/vaishnavachath/b04e3be90af4cdec59fb0d9cc72441b9

For those interested, more details about this SoC can be found in the
Technical Reference Manual here:
            https://www.ti.com/lit/zip/sprujb3

Thanks and Regards,
Vaishnav

Siddharth Vadapalli (1):
  arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1

Vaishnav Achath (1):
  arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 132 ++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

-- 
2.34.1


