Return-Path: <linux-kernel+bounces-100527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A4879924
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F100C282824
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D237E0EE;
	Tue, 12 Mar 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jbDhcBSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rf8Bq+0+"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D67A15B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261619; cv=none; b=B6/bTAcW68FN37c+pyOVOgLal4rtEWg/4BVLhcPk+9i7hFAefSi8eAm5zFEc6t2m24K9ZJzy3dNYcTqdXqxQMk1P+RQYlrKw6+hzxsXpgLQKULVnJsRFtUgmLJxEem3ovm1jMFleFnl5V/gz0GZdh5etrspF9DeKjRINKdzyo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261619; c=relaxed/simple;
	bh=PFzijgEHfFJ1RqmvEdnyVlBbRRCYXP8e7Eh/psoGdGY=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=ufXByH5prz8TgGtYwBOIJAcu2NceeBb0FWFaOpJ7eFr34NF3ppcBFud4w70NXYDmf4HbQQWRJQlISEekS3kl+IOK7Bwfe2yqvdb/HiomEKgJ6nrIvqG85ZcHWk/1lvdb8ODCiMxDzbsIaGD4Xwsjy+qiiPTcxsxDfaTMEoquKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jbDhcBSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rf8Bq+0+; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C8AB41C0010B;
	Tue, 12 Mar 2024 12:40:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 12:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1710261615; x=1710348015; bh=No
	3/x37VrAXFxgp1EVrtb4FFgXQ4bK6K83UBpoL3gdo=; b=jbDhcBSnCclYHzQtYl
	qK3x9qd2+KMRxvhFA7volvMMddM5G4E/lCMzfDy8NoEksqqUD+CuIpn5XhU395hA
	uvHmWwBPd/9M8b4vuLPwbJQZ9LPsOqwab9oxCUyzC5veGE4txEDnKlmWTJKrrPhs
	tVeD+H2o+2nqOFxpTTWIHe28aJ1P8exDk+3z0PyErf7anbC0tJVjoE/taO2WKRTL
	vq+gpVbWliIbsyAhk1wVXWAUPioG1x9i8vKQc86h4e/ep4c6l8fqx8Q/rBVIY3uu
	5oA3HYPn2qHeim1awzS8bnaHhvp931F05sBbRS/2lkmYXk7aPF1gJ/jF9eOf6Msr
	sZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1710261615; x=1710348015; bh=No3/x37VrAXFx
	gp1EVrtb4FFgXQ4bK6K83UBpoL3gdo=; b=Rf8Bq+0+dg7i5dR4MQHJ1k58EdTeu
	h1Hqq/5BtiUE7juQnyYLr3H/IiPSi+YyGilTTGEADttY8lnfPdcr2VY0OWPxpgNe
	hpePjdVdoOtZM6WgyawgCgv/3c234fOkJ8CwqB+bCrdi0xO0D7PJFKeVZcl1Abrr
	T025FMKaS96iuOPRBFhkQqKnPWbwnrDEs8OkLAxs9q5TD8WWiamiUyBgPCGFbWyK
	1PayQcZmhKJyI4ARzKLsHG6Er88AEQV+PNywyBCqETF5mQofkGkYiBSe8IMkGsEB
	573CWUBwRDMHaNg9TSnwbOvkaDtkYpreN3Ii5GC95wCdOjpKmxRkVl1mQ==
X-ME-Sender: <xms:b4XwZRQWUJjpzLygpclXjmvZF9z52xqOQT_grMTe2ztjTFPcX20x9Q>
    <xme:b4XwZax6Vci_63EonTFoGC3vZMv7deff-n7qMqPAp-CsyN6Igl9cQs33k3Qh5aLAO
    O1xNtqy78bFv6FJpPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeehleefteehledvieeifeeftefhkedvheehudelteevieekhefhgefhveekffeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:b4XwZW0bjE5Tcl8iaF6GyB7sDcyPIiQ4tWv0-p2QxIcvtxmREtrW9w>
    <xmx:b4XwZZAHq2Xg4v5cE0DDpr1rIzBTSubAuIcXjey-A_gV2E_dZSdp4g>
    <xmx:b4XwZahcoQfMXLSTCyJoDmjTmMD_1Jeycd8cyQnwgy2FFry2B8pYKQ>
    <xmx:b4XwZdr_udQ3dvmxPfVlaA2PcDQZwA_ta6-x0VK-qid4xYFVYFt82A>
    <xmx:b4XwZSc_9I6C_Exar2BcPI6_ivAqKXZ-gJrpJP-_LJ5F8qbzQt-IPQV3pM0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1FF06B6008D; Tue, 12 Mar 2024 12:40:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com>
