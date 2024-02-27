Return-Path: <linux-kernel+bounces-83018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81F868D27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D321C22594
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90276138493;
	Tue, 27 Feb 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTXVqAEC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437E138484;
	Tue, 27 Feb 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029104; cv=none; b=jbzSijQtgdUZINne6j5CMRa122GRU9xCiqA0eKMQDvpMuMDIuyFgiDBNzK/7GHyLZFVCHNSXO/ziIusHCyxZd7Mz45/LSihYlS2+bVrqgt8lPLpZzJld9VK/lM6hotbdX/78cbBgaOWBWVzGGAtrXlrGdM4/SSWnwmtZOyey41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029104; c=relaxed/simple;
	bh=+XdkE4DgIHAhgkKhHEoE2TV6/xi1f4rWmM/JoiflBKU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NPdkVfTwVlYgxWvEliAz90wtVlnwwi+Ozzs2MsRqFjk36YYtsMm8Oy7ITd7b6yvSzaH6/Uyx5WjXJWzCIEh42++kY5TXJ7DEtvvNeEU/BkB4CtUvWWe+QUvT/+S8P+nsT2ugMycLFJtIpVvx84AOxsuHgHciOpS/LMz/fQl1B/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTXVqAEC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709029103; x=1740565103;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+XdkE4DgIHAhgkKhHEoE2TV6/xi1f4rWmM/JoiflBKU=;
  b=lTXVqAECt5ZgimA/0Njvzu5qUTE1M2S9PLdDhrxHsY7avgt6lD1P4FY5
   NzfipyJ6GV4ati+Iv6Z9f5livT3GOXfFbH42OYnf53L750f55oMGnTBvl
   k05dHRgR4WIKs9tq5YQ23TihubUkNp6jwXnVx0eYGzsxmg5FONr6h+gVO
   h6vdokT3Hmko1rJDhZ5QpbyBUW9K5DXoRfr+KCwEMU0Vh9ftmmjy/oD7A
   hX00gOoqrSO0uTalx9ioRrodXOXj+StOmJ0BXZDvGKIp/zqCjZjcCI4oy
   PbIF6U11QRKGMALzNMvRL3S1u/FolakQYHR/JflqdMnipBEV03kE75vRj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3914919"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3914919"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:18:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6853286"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:18:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 12:18:16 +0200 (EET)
To: Szilard Fabian <szfabian@bluemarch.art>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    jwoithe@just42.net, Hans de Goede <hdegoede@redhat.com>, W_Armin@gmx.de
Subject: Re: [PATCH v4] platform/x86/fujitsu-laptop: Add battery charge
 control support
In-Reply-To: <170834440647.4050.13047961348645894978.b4-ty@linux.intel.com>
Message-ID: <a4b35e55-1f29-6c98-745c-df6896e49270@linux.intel.com>
References: <20240129163502.161409-2-szfabian@bluemarch.art> <20240129175714.164326-2-szfabian@bluemarch.art> <20240207023031.56805-2-szfabian@bluemarch.art> <20240215203012.228758-2-szfabian@bluemarch.art>
 <170834440647.4050.13047961348645894978.b4-ty@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-957297465-1709028876=:1099"
Content-ID: <8b80bf93-d78a-388a-e88d-a911f9418556@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-957297465-1709028876=:1099
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <20edec04-805c-ce6f-95c4-8d07e40e6e6f@linux.intel.com>

On Mon, 19 Feb 2024, Ilpo J=E4rvinen wrote:

> On Thu, 15 Feb 2024 20:31:43 +0000, Szilard Fabian wrote:
>=20
> > This patch adds battery charge control support on Fujitsu notebooks
> > via the S006 method of the FUJ02E3 ACPI device. With this method it's
> > possible to set charge_control_end_threshold between 50 and 100%.
> >=20
> > Tested on Lifebook E5411 and Lifebook U728. Sadly I can't test this
> > patch on a dual battery one, but I didn't find any clue about
> > independent battery charge control on dual battery Fujitsu notebooks
> > either. And by that I mean checking the DSDT table of various Lifebook
> > notebooks and reverse engineering FUJ02E3.dll.
> >=20
> > [...]
>=20
>=20
> Thank you for your contribution, it has been applied to my local
> review-ilpo branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo branch only once I've pushed my
> local branch there, which might take a while.
>=20
> The list of commits applied:
> [1/1] platform/x86/fujitsu-laptop: Add battery charge control support
>       commit: 9b716ef48c90446b8d6d86726c6c3f0141e53091

Hi,

Can you please take a look at the two build failures LKP has brought up.=20
They looked like some depends on and/or select clauses missing from=20
Kconfig.

I'll be merging the patches that fix those into the original commit so=20
don't spend too much fine-tuning the commit message.

--=20
 i.
--8323328-957297465-1709028876=:1099--

