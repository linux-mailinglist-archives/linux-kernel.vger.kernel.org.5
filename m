Return-Path: <linux-kernel+bounces-56431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC9784CA13
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69EBB245B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43FA59B69;
	Wed,  7 Feb 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lpJz2eoM"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4059176
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307175; cv=none; b=eXnP15daBW9QO1Ih6GW4zZ3eSqcghUI3GiFS1HvMQcDma+IvHU8Rw9Bi+WKUCAROLWym96BRvfn+Qvo0/sAW28cc1q2Z0MtnRd8P+OwRqVh5hWwFfyMtmMxnoE20Xd1n/uzwu0eHMNmXOwco2+IFAAokZ5NboJIIzVj8df4L61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307175; c=relaxed/simple;
	bh=4Dzuc4ozpYlQxuD8azhA0pj38vOTx6H5p1tDERc3qF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=pjpw+0JVsUMljIf9eknI5+KMI8aDM+w+GduKBAecKKQGDd7BKeuWmbsGLToTwqGpZcOAKYI7p4StDY9Dbqv3xSbwTl50LNNTzZHwH63GZNrsOukjpq/bfTLF75jzdAJAnNUNEBhvaJN+Ge9wuuj64/RjJSFZg/y1lpztQ6q3R6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lpJz2eoM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240207115930euoutp02e682102ca1f31faf01c51a2913ec5267~xktNm6luS1838718387euoutp023
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:59:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240207115930euoutp02e682102ca1f31faf01c51a2913ec5267~xktNm6luS1838718387euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707307170;
	bh=ynbj17t33/+bqH1PNF8D/EuPAXN1vfaZJ7FwjG8sFdc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lpJz2eoMJsKbo0D/d2NM6Emf0oWWHkOR0pwtzo/mOKvKR4cniVlN13YLwp/T/ukDq
	 95Nh8kRFMzLghfUJw7UFxWiJY8Usn0ISjmbcABjiOs2BykOD3TpdH5F8O+13GpHTmt
	 BmUXU/ETryUYH3F8cUhSKPkaREuvFWz+l3IWAV/s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240207115930eucas1p1c3fb19c28c5e442370aae05cab84d8b7~xktNa7EEZ0109101091eucas1p1I;
	Wed,  7 Feb 2024 11:59:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 2E.FF.09552.2A073C56; Wed,  7
	Feb 2024 11:59:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec~xktNCDyoX0983609836eucas1p13;
	Wed,  7 Feb 2024 11:59:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240207115929eusmtrp1a3aa4ad5ba4659fa30592e1a707c87c4~xktNBbbt-2420724207eusmtrp1q;
	Wed,  7 Feb 2024 11:59:29 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-13-65c370a2a715
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.69.10702.1A073C56; Wed,  7
	Feb 2024 11:59:29 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240207115929eusmtip2281373b5b758a06bd4b18bfcfb788580~xktMcpQHz0589105891eusmtip2M;
	Wed,  7 Feb 2024 11:59:29 +0000 (GMT)
