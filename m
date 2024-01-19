Return-Path: <linux-kernel+bounces-31320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE2832C76
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE14284FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440E54BE4;
	Fri, 19 Jan 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn3TFbO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB354BD0;
	Fri, 19 Jan 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679100; cv=none; b=snROxw77TGTS8n1ThgP9Cq8lwzrxhRVoB6Yeeos8ReBwdcPVYV3DqgNm7Nc4X+4alXcxNoaZ54u/ISApWkDz+bprAGiSS5vO6WJo8egWivPetXZ16tGJi7jxmvDDigyf2+pjoQF/EMTsJPnVKmNzPjrO7qQM8mQyuEPSvjKSs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679100; c=relaxed/simple;
	bh=D28ZlfPny1oHiymh5+pa9L4MzlbSeYrIDVTVEReFPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5ZSMycUowyECy4A7P2vBBLiXYt5c/Q32dp56X1k2EVk4zW31qvht8nHyKxC3t8DykdW0AI3LvnaabuAgt3AVkKeNuRGzTY3L5HJpISUHpAiI6Ar/okFcG4Io08Y4dUEpkn2q+lH3L3wsy1z3+Iq2yYZ6ChGueoyRdZyW4FxzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn3TFbO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D596C433F1;
	Fri, 19 Jan 2024 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705679099;
	bh=D28ZlfPny1oHiymh5+pa9L4MzlbSeYrIDVTVEReFPds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dn3TFbO6/zoMSeK97Owg/IA7PUZb8SzOa/cad6W49ZD3vkFHhlnbgpCnyHn6IJA4/
	 Md93oEAAU0FW2OHFsuRd5hKVCoawsKwrzjdO2OqsEmcRd+Z/rWCYS9olgZ2K9OAUyc
	 ZY1/JV00K+mM2ilAa4w6cAVME+l+7WFBRcomtJV0W9aDZUwR+L9UhrEOI9tEatgkQD
	 Y+Hr46kNo1yiWnMTda+sjH97DCqnbojoIxHwLAjWtGp+RIqODiN7rWHOdVri8MxRyt
	 /Zt1eOQNmZ9FdC1J0h/w00mJBX3JB4gSZtv2pBoyF0s/4fywFmvzQN24DkBUsK/tLw
	 oAJ/mQX5OtUrA==
Date: Fri, 19 Jan 2024 15:44:55 +0000
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vlan: skip nested type that is not
 IFLA_VLAN_QOS_MAPPING
Message-ID: <20240119154455.GD89683@kernel.org>
References: <20240118130306.1644001-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118130306.1644001-1-linma@zju.edu.cn>

On Thu, Jan 18, 2024 at 09:03:06PM +0800, Lin Ma wrote:
> In the vlan_changelink function, a loop is used to parse the nested
> attributes IFLA_VLAN_EGRESS_QOS and IFLA_VLAN_INGRESS_QOS in order to
> obtain the struct ifla_vlan_qos_mapping. These two nested attributes are
> checked in the vlan_validate_qos_map function, which calls
> nla_validate_nested_deprecated with the vlan_map_policy.
> 
> However, this deprecated validator applies a LIBERAL strictness, allowing
> the presence of an attribute with the type IFLA_VLAN_QOS_UNSPEC.
> Consequently, the loop in vlan_changelink may parse an attribute of type
> IFLA_VLAN_QOS_UNSPEC and believe it carries a payload of
> struct ifla_vlan_qos_mapping, which is not necessarily true.
> 
> To address this issue and ensure compatibility, this patch introduces two
> type checks that skip attributes whose type is not IFLA_VLAN_QOS_MAPPING.
> 
> Fixes: 07b5b17e157b ("[VLAN]: Use rtnl_link API")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: make net-next to net as suggested by Paolo
>           and add Fixes tag for this one

Reviewed-by: Simon Horman <horms@kernel.org>


