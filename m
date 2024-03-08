Return-Path: <linux-kernel+bounces-96609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FA875EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615E3B20B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6694F606;
	Fri,  8 Mar 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfk9iVLJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162F1CD09
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884488; cv=none; b=M8mNlDr8bhO64KAzLkgzfqwZ/iGcj1M6/T48P5LJdCqkZwKKQr/tMP+3yoqyorTh5qf/DHBum2odfQU2/bfoAAxsdAONAt7nc1xlRKASGeJqsRKqM7XuD6CCPpofvlr+MjnSVF620CaB3aPwwyFL+RIIUn8YPwAGmlL5k4rFO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884488; c=relaxed/simple;
	bh=6aetVt5pJf5SLmzLY38Fa4qD7/eAZvCvftnw107cvXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTCJaaza4ocaw7KjiF7fDRMZ/nFRFXeJkSIL8AasVby7F2ft8BDC6T6c4MJab5RFXOAJxW1KavsX3m8T1WSbmJdlB9CmmwmmMg8WIHJhYMkvaHTwMuuhBeBBkSK7DwTpNoYJPOeatdUqxVJ77/aI6BYrtR1U8U/0a0/FCGyADLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfk9iVLJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709884486; x=1741420486;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6aetVt5pJf5SLmzLY38Fa4qD7/eAZvCvftnw107cvXc=;
  b=bfk9iVLJUxozWD8VwtIfv+HdW26O9vpTBeJyhkExzzgfW4gaH/MgFX/d
   ELJuzHD4tlBk2CYHAPt3xsxIw17u8chQrSED8U0M+URu5r23rQSsguyb8
   ixeWB/t0Q8EsEW3dzQISRYReIW54WPmCvu18G3jsm/Fu5bm+2EYhJR4B3
   i3x291GSfqTOTjHxaDBpBjlU5h8P+y0tGFLaQctNjQPuw78ae481y1VoO
   bHp5lfRsNwuNafw7YR3Wkr4eEWC+kCg4biHgw6oiXMIR5r56u6ebC9i2J
   BBn5gb5tttGqIYWnfBd2n2yAJTTOGNZoIF89kSBOKq4V692eorxKYB5Ok
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15315638"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="15315638"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="15062933"
Received: from tofferse-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.212])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:54:43 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, R SUNDAR
 <prosunofficial@gmail.com>, airlied@gmail.com, daniel@ffwll.ch,
 lyude@redhat.com, imre.deak@intel.com, mripard@kernel.org,
 ville.syrjala@linux.intel.com, Wayne.Lin@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed vcpi field description to fix kernel doc warning
In-Reply-To: <9199ed28-ba15-4d50-b8a6-7f6a32aeb3bb@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240308025152.17297-1-prosunofficial@gmail.com>
 <9199ed28-ba15-4d50-b8a6-7f6a32aeb3bb@infradead.org>
Date: Fri, 08 Mar 2024 09:54:38 +0200
Message-ID: <87msr9upj5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 07 Mar 2024, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/7/24 18:51, R SUNDAR wrote:
>> For linux-next repo
>> 
>> /include/drm/display/drm_dp_mst_helper.h:156: warning: Excess struct member 'vcpi' description in 'drm_dp_mst_port'
>> 
>> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
>
> or
> https://lore.kernel.org/lkml/20240106032321.28596-1-rdunlap@infradead.org/
>
> but I would be happy to see either of them merged.

That has fallen through the cracks, apologies, but I merged this
yesterday to drm-misc-next:

ca892057e03e ("drm/dp_mst: fix drm_dp_mst_helper.h kernel-doc")

BR,
Jani.

>
> Thanks.
>
>> ---
>>  include/drm/display/drm_dp_mst_helper.h | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
>> index 9b19d8bd520a..3ae88a383a41 100644
>> --- a/include/drm/display/drm_dp_mst_helper.h
>> +++ b/include/drm/display/drm_dp_mst_helper.h
>> @@ -83,7 +83,6 @@ struct drm_dp_mst_branch;
>>   * @passthrough_aux: parent aux to which DSC pass-through requests should be
>>   * sent, only set if DSC pass-through is possible.
>>   * @parent: branch device parent of this port
>> - * @vcpi: Virtual Channel Payload info for this port.
>>   * @connector: DRM connector this port is connected to. Protected by
>>   * &drm_dp_mst_topology_mgr.base.lock.
>>   * @mgr: topology manager this port lives under.

-- 
Jani Nikula, Intel

