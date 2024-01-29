Return-Path: <linux-kernel+bounces-42713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E6840570
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D171F2326F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD7629EE;
	Mon, 29 Jan 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHMNO3CR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D4629EB;
	Mon, 29 Jan 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532422; cv=none; b=Sg5I3zlC7mXw3xscm0a0gfnMxYN40eXtjng4ajlSqBzfN4f/posfDBK1ruxKdeOOHgKWmeGzDjD/FKCnlgch7B42JG4ug3OSnsWHi/eHeID5GU/kvXu4lSxrux8yPjjG02EHO8SdWNZcOs7kcECPoALNfaekDntXI/S7NNsZxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532422; c=relaxed/simple;
	bh=1Z45lbmuua+VyNOBrONHhwFAho5Ew0nWG2uDmoVnSxg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sCIkjmBQqTC/177GQUl7BxLX6TTdL7ZXm3K+X7QthNo0TiTEx1xGzTMgAB46kUhvoBjC1RWebqbgync9D62WHjLLOQOVkWlpPJpmH4vFfYhJlVZsbltGnxq2T7sOF0vHCaJM999pMQ2Tw3PBzHV+d9GwjV6NiX7JMOxJhXwJrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHMNO3CR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706532421; x=1738068421;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=1Z45lbmuua+VyNOBrONHhwFAho5Ew0nWG2uDmoVnSxg=;
  b=jHMNO3CREBPeqX92dKlu/YRrk3kuZQtw8zbg2vyXOFu1NLvHCNdJUKtb
   Gp7wy53btm6XGf5t9jxkkaLQms/ob8jLv2gaLWdJowhU2UxSBGJwumWB5
   F4lnA8bjpupEVGt5YcYynCLHRunfXgFNIgk9DhBOr948WysK8C04oWmEZ
   Koav6DmQ8cY1tR5drq2M6uT9jqD8OUQhbai4mPlAIRXqDRNvCKPaqmntv
   0U6wfUf7Czj8C3y5qAy4rwN68qPOcTg81Nh0/saLVhAOIu3mf3Mh+Irau
   Qo+dMD9hHjTD/zK3Nng2zQONiZMlwLKiDm5z7Na8YLeFJBxeEk3DOoLcN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2828980"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2828980"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 04:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3299531"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.253.213])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 04:46:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jan 2024 14:46:45 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Suma Hegde <suma.hegde@amd.com>
cc: naveenkrishna.chatradhi@amd.com, LKML <linux-kernel@vger.kernel.org>, 
    Carlos Bilbao <carlos.bilbao@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use
 device_add_groups()
In-Reply-To: <2024012822-exalted-fidgeting-f180@gregkh>
Message-ID: <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
References: <2024012822-exalted-fidgeting-f180@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-481654086-1706523055=:1439"
Content-ID: <9ec7d7ac-21d3-1810-4e1e-7bd1e6c1a96b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-481654086-1706523055=:1439
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <66ab558a-7c2c-910a-9c17-a61ea96c7b48@linux.intel.com>

+ Cc Suma Hegde.

On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:

> The use of devm_*() functions works properly for when the device
> structure itself is dynamic, but the hsmp driver is attempting to have a
> local, static, struct device and then calls devm_() functions attaching
> memory to the device that will never be freed.
>=20
> The logic of having a static struct device is almost never a wise
> choice, but for now, just remove the use of devm_device_add_groups() in
> this driver as it obviously is not needed.
>=20
> Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo J=E4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/platform/x86/amd/hsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/h=
smp.c
> index b55d80e29139..49ef0b1d6df0 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c
> @@ -471,7 +471,7 @@ static int hsmp_create_sysfs_interface(void)
>  =09=09if (ret)
>  =09=09=09return ret;
>  =09}
> -=09return devm_device_add_groups(plat_dev.dev, hsmp_attr_grps);
> +=09return device_add_groups(plat_dev.dev, hsmp_attr_grps);
>  }

Thanks Greg for bringing this up. I've added Suma who has some patches=20
which change code around this area.

--=20
 i.
--8323328-481654086-1706523055=:1439--

