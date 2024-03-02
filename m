Return-Path: <linux-kernel+bounces-89368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446586EF7A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92571F22DF6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4714F86;
	Sat,  2 Mar 2024 08:20:12 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8B12B83;
	Sat,  2 Mar 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709367612; cv=none; b=lDa4O5KNgKL6tjXXGyRdgog1bH9vhRk4hoWr441ZQ5q0P6I8EOdug99aib6QE/C+l+NFFN9agmOnaGYPDbrjiJhgHrNx02Zld3C6KSlewX/qAHLPlhVz1f20RhBpzxKF2+GRRBkKa2lLae7LGYeBkgdT61ySMm49WX+ZqOdgze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709367612; c=relaxed/simple;
	bh=HlGnkN+gyjOOzDLmS5VehlLSLAGxnQMbjYYBTtTaveA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLlQoFJ0BknlZJ8meoJylVm4FJzlk+LJOF8f0gCiIaTZmASHOwqIWd6a/a86JYqUJQ10PxLNDiLlT128RfXM5DXuG/x7oT/k6dtFCUMsIRGeLEh8FH4T2xecyzxQmwT6jCTXp+3WaQO819GzUr9BUUTfgxp79FdMfHx0HKSn0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeb37.dynamic.kabel-deutschland.de [95.90.235.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BAD2661E5FE05;
	Sat,  2 Mar 2024 09:19:06 +0100 (CET)
Message-ID: <51b6c48b-a33e-46cd-9b00-5568ccc529ca@molgen.mpg.de>
Date: Sat, 2 Mar 2024 09:19:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH Linux-6.8-rc5 1/1] ixgbevf: start
 negotiate with api version 1.4
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lihong.yang@intel.com, harshit.m.mogalapalli@oracle.com,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 jack.vogel@oracle.com, netdev@vger.kernel.org,
 ramanan.govindarajan@oracle.com
References: <20240301235837.3741422-1-yifei.l.liu@oracle.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240301235837.3741422-1-yifei.l.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Yifei,


Thank you very much for your patch.

Am 02.03.24 um 00:58 schrieb Yifei Liu:
> ixgbevf updates to api version to 1.5 via
> 	commit 339f28964147d ("ixgbevf: Add support for new mailbox
> 	communication between PF and VF")
> while the pf side is not updated to 1.5 properly. It will lead to a
> failure of negotiation of api version 1.5 This commit will enforce
> the negotiation to start with 1.4 which is working fine.
> 
> Normally the pf and vf side should be updated together. Example:
> 	commit adef9a26d6c39 ("ixgbevf: add defines for IPsec offload request")
> 	commit 7269824046376 ("ixgbe: add VF IPsec offload request message handling")

Why can’t the PF side not be updated to version 1.5 too?

If you don’t mind, I’d format the commit message like below.

Commit 339f28964147d ("ixgbevf: Add support for new mailbox communication
between PF and VF") updates the driver ixgbevf to API version 1.5 while the
pf side is not updated to 1.5 properly. This leads to a negotiation failure
of api version 1.5. So, enforce the negotiation to start with 1.4 which is
working fine.

Normally the pf and vf side should be updated together. Example:

1.  commit adef9a26d6c39 ("ixgbevf: add defines for IPsec offload request")
2.  commit 7269824046376 ("ixgbe: add VF IPsec offload request message 
handling")

> Reported-by: Manjunatha Gowda <manjunatha.gowda@oracle.com>
> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
> Reviewed-by: Jack Vogel <jack.vogel@oracle.com>

Please add a Fixes: tag.

Fixes: 39f28964147d ("ixgbevf: Add support for new mailbox communication 
between PF and VF")

Unfortunately, I am unable to find this commit hash. What archive/tree 
is it from?

> ---
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index a44e4bd56142..a1b9b789d1d4 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -2286,6 +2286,12 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
>   
>   	spin_lock_bh(&adapter->mbx_lock);
>   
> +	/* There is no corresponding drivers in pf for
> +	 * api version 1.5. Try to negociate with version

negotiate

> +	 * 1.5 will always fail. Start to negociate with
> +	 * version 1.4.

Could you please use the fully allowed line length, so less lines are used?

> +	 */
> +	idx = 1; >   	while (api[idx] != ixgbe_mbox_api_unknown) {
>   		err = hw->mac.ops.negotiate_api_version(hw, api[idx]);
>   		if (!err)

Where is `idx` set before?

Unrelated to the problem at hand, but enums or macros should be used for 
the API version.


Kind regards,

Paul

