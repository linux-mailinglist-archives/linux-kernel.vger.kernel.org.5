Return-Path: <linux-kernel+bounces-90661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F98702D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D77C28BD30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17AE3DB9A;
	Mon,  4 Mar 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghiG6N+b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33A3E462;
	Mon,  4 Mar 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559289; cv=none; b=NMMjiAigkZM+gqH1RHoZYzKRlXNHZE4t/dsLr36wj4Eb54l/St7hwv91ZBWdjDgr3fKzXzo/j/NN2Q1NvoAMJdxhH+oMs2r97SlHydMF7eKcU7N3SdAjscDbD/YmUVcqYpYLnqJn/w9Vv/IH5Dl5t7YbUB0VwFKQToIwiyH/2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559289; c=relaxed/simple;
	bh=+Owds2r9Mm7uOEVwGzmpQS09QahSOxcWW+Vi+cImv20=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VEnRfY85wv3zoRxju3DCi4vstNJXzDrbRqGZ/O1iCBniW8vgHtIud63q0AtKFTMDuM2sdd46nmDFfU+NiYz2PHt7tlDWtOA0UiJqz3VRNvLW2xhAwe2PQJjXC/2AqOvEOMsH+QZdF7p3GBiR+v9MNIS1hffpRsXW0K8tHs7SiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghiG6N+b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709559288; x=1741095288;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+Owds2r9Mm7uOEVwGzmpQS09QahSOxcWW+Vi+cImv20=;
  b=ghiG6N+blP77tS+/FslmQ+BrzKlXgh6XWZF29z0wymxMLW5HfJQw/uVg
   AKWCRP9LSec4UzbqvBOr+xi3w1/vdaoRJXXcMZRU1c7metFamfizdj5Gw
   uXQpYRbibn+cWTVB3yX40iMNizr+lb6m5DlGnXaz7w5x8uQSMl2f0z7cr
   ODByiqQplzZykOMkdEEWcJ1J2kA43cYtSjbzljPZdWWhtU09otH/m6AD9
   DgqsCCX6IYmXZe1q2+I8UnvflRb72xSKqlj8gOTEuLohqlxbrg308rVGw
   JaE54TaEgfXgHLe9cds4wUsdki7Utw+T0Kup/BCqGPvc6fijh8ZmvS6Gd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14626052"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14626052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13499598"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:34:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Mar 2024 15:34:40 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH V2 9/9] tools: intel_sdsi: Add current meter support
In-Reply-To: <20240228000016.1685518-10-david.e.box@linux.intel.com>
Message-ID: <297de469-c804-e641-337b-d2bf0524097b@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com> <20240228000016.1685518-10-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-432551398-1709559280=:986"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-432551398-1709559280=:986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Feb 2024, David E. Box wrote:

> Add support to read the 'meter_current' file. The display is the same as
> the 'meter_certificate', but will show the current snapshot of the
> counters.
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>=20
> V2 - Set the name of the file to be opened once.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-432551398-1709559280=:986--

