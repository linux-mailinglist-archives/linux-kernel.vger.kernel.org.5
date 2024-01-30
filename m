Return-Path: <linux-kernel+bounces-44460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5220684224C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD7B281BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C5664D9;
	Tue, 30 Jan 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RzRLZM2j"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046965BD1;
	Tue, 30 Jan 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613002; cv=none; b=PoQqbaOSG7lxg2YzxBWWmfWAH1Ts4NCC9tv1mw+jeFW9LXBzAhuqW1nkzQWlDPFblN9TbWKhdNoFj/Je6voF6hlzcqN/mlpLMt3Cmq90atcRz7qlqesfBLkIWo6dVvPw52hmGyZuU/c9RVw5Q4upBbgKc01Z53Tq83CiO8fSVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613002; c=relaxed/simple;
	bh=zspf8SYadbAACMXqigZF2hJmTlJO611Zlv+2qhlvvUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y8z0uhokMocEn81kumHFux2Gv/0Bn5NCJrK0VmudYTfR2AnOmHlyRffEXynv3/YFdoiSin+87l6HMm5isZS9pvbAwVbpzNzg6F5+962hSihmUmPlYMeOBPJsdnK0kwt8SfB1Hbq8PsVpehGUwbcziG+uffc1zussTBI3Es6AlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RzRLZM2j; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UB9mkZ088017;
	Tue, 30 Jan 2024 05:09:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706612988;
	bh=9LLssVpCHtXfHc82S11w8FgCNWEXnD9aH5a9NDeL/mY=;
	h=From:To:CC:Subject:Date;
	b=RzRLZM2jXCPQ3GRFWAR7kIHe8QzU35VSd+vydVeQ2QG4XPqeT0u/HXfV5tGvzJbZ0
	 HCW3mwu1PMxypKHQSkK2TPm5Gb2apzRlfPnFDNwmN6SC4Gtfx0LAdQIdrqf4nqWW7y
	 1kjeswYKji8pspQKkvrMb/1jsWj+vkX5j2gJRwDo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UB9mYl006214
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 05:09:48 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 05:09:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 05:09:48 -0600
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UB9ilL088313;
	Tue, 30 Jan 2024 05:09:45 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>, <rogerq@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 0/2] RPMsg based shared memory ethernet driver
Date: Tue, 30 Jan 2024 16:39:42 +0530
Message-ID: <20240130110944.26771-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

virtio-net provides a solution for virtual ethernet interface in a
virtualized environment.

There might be a use-case for traffic tunneling between heterogeneous
processors in a non virtualized environment such as TI's AM64x that has
Cortex A53 and Cortex R5 where Linux runs on A53 and a flavour of RTOS
on R5(FreeRTOS) and the ethernet controller is managed by R5 and needs
to pass some low priority data to A53.

One solution for such an use case where the ethernet controller does
not support DMA for Tx/Rx channel, could be a RPMsg based shared memory
ethernet driver. The data plane is over the shared memory while the control
plane is over RPMsg end point channel.

Two separate regions can be carved out in the shared memory, one for the
A53 -> R5 data path, and other for R5 -> A53 data path.

The shared memory layout is as below, with the region between
PKT_1_LEN to PKT_N modelled as circular buffer.

-------------------------
|	   HEAD		|
-------------------------
|	   TAIL		|
-------------------------
|	PKT_1_LEN	|
|	  PKT_1		|
-------------------------
|	PKT_2_LEN	|
|	  PKT_2		|
-------------------------
|	    .		|
|	    .		|
------------------------
|	PKT_N_LEN	|
|	  PKT_N		|
 -----------------------

Polling mechanism can used to check for the offset between head and
tail index to process the packets by both the cores.

I initially intended to post this as a query to know whether a
RPMsg based shared memory ethernet driver would be an upstream
friendly solution or not. But then decided to do some prototyping
and share it as RFC hoping the code might help a bit in understanding
the approach.

There is still quite a handful of work to be done. As of now firmware
just helps in registering the RPMsg driver on Linux by announcing the
RPMsg device ID.

For the purpose of testing, I allocated the memory in Linux and the Tx packet
is injected back into the network stack. These test code snippets are under
TEST_DEBUG macro.

Could you all please share your opinion on this approach?
I wanted to get the community feedback before proceeding into further implementation.

Please note, I have not included the Makefile, Kconfig in this series.

Ravi Gunasekaran (2):
  net: ethernet: ti: Introduce inter-core-virt-eth as RPMsg driver
  net: ethernet: ti: inter-core-virt-eth: Register as network device

 drivers/net/ethernet/ti/inter-core-virt-eth.c | 455 ++++++++++++++++++
 drivers/net/ethernet/ti/inter-core-virt-eth.h | 105 ++++
 2 files changed, 560 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.c
 create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.h

-- 
2.17.1


