Return-Path: <linux-kernel+bounces-28414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89882FE44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B031F278D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92E1170E;
	Wed, 17 Jan 2024 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRT/NlWw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D529A9;
	Wed, 17 Jan 2024 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453810; cv=none; b=Vp8aJBGEbbVXWjxRfYGd64n1TMRypoUHmteJ/MYqQ2nmCUIhPZT0a+AmTusfp64FIZYx44U+HeXdCyY8GQeMtgK3ebGV8e5oUdsmsVSllG41pjGvZP9TZKMKKnYT1/tgW1u0JumJqyaxbIzJjHOYBQAYTIYSD9kRjCCWvIF05vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453810; c=relaxed/simple;
	bh=ao3j/PHziICip5QY+H3PmQcaFdiysra4OxcF9jLCvXo=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=BbyoxJprsaMcq84v8q4t1YM1IRPlAjPlH0doUlqC4tt4kqzK1HCKuN8FK0Xwg1e25flxIjIieeerMJFtUlKwR+bffqPOJJ/JRuV9JzDQg8aKPUHlXqD3ynxD8MqNTZp1ZAmroHYgCRXmtA5wjSulks+xoMTf4poGwjwp76rLrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MRT/NlWw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qa6fUxPXUaqPN0YIg7RJSfQQy70I4nGp8qxnNLTyklk=; b=MRT/NlWw839YjjEOkVyFtrW6pG
	y3TCu+C5AUZIuVLvjgzYiPRN2+11+lTWCVOOoIifeRv+TXsl7xpkVXcgHUZC3ly+7SL8KSBl5TanR
	MwjENsXt8UBWWQA6psLC0O6SrFhSutx8lq4nu3MJpBmPX/Soxhqi//grPo04cvL4ZjDvNmnV8jZml
	YIVA8hbSL8bFa8skEDijL8EAPKcQwGNY11rq2kjdfTNhVpWXAazhUYUdllHpVwnf3dSlMO/TVtKe1
	LyZb/RCKwlOndgcTSfpe6uKbIiXSvCSfKEcBOZ71D4z0HvcOG3f/3P+OBD+z+wwu24H5kavc98/VC
	KcpdYklA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRT-00E6zu-36;
	Wed, 17 Jan 2024 01:10:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Kevin Hilman <khilman@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 08/13] ARM: OMAP2+: pmic-cpcap: fix kernel-doc warnings
Date: Tue, 16 Jan 2024 17:09:56 -0800
Message-ID: <20240117011004.22669-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function names in kernel-doc comments.
Use "Return[s]:" kernel-doc notation for function return values.

These changes prevent the following warnings:

pmic-cpcap.c:28: warning: expecting prototype for omap_cpcap_vsel_to_vdc(). Prototype was for omap_cpcap_vsel_to_uv() instead
pmic-cpcap.c:92: warning: expecting prototype for omap_max8952_vsel_to_vdc(). Prototype was for omap_max8952_vsel_to_uv() instead
pmic-cpcap.c:139: warning: expecting prototype for omap_fan5355_vsel_to_vdc(). Prototype was for omap_fan535503_vsel_to_uv() instead
pmic-cpcap.c:154: warning: expecting prototype for omap_fan535508_vsel_to_vdc(). Prototype was for omap_fan535508_vsel_to_uv() instead
pmic-cpcap.c:28: warning: No description found for return value of 'omap_cpcap_vsel_to_uv'
pmic-cpcap.c:42: warning: No description found for return value of 'omap_cpcap_uv_to_vsel'
pmic-cpcap.c:92: warning: No description found for return value of 'omap_max8952_vsel_to_uv'
pmic-cpcap.c:106: warning: No description found for return value of 'omap_max8952_uv_to_vsel'
pmic-cpcap.c:139: warning: No description found for return value of 'omap_fan535503_vsel_to_uv'
pmic-cpcap.c:154: warning: No description found for return value of 'omap_fan535508_vsel_to_uv'
pmic-cpcap.c:172: warning: No description found for return value of 'omap_fan535503_uv_to_vsel'
pmic-cpcap.c:191: warning: No description found for return value of 'omap_fan535508_uv_to_vsel'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/pmic-cpcap.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff -- a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -18,10 +18,10 @@
 #include "vc.h"
 
 /**
- * omap_cpcap_vsel_to_vdc - convert CPCAP VSEL value to microvolts DC
+ * omap_cpcap_vsel_to_uv - convert CPCAP VSEL value to microvolts DC
  * @vsel: CPCAP VSEL value to convert
  *
- * Returns the microvolts DC that the CPCAP PMIC should generate when
+ * Returns: the microvolts DC that the CPCAP PMIC should generate when
  * programmed with @vsel.
  */
 static unsigned long omap_cpcap_vsel_to_uv(unsigned char vsel)
