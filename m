Return-Path: <linux-kernel+bounces-71169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34785A192
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9021F22022
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B492C19F;
	Mon, 19 Feb 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI3AdxuQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7C1C10;
	Mon, 19 Feb 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340521; cv=none; b=HGRPBixG31K7+BlnDrVE8Lg3N3wjMQQ7vH+OwNowV3X0+7FAL1zv0ZdUWMPPzdCYZwpQ51ffQSEEtbgn9D++4f6mJ9omrxedSwiM0EM6Yn1gmHzXFXZlSTTepEI2k+EsMiR8agMRIytkpOGZIn++OJ+sQl8X61p2mvV/GRnz6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340521; c=relaxed/simple;
	bh=FYHwUjv0CBOVE/UvV6qkWI5k+uNh+6/RQIoNRoiJaqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+cGZ/rTpG2hCZcaYuT0/KpyxyQSCLGNvnhNccGYYxPBPZC/tBgib1Oni+SAYA/2VRpp8yQi89IiDSzpL8DXeAvS6AVTRPx32MDoVb7Zi5ewnjBJ1ZbRF1t/iPece53la1218c6UrgDMn8A87DG+TgxfzP4uIXhVj6aSeHFmqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iI3AdxuQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708340519; x=1739876519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FYHwUjv0CBOVE/UvV6qkWI5k+uNh+6/RQIoNRoiJaqg=;
  b=iI3AdxuQLJ85BdNTv3LccBvTl5WpMvi7xNNIB/S4qC0txlEEhksTTF4t
   PObXqnZpH7B9civwnocqwQqi7C93tDCK7ntMrdlosEgtv4GHRtZmFZkrR
   hbPSMYpk0z9IrOc7SQR6DN22A6iklWlgKP08i1akbwVjBrxa435dC7s4x
   /ZOs19P1TCMAx+2atJl7CfGGimudpfoBiW6s89tAoHFzMM5CkQF7HtsN7
   bJBRifBbJ+X798YVCRjVfVX+CYt5s7HVfH/oRB8cg1l9HYEvMsSKgdEVY
   zeHxFy6koLkwkj4IChSaQMcnrJ5v0xh7a4bypUyV8zwLUpOJFFSb9fVMK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2276106"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2276106"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936276332"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936276332"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 03:01:53 -0800
Message-ID: <d82c8955-6793-7544-0013-1033abd9f1e9@linux.intel.com>
Date: Mon, 19 Feb 2024 13:03:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v17 00/51] Introduce QC USB SND audio offloading support
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
 broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
 robh+dt@kernel.org, konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
 <2024021754-unengaged-saggy-6ab1@gregkh>
 <96ab6033-2cb9-daa7-ddad-090138896739@linux.intel.com>
 <2024021922-privatize-runt-495e@gregkh>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <2024021922-privatize-runt-495e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Patch 10/10 is based on an old POC patch by me, but it's heavily modified.
>>
>> It looks like it does a few minor things that are not optimal, like extra
>> spinlock/unlock, and wait_for_completion_timeout() with magical timeout value.
>> I haven't tested this version, but I guess any fixes or cleanups can be done
>> later on top of it.
> 
> I can revert it now if you want, just let me know.
> 

Maybe reverting it would be better yes.

Thanks
Mathias

