Return-Path: <linux-kernel+bounces-99151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FD87841C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473A31C21B36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDEC44C6A;
	Mon, 11 Mar 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KS/07v87"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504D44C60
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171970; cv=none; b=hVd5NE4vTazDGW0XfIhCufNKDRHhFVBLzPxJhGStiQ0GlQ9euWE40fZnwjrjlfVUz9FBhrsbTnCgPLPoi2/8SAvnuSRpoJZ37zrN3lTOCSriUttyY4hFGkGXtcEVAuR09zPELGS66MbgCmeBVXPEX8O+1PhpJ9cG2z+q8VHHfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171970; c=relaxed/simple;
	bh=gFDUuj57lYr4wG8krVTq8NkfsBL43/jiGP8AhQV7/DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dysluN0pKkI0iX5rqCgYCZLItm2koN/QdsQYQOTSdvPaY3YQzmg3A2Q0wC68ewt2unl95vmbgC85JFii90PWGEauAoAzVSfqrYgVli1LZUV2HY5QZN9s4Yc8aWHYLwxagAoMOzcjkPCPdoN3DoFOKs/YrbC4w4jDSaYAzmihPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KS/07v87; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d382a78c38so53632771fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710171966; x=1710776766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUYX9uojUp5ax4gJj/GFoNZKgIJDaBka6QZETxo7B58=;
        b=KS/07v87cYTpm/t7Nw+c9hSe9R+/PeY9WBpNoy+Pz/Q2YYLpDmJ5V8tLwv7leUdvtP
         FPyanVTn4Z5+wdyC4wPc3xpUIrprDnBJGfpxaOHzdd/6jRla6qa1kopfHo90vfAWEwgd
         MAfiboOg1ymSMKfyndoMmyAyvj2BjAw5JwEW6xpC/TDfwG4jpqliwItZQo52MTUzLh/x
         UOOLSlJVJoBPrS51yYOoA7VvDG/FNDBJA7FCCkY324YGbYbWewWkkwLmTxAp0evITZBd
         Gc6zB+qk5fNP0dRLK3GrnCODStrtnCVoc8QjBeKXQTws/g7q/A6BEXGgRmMYXm5GqYA6
         BiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171966; x=1710776766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUYX9uojUp5ax4gJj/GFoNZKgIJDaBka6QZETxo7B58=;
        b=CfGhOaHEFxIiL/KQ3MTmzUwpYM++5A2Sp0JEOLC6UV1XtAMWDmxet0BzoM+JSEEyLA
         kcP+gUfs0zzK+OvpJwBAsLYN0XaiuuHNKbjUuqhdssNCZ5KivKtN4eh8fA9I9CNiTOXB
         ZVuGCHHj/sBwpTev+/Lkmt77tpes9Rb5xUamldKxICi/C4zOo8mxqJ/v2hPcb7Aj5cKS
         ste4CFfCAN80/m0zZDo2//4XPgdXpSzUePtU86YwdCF+ExZfxX8WyDtTGaqEUMQPLWcN
         rARMMzPPfnCGUM3lmu3KnBMhY6e/PgIdoGrqIU7Cr1iV5giYILyu5Veg4AM5OEvB/HMD
         dsAA==
X-Forwarded-Encrypted: i=1; AJvYcCVLYpNslZ1iz+z/cFuP3HWMYZK5sd8TDgoMDVl4vfi5xNGPZ1qLpFuGe9m0i0ZlX3s8v2n3BMME7z0U7rBDf0qjSeVZB5pU9T5GTQgs
X-Gm-Message-State: AOJu0Yxf+SF1IY7z3IgGT1XMBZv7gKu6jvzUsuClh7LyBSvCpgy8kfgX
	NcXYCJ6zWt3jlcs1W31npa35d/ZrJ5gkNF4PtMls4vlMssqj49zlNMKR8u3+9eU=
X-Google-Smtp-Source: AGHT+IEeuLmyBO0IoJnRxGN0zIrcN/c5KYRHmU2IUoV8gW/Levqp24JcR5bSBb/CjJ9TNJswcTmDjA==
X-Received: by 2002:a05:6512:31c7:b0:512:e00b:8da4 with SMTP id j7-20020a05651231c700b00512e00b8da4mr6101963lfe.53.1710171966223;
        Mon, 11 Mar 2024 08:46:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b005131544fc6fsm1154454lfg.291.2024.03.11.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:46:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v6.9
Date: Mon, 11 Mar 2024 16:46:04 +0100
Message-Id: <20240311154604.3069122-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain updates for v6.9. Details about the
highlights are as usual found in the signed tag.

