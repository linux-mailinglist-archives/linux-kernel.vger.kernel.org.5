Return-Path: <linux-kernel+bounces-51845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25A848FF1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072311C20C91
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1F6250F8;
	Sun,  4 Feb 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NEtxkGF0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83352249EE;
	Sun,  4 Feb 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707071563; cv=none; b=ZuPt7597U8ny3KZPHT+jdJWKuJXPr39yW101VI5T2Pcc5antz/IZ5YaUvmq9lNT+8Di3kY8sVrivEe/kQyGdBpXnawfU5Myt41nX339nVlJASgL+rPQA0ha7cJpAtUBexLX4ZxQWwqfGKl/wwr0TOmmb3apnKEvRzmXWNovsOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707071563; c=relaxed/simple;
	bh=0+rTMhidwrziDNcAPA5ZtRDC2hGitSVJlE07G60n9N8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qShD9XtWUVITc3Il4N4SCr4bbsKq/dV3vHZoR+rVTtkKBgJDoFXEQd3a7/Z/AbHpc1v5N3NaCm+UhYJmyt4YmxlmWMBZpOE7cCUhuM2zYuXoJnbnHryAxyptC4C1Zyrp5w/RHgZEVz1NLfhlH2+2qBlyBrXjbuc9Sg/ew2hGP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NEtxkGF0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 414IW9Ft020319;
	Sun, 4 Feb 2024 12:32:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707071529;
	bh=s2TWXxbk1O39WIKgnGYQbW++dB7WqbpabTQYcEP9Epg=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=NEtxkGF0LK9XaN9HqFJjU9aFr3taztUE4uxi+uN7w/z6xRWBwV/f5C1nBHVQUOsNW
	 l2APL7p+wukyZK+oneR50K5qf3nPn8zPfiJ1y1sbJjJZiOI4epbkRk6XcpzUsAxHoS
	 dquzwtolCOfUc11IG0xiylFmsBeN9TaCsknOPWVc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 414IW9NI020112
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 4 Feb 2024 12:32:09 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 4
 Feb 2024 12:32:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 4 Feb 2024 12:32:09 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 414IW86i038451;
	Sun, 4 Feb 2024 12:32:08 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_omprsing@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: Re: [EXTERNAL] [PATCH v4 04/15] soc: qcom: ice: add hwkm support in
 ice
In-Reply-To: <20240127232436.2632187-5-quic_gaurkash@quicinc.com>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-5-quic_gaurkash@quicinc.com>
Date: Mon, 5 Feb 2024 00:02:07 +0530
Message-ID: <87jznkytaw.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Gaurav Kashyap <quic_gaurkash@quicinc.com> writes:

..

> +	/*
> +	 * When ICE is in standard (hwkm) mode, it supports HW wrapped
> +	 * keys, and when it is in legacy mode, it only supports standard
> +	 * (non HW wrapped) keys.
> +	 *
> +	 * Put ICE in standard mode, ICE defaults to legacy mode.
> +	 * Legacy mode - ICE HWKM slave not supported.
> +	 * Standard mode - ICE HWKM slave supported.
> +	 *
> +	 * Depending on the version of HWKM, it is controlled by different
> +	 * registers in ICE.
> +	 */
> +	if (ice->hwkm_version >= 2) {
> +		val = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
> +		val = val & 0xFFFFFFFE;
From the code I understand that the last bit is used for setting the
mode.

Was wondering if it would make more sense to use ~BIT(0) or GENMASK
to generate this value and #define this value to express the work it
does.

In this case, something like #define xx_SET_MODE_MASK (~BIT(0)) or use GENMASK

This would make it easier for a person who is taking a look at the code
for first time. This is just my perspective.

If you do agree, you can change them at multiple places accross this
patch, wherever magic numbers are used for val and masking the value.

Regards,
Kamlesh

> +		qcom_ice_writel(ice, val, QCOM_ICE_REG_CONTROL);
> +	} else {
> +		qcom_ice_writel(ice, 0x7, HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
> +	}
> +}
> +
> +static void qcom_ice_hwkm_init(struct qcom_ice *ice)
> +{
> +	/* Disable CRC checks. This HWKM feature is not used. */
> +	qcom_ice_writel(ice, 0x6,
> +			HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
> +
> +	/*
> +	 * Give register bank of the HWKM slave access to read and modify
> +	 * the keyslots in ICE HWKM slave. Without this, trustzone will not
> +	 * be able to program keys into ICE.
> +	 */
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_0));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_1));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_2));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_3));
> +	qcom_ice_writel(ice, 0xFFFFFFFF, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_4));
> +
> +	/* Clear HWKM response FIFO before doing anything */
> +	qcom_ice_writel(ice, 0x8, HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS));
> +	ice->hwkm_init_complete = true;
> +}

..

