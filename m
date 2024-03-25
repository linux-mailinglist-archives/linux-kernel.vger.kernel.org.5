Return-Path: <linux-kernel+bounces-117058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A788A686
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CBD3026AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E1416ABE7;
	Mon, 25 Mar 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+EHva/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1E16A98E;
	Mon, 25 Mar 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371010; cv=none; b=JGljEX2WOGlub+lYZGF6cTtr2HoI/ywOaxU4NoKNts26VqthqtUFMLCBg4DZZyhP1Bb/TgS+S8aCOhmnupLdb6iX1GeFbLQnLleYA+Fmaosx0/RsAGgLQcniZ8v/GCvUlQxN4oHKSeK32nEjqG/g8j0lPyxxPsHEb8PiaB1k940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371010; c=relaxed/simple;
	bh=MQyP8Cbvbfb+NAFnJuG/Jpo0myxuH0p0Tsd7Fl2/voM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwW+CSBB1HRHi85VPD39dFiAUUiBhrtWOxha9H97Zn3woV0J+N5sBWMaI8ycl17Z6h27Y3K8CjPjMP3XKzDDakWenHFtz5cxmXlSRUvX2nDvLYPTynWUH6fS/lJOAjPD5L3xrryO03ja2ib1uFW8dYC2CbVKvMibQcUFsHwbbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+EHva/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D398C433C7;
	Mon, 25 Mar 2024 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711371009;
	bh=MQyP8Cbvbfb+NAFnJuG/Jpo0myxuH0p0Tsd7Fl2/voM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+EHva/YW/yeyj9fLBo/9Fmbks6yAcEAuW2gfJXWKUVuTPzJWLupbZo7MJxbKF0/O
	 +lyfEULjCwj1g9SVzkGcH15gKqHEafihTsZqmRQJkfj+fciO0s9+/uvsHk/jYgn+uO
	 nSPlseLGlcrBy1wu29L0kcjaikbrDRV/FupikG9v5apaq2KAxYYs8Ycy9yC9F33RJ7
	 CMq3tfZMgHFjq02AbQSswi03Y1zDQI4rxoF7RkCBGc9bNubAQT5jExBmMZoScBleiK
	 qbsJWHfwOIMhg/HBWG6gw8UUyZnJQ3PxFalfrUtFhzdXNnhnF0yp2PRIfE1SKuNAYC
	 dU1FDAIaPpG4g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojmK-000000001VZ-0fwr;
	Mon, 25 Mar 2024 13:50:16 +0100
Date: Mon, 25 Mar 2024 13:50:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
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
Subject: Re: [PATCH v16 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Message-ID: <ZgFzCKXxo63ckbe-@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-9-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-9-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:51AM +0530, Krishna Kurapati wrote:
> DWC3 Qcom wrapper currently supports only wakeup configuration
> for single port controllers. Read speed of each port connected
> to the controller and enable wakeup for each of them accordingly.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

