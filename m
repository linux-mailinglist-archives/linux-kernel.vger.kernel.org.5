Return-Path: <linux-kernel+bounces-152859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E68AC552
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB51F21DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9B4DA10;
	Mon, 22 Apr 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK0Z80cK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE74C62A;
	Mon, 22 Apr 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770300; cv=none; b=XJws4X3E6xnZhwdCIB4/CxSTpcrh7vTv09fxr0cWeXMfy+DUTw3gOYEgMdkXCiyM1YDIJq23UpcNudJ7r6uH9V2cbA0CO+ZSnreuhTY4eekgRZ5sX7zQeiNylVj8dupyO//YJxf3L0zdT2SzX2gAeV5NIZNXescaiCRvAntj4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770300; c=relaxed/simple;
	bh=4j9/ixBcrRXzHNP/FULKIaHBtcfKqIhHzURyKg3qzdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh/dOXyhvmR3r1K6AAoxnU6FrlHxClxpLO5Gq9WJkxsUfmMkQF/tbHA3RdWGEzKaqlVrTMOne4DG5bjz6kIu0yqSkavPiJWnEMqvw0v8bLOrIzcnYdnrauVwZUJ9Z3WwOPQJRkBlCgKJ8cOiGPb9r8Ib+Z0lTKU9H4tUaXqK0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK0Z80cK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8AFC113CC;
	Mon, 22 Apr 2024 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770300;
	bh=4j9/ixBcrRXzHNP/FULKIaHBtcfKqIhHzURyKg3qzdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mK0Z80cKCAI+uDxSxdZHcaGs5+UT4XVQgZnS0F5bwO8/s8LgGk+/jsdRgfIB/Mgmx
	 tS8XBioRztDxO4OLF0s2jjbrzM57aXUgIkAcYYfAfNkAeJWcMqMglFZpMz71SHWYgg
	 mm0AXjUyQriCTOWMDeLd5h6v2gNV9qEkzvD3M2Z+vmTXEeQVQNmZCpmfLZrMRjBB4D
	 70e3EfS7O5BOG4E1E9j0SFe9yr5cQo3iZbLBigNhr1XKg3Fj72hoI1c7a0vFE5u7bJ
	 XnRjx3kwgRMcbn7ueNLFlHmea+een/YxKporS4WRUaPTCZTRVdydIOVULyJuzeK1CJ
	 OFi1v4keCfTIQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rynwM-000000002f8-3LC2;
	Mon, 22 Apr 2024 09:18:14 +0200
Date: Mon, 22 Apr 2024 09:18:14 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Message-ID: <ZiYPNv8Q46rFj5CJ@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-7-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-7-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:18:58AM +0530, Krishna Kurapati wrote:
> The logic for requesting interrupts is duplicated for each interrupt. In
> the upcoming patches that introduces support for multiport, it would be
> better to clean up the duplication before reading mulitport related
> interrupts.
> 
> Refactor interrupt setup call by adding a new helper function for
> requesting the wakeup interrupts. To simplify implementation, make
> the display name same as the interrupt name expected in Device tree.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

As far I can see, you only replaced "DT" with "Device tree" in the
commit message. For changes like that you could have kept my
Reviewed-by tag (but I appreciate that you dropped it from some of the
others):

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

