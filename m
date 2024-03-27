Return-Path: <linux-kernel+bounces-120476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AAB88D81A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E289B29F52B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A112F2C6BD;
	Wed, 27 Mar 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTfvzXs3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F962C6A7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526196; cv=none; b=V3mbJ0jTIgrYghSHueXw9c1ZrxQ1TMf6UsAgRNM10bIHINFECtCsQ6+cEPt5hwmxR81lV7Ar0y9atf/o7SISQG/Pz3piFzkUfmqqgUIZK43dNXK++3vFYkcOaxjhlr89L1LcDVqTmMy1BExUnxkEf5lQf+pr47f5FV9bOH9rIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526196; c=relaxed/simple;
	bh=C4U0eqAmnNBrofU/o36p66DJsXqi1eYto3VlCqQ5c9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GG5pqCyZCRA/3nF25pHMTkobkrjtsm8Cpg4ADx2TUncdGp42C4qK7YIFuONBgFEndmsdynrCco6OJM848OE9S/4JNT4b2LTMKGFzQz/VNFAfFpq/iAQ27jfBQM/WkWD8zX8Fz6hJcBOW4Rj/ert1ldv2omGU4kmdv/r5iYKTB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTfvzXs3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711526193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWGB2LdKUChFqfU8um7pkDBwNPH94X6nDV81R4tdCC4=;
	b=KTfvzXs3JDtSswE9LJ6uiFP0Pvom6F3occYu7l5vOELi28C5P6q5eIpOrResXKgsvWa3AX
	2KFe4Y5A6nMnv2gXgl+OGwwif2C4H/pcF3GizMfgK4oDWpb/ew5ppsVdb3FBPTQ6zxNIVl
	E8RrL8qnMEseDhxIqdJw2caIqGCoahY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-wu8tkoviPh28arYMlnYIGg-1; Wed, 27 Mar 2024 03:56:28 -0400
X-MC-Unique: wu8tkoviPh28arYMlnYIGg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D3B885A58C;
	Wed, 27 Mar 2024 07:56:28 +0000 (UTC)
Received: from [10.45.224.197] (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4D87492BD4;
	Wed, 27 Mar 2024 07:56:26 +0000 (UTC)
Message-ID: <4e9e2877-7fa1-44e5-9ca5-8397197bf725@redhat.com>
Date: Wed, 27 Mar 2024 08:56:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/7] i40e: cleanups & refactors
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mschmidt@redhat.com, aleksandr.loktionov@intel.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20240327074833.8701-1-ivecera@redhat.com>
In-Reply-To: <20240327074833.8701-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10



On 27. 03. 24 8:48, Ivan Vecera wrote:
> This series do following:
> Patch 1 - Removes write-only flags field from i40e_veb structure and
>            from i40e_veb_setup() parameters
> Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
>            and i40e_notify_client_of_netdev_close()
> Patch 3 - Refactors parameter of i40e_detect_recover_hung()
> Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
>            in existing code
> Patch 5 - Consolidates checks whether given VSI is the main one
> Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
>            in existing code
> Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
>            particular and uses it to replace existing open-coded pieces
> 
> Changes since v1:
> - adjusted titles for patches 2 & 3
> 
> Ivan Vecera (8):
>    i40e: Enforce software interrupt during busy-poll exit
>    i40e: Remove flags field from i40e_veb
>    i40e: Refactor argument of several client notification functions
>    i40e: Refactor argument of i40e_detect_recover_hung()
>    i40e: Add helper to access main VSI
>    i40e: Consolidate checks whether given VSI is main
>    i40e: Add helper to access main VEB
>    i40e: Add and use helper to reconfigure TC for given VSI
> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |  30 ++-
>   drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
>   drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 +--
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 205 ++++++++++--------
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
>   .../net/ethernet/intel/i40e/i40e_register.h   |   3 +
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  98 ++++++---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   3 +-
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
>   11 files changed, 282 insertions(+), 173 deletions(-)
> 

Please ignore this... Wrong series with extra patch. Need to resubmit.

Ivan


