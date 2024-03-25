Return-Path: <linux-kernel+bounces-116999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D288AB4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7307ECC4075
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796D9524C9;
	Mon, 25 Mar 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrQlwVvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5071CA9C;
	Mon, 25 Mar 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369826; cv=none; b=LjsMouAH+N2dTy1kDjJWJllGpPzhQuZx2Dn/t3REDyulpQuMXSo0wLMKt1tZnEcOE6tdEVSBeu7XXmJ4cuMu70HmkHS1iBm4UtKHRhHlrmSi1I66KYSIxuV36xIRrURSa8ynd08p21Io3ITQgwkcvTYmP+ZYSAiM97mjiW3euVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369826; c=relaxed/simple;
	bh=uSA6b/rXUkeindQUeRTDu0X18aB4WbICa7Pj8OSlW6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqm/voBRvg5GhZmQYYJDIEhXifOogyO2dbsK+ZbWWkRsSYv7au2avF/w33fJRZGY+bVf5Q9Yvns7G1Fqler6euq4IOwjPTa2GwK7bRqW1VXpCdMPtPCz2lstf1oRs9KJLM03GdesQcJTQIyLMlGnvoJomcXYHn2Lz7HlZhPJcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrQlwVvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3792FC433F1;
	Mon, 25 Mar 2024 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711369826;
	bh=uSA6b/rXUkeindQUeRTDu0X18aB4WbICa7Pj8OSlW6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrQlwVvSO+ZUSTM9MvRT2mHQAYNtQN7mSFORV2D8DevnHh4u89hQJuwObevqhRGyc
	 7TsTel3bGmTRVyl3/3iwYlyCLypIN198PRM4jiFzbGp8dC3vhFFUIAkwis36BP77qL
	 CXjgrVzC0MgwDDCT6id46mvHALNzWADTA/qf2rn4+IkBe3//bqG4BYcXP+wZ72hPkB
	 Pgx/93GYDdYVwRucrJYm/KDjVVvvZIU/7RIyhwWGF8t4rS+/vXJgrt9LaCpGqpmVRw
	 yiGe2Egf8XpYo9q0I40IldEx/ffe3C6i76I+8IXvOUvQ6l4X+cQsAgMH6Jl7M9Sunc
	 IFfH+1LLe8/CA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojTE-000000001Qs-3iyO;
	Mon, 25 Mar 2024 13:30:32 +0100
Date: Mon, 25 Mar 2024 13:30:32 +0100
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
Subject: Re: [PATCH v16 1/9] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <ZgFuaL7H2U3Awo2p@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-2-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:44AM +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Synopsys DWC3 controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

