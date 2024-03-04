Return-Path: <linux-kernel+bounces-90650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54098702B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B021F22C55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B13EA74;
	Mon,  4 Mar 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjI9bCr7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC33D982;
	Mon,  4 Mar 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558986; cv=none; b=Yd4D68/pkVDWGbCNKGxvAuK2sGYhbp5+Bto3zgwvq4Y7VqU6D7Mej3CVMLO6fwGJhf6R0yzd78jqsADxFvzNGGPBmJLcvnwRz90Re4/LoD0sSFcfWPMotHsaDb69l4mOi+RT5j2uqjPj5OWUuWIm3C43nAO0ZOKKZko9tg/Z/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558986; c=relaxed/simple;
	bh=DMUoXzNwINYPT6TKigZ3BhexDPsrhQRSpJ0qDR1BC2c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QETHn5f3hKtyc62ZDg3jtQQhXgxupY329pq3YWNw/zoHrIZVkkVKsDxAxEMXrm7QIk0z3gwv20FtthMK0PMr74XI5bfpflFu50hY8XNSkYFCASKAgA9pxiJ1AOdCUIpQKAzrc1Mt/0p7WT6IfPAvJIYDb9gas+mlp/6I0REDO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjI9bCr7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558985; x=1741094985;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DMUoXzNwINYPT6TKigZ3BhexDPsrhQRSpJ0qDR1BC2c=;
  b=gjI9bCr7vhK7Z/saykTcwRxhZXES1ECdGWZd474ewGxfnZOZbT50csnK
   /P0hFdPMiakqvp6QBbGu0u6ZZINZPPkpmA3PSc758FEKyn5R+eEHcyi9a
   PoBtCxoX1hqSe8w12JjpCHQ2QvW08Ney+QeM3cs7z4F1aEuzA8PmiBecR
   VgJvEX2XwghOMz+ZA7wrzZvMRdyV2IB9hpo0233eHH3G2JE+shBTLAY3x
   Ul3/gEf1Yoqz+7rmq+guWaZ/94BwibqXNZP1C8N+9lgoJCzDzZFOEG4XH
   969GJv96Mzp21UQS2obyIjb7UBA6dGLPq1fkl3U7IFrTBIvgrEuLHveXw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="21507963"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="21507963"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9174755"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:29:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Mar 2024 15:29:39 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH V2 4/9] platform/x86/intel/sdsi: Add attribute to read
 the current meter state
In-Reply-To: <20240228000016.1685518-5-david.e.box@linux.intel.com>
Message-ID: <8e9fe5a5-4270-a71d-bb36-4f7d0a1ca049@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com> <20240228000016.1685518-5-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-917811586-1709558979=:986"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-917811586-1709558979=:986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Feb 2024, David E. Box wrote:

> The meter_certificate file provides access to metering information that m=
ay
> be attested but is only updated every 8 hours. Add new attribute,
> meter_current, to allow reading an untested snapshot of the current value=
s.
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>=20
> V2 - make control_flags a parameter to be eventually passed to
>      sdsi_mbox_cmd_read(). This removes the need for a lock which had bee=
n
>      added to protect control_flags when it was a member of the private
>      struct.

Yes, thanks. It's more obvious now what's going on w/o all that lock=20
trickery.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-917811586-1709558979=:986--

