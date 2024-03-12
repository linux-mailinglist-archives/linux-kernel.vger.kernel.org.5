Return-Path: <linux-kernel+bounces-100534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FF879943
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85010282F22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FF47E586;
	Tue, 12 Mar 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D2ycGkQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDgCe9/D"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792B15BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261953; cv=none; b=ZGIXauoNVMCIYKhUummJKEj1TeQ+91w41lxVZYcfU0XCNNbxSRehNN4y9ZNQNQC+eihymQZOr1B9sMWEDNHwquBW3QDGJkCuslxJAu1u8dd4oClz17kemEj8ekUjlYPBav2s51on4V12tDFmn/WSJXhPpzoIn2dN5/qE3WVqjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261953; c=relaxed/simple;
	bh=Pdn3X05FIqY3RgJ4kH05rO7WEVGCHG1sHiO7nwbjJFE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JCQEF4Aw82A8JXjo6rRUQGkf6ybC/7WdKvxneUZkbIJPfh2SfIVyiUxymZ1sMlK18LzGQSTttKCXTW6O8u/dk1zk6Orj28W299ruhZqeYw4QqNxEHhGR8G4pkqfLIss3+EbJCKfI+YcYLhCi7uQqYUDB2VcJUzSl2aUAZfPQch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D2ycGkQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDgCe9/D; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A890C1C00084;
	Tue, 12 Mar 2024 12:45:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 12:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710261950;
	 x=1710348350; bh=jDkpr1CO6A8RUZEyAfzCCOgBSr7MUYnAnILwj9l8UME=; b=
	D2ycGkQkzKZJoqIT6OlkkjCwTwTD81ix6RtIkhp/VnY/EO8bbhpahL2vQ+ME+1yt
	f4TndQ94tctjgVVQUoUtbi8rcQbSaw6ke+Ktxdvn5S2E8fWtqYT0qkG7Dvawwf7+
	zh8Ttt6oAgtBgGpvFAmLJb17E0omAwiz0U6NCjkRJMpSEHQ7baB5Ok7rx8vk/6ja
	9qtqcaywMpFwP0IGr+ggKTJ6p8molTRWB2RFPjj7JrQF9e+wi//ExD8VhPM6TWUJ
	YXiJf+mGDeOWe/iSA2e/a8z3oQWAwSafyYIoR3Wq3SXGzZrzxkn1e41rq7y2979b
	76u0NhMLtEOq2baxJzHEIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710261950; x=
	1710348350; bh=jDkpr1CO6A8RUZEyAfzCCOgBSr7MUYnAnILwj9l8UME=; b=o
	DgCe9/DED0s6EQR6bNtXoOQWBBq/w8iUZM/d6Xs4f4wBKbAxxgYx/GBjB0kcYOJD
	MYEu7lU/t/OYI5i6Fxw8+K47/1tKd0lxZ6XJH//Mr19+oYICrrqGpPCwKGZ8letT
	7ZQ3FVnV3b46lajbeR8vJkxErePxJLNmi2aNplBV1z07e6X8quECihbdXdiXvrRE
	4ggU1gpFBP61HctN2zCyr0GeNKKlxBo4a/SgjJqseGx9AzFfBxOfel8Yx0xnTSnl
	9wkvurSeRURwBurWJSS9mrr7KwEAaM0jV2BsYdsgadzb+j4Feb0bWuVvEkSnEQIs
	rSyneXrdyjdn54LFLBp5A==
X-ME-Sender: <xms:vYbwZZLhYc8D0kSf8uEXQAKxYYxK6cpeciohcN-In6xC5rYfGlRJ3g>
    <xme:vYbwZVJT5BMruqg412VeqkIX6Kso8YUvfk_SjHRISNyizNmvbvZ7PjxuWHaxxjdVm
    Wbkg-3cQ16yerj-7gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeufeef
    ieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vobwZRt-C36XDR0nLl4qYIUqh7GyVWANWdrhDEgha77ln1PUTJowWQ>
    <xmx:vobwZaZf-O2qhsLTyq_GuH8LKTKLaroQYGZp-_BXRd6Gwr1mitdDZg>
    <xmx:vobwZQai-9ViT_T5c_88DagzhPPaWHDrXFvL4REtQl4CIzrm-jtQzw>
    <xmx:vobwZeD8I0IMlx0Rh5tus3qfhJCng7pYs_MtDsod3Iz2_gze0oF0iQ>
    <xmx:vobwZXWCk8xxMBTnHKfi02_VJZD_tBgZcK_IS-wCn98GihcxszoJ0SFRv6g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DFA34B60092; Tue, 12 Mar 2024 12:45:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2bb4979a-508f-4791-82ac-ce31065f6da1@app.fastmail.com>
