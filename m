Return-Path: <linux-kernel+bounces-145497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92D8A56F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922AA1F223E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3C824AE;
	Mon, 15 Apr 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b3c1shes"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F78175E;
	Mon, 15 Apr 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196854; cv=none; b=kQtWWe1plG+LezyGtupgsCmRRu0OHr4g//PZ8wxp/Q6wP9EcTeffwnoUC+8QfUMK8Ik7TNpNu2KUwUCv8x5ul6Je8Yz43FymypRYGWsAFT6fUQvWxjj3h68/hh36P+o+BWJX85dkc1UOetc/ioGPP7r5/AZLuzo2LEX7aa8eZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196854; c=relaxed/simple;
	bh=aHZGJy27O3UQ6ClAkPEPt8qvWQjPk8Laos6wipFyuwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIUIr3h3NOFHYKnpqZAk0CndTU6BwtuS/TXmN/V/Kd1FG87m/Mc7OnmOug6JUWHw+MElYsAXbbJAMVVKeYi1bvNcOWMH0CJiAn5uF+3oo4v3Ad+ylEpdnlS39BdKOiORZK3nBWQtUgLTji0s1ce/EPJ9Nr1RnNpIzkIcu9ndJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=b3c1shes; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7FBE47E4;
	Mon, 15 Apr 2024 17:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713196798;
	bh=aHZGJy27O3UQ6ClAkPEPt8qvWQjPk8Laos6wipFyuwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b3c1sheswxT8ikKUTQ8Pt3VoSPGellzjUiMwcpuLIaFondbj1fOPgdwVO4HLqRbTM
	 STb1eSDtoyF2ldLIzTI8/0v68iRRRVV5uhwIMX+jiqMNQLXbTEkMJNoTtsw8fuWjQ3
	 qQ3vJPwqPg5ql6Yu6RnUf03vgms3ruY6gDWI39ng=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 15 Apr 2024 19:00:24 +0300
Subject: [PATCH RFC 2/2] pmdomain: ti-sci: Support retaining PD boot time
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-ti-sci-pd-v1-2-a0e56b8ad897@ideasonboard.com>
References: <20240415-ti-sci-pd-v1-0-a0e56b8ad897@ideasonboard.com>
In-Reply-To: <20240415-ti-sci-pd-v1-0-a0e56b8ad897@ideasonboard.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, 
 J Keerthy <j-keerthy@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@oracle.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4969;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=aHZGJy27O3UQ6ClAkPEPt8qvWQjPk8Laos6wipFyuwQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHU8o1BLaDv0NeuzDEaSDr1lMCCxM+xTAexGI4
 03BPSBl+9aJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh1PKAAKCRD6PaqMvJYe
 9V50EACQR5lMfH0sU8J1ckdRURsik2Oe516ogzaF77WK53RcpQSizwEC4rmMXtr7c+EH0R99Fv0
 qq5SWYcF/b/A/NNoFFFZUx7Nn3x2A3MkEBfz/3QxvXBtykhELggAT5S711Jc9nh7pFX7GAIow8A
 57tB8EFNAbqANxYRSgrmJPk0wIEucMd3NRwQIsmc8RejszxiZM2wvZ2uGXOnRRprO0AGyujN64m
 0mZE5JK6tTTf41uNH36KqO6qEHuV1V0Jm6Mb+awZKvIk2Xl5ZigAe8H5pmDeh91I4piH4AXKM3m
 7MU+HEdDgjLuxrDdfJks4NmAQFQrDyvWO+3m1pH9G0PJY20ONJJ+O1BSThlpwmYf9uX+RseYb4w
 +XWJhLsb4B4qJohUzJDTUb3v9s//HyxOOUsFQ192QDU8hUBQUw2MAFThqD/kUf4WPoGTWHMHfLO
 mWfDc2kUScL1qhruStp7kkQUZC+EZr33mqPnchZXXsNdMPBjt4gwvROt/T1YBOIxv4ApVjTy87l
 QJs4mo0aMGMM/B2UMO8hZS+gTJoYC6DWzpHS1lntXvV2qKi0aXBkZn2ho//yOC6/zUItS9uN6J8
 KI+P1Npv32mYqomT4gm0f0jJzOx85HociK9SHo2d41c0jw16CFJuFaHtI+P6eLaABRDM6OwUBDa
 r3XMNW7U5/A1Uuw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add a new flag, TI_SCI_PD_KEEP_BOOT_STATE, which can be set in the dts
when referring to power domains. When this flag is set, the ti-sci
driver will check if the PD is currently enabled in the HW, and if so,
set the GENPD_FLAG_ALWAYS_ON flag so that the PD will stay enabled.

