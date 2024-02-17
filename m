Return-Path: <linux-kernel+bounces-69986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFAD859156
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728951C2173C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616137E0F3;
	Sat, 17 Feb 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbYNEtL7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8391CD1F;
	Sat, 17 Feb 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191592; cv=none; b=eLkZR5Da6P9qY8njusDqSMXyfx0/kT+eRI9MhLEhX/lvMObDOSnXfi3ADbToV0xzrz3OFIiGMfsCyOXGuowWrLvpyovMTAzT4TuMpnzWfb6FFf1XeHRQANt9e5D38T2f+3Ia/+Lyi2WqH+nH6DSCheVyhDarShwOWVGBxa4ZIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191592; c=relaxed/simple;
	bh=ebo0Nz5NB6p8XZFP+hLXjd6Z68qG6zhlDNfq+Svz3Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqAeMVQfmUz70toF3ZRt9e88gN3wKNEdG7WUEqJlYyE2gIL+0AHYBZnAV4Q/4aJ+7uUA9zlRjqaQuf1FC7K7Zqdf7gp479werQ29nsWEi+C5CcgRgwFlLO7Tbvdrp6N/oqx+6c0qDP0o1cxucuTPdwW/HcNmtiSRMRTdpHnNSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbYNEtL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD05C433C7;
	Sat, 17 Feb 2024 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708191592;
	bh=ebo0Nz5NB6p8XZFP+hLXjd6Z68qG6zhlDNfq+Svz3Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbYNEtL7ZT1TNkc5nfo4LMlRj6ZwcBCtHKauFUBn8V4P6G/VwAV/j964gwHPJ5ejj
	 Uv0uZTfGjFOiugbE5vI7+fDavhAKHpmpqTT7udXIvG0sek/WY9Fj4T8Ban5HwAgjLq
	 dk0hVb4xYB++E+RBXOw2+UYEnF0jz/d1/MsZpwnA=
Date: Sat, 17 Feb 2024 18:39:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, Johan Hovold <johan@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v15 0/9] Add multiport support for DWC3 controllers
Message-ID: <2024021703-sponge-reactor-4984@gregkh>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216005756.762712-1-quic_kriskura@quicinc.com>

On Fri, Feb 16, 2024 at 06:27:47AM +0530, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller which
> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
> DWC3 controller with multiple ports that can operate in host mode.
> Some of the port supports both SS+HS and other port supports only HS
> mode.
> 
> This change primarily refactors the Phy logic in core driver to allow
> multiport support with Generic Phy's.
> 
> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
> are HS+SS capable and 2 are HS only capable).

I've dropped these all from my queue (see the other private email thread
on the commit response).  Please resend when you address the issues
Johan raised.

And note, please do NOT attempt to poke maintainers in private bug
reports to do reviews as that is not how any of this happens, you know
this quite well.

thanks,

greg k-h

