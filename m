Return-Path: <linux-kernel+bounces-117007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE388A60E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A371F63353
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45EC13C691;
	Mon, 25 Mar 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJGxSBag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CD13A245;
	Mon, 25 Mar 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370072; cv=none; b=EAbh1ki6aceoH1NMSqtxcYmAIzzHi7C5ckXkTZpsq1nl2UsNXct+r+KmnKezsc6olXLqWg07UUkFPaALqp6IpPxB3pqBmxSEuc9ugx/30CEiS+YWBTvNgm4XYlQN8RC3HN5LigeOGF0prraxm+oHJv3BViL/bewqlZgNJYeADzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370072; c=relaxed/simple;
	bh=Po4z7pfUaQrMjDD7xGqP/iurr0JJOKzsojQ64s9r5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Inc3X26SmmEDnUp0VEr1CzIrmLQr0RGDvYuaR9BfiTRpxQmlv3ENZgUJ4AFztzmLI2SZF1Y8Juy/dUHnoO/GIV/niNJYz7gL5HghrRH+SsdfNFA/dm8RIgNs/RI8JmjPa9Xu3AL6OQpEH+6v+xH/LeOmjB9q2M8+9HBDRwlxs34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJGxSBag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBD4C433C7;
	Mon, 25 Mar 2024 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370071;
	bh=Po4z7pfUaQrMjDD7xGqP/iurr0JJOKzsojQ64s9r5zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJGxSBaguGSQA+7ZvZ+fEdYfPyZZDh/02oOTGxnZY6vxNtLJb/cgLk2Ihqcwb0z3f
	 6Hmga5encTm4pDxz9dFns2QUF5B1y6UwRZXvxzFzZaDPLTKDjUBF5rkiLePxc8EPqS
	 B8tZhiLoqVsvrWvm9xgevNpI16fe5XSBwHJzBsoy1OrDbzz/dtRNaOris/bGEGKXc6
	 YAWa1mQJQJn5XOLBZHZkpC5HvQazYb1Rwuggys1TAj6WwhyfG0ZMJrEr0xIJyXaB5l
	 WqNMh1jp3ouZ8pg/BVj6abV+xdif9MwZZ1WhmUEgoaw8HOvTBZ7TNk10vUZKBhoDyQ
	 kscCfpaVBCJCQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojXC-000000001Rr-22xZ;
	Mon, 25 Mar 2024 13:34:38 +0100
Date: Mon, 25 Mar 2024 13:34:38 +0100
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
	quic_jackp@quicinc.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v16 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <ZgFvXj_fwTltVJf0@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-6-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-6-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:48AM +0530, Krishna Kurapati wrote:
> Add the compatible string for SC8280 Multiport USB controller from
> Qualcomm.
> 
> There are 4 power event irq interrupts supported by this controller
> (one for each port of multiport). Added all the 4 as non-optional
> interrupts for SC8280XP-MP
> 
> Also each port of multiport has one DP and oen DM IRQ. Add all DP/DM
> IRQ's related to 4 ports of SC8280XP Teritiary controller.
> 
> Also added ss phy irq for both SS Ports.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