Please note that, there are a couple remoteproc drivers and a media driver
changed here as well, ack-ed of course. Potentially those may cause some merge
conflicts, but just let me know if there are some issues.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2a93c6cbd5a703d44c414a3c3945a87ce11430ba:

  pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation (2024-02-28 16:31:45 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.9

for you to fetch changes up to ccabbb6768fc72d6cb0223324925c93658d91e63:

  pmdomain: renesas: rcar-gen4-sysc: Reduce atomic delays (2024-03-06 11:25:27 +0100)

----------------------------------------------------------------
Core:
 - Log a message when unused PM domains gets disabled
 - Scale down parent/child performance states in the reverse order

Providers:
 - qcom: rpmpd: Add power domains support for MSM8974, MSM8974PRO, PMA8084
   and PM8841
 - renesas: rcar-gen4-sysc: Reduce atomic delays
 - renesas: rcar-sysc: Adjust the waiting time to cover the worst case
 - renesas: r8a779h0-sysc: Add support for the r8a779h0 PM domains
 - imx: imx8mp-blk-ctrl: Add the fdcc clock to the hdmimix domains
 - imx: imx8mp-blk-ctrl: Error out if domains are missing in DT

Improve support for multiple PM domains:
 - Add two helper functions to attach/detach multiple PM domains
 - Convert a couple of drivers to use the new helper functions

----------------------------------------------------------------
Adam Ford (2):
      dt-bindings: soc: imx: add missing clock and power-domains to imx8mp-hdmi-blk-ctrl
      pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain

Dien Pham (1):
      pmdomain: renesas: Adjust the waiting time to cover the worst case

Duy Nguyen (3):
      dt-bindings: power: renesas,rcar-sysc: Document R-Car V4M support
      dt-bindings: power: Add r8a779h0 SYSC power domain definitions
      pmdomain: renesas: r8a779h0-sysc: Add r8a779h0 support

Geert Uytterhoeven (2):
      pmdomain: renesas: rcar-gen4-sysc: Remove unneeded includes
      pmdomain: renesas: rcar-gen4-sysc: Reduce atomic delays

Konrad Dybcio (2):
      pmdomain: qcom: rpmpd: Keep one RPM handle for all RPMPDs
      pmdomain: core: Print a message when unused power domains are disabled

Krzysztof Kozlowski (2):
      pmdomain: core: constify of_phandle_args in xlate
      pmdomain: core: constify of_phandle_args in add device and subdomain

Kunwu Chan (1):
      pmdomain: ti: Add a null pointer check to the omap_prm_domain_init

Luca Weiss (3):
      dt-bindings: power: rpmpd: Add MSM8974 power domains
      pmdomain: qcom: rpmpd: Add MSM8974+PM8841 power domains
      pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084 power domains

Marek Vasut (1):
      pmdomain: imx8mp-blk-ctrl: Error out if domains are missing in DT

Markus Elfring (1):
      pmdomain: mediatek: Use devm_platform_ioremap_resource() in init_scp()

Stephan Gerhold (1):
      pmdomain: core: Scale down parent/child performance states in reverse order

Ulf Hansson (8):
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      PM: domains: Add helper functions to attach/detach multiple PM domains
      remoteproc: imx_dsp_rproc: Convert to dev_pm_domain_attach|detach_list()
      remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
      remoteproc: qcom_q6v5_adsp: Convert to dev_pm_domain_attach|detach_list()
      media: venus: Convert to dev_pm_domain_attach|detach_list() for vcodec
      pmdomain: Merge branch fixes into next

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   2 +
 .../bindings/power/renesas,rcar-sysc.yaml          |   1 +
 .../bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml |  22 +--
 drivers/base/power/common.c                        | 134 +++++++++++++++++
 drivers/media/platform/qcom/venus/core.c           |  12 +-
 drivers/media/platform/qcom/venus/core.h           |   7 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |  48 +++----
 drivers/pmdomain/core.c                            | 141 +++++++++++-------
 drivers/pmdomain/imx/imx8m-blk-ctrl.c              |   9 +-
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c             |  19 +--
 drivers/pmdomain/imx/scu-pd.c                      |   2 +-
 drivers/pmdomain/mediatek/mtk-scpsys.c             |   4 +-
 drivers/pmdomain/qcom/rpmpd.c                      |  96 ++++++++++++-
 drivers/pmdomain/renesas/Kconfig                   |   4 +
 drivers/pmdomain/renesas/Makefile                  |   1 +
 drivers/pmdomain/renesas/r8a779a0-sysc.c           |  12 --
 drivers/pmdomain/renesas/r8a779f0-sysc.c           |  12 --
 drivers/pmdomain/renesas/r8a779g0-sysc.c           |  12 --
 drivers/pmdomain/renesas/r8a779h0-sysc.c           |  54 +++++++
 drivers/pmdomain/renesas/rcar-gen4-sysc.c          |  17 ++-
 drivers/pmdomain/renesas/rcar-gen4-sysc.h          |   1 +
 drivers/pmdomain/renesas/rcar-sysc.c               |   4 +-
 drivers/pmdomain/tegra/powergate-bpmp.c            |   2 +-
 drivers/pmdomain/ti/omap_prm.c                     |   2 +
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |   2 +-
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c        |   2 +-
 drivers/remoteproc/imx_dsp_rproc.c                 |  82 ++---------
 drivers/remoteproc/imx_rproc.c                     |  73 ++--------
 drivers/remoteproc/qcom_q6v5_adsp.c                | 160 ++++++++++-----------
 include/dt-bindings/power/qcom-rpmpd.h             |   7 +
 include/dt-bindings/power/renesas,r8a779h0-sysc.h  |  49 +++++++
 include/linux/pm_domain.h                          |  60 ++++++--
 32 files changed, 644 insertions(+), 409 deletions(-)
 create mode 100644 drivers/pmdomain/renesas/r8a779h0-sysc.c
 create mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h