@@ -35,7 +35,7 @@ static unsigned long omap_cpcap_vsel_to_
  * omap_cpcap_uv_to_vsel - convert microvolts DC to CPCAP VSEL value
  * @uv: microvolts DC to convert
  *
- * Returns the VSEL value necessary for the CPCAP PMIC to
+ * Returns: the VSEL value necessary for the CPCAP PMIC to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
 static unsigned char omap_cpcap_uv_to_vsel(unsigned long uv)
@@ -82,10 +82,10 @@ static struct omap_voltdm_pmic omap_cpca
 };
 
 /**
- * omap_max8952_vsel_to_vdc - convert MAX8952 VSEL value to microvolts DC
+ * omap_max8952_vsel_to_uv - convert MAX8952 VSEL value to microvolts DC
  * @vsel: MAX8952 VSEL value to convert
  *
- * Returns the microvolts DC that the MAX8952 Regulator should generate when
+ * Returns: the microvolts DC that the MAX8952 Regulator should generate when
  * programmed with @vsel.
  */
 static unsigned long omap_max8952_vsel_to_uv(unsigned char vsel)
@@ -99,7 +99,7 @@ static unsigned long omap_max8952_vsel_t
  * omap_max8952_uv_to_vsel - convert microvolts DC to MAX8952 VSEL value
  * @uv: microvolts DC to convert
  *
- * Returns the VSEL value necessary for the MAX8952 Regulator to
+ * Returns: the VSEL value necessary for the MAX8952 Regulator to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
 static unsigned char omap_max8952_uv_to_vsel(unsigned long uv)
@@ -129,10 +129,10 @@ static struct omap_voltdm_pmic omap443x_
 };
 
 /**
- * omap_fan5355_vsel_to_vdc - convert FAN535503 VSEL value to microvolts DC
+ * omap_fan535503_vsel_to_uv - convert FAN535503 VSEL value to microvolts DC
  * @vsel: FAN535503 VSEL value to convert
  *
- * Returns the microvolts DC that the FAN535503 Regulator should generate when
+ * Returns: the microvolts DC that the FAN535503 Regulator should generate when
  * programmed with @vsel.
  */
 static unsigned long omap_fan535503_vsel_to_uv(unsigned char vsel)
@@ -144,10 +144,10 @@ static unsigned long omap_fan535503_vsel
 }
 
 /**
- * omap_fan535508_vsel_to_vdc - convert FAN535508 VSEL value to microvolts DC
+ * omap_fan535508_vsel_to_uv - convert FAN535508 VSEL value to microvolts DC
  * @vsel: FAN535508 VSEL value to convert
  *
- * Returns the microvolts DC that the FAN535508 Regulator should generate when
+ * Returns: the microvolts DC that the FAN535508 Regulator should generate when
  * programmed with @vsel.
  */
 static unsigned long omap_fan535508_vsel_to_uv(unsigned char vsel)
@@ -165,7 +165,7 @@ static unsigned long omap_fan535508_vsel
  * omap_fan535503_uv_to_vsel - convert microvolts DC to FAN535503 VSEL value
  * @uv: microvolts DC to convert
  *
- * Returns the VSEL value necessary for the MAX8952 Regulator to
+ * Returns: the VSEL value necessary for the MAX8952 Regulator to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
 static unsigned char omap_fan535503_uv_to_vsel(unsigned long uv)
@@ -184,7 +184,7 @@ static unsigned char omap_fan535503_uv_t
  * omap_fan535508_uv_to_vsel - convert microvolts DC to FAN535508 VSEL value
  * @uv: microvolts DC to convert
  *
- * Returns the VSEL value necessary for the MAX8952 Regulator to
+ * Returns: the VSEL value necessary for the MAX8952 Regulator to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
 static unsigned char omap_fan535508_uv_to_vsel(unsigned long uv)

