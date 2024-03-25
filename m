Return-Path: <linux-kernel+bounces-117140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA088A8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEF5C40BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B02813D28F;
	Mon, 25 Mar 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYLI+O76"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1B3DABE4;
	Mon, 25 Mar 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373000; cv=none; b=oeB472UE1NtFgG4m7fZBc6ukJiUuL4NgFtUJguAc0eCnCeTRRIYBn8MTvwRnxLdW+Bef6TtjpN4LKqUxInaeFSeRb4HJrJI4IMPi6YaMNtJbQ0lKUouUlGN/1uq1aVecYfhCy9xYsoDSdjkKjyCZiColNVjI8wXTKHIRxgQZm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373000; c=relaxed/simple;
	bh=PjJNeY3q/X24Nv8Rni+2wPJbh1tx07qUysRGY4cAlkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+dSkF7yNWdW8ZI7PvDbdxS/GJu6WB5GWvuSAatFSp2j58tn848cCX5k9u7NVj63rCiNarmFM3hPv4FW+9Tp8pMMwEgFTl+ja29nt6GuqqEam7ABSHmKJdW4zFlpNW98ZDK8/jnMdSlUiPAaheu+fWGLDkK41/LO8Io4BDLrWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYLI+O76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB4BC433C7;
	Mon, 25 Mar 2024 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711372999;
	bh=PjJNeY3q/X24Nv8Rni+2wPJbh1tx07qUysRGY4cAlkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYLI+O76TjbuUn3eOuQL+Ep5PhtqWZtR7o6jhiRJF33mIzQw7Dof2Fw/koksKiDS4
	 fa82FHs/d//DvxrjRz3OJJdEyMPXVke6PVzJV/T68GgSBAiklH/lZQoflyEF0pt9US
	 0iXAyrxwyumRLQ8uUsavzO2HllE84eZMo0iXtiLygCsbKrUEkKiBOl5h11X4OdGrJY
	 IE5t9YboI6Zm61HmKtfT8U3P2ZoYop7IeHcIFVPRlNBYNsBlCFRhfAILHqAODNYM/h
	 /qNU0+Gpil+9Hd3CYihGnfRwbXRJieqZFCXWGFJa6d+gF8zoRQRddr0CGsfu7LAIK1
	 aEW6C+uJMpDyg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rokIQ-0000000028D-15ah;
	Mon, 25 Mar 2024 14:23:27 +0100
Date: Mon, 25 Mar 2024 14:23:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Message-ID: <ZgF6zvaT2OkrbkHK@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-8-quic_kriskura@quicinc.com>
 <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
 <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>

On Mon, Mar 25, 2024 at 06:45:07PM +0530, Krishna Kurapati PSSNV wrote:
> >> +static int dwc3_qcom_setup_irq(struct platform_device *pdev)
> >> +{
> >> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> >> +	bool is_multiport;
> >> +	int ret;
> >> +	int i;
> >> +
> >> +	qcom->num_ports = dwc3_qcom_find_num_ports(pdev);
> >> +	if (qcom->num_ports < 0)
> >> +		return -ENOMEM;
> > 
> > Just return 'ret' directly.
> 
> Sure, will init ret to -ENOMEM and return ret here.

I meant that you should return whatever error dwc3_qcom_find_num_ports()
returns, so perhaps something like:

	
	ret = dwc3_qcom_find_num_ports(pdev);
	if (ret < 0)
		return ret;

	qcom->num_ports = ret;

It looks like dwc3_qcom_find_num_ports() can also return 0 (e.g. on
malformed DT), which also needs to be handled somehow. I missed that
earlier.

Johan

