Return-Path: <linux-kernel+bounces-67314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEFB85699F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149211C23E01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA17135419;
	Thu, 15 Feb 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0DKPwfb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61A131E56;
	Thu, 15 Feb 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014768; cv=none; b=YJW04wX3bNV3dkan0fMx1MxZeQi8Jh02Q8HS5BR/A9LNi+Xl0+2/l2w6tvjCUlvP7ltQ+YRw9uRfvlIM6pCsNzubWUMDOY0nD3VdZrwxJGmb0AQtLJhCib1nW1Wt7gccF4+npofwiICvHKLauMSTNwx/19uht6gruo9A6q11krU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014768; c=relaxed/simple;
	bh=Ab/m3FXZDk4BTfQ0FyXmzh0a7uFDpqU4kjKXHTawJTE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r8cqjQJbrfVqZ1WPi64Zyb3AFKYbe+POmCdaME5EDk8T8CkBla8PjOHukyx6kr3J9RBe76IOIaCLUCC1CYdbSy9JEZseDabYlj07IcpsjmgS0//B2wwnCM1Hqb8s388jyU5wpof1mL92LuVNSXC04rUbX09RHb22/Fdmr8Hae6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0DKPwfb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708014767; x=1739550767;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ab/m3FXZDk4BTfQ0FyXmzh0a7uFDpqU4kjKXHTawJTE=;
  b=O0DKPwfbhE/zySf+C7zJnPmOkX6b/mbzocFCqVSvzKwOPcXfQeRXTysD
   gEvwNoOtIes/C1HBsE0CfT1ahTNgTbrdN5mQ2Su8BnzHje/pi4Ox8kxNy
   5MH2CjkP3e0O4UA4vdnfZdouRhd0t0nW/XQK8OCX91eSjUGGJdiluUfIF
   k4JXP8PLAXJv56KR472c/GnEkWGGdRuhS+U73fxRYmIJODI/f1DELLbg7
   NXKM1xBZhUBri+gYW6wXZd2o4PqeNp56jhfFGQPRtqbdP/fHUGSDFInkV
   4yh/LgfSNw7EqDXhyiIs6BB0XKQRf+sXB2HSA/mB+kdDngDPolas9xjDQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12739599"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="12739599"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3505815"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:32:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 Feb 2024 18:32:38 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, 
    Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm7271: Replace custom unit
 definitions
In-Reply-To: <20240215160234.653305-1-andriy.shevchenko@linux.intel.com>
Message-ID: <ab7d7ca2-f516-68b5-b80a-fb3b5db4cb1e@linux.intel.com>
References: <20240215160234.653305-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1190146347-1708014758=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1190146347-1708014758=:1019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Feb 2024, Andy Shevchenko wrote:

> Replace custom unit definitions that are available via units.h.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1190146347-1708014758=:1019--