Message-ID: <4b5683cc-8e61-43c5-be0f-b5378639276a@samsung.com>
Date: Wed, 7 Feb 2024 12:59:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Content-Language: en-US
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240119094825.26530-1-quic_uaggarwa@quicinc.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87qLCg6nGpw8z2JxrO0Ju0Xz4vVs
	Fpd3zWGzWLSsldli44anLBYLNj5itFi14AC7A7vHplWdbB77565h95i4p85jy/7PjB6fN8kF
	sEZx2aSk5mSWpRbp2yVwZTzesI6xYK9qRdM03gbGXvkuRk4OCQETiePL3zF3MXJxCAmsYJT4
	/WcNI4TzhVHiy+zFbBDOZ0aJOf/mMMO0PD2yiRUisZxR4uR8mJaPjBKP9h5lAaniFbCTWHTm
	MjuIzSKgIjGhtZ8VIi4ocXLmE7AaUQF5ifu3ZoDVCAskSBy82Q0WZxYQl7j1ZD4TyFARgT5G
	idsbJgAVcQAlyiQ+blYEqWETMJToetvFBmJzCthLdLzpZITolZdo3job7CEJgRscEkuvTmGF
	ONtF4sHBjUwQtrDEq+Nb2CFsGYnTk3tYIBraGSUW/L7PBOFMYJRoeH6LEaLKWuLOuV9sEFdo
	SqzfpQ8RdpT4vv8CWFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSa
	hRQss5C8PwvJO7MQ9i5gZFnFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmIJO/zv+dQfj
	ilcf9Q4xMnEwHmKU4GBWEuE123EgVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJ
	anZqakFqEUyWiYNTqoGpeuf5RQWOjU5VH4UUXTl3T+pL2z/77RQR+ZbAczl1s412pi0SS9n5
	39iq8PHSmYWLVv0LCxOwTpTSd+D7P4/TcpvZ/6V8HlWXJk6M91Ti0sjUWqowY15n889WTRbl
	BWf6dj+qkDjZ+0mdr8bsotV2v/N5nzYG/A5/aOr3fuaFyRUux9lfL9j37iLDcSmdQrnvEvuc
	d5cYc16xuvRD/srsrYniGYyHmH5d+nl/vlHrJmXJA1EPT/Ev5a1ZWbo6/oSrYMvt+XemrFc0
	NJau7Ci3NdJpP6srv+ZzuMtpT/ewiuv/pymm/J/rkdOiKVWWGxq18lKYRkpfTPxz3WVcu7Q5
	Mj6Vv5ZZYP7p0umcBGElluKMREMt5qLiRAACspp/sAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7oLCw6nGjSu07Q41vaE3aJ58Xo2
	i8u75rBZLFrWymyxccNTFosFGx8xWqxacIDdgd1j06pONo/9c9ewe0zcU+exZf9nRo/Pm+QC
	WKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mh5v
	WMdYsFe1omkabwNjr3wXIyeHhICJxNMjm1hBbCGBpYwSDy6wQsRlJE5Oa4CyhSX+XOti62Lk
	Aqp5zyixqmcyG0iCV8BOYtGZy+wgNouAisSE1n5WiLigxMmZT1hAbFEBeYn7t2aA1QgLJEgc
	vNkNFmcWEJe49WQ+E8hQEYEJjBJ7P19lh0iUSXy78YYN4iI7iZ0v+xhBbDYBQ4mut11gcU4B
	e4mON52MEPVmEl1bu6BseYnmrbOZJzAKzUJyxywk+2YhaZmFpGUBI8sqRpHU0uLc9NxiI73i
	xNzi0rx0veT83E2MwIjbduznlh2MK1991DvEyMTBeIhRgoNZSYTXbMeBVCHelMTKqtSi/Pii
	0pzU4kOMpsDAmMgsJZqcD4z5vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKY
	PiYOTqkGpkXm/dv3vgxOcrPdELA5JtUyMufTUw4F+b03FhyYrvDqUNbqck4P79cy/Ms5Pj1y
	rtS489HBmGPREvXplVdzlCu+b3uyuVjqx/8NT2atnP30WJyq12fpHdvXarQfcv5rWlS5db4B
	e8szG96qxhnpSzpC75msXe/eatCz4Mkeww8vL87/EZeQ8/DAGQ/J+J5jDu9mfHmi0/HCsNt6
	Vkci11JVJYFrgmdeOn5oPB8SX58X9TFFxnGFrdxZ73M6x4PCpzyTNnd9p6tlmvZFVfDzr7Ad
	U498znKLy/dkXMy4wao/bavYnLI3thcylWuXfrSYenbRR86Ek7cYGrclrLU9v6ZW33e7ytzb
	PnWnOQO+hiuxFGckGmoxFxUnAgBvL4jzQQMAAA==
X-CMS-MailID: 20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec
References: <20240119094825.26530-1-quic_uaggarwa@quicinc.com>
	<CGME20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec@eucas1p1.samsung.com>

Dear All,

On 19.01.2024 10:48, Uttkarsh Aggarwal wrote:
> In current scenario if Plug-out and Plug-In performed continuously
> there could be a chance while checking for dwc->gadget_driver in
> dwc3_gadget_suspend, a NULL pointer dereference may occur.
>
> Call Stack:
>
> 	CPU1:                           CPU2:
> 	gadget_unbind_driver            dwc3_suspend_common
> 	dwc3_gadget_stop                dwc3_gadget_suspend
>                                          dwc3_disconnect_gadget
>
> CPU1 basically clears the variable and CPU2 checks the variable.
> Consider CPU1 is running and right before gadget_driver is cleared
> and in parallel CPU2 executes dwc3_gadget_suspend where it finds
> dwc->gadget_driver which is not NULL and resumes execution and then
> CPU1 completes execution. CPU2 executes dwc3_disconnect_gadget where
> it checks dwc->gadget_driver is already NULL because of which the
> NULL pointer deference occur.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 9772b47a4c29 ("usb: dwc3: gadget: Fix suspend/resume during device mode")
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>