Date: Tue, 12 Mar 2024 17:39:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] ARM SoC updates for 6.9
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The SoC updates this time are rather uneventful this time, with
not much sticking out at all, just the usual amount of normal
maintenance going on throughout the tree. It is less dominated
by Qualcomm SoC work than the past few releases, with sizable
contributions for TI, Mediatek, NXP, Rockchip and NVIDIA as well.

There are a total of 996 non-merge changesets from 242 individual
contributors, though a small number of these will come in a later
pull request. The main contributors by number of patches are:

     59 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
     43 Alexander Stein <alexander.stein@ew.tq-group.com>
     40 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
     37 Andrew Davis <afd@ti.com>
     32 Geert Uytterhoeven <geert+renesas@glider.be>
     28 Konrad Dybcio <konrad.dybcio@linaro.org>
     20 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
     18 Nishanth Menon <nm@ti.com>
     17 Randy Dunlap <rdunlap@infradead.org>
     17 Cristian Marussi <cristian.marussi@arm.com>
     16 Michal Simek <michal.simek@amd.com>
     15 Neil Armstrong <neil.armstrong@linaro.org>
     15 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
     14 Vaishnav Achath <vaishnav.a@ti.com>
     14 Josua Mayer <josua@solid-run.com>
     14 Frieder Schrempf <frieder.schrempf@kontron.de>
     13 Abel Vesa <abel.vesa@linaro.org>
     12 Luca Weiss <luca.weiss@fairphone.com>
     12 Bjorn Andersson <quic_bjorande@quicinc.com>
     11 Mark Hasemeyer <markhas@chromium.org>
     11 Frank Li <Frank.Li@nxp.com>
     11 Chen-Yu Tsai <wenst@chromium.org>
     10 Jagan Teki <jagan@edgeble.ai>
     10 Duy Nguyen <duy.nguyen.rh@renesas.com>

This is the overall dirstat:

   1.2% Documentation/devicetree/bindings/arm/
   0.3% Documentation/devicetree/bindings/bus/
   0.3% Documentation/devicetree/bindings/clock/
   0.4% Documentation/devicetree/bindings/memory-controllers/fsl/
   0.6% Documentation/devicetree/bindings/soc/
   0.7% Documentation/devicetree/bindings/
   0.9% arch/arm/boot/dts/microchip/
   6.0% arch/arm/boot/dts/nvidia/
   3.2% arch/arm/boot/dts/nxp/imx/
   2.7% arch/arm/boot/dts/qcom/
   2.0% arch/arm/boot/dts/ti/omap/
   1.2% arch/arm/boot/dts/
   0.3% arch/arm/mach-omap2/
   0.9% arch/arm/
   1.1% arch/arm64/boot/dts/allwinner/
   1.6% arch/arm64/boot/dts/amlogic/
   0.3% arch/arm64/boot/dts/exynos/google/
   8.3% arch/arm64/boot/dts/freescale/
   6.9% arch/arm64/boot/dts/mediatek/
   5.6% arch/arm64/boot/dts/nvidia/
  15.2% arch/arm64/boot/dts/qcom/
   4.6% arch/arm64/boot/dts/renesas/
   9.0% arch/arm64/boot/dts/rockchip/
  14.2% arch/arm64/boot/dts/ti/
   0.4% arch/arm64/boot/dts/xilinx/
   0.3% arch/arm64/boot/dts/
   0.6% arch/riscv/boot/dts/starfive/
   1.5% drivers/firmware/arm_scmi/
   1.7% drivers/memory/
   0.6% drivers/reset/
   0.4% drivers/soc/mediatek/
   1.2% drivers/soc/qcom/
   0.4% drivers/soc/samsung/
   0.4% drivers/soc/tegra/fuse/
   0.6% drivers/
   1.4% include/dt-bindings/clock/
   0.3% include/dt-bindings/