In-Reply-To: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com>
References: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com>
Date: Tue, 12 Mar 2024 17:45:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] ARM: SoC drivers for 6.9
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd=
33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.9

for you to fetch changes up to 049238d24467e3d2121e8ef2abef1149be6722e9:

  Merge tag 'qcom-drivers-for-6.9-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/drivers (2024-03-06 07:43:46 +0100)

----------------------------------------------------------------
ARM: SoC drivers for 6.9

This is the usual mix of updates for drivers that are used on (mostly
ARM) SoCs with no other top-level subsystem tree, including:

 - The SCMI firmware subsystem gains support for version 3.2 of the
   specification and updates to the notification code.

 - Feature updates for Tegra and Qualcomm platforms for added
   hardware support.

 - A number of platforms get soc_device additions for identifying newly
   added chips from Renesas, Qualcomm, Mediatek and Google.

 - Trivial improvements for firmware and memory drivers amongst
   others, in particular 'const' annotations throughout multiple
   subsystems.

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: soc: qcom: qcom,pmic-glink: document X1E80100 compati=
ble

Andre Przywara (1):
      firmware: arm_scmi: Fix double free in SMC transport cleanup path

Andr=C3=A9 Draszik (1):
      dt-bindings: samsung: exynos-sysreg: gs101-peric0/1 require a clock

Anjelique Melendez (2):
      dt-bindings: soc: qcom: Add qcom,pbs bindings
      soc: qcom: add QCOM PBS driver

Arnd Bergmann (16):
      soc/tegra: Fix build failure on Tegra241
      Merge tag 'mtk-soc-for-v6.9' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/mediatek/linux into soc/drivers
      Merge tag 'renesas-drivers-for-v6.9-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'samsung-drivers-6.9' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.9' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      soc: qcom: spm: fix building with CONFIG_REGULATOR=3Dn
      Merge tag 'ffa-update-6.9' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'scmi-updates-6.9' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'tegra-for-6.9-soc' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.9-firmware' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'sunxi-drivers-for-6.9-1' of https://git.kernel.org/pub/=
scm/linux/kernel/git/sunxi/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.9' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'samsung-drivers-6.9-2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'omap-for-v6.9/ti-sysc-signed' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/tmlind/linux-omap into soc/drivers
      Merge tag 'memory-controller-drv-6.9-2' of https://git.kernel.org/=
pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'qcom-drivers-for-6.9-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into soc/drivers

Bjorn Andersson (5):
      soc: qcom: aoss: Mark qmp_send() __printf()
      soc: qcom: aoss: Add debugfs interface for sending messages
      soc: qcom: aoss: Add tracepoints in qmp_send()
      pmdomain: qcom: rpmhpd: Drop SA8540P gfx.lvl
      Merge branch '20240201204421.16992-2-quic_amelende@quicinc.com' in=
to drivers-for-6.9

Chen-Yu Tsai (2):
      soc: mediatek: mtk-socinfo: Clean up NVMEM cell read
      soc: mediatek: mtk-socinfo: Add extra entry for MT8183

Christophe JAILLET (1):
      soc/tegra: pmc: Remove some old and deprecated functions and const=
ants

Christophe Kerello (5):
      dt-bindings: memory-controller: st,stm32: add MP25 support
      memory: stm32-fmc2-ebi: check regmap_read return value
      memory: stm32-fmc2-ebi: add MP25 support
      memory: stm32-fmc2-ebi: add MP25 RIF support
      memory: stm32-fmc2-ebi: keep power domain on

