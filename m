Return-Path: <linux-kernel+bounces-109857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C708885698
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5FA1C21466
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619454BE8;
	Thu, 21 Mar 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ql67lD25"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636074E1D5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013613; cv=none; b=dK9Zihm4s594iY2oI1ohHfxc/oQNZejd6OIjv6cnNjW42hDInUySHFcMsQYUKz0BHfpimv5c4hd5B5mqaDIZZWP/hA24d99VqzC/nbEf7v/r0DjLfFNbv7dwVnKdvjzep6hnw3fzmMU6GMfkRjdeGjw1Y0SSB0GWr+VPFTKjLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013613; c=relaxed/simple;
	bh=yqdjQVNbcauOFxaogP8b3/2502Vi0LT+CvmPhASCPlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rph0E65QltD/5O2tbzUigeyt4BEunQgtqOQ3qwBj0Q0AtNRqkiyNDR8yCj5+ozMmItl6DU9p3p9qKdfsRXWIxXidKMx2t06+FICXVdLEVL2wB9TwKuTH9qEICDxJPasVaysClIPBQzXSPWqMuT1tbuHsDu4Sw/d3RQSK333/hLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ql67lD25; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711013611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs6XYbBWQxRBg0YMTrNuobAVa9pvsnukIpqnddxJZbc=;
	b=Ql67lD25mjYGPiGx5fcGug7MFFT+p1AXSGgULTZASu5MgCtecDhpjJOf8J921qasdEaD1B
	AW+ccmGe5gKX9/gTTjnGeN/zKro309MoENq3S9ooVDg3tzDBWJK47jilbeP+NXGzmy9/LC
	Xt87SXMuykEml3suAWs6JeoSb7nvVlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-Dob_UXorNx2b4J-k8THHIg-1; Thu, 21 Mar 2024 05:33:27 -0400
X-MC-Unique: Dob_UXorNx2b4J-k8THHIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4759D89C661;
	Thu, 21 Mar 2024 09:33:27 +0000 (UTC)
Received: from [10.45.225.240] (unknown [10.45.225.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B6331D091;
	Thu, 21 Mar 2024 09:33:25 +0000 (UTC)
Message-ID: <3540c6da-edbd-48e8-8bcb-effe64470ca0@redhat.com>
Date: Thu, 21 Mar 2024 10:33:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 5/7] i40e: Consolidate checks whether given VSI
 is main
To: Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240318143058.287014-1-ivecera@redhat.com>
 <20240318143058.287014-6-ivecera@redhat.com>
 <557e819bc6acdfc2311fe2254b1f382bad8368fc.camel@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <557e819bc6acdfc2311fe2254b1f382bad8368fc.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5



On 19. 03. 24 11:17, Paolo Abeni wrote:
> On Mon, 2024-03-18 at 15:30 +0100, Ivan Vecera wrote:
>> In the driver code there are 3 types of checks whether given
>> VSI is main or not:
>> 1. vsi->type ==/!= I40E_VSI_MAIN
>> 2. vsi ==/!= pf->vsi[pf->lan_vsi]
>> 3. vsi->seid ==/!= pf->vsi[pf->lan_vsi]->seid
>>
>> All of them are equivalent and can be consolidated. Convert cases
>> 2 and 3 to case 1.
> 
> Minor nit: while at it, what about introducing an helper for such
> check?
> Reordering the patches you could use it also in i40e_pf_get_main_vsi()

No, I couldn't, that helper does not check vsi->type value:

/**
  * i40e_pf_get_main_vsi - get pointer to main VSI
  * @pf: pointer to a PF
  *
  * Return pointer to main VSI or NULL if it does not exist
  **/
static inline struct i40e_vsi *i40e_pf_get_main_vsi(struct i40e_pf *pf)
{
	return (pf->lan_vsi != I40E_NO_VSI) ? pf->vsi[pf->lan_vsi] : NULL;
}

I had an idea with helper like:
static inline bool i40e_is_main_vsi(struct i40e_vsi *vsi)
{
	struct i40e_pf *pf = vsi->back;
	return (pf->vsi[pf->lan_vsi] == vsi);
}

but I think that `vsi->type == I40E_VSI_MAIN` is simple enough.

Thanks,
Ivan


