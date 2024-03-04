Return-Path: <linux-kernel+bounces-90630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871A870277
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B866A1F214A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616E3D972;
	Mon,  4 Mar 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lvk/riKI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761043E486;
	Mon,  4 Mar 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558240; cv=none; b=GCz/b1RlemI/jeL01SXNkkaqjAdWmN/jzjhtQJrjNhQYdcvNP8Cym6X1Ur2gWKhxjSETaxrMB15rt5qBq69vyeFsn2xZH0qxKe/Bt2xQ/8D8GgjBjCgQutZk+7mhY3TAGQXPaMn2mKepI1/jTbK6exE21gJjYAvbKnNJ0rF6jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558240; c=relaxed/simple;
	bh=XgGqRbbMktwxIBJCvB0744jrz2yqMhcaCDWd5eNki3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aCbNlfYkoLOPfSOVYo/29tDaUknfA1DVtMirJmdvOb8OMjeZEzUXzLBNJeL48PaIRCa9Xj4e2UeTiQ4E9cZTIVxH6iRuaKb6IVcs+6eR9kJtXZoCq9WnoaeTaYC8ROpxlMAby6ZNoRuaUJqrY9j7b6TLvt2gZyD87GqOYjIIwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lvk/riKI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558239; x=1741094239;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=XgGqRbbMktwxIBJCvB0744jrz2yqMhcaCDWd5eNki3E=;
  b=Lvk/riKIi4MH5XBGVoENyNRQiMXtksfAX0VA05zmkv2K3y7GSKQr9qQ1
   fSQiOeq/I0tPY+sW2j7Q07zkFViHq1mGHFROjrJ6GoVG1dY6FXVy10QHg
   vAoUwN/ooh1p3/bRXVBXO00mSPfoUmZPwZmnmVVcUz6QOpXEayrOmHEfG
   Ko5uVSXnFQUO8mXfxapBhUa4ztMxepfZkj9djs2RSiDCytbhDHekKzRVa
   5QOUiNvDIRUUsZlNPxvzZGCrfuEoAh8V5ppW5CqNdOlXLqNfc/uBI4Hbs
   zBhBJ5+qwvqsXpl++3iisAHBgFaxWSzKkkeTOpQOKnPEvCJqnoiUqSl53
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4625189"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4625189"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8905195"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Vishnu Sankar <vishnuocv@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mpearson-lenovo@squebb.ca, vsankar@lenovo.com
In-Reply-To: <20240228150149.4799-1-vishnuocv@gmail.com>
References: <20240228150149.4799-1-vishnuocv@gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add more ThinkPads with
 non-standard reg address for fan
Message-Id: <170955823261.5357.3667196040334632784.b4-ty@linux.intel.com>
Date: Mon, 04 Mar 2024 15:17:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Thu, 29 Feb 2024 00:01:49 +0900, Vishnu Sankar wrote:

> Add more ThinkPads with non-standard register addresses to read fan values.
> 
> ThinkPads added are L13 Yoga Gen1, X13 Yoga Gen1, L380, L390, 11e Gen5 GL,
> 11e Gen5 GL-R, 11e Gen5 KL-Y.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: Add more ThinkPads with non-standard reg address for fan
      commit: 0dfb4617af0d4cfbaf75590a83e2ce367b67134a

--
 i.


