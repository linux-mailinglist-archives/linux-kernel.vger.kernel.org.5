Return-Path: <linux-kernel+bounces-152866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3378AC56A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A0B1C21D29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17314CE0F;
	Mon, 22 Apr 2024 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfEsq+7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCA482D3;
	Mon, 22 Apr 2024 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770568; cv=none; b=uWaOdRezDU+tjf+ijdwpq2D46Qi8Biobcgq4tMSC7mXYZGiqIRalsdpxPeNBQ6JToWk6NVqnM2pniU9JpcklnpVUFDH0wDKVaaBz+FDVTA0V2nxI6p8e+rwp4fpEbzqG+Id4wASzMLAuazJX1YZ/PWFFymAwLiKg4Oz5zwQf6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770568; c=relaxed/simple;
	bh=+bds4KaPIsETmyKenODVb60+fYLzI98dsErkjcissAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAhHi1B2BM5Q/UiRgAAAqn5P1s3thuuMI4Ym9FOlqE1/VogCoo+DPYoH4XImCaDcqs4xrCFxWrcEtII6kzBmmCP7gKNcp3f1eTPX0CRCFay+bNSINJJg8CexCFpr+QMuf2juJIbhP8JiHdoeWDChj3e+4lXJR2vJSopD4sytJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfEsq+7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550F8C113CC;
	Mon, 22 Apr 2024 07:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770568;
	bh=+bds4KaPIsETmyKenODVb60+fYLzI98dsErkjcissAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfEsq+7zn8VY+YIX+RPml3IpRBjLNn9PikKkg+hcWyjq00kszngeJWoL5Ez+pM5sM
	 O9mo45hpSJdwaZ+BuSoL7eSqfdM13VgzY9zQg9N99f88QoBHX//Wq9SNxpWyGoai0Z
	 PsXlKE5C24KWFCX2Oht8WvvlrhEkytzScW4LneRrstDvI+d4gtrx9aIHoVOLwdyRb0
	 JuU8cyI+GAAhlkkwutO3NWjmgF8a3COz5+E/L6CPG5hLNHGMHpjqprySFinOiKHA+d
	 bseQVbRrknxFejxlORusHH1YNleZEjEoZ4Le4bXzR1TcLwnDd7aTwnsQaQO2218VgD
	 dcFzcgwfOF2mg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ryo0h-000000002ix-0Prm;
	Mon, 22 Apr 2024 09:22:43 +0200
Date: Mon, 22 Apr 2024 09:22:43 +0200
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
Subject: Re: [PATCH v21 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Message-ID: <ZiYQQ6DlGPFcxrdI@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-10-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-10-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:19:01AM +0530, Krishna Kurapati wrote:
> Power event IRQ is used for wakeup either when the controller is
> SuperSpeed capable but is missing an SuperSpeed PHY interrupt, or when
> the GIC is not capable of detecting DP/DM High-Speed PHY interrupts.
> 
> The Power event IRQ stat register indicates whether the High-Speed
> phy entered and exited L2 successfully during suspend and resume.
> Indicate the same for all ports of a multiport controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

