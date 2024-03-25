Return-Path: <linux-kernel+bounces-117004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7149388A602
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7111F63254
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C4F136E05;
	Mon, 25 Mar 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knzeYiJl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBC161;
	Mon, 25 Mar 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369974; cv=none; b=mF8s8pvO8ptw3MKPD/ADTe+AFRaNCE1Wa4doZ38TLhfGxtOj4e/+rNaM7J/JaebGDEM9L5Cek6CdYg2X/hEuTvojpp+/PeLHCeb9DrmqjrJpGIKYWfIZ+y9PAiDkH6Rt/+Hzul+1d2uV3P+P46jOPKIk/YQJuT54Nf7TEAlpGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369974; c=relaxed/simple;
	bh=fa889V0P6tJ2Pz1hqZwuxvJ+yobUR0IwbUUrhUxrTjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1ZLnf8DiZj9GFRhLUdqcTA/W+Cka5/qCru/1rJdbdpaR9s0Jc4yXunGQFoKaIJHpjSxJ9H3k0s4dSy1T4dByj01qXYazGSm0FUJx3QynIn7c7VoMpy6yZJW1n9Pps+zQo2KgaNn5vLJTyq2hcQi2RgIGl/2HAzGk/5+XWEdavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knzeYiJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94F8C433C7;
	Mon, 25 Mar 2024 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711369973;
	bh=fa889V0P6tJ2Pz1hqZwuxvJ+yobUR0IwbUUrhUxrTjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knzeYiJlUSzPUAhLOoovzbZTHk5SvN0qTYtkwQXlHU94fQqHjh2BKwSiKtTIs1TGI
	 D36+2vXpSodeFr0i4IQB8RDBs6nWQ0/ACDO26NyYi74CZd/Z/liUSBJHbvfq8iKVg2
	 Qq/OOIbEuvjUJPN2cyfvwqOAhkwp8lBWc+bM5y8hquXUE8ohZEmbIyBv7YFb5XACZv
	 99G+RLGPYhKc4R3lsi68qZTw9V+tPisFDCRuhRK4hL3adlg2mn91TW5zlipBvRDvOb
	 e/w2kO+VRpZuRtDWuTYlH75MZC03pu+3s6dRqHwCf3MbOgZwLwJDEB3k75xqSp2Lr9
	 eqZoDZ1V+2vAg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojVc-000000001RR-2DNi;
	Mon, 25 Mar 2024 13:33:00 +0100
Date: Mon, 25 Mar 2024 13:33:00 +0100
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
Subject: Re: [PATCH v16 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZgFu_Of9GLnd3P-d@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-5-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-5-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:47AM +0530, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller
> which requires at least one HS PHY and at most one SS PHY.
> 
> But the DWC3 USB controller can be connected to multiple ports and
> each port can have their own PHYs. Each port of the multiport
> controller can either be HS+SS capable or HS only capable
> Proper quantification of them is required to modify GUSB2PHYCFG
> and GUSB3PIPECTL registers appropriately.
> 
> Add support for detecting, obtaining and configuring PHYs supported
> by a multiport controller. Limit support to multiport controllers
> with up to four ports for now (e.g. as needed for SC8280XP).
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

