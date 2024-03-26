Return-Path: <linux-kernel+bounces-120054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9A188D0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AAB1C37E67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C349140378;
	Tue, 26 Mar 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CagB35W+"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58D13F420;
	Tue, 26 Mar 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492214; cv=none; b=dlauUB+i48V7VvvUsoA35XVO5LX67vTNwREjtNLkMgx2kTcq9lvSpc+FFAgplPI9OlHn1rL279DYMyJrFbppByRUIQ05MQ56301raic0NUHAkYa2dlX9qDhIXVIFxfcnN8j22qf4CwCvUgiEXPrwowNTwGuXnQoFGHBrJhXZfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492214; c=relaxed/simple;
	bh=ry/DihWBqFAS5czADTnqSvM71OrE0DpTnMruEEdq/64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrDpOBolCZfh/3ctzh4f2sfJ52SD4jlvfG3ClF40sIfH7ln9sZVXOqDWnM+p8uoGAcS7TAchpTxJzUWzP/7eLonyNBQV0YG2spvdY4G8P6W5K2T3VCms8ofvIGJVRFbpL/2KtKvVX9bUGT3as8o560malty8QGbJzrkmZqJkS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CagB35W+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed7ef0ae8so4319103f8f.0;
        Tue, 26 Mar 2024 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492211; x=1712097011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIIuyjYgKvlbHZWyIDIL4+6J6/vl+xy082AgaZCuG00=;
        b=CagB35W+j0YsYHrAkY6GNr4dmrGyUmbxTZPnJ5uJTFXvraUfv5tqZKxWgDr1O4lGI3
         N5g5Jk1fZ1iBhP8uykTzittPIJ+MhBnOmCD9wA52LKhp4gpGEJ+K2kPVxH81dODcCaJh
         FbDsd1CnkaZsAeMtQ/gzJl+fUmmkxQxM5tN3g/oOH+yKa2R0yOXOsOxRjvZnpdVdIeWr
         BgbDSVc6rMnlGaluzVfRDwRoa6zsWT1Rp0ZL10Z3Qnk7vICAZUPNWO3ROJ0sjT9mzpJl
         TqHyMGugRDL/Hapc/CMQo8JEptlz/kiljZGiYv2JqqQIv+nyjNXsUnX/AU94n5YjGtF0
         aoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492211; x=1712097011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIIuyjYgKvlbHZWyIDIL4+6J6/vl+xy082AgaZCuG00=;
        b=iasTWao2HbLE9YZW06KbbiOPKJuz+vdCte9T2yxEGa3ZgO8fkQWGkAaAxiHZPXtx/K
         UYUN0Yyyn5ckN5KO5BlrBW8iLRuLzkftlpmiAjOB9Y3VVQwPAE6tu0hg6uBB3AMXRULv
         Lld7vsf2GqiJZlBRAHNAdZzn+A6HWTfnp2o7ywipWDEZXl0tEhraiHsGtqKZlC15gObA
         CCIzNBZGaSjoy1DDS/YGwhcGpf8RF6/SJ9i9RAWaJvVRQ5JCH/AektaTe0h3iGDg8DFL
         J5gRdPVkQ8B0XENF41MtiG8SoYOsRYsThedKNGp8FC3xGix9S245pTDlvOzBB80qXv27
         tMOg==
X-Forwarded-Encrypted: i=1; AJvYcCU8U87Vl476AhYWaRuYM1PKlTTEjzBd/aiUo6I1O2eeOmrzzf57dg7iEyCuHYC/uFsSA/EZffY+0rQ44BdPs7wM7YW9QJBUlhzzQx4TwyM2boYZV9pu+M4TgjyWkzCiuoPT9Gwt/ctiVrKTQDo5V7MyJNT45wJqlKofhdBdPojWqEwAbrg=
X-Gm-Message-State: AOJu0Ywoic0Vq/FWKHBoNxZfzxNt7MeLUHxW07gVFDDZ1WFggzd0u6Jm
	Qt5DwNSLnWyP2woqdERZr36lt0o8xPtx23XmXEGP3+vL378fuYZ8
X-Google-Smtp-Source: AGHT+IF6MheTIv2ZJKp1Ji444fGpvCoXRwse0B6F+l4zy5HfHc9jBwkXEVn9+727Bjia8vH/z02VDA==
X-Received: by 2002:a5d:4b81:0:b0:33e:bfb8:7320 with SMTP id b1-20020a5d4b81000000b0033ebfb87320mr9288720wrt.7.1711492211096;
        Tue, 26 Mar 2024 15:30:11 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 10/13] pinctrl: renesas: pinctrl-rzg2l: Add function pointers for reading/writing OEN register
Date: Tue, 26 Mar 2024 22:28:41 +0000
Message-Id: <20240326222844.1422948-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch introduces function pointers, read_oen() and write_oen(), in the
struct rzg2l_pinctrl_data to facilitate reading and writing to the PFC_OEN
register. On the RZ/V2H SoC, unlocking the PWPR.REGWE_B bit before writing
to the PFC_OEN register is necessary, and the PFC_OEN register has more
bits compared to the RZ/G2L family. To handle these differences between
RZ/G2L and RZ/V2H and to reuse the existing code for RZ/V2H, these function
pointers are introduced.

Additionally, this patch populates these function pointers with appropriate
data for existing SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 3de97d5e198a..9bc110b00cbb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -261,6 +261,8 @@ struct rzg2l_pinctrl_data {
 	void (*set_pfc_mode)(struct rzg2l_pinctrl *pctrl, u8 pin, u8 off, u8 func);
 	void (*pm_set_pfc)(struct rzg2l_pinctrl *pctrl);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr);
+	u32 (*read_oen)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin);
+	int (*write_oen)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen);
 };
 
 /**
@@ -1120,7 +1122,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		arg = rzg2l_read_oen(pctrl, cfg, _pin, bit);
+		arg = pctrl->data->read_oen(pctrl, cfg, _pin, bit);
 		if (!arg)
 			return -EINVAL;
 		break;
@@ -1228,7 +1230,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg = pinconf_to_config_argument(_configs[i]);
-			ret = rzg2l_write_oen(pctrl, cfg, _pin, bit, !!arg);
+			ret = pctrl->data->write_oen(pctrl, cfg, _pin, bit, !!arg);
 			if (ret)
 				return ret;
 			break;
@@ -2685,6 +2687,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
 	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.read_oen = &rzg2l_read_oen,
+	.write_oen = &rzg2l_write_oen,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -2699,6 +2703,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
 	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.read_oen = &rzg2l_read_oen,
+	.write_oen = &rzg2l_write_oen,
 };
 
 static struct rzg2l_pinctrl_data r9a08g045_data = {
@@ -2712,6 +2718,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.set_pfc_mode = &rzg2l_pinctrl_set_pfc_mode,
 	.pm_set_pfc = &rzg2l_pinctrl_pm_setup_pfc,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.read_oen = &rzg2l_read_oen,
+	.write_oen = &rzg2l_write_oen,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.34.1