This patch landed some time ago in linux-next as commit 61a348857e86 
("usb: dwc3: gadget: Fix NULL pointer dereference in 
dwc3_gadget_suspend"). Recently I found that it causes the following 
warning when no USB gadget is bound to the DWC3 driver and a system 
suspend/resume cycle is performed:

dwc3 12400000.usb: wait for SETUP phase timed out
dwc3 12400000.usb: failed to set STALL on ep0out
------------[ cut here ]------------
WARNING: CPU: 4 PID: 604 at drivers/usb/dwc3/ep0.c:289 
dwc3_ep0_out_start+0xc8/0xcc
Modules linked in:
CPU: 4 PID: 604 Comm: rtcwake Not tainted 6.8.0-rc3-next-20240207 #7979
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __warn+0x7c/0x1bc
  __warn from warn_slowpath_fmt+0x1a0/0x1a8
  warn_slowpath_fmt from dwc3_ep0_out_start+0xc8/0xcc
  dwc3_ep0_out_start from dwc3_gadget_soft_disconnect+0x16c/0x230
  dwc3_gadget_soft_disconnect from dwc3_gadget_suspend+0xc/0x90
  dwc3_gadget_suspend from dwc3_suspend_common+0x44/0x30c
  dwc3_suspend_common from dwc3_suspend+0x14/0x2c
  dwc3_suspend from dpm_run_callback+0x94/0x288
  dpm_run_callback from device_suspend+0x130/0x6d0
  device_suspend from dpm_suspend+0x124/0x35c
  dpm_suspend from dpm_suspend_start+0x64/0x6c
  dpm_suspend_start from suspend_devices_and_enter+0x134/0xbd8
  suspend_devices_and_enter from pm_suspend+0x2ec/0x380
  pm_suspend from state_store+0x68/0xc8
  state_store from kernfs_fop_write_iter+0x110/0x1d4
  kernfs_fop_write_iter from vfs_write+0x2e8/0x430
  vfs_write from ksys_write+0x5c/0xd4
  ksys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xf1421fa8 to 0xf1421ff0)
..
irq event stamp: 14304
hardirqs last  enabled at (14303): [<c01a599c>] console_unlock+0x108/0x114
hardirqs last disabled at (14304): [<c0c229d8>] 
_raw_spin_lock_irqsave+0x64/0x68
softirqs last  enabled at (13030): [<c010163c>] __do_softirq+0x318/0x4f4
softirqs last disabled at (13025): [<c012dd40>] __irq_exit_rcu+0x130/0x184
---[ end trace 0000000000000000 ]---

IMHO dwc3_gadget_soft_disconnect() requires some kind of a check if 
dwc->gadget_driver is present or not, as it really makes no sense to do 
any ep0 related operations if there is no gadget driver at all.


> ---
>
> changes in v3:
> Corrected fixes tag and typo mistake in commit message dw3_gadget_stop -> dwc3_gadget_stop.
>
> Link to v2:
> https://lore.kernel.org/linux-usb/CAKzKK0r8RUqgXy1o5dndU21KuTKtyZ5rn5Fb9sZqTPZqAjT_9A@mail.gmail.com/T/#t
>
> Changes in v2:
> Added cc and fixes tag missing in v1.
>
> Link to v1:
> https://lore.kernel.org/linux-usb/20240110095532.4776-1-quic_uaggarwa@quicinc.com/T/#u
>
>   drivers/usb/dwc3/gadget.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 019368f8e9c4..564976b3e2b9 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4709,15 +4709,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
>   	unsigned long flags;
>   	int ret;
>   
> -	if (!dwc->gadget_driver)
> -		return 0;
> -
>   	ret = dwc3_gadget_soft_disconnect(dwc);
>   	if (ret)
>   		goto err;
>   
>   	spin_lock_irqsave(&dwc->lock, flags);
> -	dwc3_disconnect_gadget(dwc);
> +	if (dwc->gadget_driver)
> +		dwc3_disconnect_gadget(dwc);
>   	spin_unlock_irqrestore(&dwc->lock, flags);
>   
>   	return 0;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


