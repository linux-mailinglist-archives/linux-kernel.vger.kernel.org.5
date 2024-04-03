Return-Path: <linux-kernel+bounces-129122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D31889654F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297022842DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188A5646D;
	Wed,  3 Apr 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsqgg+cE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29933537F0;
	Wed,  3 Apr 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127964; cv=none; b=BlE70Kv0Elqe0ZFkDacP3h63PRIbqvH9m5oZ/fyln/NW/g8Eui4EmXrAY27q0vjdRwEOTj20cjrtq9uAiaUL409hpvy/iq/JJeZ0aanrNlzmahNPWYlre1dV/r9veRFuwAPhZ5W05EqkLFBB+9hHN8x24ap7TLJQK57BhnvYJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127964; c=relaxed/simple;
	bh=pLe1zO2KxOqFTC50hG8lKBdb2ln2PJxOAj1b7Rg2kIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTVPmI+gCqivxOYQG33m8qN03maXDy7hoqs0Kf5WEU9fG3eEMpxKvTSHl7DkzEuE1BIbME4RxYJ7CtTKaSXgjVeFZ7cppwMpgo6HhT34d+xc0H8hJu4iyBfOmYk3uLR6c2YnMMjdapU5mZOBdztUm3LgZaqj5nkYAPw900vmjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsqgg+cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE52C433F1;
	Wed,  3 Apr 2024 07:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712127964;
	bh=pLe1zO2KxOqFTC50hG8lKBdb2ln2PJxOAj1b7Rg2kIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zsqgg+cEZQMPJJMhRULn+C1BAygbh1Jo+iW/fdyZq38BLsH1GQlSSiLdKKVmIubdl
	 JPv/ktx6eD1Fer7jBzWejLrYpKWe5qGj9woXlvdU6gTT5yazsOjInI65kTaSR1KriK
	 4Z9uUD/QhThZzfY5cjtpOda9SCsMu/xiQpe8iGWXHmjPOn2q5mcKYWSLjcWTzyUq2k
	 g8suoptVxiw0vnVB8qX1rRlWfOD6qKassulNDmKmBcfB/nLz++BhhN9G0QTvEN67tN
	 5neo1wSUKQsZLRPIyF2tlXPl3wGkbuz3Cl2opHP29bv/13s4Iz5eaFyJaiJQjboQtD
	 kBMHljPftTyBw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rruhA-000000007BG-01yh;
	Wed, 03 Apr 2024 09:06:04 +0200
Date: Wed, 3 Apr 2024 09:06:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v18 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <Zgz_3AspRRfYqOwZ@hovoldconsulting.com>
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
 <20240326113253.3010447-3-quic_kriskura@quicinc.com>
 <20240402233218.5kngtj56qellnrmo@synopsys.com>
 <39010f95-b08f-4a57-b3af-f34eb1069865@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39010f95-b08f-4a57-b3af-f34eb1069865@quicinc.com>

On Wed, Apr 03, 2024 at 10:54:25AM +0530, Krishna Kurapati PSSNV wrote:
 
> >> +static int dwc3_read_port_info(struct dwc3 *dwc)
> >> +{
> >> +	void __iomem *base;
> >> +	u8 major_revision;
> >> +	u32 offset;
> >> +	u32 val;
> >> +
> >> +	/*
> >> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> >> +	 * needed to get information on number of ports present.
> >> +	 */
> >> +	base = ioremap(dwc->xhci_resources[0].start,
> >> +		       resource_size(&dwc->xhci_resources[0]));
> >> +	if (IS_ERR(base))
> >> +		return PTR_ERR(base);
> > 
> > Looks like you forgot to address some of the comments you said you'd
> > update previously if you submit a new version to the series.
> > 
> > [*] https://lore.kernel.org/linux-usb/af73110d-e13e-4183-af11-aed869ac0a31@quicinc.com/
> > 
> 
> Apologies. I agree. I was too much focused on acpi removal and interrupt 
> cleanup, I forgot the last comment you gave.
> 
> Can I send in a separate patch for this ?

The series has not been merged yet so you can address both issues in a
v19. Perhaps wait a day or two in case Thinh has further comments.

Johan

