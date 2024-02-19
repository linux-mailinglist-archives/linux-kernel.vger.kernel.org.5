Return-Path: <linux-kernel+bounces-71234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3885A24B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D92FB2478F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266E2D608;
	Mon, 19 Feb 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJwPMlI5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234C2D04B;
	Mon, 19 Feb 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343071; cv=none; b=YRILGaaGve+wzq8/XnbjqCuikShyhqak9U8aHtP0SP+TGQ+nysNi794+oyyasPNU/JKQX2eob+wLwE+MSxRPo5whn6rA6+ozekMz8jwt00SpHHfiHySRP55eHanYeJvNEE3pHzzTpFcOpCqWSFtxTlbwnK9Y+6dDe0LVk6fsSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343071; c=relaxed/simple;
	bh=Uk+rptqnDtWSILv1zQxinfn6kYzZNxZAnPEcPsAC5OA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EzmjIvUTKAVgQxsMB3dze0lEFIpFNPZfVeOLsoUkz1+JP3OjW/cHTNe2iiXwHwx3WRWxT4reP1yqOTq+u/izv89NdS/OHDhKnLfFLgr7x6miA3nSByGhrkxEYlIidR4LAvkCcSdUBRTg6deVFaBuV5nQKBVxqhYZrI6vUh4N1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJwPMlI5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343069; x=1739879069;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uk+rptqnDtWSILv1zQxinfn6kYzZNxZAnPEcPsAC5OA=;
  b=gJwPMlI5IzqmeFXD0No7lol+fMu04K0Q+QFScRApNek92WJumKiLby0t
   NEQPFRIz6inqV2k589HJ6/HAU/eXDtPcBBLPgxsQmr9KOo9irmDfkKfgO
   1bqmUR7hsT42UtffbnqU16mlsc6CAkxwedUH7yqLGEoSqAleTFUDim39/
   pFWPu41Rl/s4N6btf3EnP+t9K4MYCk8a+6J8m2DQl7Vu2dCh+5KsrH7O3
   G/6GrdwjeqYzZi59ZP2s9gyXr0bAV4jVmeFQFNuoGXmq9zGr5Y4dvCbfM
   XGg5vyKyWdUowvjcdwLPOVeLCyDeZErAxV9QuBHp9ndAQGkd7ySQt2wLI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13125380"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13125380"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4469669"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.18])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:44:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 Feb 2024 13:44:18 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, vsankar@lenovo.com
Subject: Re: [PATCH v2 2/2] platform/x86: thinkpad_acpi: Fix to correct wrong
 temp reporting on some ThinkPads
In-Reply-To: <20240215134102.25118-2-vishnuocv@gmail.com>
Message-ID: <ce399b39-aef8-b911-3575-191a0c1104a5@linux.intel.com>
References: <20240215134102.25118-1-vishnuocv@gmail.com> <20240215134102.25118-2-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Feb 2024, Vishnu Sankar wrote:

> Added non-standard thermal register's support for some ThinkPads.
> 
> Some of the Thinkpads use a non-standard ECFW which has different
> thermal register addresses. This is a fix to correct the wrong temperature
> reporting on those systems.
> 
> Tested on Lenovo ThinkPad L13 Yoga Gen2.
> 
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>

> @@ -6290,6 +6332,8 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
>  
>  	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
>  		n = 16;
> +	else if (thermal_read_mode == TPACPI_THERMAL_TPEC_12)
> +		n = 12;
>  
>  	for (i = 0 ; i < n; i++) {
>  		res = thermal_get_sensor(i, &s->temp[i]);

Thanks. Both patches now applied. I did some further cleanups into the 
first patch (which I had requested you to do :-().

This 2nd patch didn't apply cleanly on top of for-next but I handled the 
conflict for you this time, in future, please try to base your work on top 
of for-next branch.


-- 
 i.


