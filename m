Return-Path: <linux-kernel+bounces-61272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A922585102E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C372882C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602617C66;
	Mon, 12 Feb 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R0yVKx8j"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0518C1A;
	Mon, 12 Feb 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731966; cv=none; b=EnSYLZsDPqRN54dzkOcaJlQra5C3V7CIPoysF1MXBbUKcxf8+XbfSo0PzxU9wLk0spdE1exaPjrUzwlQUgbZd7bhG3ULRzOJ9kvUSnvv1S8OGd96ctdk5WxlClGqpPKCh4Hqp3bU5uIp+Q5Us9zDvcsAiZ8jhcQWhQbYXc8GyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731966; c=relaxed/simple;
	bh=ftGHsqO0Vk/c2onr5I5HWonlwK+PTS5LvdCnyhPdl/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EqbUF9K7tXNWa6F4YpxnWlEs6yk1Qm4cnZA5JW/LBV4u7Hc9nSPpji7x+EvA+7aARI69Y/alm5CWZinc3jlBxvtWpFse0tTDzXt5U+K2UDLpySUZ5T9b7Kqaf/whfclNCPiyj1sYW7/l5gFL8NRV4HJv4QXnbvdMZ3EAF+zMCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R0yVKx8j; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C9x7dg104125;
	Mon, 12 Feb 2024 03:59:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707731947;
	bh=H03vJZR7X7TTsYl6qr8Q1kdmFHGN5fIcR2OQ+SgxN78=;
	h=From:To:CC:Subject:Date;
	b=R0yVKx8jFcR+epauEenmmCuHrozmtv8c2YQY0MtzklerqbwGRBC7rPMe3ByP7VD3R
	 zMcOAHUlflSkz512kcGwAzrOfXEiAMdfV09rukbLIrXW1jPzDdO2aKBeLaabBa2IPT
	 DR9HjWEMgplxK995nPF2vxyuiAaH9gJmvrHyY6Oc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C9x75i004479
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 03:59:07 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 03:59:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 03:59:06 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C9x607056478;
	Mon, 12 Feb 2024 03:59:06 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: Modify pinmux for wkup_uart0 and mcu_uart0
Date: Mon, 12 Feb 2024 15:29:01 +0530
Message-ID: <20240212095905.1057298-1-b-kapoor@ti.com>
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

WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies under
wkup_pmx2 for J7200. Thus, modify pinmux for both of them. Also,
remove the redundant clock-frequency property from mcu_uart0 node.

Only Tx and Rx Signal lines for wkup_uart0 are brought out on
J721S2 Common Proc Board and J784S4 EVM, but CTS and RTS signal lines
are not brought out. Thus, remove pinmux for CTS and RTS signal lines
for wkup_uart0 in J721S2 and J784S4.

Bhavya Kapoor (4):
  arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for
    wkup_uart0 and mcu_uart0
  arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency
    from mcu_uart0
  arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and
    RTS in wkup_uart0
  arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in
    wkup_uart0

 .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 +++++++++---------
 .../dts/ti/k3-j721s2-common-proc-board.dts     |  2 --
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts       |  2 --
 3 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.34.1