Cristian Marussi (22):
      firmware: arm_scmi: Check mailbox/SMT channel for consistency
      firmware: arm_scmi: Use xa_insert() to store opps
      firmware: arm_scmi: Use xa_insert() when saving raw queues
      firmware: arm_scmi: Fix the clock protocol version for v3.2
      firmware: arm_scmi: Fix the clock protocol supported version
      firmware: arm_scmi: Rework clock domain info lookups
      firmware: arm_scmi: Add multiple protocols registration support
      firmware: arm_scmi: Check for notification support
      firmware: arm_scmi: Add a common helper to check if a message is s=
upported
      firmware: arm_scmi: Implement is_notify_supported callback in perf=
 protocol
      firmware: arm_scmi: Implement is_notify_supported callback in powe=
r protocol
      firmware: arm_scmi: Implement is_notify_supported callback in syst=
em power protocol
      firmware: arm_scmi: Implement is_notify_supported callback in cloc=
k protocol
      firmware: arm_scmi: Implement is_notify_supported callback in sens=
or protocol
      firmware: arm_scmi: Implement is_notify_supported callback in rese=
t protocol
      firmware: arm_scmi: Implement is_notify_supported callback in powe=
rcap protocol
      firmware: arm_scmi: Use opps_by_lvl to store opps
      firmware: arm_scmi: Report frequencies in the perf notifications
      firmware: arm_scmi: Add support for v3.2 NEGOTIATE_PROTOCOL_VERSION
      firmware: arm_scmi: Add clock check for extended config support
      firmware: arm_scmi: Add standard clock OEM definitions
      firmware: arm_scmi: Update the supported clock protocol version

Danila Tikhonov (2):
      dt-bindings: arm: qcom,ids: Add IDs for SM8475 family
      soc: qcom: socinfo: Add Soc IDs for SM8475 family

Dmitry Baryshkov (6):
      soc: qcom: socinfo: rename PM2250 to PM4125
      dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
      dt-bindings: soc: qcom: qcom,saw2: add missing compatible strings
      dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
      soc: qcom: spm: remove driver-internal structures from the driver =
API
      soc: qcom: spm: add support for voltage regulator

Duy Nguyen (2):
      soc: renesas: Identify R-Car V4M
      soc: renesas: rcar-rst: Add support for R-Car V4M

Florian Fainelli (1):
      MAINTAINERS: Update SCMI entry with HWMON driver

Geert Uytterhoeven (2):
      soc: renesas: Introduce ARCH_RCAR_GEN4
      dt-bindings: memory: renesas,rpc-if: Document R-Car V4M support

Jon Hunter (4):
      soc/tegra: fuse: Fix crash in tegra_fuse_readl()
      memory: tegra: Correct DLA client names
      memory: tegra: Add BPMP and ICC info for DLA clients
      memory: tegra: Fix indentation

Kartik (9):
      mm/util: Introduce kmemdup_array()
      soc/tegra: fuse: Use dev_err_probe for probe failures
      soc/tegra: fuse: Refactor resource mapping
      soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
      soc/tegra: fuse: Add function to add lookups
      soc/tegra: fuse: Add function to print SKU info
      soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
      soc/tegra: fuse: Add support for Tegra241
      soc/tegra: fuse: Define tegra194_soc_attr_group for Tegra241

Krzysztof Kozlowski (4):
      dt-bindings: memory-controllers: narrow regex for unit address to =
hex numbers
      MAINTAINERS: samsung: gs101: match patches touching Google Tensor =
SoC
      soc: qcom: geni-se: drop unused kerneldoc struct geni_wrapper param
      soc: qcom: aoss: add missing kerneldoc for qmp members

Luca Weiss (1):
      dt-bindings: soc: qcom: qcom,saw2: add msm8226 l2 compatible

Markus Elfring (1):
      firmware: tegra: bpmp: Return directly after a failed kzalloc() in=
 get_filename()

Peng Fan (1):
      firmware: arm_scmi: Implement clock get permissions

Peter Griffin (2):
      soc: samsung: exynos-pmu: Add regmap support for SoCs that protect=
 PMU regs
      watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for =