The main issue I'm trying to solve here is this:

If the Display Subsystem (DSS) has been enabled by the bootloader, the
related PD has also been enabled in the HW. When the tidss driver
probes, the driver framework will automatically enable the PD. While
executing the probe function it is very common for the probe to return
EPROBE_DEFER, and, in rarer cases, an actual error. When this happens
(probe() returns an error), the driver framework will automatically
disable the related PD.

Powering off the PD while the DSS is enabled and displaying a picture
will cause the DSS HW to enter a bad state, from which (afaik) it can't
be woken up except with full power-cycle. Trying to access the DSS in
this state (e.g. when retrying the probe) will usually cause the board
to hang sooner or later.

Even if we wouldn't have this board-hangs issue, it's nice to be able to
keep the DSS PD enabled: we want to keep the DSS enabled when the
bootloader has enabled the screen. If, instead, we disable the PD at the
first EPROBE_DEFER, the screen will (probably) go black.

Another option here would perhaps be to change the driver framework
(drivers/base/platform.c) which attaches and detaches the PD, and make
it somehow optional, allowing the driver the manage the PD. That option
has two downsides: 1) the driver _has_ to manage the PD, which would
rule out the use of simplefb and simpledrm, and 2) it would leave the PD
in off state from Linux's perspective until a driver enables the PD, and
that might mean that the PD gets actually disabled as part of normal
system wide power management (disabling unused resources).

Yet another option would be to do this outside the ti_sci_pm_domains
driver: a piece of code that would somehow be ran after the
ti_sci_pm_domains driver has probed (so that we have the PDs), but
before tidss/simplefb/simpledrm probes. The problem here is the
"somehow" part. Also, this would partly have the same issue 2) as
mentioned above.

TODO: If this approach is ok, sci-pm-domain.yaml needs to be extended.
Also, it sounds a bit like the cell value is not a bit-mask, so maybe
adding TI_SCI_PD_KEEP_BOOT_STATE flag this way is not fine.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c    | 27 +++++++++++++++++++++++++--
 include/dt-bindings/soc/ti,sci_pm_domain.h |  1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..b71b390aaa39 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -103,7 +103,7 @@ static struct generic_pm_domain *ti_sci_pd_xlate(
 		return ERR_PTR(-ENOENT);
 
 	genpd_to_ti_sci_pd(genpd_data->domains[idx])->exclusive =
-		genpdspec->args[1];
+		genpdspec->args[1] & TI_SCI_PD_EXCLUSIVE;
 
 	return genpd_data->domains[idx];
 }
@@ -161,6 +161,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
+				bool is_on = false;
+
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
 				} else {
@@ -189,7 +191,28 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
 
-				pm_genpd_init(&pd->pd, NULL, true);
+				/*
+				 * If TI_SCI_PD_KEEP_BOOT_STATE is set and the
+				 * PD has been enabled by the bootloader, set
+				 * the PD to GENPD_FLAG_ALWAYS_ON. This will
+				 * make sure the PD stays enabled until a driver
+				 * takes over and clears the GENPD_FLAG_ALWAYS_ON
+				 * flag.
+				 */
+				if (args.args_count > 1 &&
+				    args.args[1] & TI_SCI_PD_KEEP_BOOT_STATE) {
+					/*
+					 * We ignore any error here, and in case
+					 * of error just assume the PD is off.
+					 */
+					pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
+						pd->idx, NULL, &is_on);
+
+					if (is_on)
+						pd->pd.flags |= GENPD_FLAG_ALWAYS_ON;
+				}
+
+				pm_genpd_init(&pd->pd, NULL, !is_on);
 
 				list_add(&pd->node, &pd_provider->pd_list);
 			}
diff --git a/include/dt-bindings/soc/ti,sci_pm_domain.h b/include/dt-bindings/soc/ti,sci_pm_domain.h
index 8f2a7360b65e..af610208e3a3 100644
--- a/include/dt-bindings/soc/ti,sci_pm_domain.h
+++ b/include/dt-bindings/soc/ti,sci_pm_domain.h
@@ -3,6 +3,7 @@
 #ifndef __DT_BINDINGS_TI_SCI_PM_DOMAIN_H
 #define __DT_BINDINGS_TI_SCI_PM_DOMAIN_H
 
+#define TI_SCI_PD_KEEP_BOOT_STATE 2
 #define TI_SCI_PD_EXCLUSIVE	1
 #define TI_SCI_PD_SHARED	0
 

-- 
2.34.1


