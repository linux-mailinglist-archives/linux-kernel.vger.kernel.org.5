Return-Path: <linux-kernel+bounces-86837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48886CB72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634441F26231
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2545137752;
	Thu, 29 Feb 2024 14:24:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E731137740;
	Thu, 29 Feb 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216686; cv=none; b=fjnJkD8lHXCcWIBCul7pl21c1dQbIkfg7cLeAmWZiYJazA/D2kUfO0DHQHFDSFiEA1//hs7gI/MY25XrO6g6gN62VLUCXifPP4W4I/4gean40gEQf6D5blHXaJu/giUONduvfe5u7tsPxS4SxJL7CKlGmBNFDldcnkuWypeGt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216686; c=relaxed/simple;
	bh=lCe1akPKknc5mXsZjqXrn+eyyKkLvRis75F0vbeOrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dchzdGicPs440nMb/HZd+Nc/M7s9DOuk1B1uki+nIPQn0goiCFt0bR+6ICPJuFYm5agh9o65DMV7c7/LExOYPBQSKeu09jckIU5TELa6VEvUC0URdBnEUGjdUDWcIkEHglsaEyPYu4V/sufHxFJiMFQGnsCvzPR/kjFZRfqpD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4C4F1FB;
	Thu, 29 Feb 2024 06:25:22 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC693F6C4;
	Thu, 29 Feb 2024 06:24:41 -0800 (PST)
Date: Thu, 29 Feb 2024 14:24:39 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <cristian.marussi@arm.com>, <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <konrad.dybcio@linaro.org>,
	<jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
	<conor+dt@kernel.org>, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Message-ID: <ZeCTp5jP51gnkc3u@bogus>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117173458.2312669-4-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 11:04:54PM +0530, Sibi Sankar wrote:
> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> 
> SCMI QCOM vendor protocol provides interface to communicate with SCMI
> controller and enable vendor specific features like bus scaling capable
> of running on it.
> 

I would expect a proper description of the protocol specification
either as part of the header file qcom_scmi_vendor.h or somewhere
in the Documentation. It helps to understand the design instead of
assuming and/or getting confused with the assumption while reviewing.
I will point out at couple of individual place why I am asking for this.

You can follow some pattern to describe the command using SCMI spec as
reference. That will act as a contract for the software instead of changing
the implementation every time someone thinks it should work in certain
way. I have seen that quite a lot with the Qcom firmware lately with zero
transparency provided for these firmware by Qcom. In short I don't trust
just code to understand these vendor protocols. I need them to be documented
and version where needed so that we can refer back and make maintenance
smooth and easy.

-- 
Regards,
Sudeep