PMU regs

Peter Robinson (1):
      bus: tegra-aconnect: Update dependency to ARCH_TEGRA

Petlozu Pravareshwar (2):
      soc/tegra: pmc: Update address mapping sequence for PMC apertures
      soc/tegra: pmc: Update scratch as an optional aperture

Prathamesh Shete (1):
      soc/tegra: pmc: Add SD wake event for Tegra234

Randy Dunlap (2):
      soc: qcom: smp2p: fix all kernel-doc warnings
      firmware: arm_scmi: Fix struct kernel-doc warnings in optee transp=
ort

Ricardo B. Marliere (6):
      bus: sunxi-rsb: make sunxi_rsb_bus const
      soc: qcom: apr: make aprbus const
      firmware: arm_scmi: Make scmi_bus_type const
      firmware: arm_ffa: Make ffa_bus_type const
      bus: ti-sysc: constify the struct device_type usage
      tee: make tee_bus_type const

Rob Herring (1):
      dt-bindings: soc/qcom: Add size constraints on "qcom,rpm-msg-ram"

Sebastian Reichel (1):
      dt-bindings: bus: imx-weim: convert to YAML

Sudeep Holla (1):
      firmware: arm_scmi: Warn if domain frequency multiplier is 0 or ro=
unded off

Tanzir Hasan (1):
      firmware: arm_scmi: Replace asm-generic/bug.h with linux/bug.h

Tao Zhang (1):
      soc: qcom: smem: remove hwspinlock from item get routine

Tengfei Fan (2):
      dt-bindings: arm: qcom,ids: add SoC ID for QCM8550 and QCS8550
      soc: qcom: socinfo: add SoC Info support for QCM8550 and QCS8550 p=
latform

Tomasz Figa (1):
      MAINTAINERS: Remove Tomasz from Samsung clock and pinctrl entries

Tudor Ambarus (1):
      dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible

Unnathi Chalicheemala (1):
      soc: qcom: llcc: Check return value on Broadcast_OR reg read

Uwe Kleine-K=C3=B6nig (3):
      memory: emif: Simplify code handling CONFIG_DEBUG_FS
      memory: emif: Simplify code handling CONFIG_OF
      memory: emif: Drop usage of platform_driver_probe()

William-tw Lin (1):
      soc: mediatek: mtk-socinfo: Add driver for getting chip information

 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  58 --
 Documentation/devicetree/bindings/bus/imx-weim.txt | 117 ----
 .../devicetree/bindings/i2c/i2c-exynos5.yaml       |   1 +
 .../fsl/fsl,imx-weim-peripherals.yaml              |  31 +
 .../memory-controllers/fsl/fsl,imx-weim.yaml       | 204 ++++++
 .../memory-controllers/mc-peripheral-props.yaml    |   1 +
 .../memory-controllers/nvidia,tegra20-emc.yaml     |   2 +-
 .../memory-controllers/renesas,rpc-if.yaml         |   1 +
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |   7 +-
 .../devicetree/bindings/soc/qcom/qcom,pbs.yaml     |  46 ++
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   2 +
 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   |   2 +
 .../soc/qcom/{qcom,spm.yaml =3D> qcom,saw2.yaml}     |  46 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml         |   2 +
 MAINTAINERS                                        |   4 +-
 drivers/bus/Kconfig                                |   5 +-
 drivers/bus/sunxi-rsb.c                            |   4 +-
 drivers/bus/ti-sysc.c                              |   2 +-
 drivers/firmware/arm_ffa/bus.c                     |   2 +-
 drivers/firmware/arm_scmi/bus.c                    |  26 +-
 drivers/firmware/arm_scmi/clock.c                  | 197 +++++-
 drivers/firmware/arm_scmi/common.h                 |   3 +-
 drivers/firmware/arm_scmi/driver.c                 |  99 ++-
 drivers/firmware/arm_scmi/mailbox.c                |  14 +
 drivers/firmware/arm_scmi/notify.c                 |  17 +-
 drivers/firmware/arm_scmi/notify.h                 |   4 +
 drivers/firmware/arm_scmi/optee.c                  |   6 +-
 drivers/firmware/arm_scmi/perf.c                   | 170 ++++-
 drivers/firmware/arm_scmi/power.c                  |  30 +-
 drivers/firmware/arm_scmi/powercap.c               |  45 +-
 drivers/firmware/arm_scmi/protocols.h              |   5 +
 drivers/firmware/arm_scmi/raw_mode.c               |  12 +-
 drivers/firmware/arm_scmi/reset.c                  |  37 +-
 drivers/firmware/arm_scmi/sensors.c                |  37 +-
 drivers/firmware/arm_scmi/shmem.c                  |   8 +-
 drivers/firmware/arm_scmi/smc.c                    |   7 +
 drivers/firmware/arm_scmi/system.c                 |  16 +
 drivers/firmware/tegra/bpmp-debugfs.c              |   2 +-
 drivers/memory/emif.c                              |  65 +-
 drivers/memory/stm32-fmc2-ebi.c                    | 729 ++++++++++++++=
