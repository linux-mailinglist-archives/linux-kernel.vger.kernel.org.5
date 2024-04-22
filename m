Return-Path: <linux-kernel+bounces-152874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9118AC58E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C981C21DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA64D108;
	Mon, 22 Apr 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEndPLqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2BFC8F3;
	Mon, 22 Apr 2024 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770836; cv=none; b=QaZP5wWFdd2/15ylXyKh2eLW+bGiSLG5oXhoMCemyS0P6NFFPVriRK9GygPOPuzkr+R+i8cVvxubwXdnZUNT7oGvPrd49WRg452GOo5ZDP+tecJQYVSocPA/LFSuzXdEu9y6FV2aJX9wzouNwHBqcnJV5IW7WGRgDUWJrr3PB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770836; c=relaxed/simple;
	bh=QxtwLeDVFdsiThGZTFn7jLKLoCPJR/0Rw0GOzf5zQTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exBUphodasrn5FyBJ9RZuljme0q0skyTmcrKBX7Eq1SGRolFhNdX8Vw/8Rzzz8PzpEMGVR9/wxR59W4N0Dz3gG100zHsjDGAdUG7Q8emHGE0bubMcTm0uYAWw07VJnJIAt7vd/fxUMOVs3I/Xp0yGbPFIrCoc7lTm/1NaK6pJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEndPLqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82986C113CC;
	Mon, 22 Apr 2024 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770835;
	bh=QxtwLeDVFdsiThGZTFn7jLKLoCPJR/0Rw0GOzf5zQTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEndPLqeirAFM3M5SvzcQ01Ya6CYCFgX17gJaXJoa1yHmfx2+i45rCXoo6z/Zek8G
	 v3jto6ssSXktM3BBsTaQ2vSJM9iKhsJou44trjfsTpDuWCUTcnJCHnI0+FU8KWVJNM
	 yeb2K1u5n/t3jLFu7xw8UuyxYZNuNwidUHR+c9s2+q6RvSq5G59uRRlGgsN/NkUpUV
	 L1ZlupYWwmh6W4gEkMg/LfSfS3KdCopBQhet6NgmmmRELYMKhu+RA+jxPMD4O+eKuA
	 8NJ+Brcu+aeeqjyjVbYa+iz8R8RvZS8NlPAPdlED8tj3ATkgdoydRTjELo5Ko8BHiB
	 UTpa/xs4BhOqg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ryo50-000000002mG-135y;
	Mon, 22 Apr 2024 09:27:10 +0200
Date: Mon, 22 Apr 2024 09:27:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v21 0/9] Add multiport support for DWC3 controllers
Message-ID: <ZiYRThDz-vUBXwH8@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <SHXPR01MB0863AA6AE7B391F26EF882ADE612A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SHXPR01MB0863AA6AE7B391F26EF882ADE612A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>

On Mon, Apr 22, 2024 at 01:21:07AM +0000, Minda Chen wrote:

> Can DW multiple port host patches be (patch 1-4) accepted first?
> Other multiport vendor will use this.

The whole series is good to go and should be merged for 6.10 so there's
no need to split things up.

Johan

