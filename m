Return-Path: <linux-kernel+bounces-98795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DB877F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4241F226D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10741208;
	Mon, 11 Mar 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgQOAaIG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295940BEA;
	Mon, 11 Mar 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158619; cv=none; b=YOhmEvc3g6VW8jYWlYSst1NaZNEgxa+T9CWkBI9Y5QXqwAxhwPUwY3jATVxp6SdAE4iF1+ezZHRY/y24KUXQ6HPsjt10Nk/8Grr41TaSeJn9Kiq1IAbyOH96/nj9IyPrfClDZLSt7y8cpAGwJLVAJrtf60g467JtNeAWGG6Kg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158619; c=relaxed/simple;
	bh=xzuWtYjO7QQ/BKZn354pNWlFTPOxB7wmzxvNgOJ6Hn8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zoo9GoAmWiM8sASolSsL5TuaXB3QeMIcObfnR46GzD1KPtaDjbpxl4HskY3UgbRbXi3b77klpIw9WhaHvYy7LoN+ON1Z6EnckcHBRBkbN/g980Y6Zf3yaDiqqEG8XfLP9oQ5S9bEA5wHPa5EVBGAqyFL7fyreA3E19VWGDyRFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgQOAaIG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710158618; x=1741694618;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xzuWtYjO7QQ/BKZn354pNWlFTPOxB7wmzxvNgOJ6Hn8=;
  b=UgQOAaIGeISePn7fmkNetpBapNbq3hZhGf6/6wxxk+EzAv9PIlvUfKVK
   gb6lzoKzAK8Tewr4LkLpd3N1Xleqa0vM9LL1JPWbi6tQwqnqb8fTpNFjs
   9OM5SaGNAfxnQue0RYvUM0R1hhKM++xLw9L+a2igo5xfsGV7HBBKJk9Db
   cObzmaTdDettqYssGV7w0ZfCiPx+6vvBJS/ORA+M5NVtVGtDyA8EZLrJm
   SyGOgBXrzrXFPMY0iMUcHp2R20qPQtN6XDvpUvX9Oe77gILVADx8ScI6J
   sVtaqTh/Y3eXqoP3yYDfAdw5c9FQGCuRLtc1lgpbotPX5QUApkSPNm+DN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4981225"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4981225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15789751"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:03:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 14:03:29 +0200 (EET)
To: Kate Hsuan <hpa@redhat.com>
cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
    linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
In-Reply-To: <20240306025801.8814-3-hpa@redhat.com>
Message-ID: <b6e19702-8ec1-38cb-8c43-a3067ebb2017@linux.intel.com>
References: <20240306025801.8814-1-hpa@redhat.com> <20240306025801.8814-3-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1343213729-1710158609=:1071"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1343213729-1710158609=:1071
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Mar 2024, Kate Hsuan wrote:

> This LED controller also installed on a Xiaomi pad2 and it is a x86
> platform. The original driver is based on device tree and can't be
> used for this ACPI based system. This patch migrated the driver to
> use fwnode to access the properties. Moreover, the fwnode API
> supports device tree so this work won't effect the original
> implementations.
>=20
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

FWIW,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1343213729-1710158609=:1071--

