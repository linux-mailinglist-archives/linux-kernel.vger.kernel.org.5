Return-Path: <linux-kernel+bounces-49777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B2F846F40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D7C293E01
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3214534A;
	Fri,  2 Feb 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjxOvoF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D41140769;
	Fri,  2 Feb 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874026; cv=none; b=FbsTF/Lvdmh3RMXDMpqKN+C69FXd4NBbDQWRPGDH/dXSUM/lLcpByPG+yTUIh7bGel55WurDfE7aTmxRrr1FNnYwcuIRzil5se6BadGSsAv3DYZ/vm/fP9/ZmTrqJkWDLBR8P1aRD/Ib287P+Avg11PsEgDlzcie1x7/wFJDni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874026; c=relaxed/simple;
	bh=8JqVgkJFyiuPzxngr0+F8q8UGQLgmwcIfIm9DasUXwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRwC7H250yKOGtlUUhpGDsC6XMQ7dhMBH8/MdI7qBJcfolI6/EZwGpTe7tfMzLOZpsf/4yMYURkU+IuB/ypTP0NsT3v7bQHJ28XRB+2XsUWBa5lKs633MbKapGdIOsVM7GMC9AWr4IvIfTwKa4qWTM8p5Zh4uTaUShDwjy4VhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjxOvoF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF5EC433C7;
	Fri,  2 Feb 2024 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874025;
	bh=8JqVgkJFyiuPzxngr0+F8q8UGQLgmwcIfIm9DasUXwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sjxOvoF3CxGDML8QhhEhcqRhfK6cH1G0R3g81tUKNWbYYePHScd1HiNoYZoYBbxH2
	 Uc6NqJI3a7pZmT6MbPTZknSFMDdZvg8b50dZz7FhzVSE+oDIOP+6bPEUOEWouEY0SN
	 Ckg1mnczXOLLX9sAUB6BrRT7vc9nBnWFemHm5MVYjNb/PqTkn8psbiNo+XcL2FwWwP
	 EFG446jUd02H6msoQxoFdO48i/oBxJ4Bo8URpkoEsNXvZ3heaU9RgQfRc3mGADednh
	 rL+csXY+axieyD/vNdIJCabLC8hGEsv8SLdja3TwUQD/94r1na/1e8tnFQHqrVtIhF
	 WjjCOd7EB9d7A==
Message-ID: <9530e4c2-1da9-43a0-b40d-f877aad61319@kernel.org>
Date: Fri, 2 Feb 2024 13:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: cdns3: fixed memory use after free at
 cdns3_gadget_ep_disable()
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240202051829.623273-1-Frank.Li@nxp.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240202051829.623273-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/02/2024 07:18, Frank Li wrote:
>   ...
>   cdns3_gadget_ep_free_request(&priv_ep->endpoint, &priv_req->request);
>   list_del_init(&priv_req->list);
>   ...
> 
> 'priv_req' actually free at cdns3_gadget_ep_free_request(). But
> list_del_init() use priv_req->list after it.
> 
> [ 1542.642868][  T534] BUG: KFENCE: use-after-free read in __list_del_entry_valid+0x10/0xd4
> [ 1542.642868][  T534]
> [ 1542.653162][  T534] Use-after-free read at 0x000000009ed0ba99 (in kfence-#3):
> [ 1542.660311][  T534]  __list_del_entry_valid+0x10/0xd4
> [ 1542.665375][  T534]  cdns3_gadget_ep_disable+0x1f8/0x388 [cdns3]
> [ 1542.671571][  T534]  usb_ep_disable+0x44/0xe4
> [ 1542.675948][  T534]  ffs_func_eps_disable+0x64/0xc8
> [ 1542.680839][  T534]  ffs_func_set_alt+0x74/0x368
> [ 1542.685478][  T534]  ffs_func_disable+0x18/0x28
> 
> Move list_del_init() before cdns3_gadget_ep_free_request() to resolve this
> problem.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

