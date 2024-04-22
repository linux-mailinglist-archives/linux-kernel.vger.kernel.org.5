Return-Path: <linux-kernel+bounces-152935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10D8AC656
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F2D1C217F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE6F50282;
	Mon, 22 Apr 2024 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYnnX9hk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5A4E1D1;
	Mon, 22 Apr 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773328; cv=none; b=S5+lq5xgIQVDv6C83FxvHP4dOxwljera6eU8GOuBCmDhmUpjLRZE/4z5LZ83or4lvcc5XXqW2UgeWLMm/VAxf8LtZIBJR5G1Todgq8b8Ob9C7ov+czN9z2GouHfk7ehPet8eefxjCfVIIbDziAZxlTlKH6Mka5GhhL0PO5k8c4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773328; c=relaxed/simple;
	bh=pNxKvZ0pvbZikOaEInjWBK+/okMiv9iReGjzye9rv6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ0Mf6DW8ZBz1VLwfvKuTSrGvxtd7egm0LZHsQ8aQWsZJrYwuPUe4Pdp2BqtpvdlLow7ieIaNEJFSnXHVgN7Y/6V4CShVEJoP55zuXrtov/jfhXDsVSPCjCQYDEuPBa706jXt3P7+AfYTQZlWDd46xKQow3JOegWffjVvCpGTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYnnX9hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E01C113CC;
	Mon, 22 Apr 2024 08:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773327;
	bh=pNxKvZ0pvbZikOaEInjWBK+/okMiv9iReGjzye9rv6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYnnX9hkuZk086wYX/7xTI0zsle1Jym28LckvN4FGLSLCqehhNdDq/aBiEm5HzniY
	 aBWhaV8pm2wLZ2Hw7GIA9BRGPqEY9mMEGD5DQStIsZGsYsBMdfe2xW9Pijgp6hXEQv
	 5T3+VTJrWiiMvtsPAX5VLa0zRh0QZdDbkyi3hLj04yix8nse8Xvqrh2PMeX4Tw15LV
	 TqTRlELnMoHLzZijJnNqEH3mmhHTUzdsWvmqBlk4FvObDHD+Ecey2E9DYGngsqBpmb
	 txexvDVqlJ7kLzGSsLj2eDFwjDXg0pio3yA6S3jbFaLTEkMUWfd8GH92UasMqBbLUe
	 1ISII0+6Tbkpg==
Date: Mon, 22 Apr 2024 13:38:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Mayank Rana <quic_mrana@quicinc.com>, quic_jhugo@quicinc.com,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH v3 3/3] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Message-ID: <20240422080837.GC9775@thinkpad>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>
 <17d94b91-137c-409c-8af3-f32f1af2eb71@quicinc.com>
 <4b684db2-d384-404a-9c54-60d79ac7cf9f@quicinc.com>
 <adb9ab3d-0fd2-4afe-96d7-573b1822e0c3@quicinc.com>
 <ab27b383-dcbf-4337-b3ea-da91763e834a@quicinc.com>
 <a5ea5263-8acb-48dd-a4e1-bc48a9bdf791@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5ea5263-8acb-48dd-a4e1-bc48a9bdf791@quicinc.com>

On Wed, Apr 17, 2024 at 12:41:25PM +0800, Qiang Yu wrote:

[...]

> > > > > > +    ret = mhi_get_channel_doorbell(mhi_cntrl, &val);
> > > > > > +    if (ret)
> > > > > > +        return ret;
> > > > > Don't we need error handling part here i.e. calling
> > > > > mhi_cntrl->runtime_put() as well mhi_device_put() ?
> > > > 
> > > > Hi Mayank
> > > > 
> > > > After soc_reset, device will reboot to EDL mode and MHI state
> > > > will be SYSERR. So host will fail to suspend
> > > > anyway. The "error handling" we need here is actually to enter
> > > > EDL mode, this will be done by SYSERR irq.
> > > > Here, mhi_cntrl->runtime_put() and mhi_device_put() are only to
> > > > balance mhi_cntrl->runtime_get() and
> > > > mhi_device_get_sync().
> > > > 
> > > > Thanks,
> > > > Qiang
> > > I am saying is there possibility that mhi_get_channel_doorbell()
> > > returns error ?
> > > If yes, then why don't we need error handling as part of it. you are
> > > exiting if this API return error without doing anything.
> > 
> > I think here mhi_get_channel_doorbell will not return error. But I still
> > add a error checking because it invoked mhi_read_reg, which is a must
> > check
> > API. For modem mhi controller, this API eventually does a memory read.
> > This memory read will return a normal value if link is up and all f's if
> > link
> > is bad.
> > 
> > Thanks,
> > Qiang
> 
> Actually, mhi_get_channel_doorbell should also be used in mhi_init_mmio to
> replace the getting chdb operation by invoking mhi_read_reg as Mani
> commented.
> In mhi_init_mmio, we invoke mhi_read_reg many times, but there is also not
> additionnal error handling.
> 
> I'm not very sure the reason but perhaps if mhi_read_reg returns error (I
> don't
> know which controller will provide a memory read callback returning errors),

Take a look at AIC100 driver: drivers/accel/qaic/mhi_controller.c

> most
> probably something is wrong in PCIe, which is not predictable by MHI and we
> can
> not add err handling every time invoking mhi_read_reg. But we have a timer
> to
> do health_check in pci_generic.c. If link is down, we will do
> pci_function_reset
> to try to reovery.
> 

Right, but the MHI stack is designed to be bus agnostic. So if we happen to use
it with other busses like USB, I2C etc... then read APIs may fail.

Even with PCIe, read transaction may return all 1 response and MHI needs to
treat it as an error condition. But sadly, both pci_generic and ath controllers
are not checking for invalid read value. But those need to be fixed.

Regarding Mayank's query, you should do error cleanups if
mhi_get_channel_doorbell() API fails.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

