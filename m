Return-Path: <linux-kernel+bounces-120432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B55188D742
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A989B2877DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052328DA5;
	Wed, 27 Mar 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDkQ134D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468F28DBC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524588; cv=none; b=PxjMn2ckkJhsUpqXkFnUMn2yHp2YQdCPsmCiEA2/PhZ8NYxnodelyanAT5xNAhaWCuNcvv0HMWEQkrVnA39DnjM82q19AY0p+fh+n/C8xY24ACLKQEegq41j2TWIOrhcDtLNmbXEPabYKqq84rglqx+YcnA/KBInOAZkFDoHuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524588; c=relaxed/simple;
	bh=u2wKnhEypQjtnqRaK5MI7baqVABv6jSUiswMbhJsllU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CplxO6srCnhofcumDKbxhygi0fg35ROurXiXfTJyQMkWFg7VE+vjyXAfIXCSRtOitLEo+Tl3TU6tjecbI6E6vzszvvxCkbFB0TjoLXv4vk5erC7J1v9uGBrG4W70gVanUoCyVYiqv0//SxswaTFPeixPSggGiMrHjm0KieVdC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDkQ134D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711524586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+MC2q8y8nD5KthMzwqiAm8lJS2baMGc2mOBEQ/3u6A=;
	b=DDkQ134DfZgt3OlE6vPNPw4DD+OmycyGhVherG3Hpp/yD8+9byE0lWzrmP+aMZsdxLFv6Z
	Pr1z/CIR2QXgvA7GK76EjA5UHiyU2+SXssRoK4M+JADNAvtbm2BrhYiZGAPYvgmmEbLHgb
	sD/uSHNxzIJJZJEqSA7ofs/+Lu6VVzs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-nqxTmeZ1MK2Q_AuxGNsxpA-1; Wed,
 27 Mar 2024 03:29:42 -0400
X-MC-Unique: nqxTmeZ1MK2Q_AuxGNsxpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D63653800E8D;
	Wed, 27 Mar 2024 07:29:41 +0000 (UTC)
Received: from [10.45.224.197] (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 32D79C017A2;
	Wed, 27 Mar 2024 07:29:40 +0000 (UTC)
Message-ID: <8e585156-4f6f-4837-9375-f29842fa7f85@redhat.com>
Date: Wed, 27 Mar 2024 08:29:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: Fix VF MAC filter removal
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksandr.loktionov@intel.com, mschmidt@redhat.com, horms@kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313135618.20930-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20240313135618.20930-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 13. 03. 24 14:56, Ivan Vecera wrote:
> Commit 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove
> administratively set MAC") fixed an issue where untrusted VF was
> allowed to remove its own MAC address although this was assigned
> administratively from PF. Unfortunately the introduced check
> is wrong because it causes that MAC filters for other MAC addresses
> including multi-cast ones are not removed.
> 
> <snip>
> 	if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
> 	    i40e_can_vf_change_mac(vf))
> 		was_unimac_deleted = true;
> 	else
> 		continue;
> 
> 	if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
> 	...
> </snip>
> 
> The else path with `continue` effectively skips any MAC filter
> removal except one for primary MAC addr when VF is allowed to do so.
> Fix the check condition so the `continue` is only done for primary
> MAC address.
> 
> Fixes: 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove administratively set MAC")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index b34c71770887..10267a300770 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3143,11 +3143,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
>   		/* Allow to delete VF primary MAC only if it was not set
>   		 * administratively by PF or if VF is trusted.
>   		 */
> -		if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
> -		    i40e_can_vf_change_mac(vf))
> -			was_unimac_deleted = true;
> -		else
> -			continue;
> +		if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
> +			if (i40e_can_vf_change_mac(vf))
> +				was_unimac_deleted = true;
> +			else
> +				continue;
> +		}
>   
>   		if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
>   			ret = -EINVAL;

Hi Tony,
the fix is not part of your recent pull series for i40e... I have 
submitted it to 'net' instead of 'iwl-net' as it fixes recent commit 
that causes MAC filter resource leaks that should be fixed as soon as 
possible. But its status in patchwork is 'Awaiting upstream' so it has 
to be resubmitted by yourself... Or should this be picked directly by 
netdev maintainers?

Thanks,
Ivan