+++++--
 drivers/memory/tegra/tegra234.c                    |  48 +-
 drivers/pmdomain/qcom/rpmhpd.c                     |   1 -
 drivers/soc/mediatek/Kconfig                       |   9 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-socinfo.c                 | 191 ++++++
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/apr.c                             |   2 +-
 drivers/soc/qcom/llcc-qcom.c                       |   2 +
 drivers/soc/qcom/qcom-geni-se.c                    |   1 -
 drivers/soc/qcom/qcom-pbs.c                        | 236 +++++++
 drivers/soc/qcom/qcom_aoss.c                       | 105 ++-
 drivers/soc/qcom/smem.c                            |  11 -
 drivers/soc/qcom/smp2p.c                           |   6 +-
 drivers/soc/qcom/socinfo.c                         |   7 +-
 drivers/soc/qcom/spm.c                             | 248 ++++++-
 drivers/soc/qcom/trace-aoss.h                      |  48 ++
 drivers/soc/renesas/Kconfig                        |  17 +-
 drivers/soc/renesas/rcar-rst.c                     |   1 +
 drivers/soc/renesas/renesas-soc.c                  |   8 +
 drivers/soc/samsung/Kconfig                        |   1 +
 drivers/soc/samsung/exynos-pmu.c                   | 235 ++++++-
 drivers/soc/samsung/exynos-pmu.h                   |   1 +
 drivers/soc/tegra/Kconfig                          |   5 +
 drivers/soc/tegra/fuse/fuse-tegra.c                | 118 +++-
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  23 +-
 drivers/soc/tegra/fuse/fuse.h                      |   8 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c             | 108 ++-
 drivers/soc/tegra/pmc.c                            |  87 ++-
 .../bindings/fieldbus/arcx,anybus-controller.txt   |   2 +-
 drivers/tee/tee_core.c                             |   2 +-
 drivers/watchdog/Kconfig                           |   1 -
 drivers/watchdog/s3c2410_wdt.c                     |   8 +-
 include/dt-bindings/arm/qcom,ids.h                 |   5 +
 include/linux/arm_ffa.h                            |   2 +-
 include/linux/scmi_protocol.h                      |  21 +-
 include/linux/soc/qcom/apr.h                       |   2 +-
 include/linux/soc/qcom/qcom-pbs.h                  |  30 +
 include/linux/soc/samsung/exynos-pmu.h             |  11 +-
 include/linux/string.h                             |   1 +
 include/linux/tee_drv.h                            |   2 +-
 include/soc/qcom/qcom-spmi-pmic.h                  |   2 +-
 include/soc/qcom/spm.h                             |  23 +-
 include/soc/tegra/fuse.h                           |   1 +
 include/soc/tegra/pmc.h                            |  18 -
 mm/util.c                                          |  17 +
 86 files changed, 3210 insertions(+), 543 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.=
txt
 delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/fsl/fsl,imx-weim-peripherals.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/fsl/fsl,imx-weim.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.=
yaml
 rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml =3D> q=
com,saw2.yaml} (53%)
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.c
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 drivers/soc/qcom/trace-aoss.h
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

