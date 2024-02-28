Return-Path: <linux-kernel+bounces-85448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276FD86B61F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78661F284A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08BA15CD60;
	Wed, 28 Feb 2024 17:34:46 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2912DD9B;
	Wed, 28 Feb 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141686; cv=none; b=o6q78753tdHRJ0m/SfaLQ6Q+3FBJBoGyp2NdbgpEUTKHnOBxdbM1C5ZbvXlDKAJFBvh9JQg/urONVjiqolsGpCvNeY8pIHnDH69CMEDUHDq7j9Ywhb2PWal/7/ITUDsUDtJI29RsMQu9ARRKlfTvOgBLK6uk2f+anges7H1NQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141686; c=relaxed/simple;
	bh=Chpmnn/CEklwGU7G/Mv5RUKi93wJ82uNN/EYB5Ywe5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llBaczBkH1YujkxJxoCORjdPlrxX1R0sE686927dIzijdKGr8grGHEKeK2WaJTV53jJ2RtSd0ukU0H8YQwXAjxVnWeumC6I1MmUKprysUqFTCRwSgtAZUD2xHYzp2w5Aor/tWe+kqgSFXOlR1OESo1axVh7exa615LqaucwbyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aedb1.dynamic.kabel-deutschland.de [95.90.237.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 00DCC61E5FE04;
	Wed, 28 Feb 2024 18:33:58 +0100 (CET)
Message-ID: <e0c35b34-a845-4221-b9d3-867d2f339f8d@molgen.mpg.de>
Date: Wed, 28 Feb 2024 18:33:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Fix firmware version
 comparison function
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240228172603.29177-1-ivecera@redhat.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240228172603.29177-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ivan,


Thank you for your patch.

Am 28.02.24 um 18:26 schrieb Ivan Vecera:
> Helper i40e_is_fw_ver_eq() compares incorrectly given firmware version
> as it returns true when the major version of running firmware is
> greater than the given major version that is wrong and results in

… version. That …

> failure during getting of DCB configuration where this helper is used.
> Fix the check and return true only if the running FW version is exactly
> equals to the given version.

is … equal

> Reproducer:
> 1. Load i40e driver
> 2. Check dmesg output
> 
> [root@host ~]# modprobe i40e
> [root@host ~]# dmesg | grep 'i40e.*DCB'
> [   74.750642] i40e 0000:02:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
> [   74.759770] i40e 0000:02:00.0: DCB init failed -5, disabled
> [   74.966550] i40e 0000:02:00.1: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
> [   74.975683] i40e 0000:02:00.1: DCB init failed -5, disabled
> 
> Fixes: cf488e13221f ("i40e: Add other helpers to check version of running firmware and AQ API")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_prototype.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> index af4269330581..ce1f11b8ad65 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> @@ -567,8 +567,7 @@ static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
>    **/
>   static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
>   {
> -	return (hw->aq.fw_maj_ver > maj ||
> -		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
> +	return (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min);
>   }
>   
>   #endif /* _I40E_PROTOTYPE_H_ */

With the nits in the commit message addressed, this is

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

