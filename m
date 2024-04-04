Return-Path: <linux-kernel+bounces-131614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18351898A0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6838FB21F15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590612A177;
	Thu,  4 Apr 2024 14:25:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539B7350E;
	Thu,  4 Apr 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240745; cv=none; b=tR0ougB80+DxCMpNl9ZMsrIZcqqp6l8nLhjzbJjN+4RDCUd8W8U+mZMFmp/kRhD16luyl+vpSrIVV7zCXCQOf7VUCMOw6apZxF7X3CcQLo4o4IEEnG5OkxUDaoFU2rdBWmsvt4kv+f+qkPl7RUr9wSuCE6/+2Fly48+8klXeefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240745; c=relaxed/simple;
	bh=NjIRbG3/6S+ypvVISWtCKpe/MfxEtqkQ1P7SZJslqgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFMSb4thQLr/lTZsLsButo3RBlIOukhhJET2kQ7hTjGa59DaCx1l7YB0yul6UjPkBiMSee8UHjn6SakFoIHr9KOZ4V61+9QOIG8yowfUvN4iPt7oL4IfQVE5HJVpNE+i6900/43Qfbl4kgZH/Tk9iqQ1XI7JMNjivOTFgmnwmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1C7FEC;
	Thu,  4 Apr 2024 07:26:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3403F3F64C;
	Thu,  4 Apr 2024 07:25:41 -0700 (PDT)
Date: Thu, 4 Apr 2024 15:25:38 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: mturquette@baylibre.com, sboyd@kernel.org
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 0/5] Rework SCMI Clock driver clk_ops setup procedure
Message-ID: <Zg64Yk-COGfS7cTD@bogus>
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325210025.1448717-1-cristian.marussi@arm.com>

Hi Stephen,

On Mon, Mar 25, 2024 at 09:00:20PM +0000, Cristian Marussi wrote:
> Hi,
>

[...]

>
> This rework introduces a dynamic allocation mechanism to be able to
> configure the required clk_ops at run-time when the SCMI clocks are
> enumerated.
>
> Only one single clk_ops is generated for each of the features combinations
> effectively found in the set of returned SCMI resources.
>
> Once this preliminary rework is done in 1/5, the following patches use this
> new clk_ops schema to introduce a number of restricted clk_ops depending on
> the specific retrieved SCMI clocks characteristics.
>

Let me know if you are happy with this changes. There is no strict
dependency on the changes in SCMI tree ATM, so I can provide reviewed-by
if you would like to take it via clk tree. If you prefer me to take it
via SCMI tree, please provide Ack if you are OK with the changes.

--
Regards,
Sudeep

