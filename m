Return-Path: <linux-kernel+bounces-98778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48852877F43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DD5B21849
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9933B7AC;
	Mon, 11 Mar 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsAqa4Qz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021953C460;
	Mon, 11 Mar 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157595; cv=none; b=MmKIXKvHoVXy0hcqako1SDMVvchrkeWnbMmQAbCNgiMeNXLrvUabc76AkQOoaWlPuytaheaVwBOrQwOA/kgyOEFSyMO2AA4WeR0j/IIM6nFq/LOw4Sd+OwMoh42XD2WP7tHVGmhebs/osGFwQ1MZl5dd1G/YQmdEGoVhF1WXxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157595; c=relaxed/simple;
	bh=jbQWLUO3F3KAytHXkEmfZhoxNTmpUZGxd7ZYmGGgyPc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MGJkq/sBL0f4up2kju3olB9T515ate6ICzF65T+Vt0ebsYguYKTCU0ZhPVLxjhQ3cFXg5SedZwi9aUbyzARUQmi4oDTvEOhtHXHdvWYjkeT+miMWByJdSh2TruKTdKJome+0n6R3g3nszLkrr8tL3Z9g/OwKmEpSxnapCK2g8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsAqa4Qz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710157594; x=1741693594;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jbQWLUO3F3KAytHXkEmfZhoxNTmpUZGxd7ZYmGGgyPc=;
  b=XsAqa4QzEOKcscirafytwDPlcnur3AXd5zODkUkWJcnPKLc3i/bVhIRu
   xe0zo1j+uNYtcd69n1eLOFJV1713LByN3NXX6+REz9nyYunwfeeXquBL6
   yER0TnNgCBUq7wR+P5Mwh9XOlyIC+55arK6JOn4+i/W9uoYP7qDtKnQda
   LWU1ACBxVO+ECOx0kxOFmzDd4G/CleoPKYu280tyKBV9nKsnSrf48qOg/
   ZbNkIKEb4rPPL91e2u0FNTT6xVayxtIr7VNXW+MKDM4Zu9HdKdF5xW2fp
   Bjkce9sKAK7J4OAEWE28bRIVU216ofP+cWzRO2GUpMy277ApkNxvdSN0h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4675072"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4675072"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 04:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11713937"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 04:46:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 13:46:24 +0200 (EET)
To: Ivor Wanders <ivor@iwanders.net>
cc: Maximilian Luz <luzmaximilian@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] platform/surface: platform_profile: add fan profile
 switching
In-Reply-To: <20240302170147.13026-2-ivor@iwanders.net>
Message-ID: <fa16bf5a-b0da-2751-7109-fe76acbcd7d8@linux.intel.com>
References: <20240302170147.13026-1-ivor@iwanders.net> <20240302170147.13026-2-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 2 Mar 2024, Ivor Wanders wrote:

> Change naming from tmp to platform profile to clarify the module may
> interact with both the TMP and FAN subystems. Add functionality that
> switches the fan profile when the platform profile is changed when
> a fan is present.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> ---

> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index a5a3941b3f43..e54d0a8f7daa 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c

> @@ -42,6 +54,13 @@ SSAM_DEFINE_SYNC_REQUEST_CL_W(__ssam_tmp_profile_set, __le32, {
>  	.command_id      = 0x03,
>  });
>  
> +SSAM_DEFINE_SYNC_REQUEST_W(__ssam_fan_profile_set, char, {

Is char correct type here or do you perhaps mean e.g., u8 that is more 
approriate for 1-byte long binary data?

> +	.target_category = SSAM_SSH_TC_FAN,
> +	.target_id = SSAM_SSH_TID_SAM,
> +	.command_id = 0x0e,
> +	.instance_id = 0x01,
> +});
> +
>  static int ssam_tmp_profile_get(struct ssam_device *sdev, enum ssam_tmp_profile *p)
>  {
>  	struct ssam_tmp_profile_info info;
> @@ -62,7 +81,14 @@ static int ssam_tmp_profile_set(struct ssam_device *sdev, enum ssam_tmp_profile
>  	return ssam_retry(__ssam_tmp_profile_set, sdev, &profile_le);
>  }
>  
> -static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
> +static int ssam_fan_profile_set(struct ssam_device *sdev, enum ssam_fan_profile p)
> +{
> +	char profile = p;

u8 ?

-- 
 i.


