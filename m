Return-Path: <linux-kernel+bounces-106094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31C87E8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7A5282BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F85337714;
	Mon, 18 Mar 2024 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eb5NZg+L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9A374DD;
	Mon, 18 Mar 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762847; cv=none; b=JpxgdRuhhbTLawLG9KZzN1JG2m8+42xYGlNOSDQP46GsWwn1MbZACQpLT8lTvn9LPFKj4pRx8XDes4zmGrKde6kK4WdL7xL2imRouiY/PDCUHHH55GwXUtn2WL/vEwTs5sAcqb/NTcjSBtiZ+65HJZqlhztE2Bb4veNPEg7MQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762847; c=relaxed/simple;
	bh=JA/KRWB1iWsUGT53W2XAqwsBspnF3Fn6EQ5RKr36NmY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AlNVKQAq/kU8haXIZ0Jw2Jhpq7+WHdUV4LndzJ0qDBcdHaWZxBjkQy0i6tStNN2fJKOfsAP3R5iPzys4s87wdNa2IjnndfK1/4OtU17VW7V0wb5IXrtH5VJQuSTvzJoU7u25X2RLc4OrIEVHCQrrNI0rf6QQqJ8VFLpcNcyiRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eb5NZg+L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710762846; x=1742298846;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=JA/KRWB1iWsUGT53W2XAqwsBspnF3Fn6EQ5RKr36NmY=;
  b=eb5NZg+LYnEn7CKFrX9FI+Zg55awTvJYagQwm9tGhfpexOAk9we8/jMw
   3H9G/jiGShw2znpt6c+0uThoh9Hv2gFt5Myk8r+WgUCiKQGfGBGc41izP
   okfRlvKMoCVUxclM9vEq2UImSPLLMhQwuLRl6GX80cFuPzG2H2V8cJ5ZR
   u8B4QTKsUJ9ZaqbCl8vPUB7L4ZExEBFcbOyc0+C07YlVzZcKaz8pGvKqL
   2m0cVtfdhNyY3/F1SSYDdgGmPtEm07ojn4oV6Ygf9lYA0W2/0EdwrR8Tx
   O3lg0PVgK0AElJvxGP8jOqPpY9bfKZbfReEcEc6MKMrzDTCJ7ktPKaJB9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5403765"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5403765"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 04:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13831209"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.11])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 04:53:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 18 Mar 2024 13:53:53 +0200 (EET)
To: Nikita Travkin <nikita@trvn.ru>
cc: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
    Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
    Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 3/4] platform: arm64: Add Acer Aspire 1 embedded
 controller driver
In-Reply-To: <20240315-aspire1-ec-v5-3-f93381deff39@trvn.ru>
Message-ID: <f68150a6-62bd-f99f-ad24-f2a018a67d2e@linux.intel.com>
References: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru> <20240315-aspire1-ec-v5-3-f93381deff39@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-685438645-1710762824=:1041"
Content-ID: <8d9d18f0-5a11-8f08-3681-a84e27267c21@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-685438645-1710762824=:1041
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <64e59465-3e35-8c82-5b41-6fd74dbb49db@linux.intel.com>

On Fri, 15 Mar 2024, Nikita Travkin wrote:

> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
> controller to perform a set of various functions, such as:
>=20
> - Battery and charger monitoring;
> - Keyboard layout control (i.e. fn_lock settings);
> - USB Type-C DP alt mode HPD notifications;
> - Laptop lid status.
>=20
> Unfortunately, while all this functionality is implemented in ACPI, it's
> currently not possible to use ACPI to boot Linux on such Qualcomm
> devices. To allow Linux to still support the features provided by EC,
> this driver reimplments the relevant ACPI parts. This allows us to boot
> the laptop with Device Tree and retain all the features.
>=20
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-685438645-1710762824=:1041--

