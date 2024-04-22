Return-Path: <linux-kernel+bounces-152840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235318AC527
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9371282A21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0594D5B0;
	Mon, 22 Apr 2024 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRfy41E6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1321C8F3;
	Mon, 22 Apr 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770028; cv=none; b=fKdTlHQ9TeAL68+voi5LtyXFegdICkYVAU3JXznz9j20/FCMKsA7Soo7PcnBam3eyr1q+61lS/IhVv4ZJWJ7v7qnsu/tBiefDlCz9027qb2ThiZpH7OnLqjNG2OA59D6GjiUegVpthCa/RqLqe+4Fgqyjsecf3hEBQf3n0JEMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770028; c=relaxed/simple;
	bh=nANodsRQh0SlHeZ8TSIrbcrOjTmp+PFztQpd3BDIO14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvqbHR/jydyLUjyRIHvi0W1mAL9IGAqEtkV6p3bw2Bm6z1LMJetk8rg+ui3JE9na1p9VcxNWIWYN0xpVexfcPTaAjaAt5DALuTjmzeAXMd4lbMUAysTIv/FiTYYujgXnCBMKJpiqiP7gwX4ZeFSKMZnON6fWrM/GbWPMwbJrFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRfy41E6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42188C113CC;
	Mon, 22 Apr 2024 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770028;
	bh=nANodsRQh0SlHeZ8TSIrbcrOjTmp+PFztQpd3BDIO14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRfy41E6vUIkYxsNdD6rO3NiJJjKegcOJ2ILw505xnUWuaMYmd2y0Ouh9eG5Y0Al8
	 9XUxKoKib0O/SCuQNVmmJ9fdUUXeSDaqjjMrS+0eYUcNgVXy+IJH3hw2f2cEiXbYeQ
	 B1lj1CUIRjICUJrmg8VW93yAk/u2QLv0JdQwUoD/DDeGADHQolQrQfETM3aSn7D+aM
	 acd5+5Ztxwlxr/qRzLAac5VY6lUcqECdqPTtcXBiizrfJl/Qz6XoH2CZ6SP4bbneBb
	 8gN1GhX3ckEUIPQCuaFKxU7bn+wm6Hw5LtChBM53gampmICaUO/hJRlipt2yRWJu1R
	 mTqYmB878Fn7w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rynry-000000002bu-3VFf;
	Mon, 22 Apr 2024 09:13:42 +0200
Date: Mon, 22 Apr 2024 09:13:42 +0200
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
Subject: Re: [PATCH v21 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <ZiYOJuUSF_iDUTeI@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-6-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-6-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:18:57AM +0530, Krishna Kurapati wrote:
> Add the compatible string for SC8280 Multiport USB controller from
> Qualcomm.
> 
> There are 4 power event interrupts supported by this controller
> (one for each port of multiport controller). Add all the 4 as
> non-optional interrupts for SC8280XP-MP
> 
> Also each port of multiport has one DP and one DM IRQ. Add all DP/DM
> IRQs related to 4 ports of SC8280XP Teritiary controller.
> 
> Also added SuperSpeed PHY interrupt for both Superspeed ports.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

