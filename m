Return-Path: <linux-kernel+bounces-6779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966EA819D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A711C25C18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E90020DE6;
	Wed, 20 Dec 2023 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="Pm6rYARo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [159.69.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A80210E9;
	Wed, 20 Dec 2023 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=CsVrMzlnClZBs8fIy1cwy38/3lc5X9yJ6wHcUOPH4WM=; b=Pm6rYARoAbayjWXgboBdqN3rYh
	NIjefdVbMu0n9vThQoS94qSZ81IT2T4LImMgGMcrvzKTg0QRHQP3jcP78E8IDujY2habqr++Hn26V
	YWzzF0WraOICVuN1+sYKITJi0rAfy3k0ydmaMiIyG3CgPft4yBR63ysDpBd85woAlFkKKLhTbadWT
	CIhsH4Lh6PqjDsySHZnbWBTpcVZSJnOvhRkiVpmXqj/DdWLOwFP3TFIIwi7fkVAtRrPwagOLmjdQW
	hojj4P2XTfUPE1GgYKPk2KGQzG5bgFCdsiSmpqgyemU9JQe6dXrgHBGlw4aYF8fAvZsNSCVtXBZ+G
	87TvQWiQ==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
	by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
	id 1rFthn-00DKcd-2H;
	Wed, 20 Dec 2023 11:21:35 +0100
Date: Wed, 20 Dec 2023 11:21:30 +0100
From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect
 provider driver
Message-ID: <ZYLAKvXE156fPHJ1@kernkonzept.com>
References: <20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com>
 <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
 <3f921a53-8eac-48e6-be17-43c07a0313d0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f921a53-8eac-48e6-be17-43c07a0313d0@linaro.org>

On Sat, Dec 09, 2023 at 06:54:16PM +0100, Konrad Dybcio wrote:
> On 6.12.2023 15:35, Stephan Gerhold wrote:
> > From: Adam Skladowski <a39.skl@gmail.com>
> > 
> > Add driver for interconnect busses found in MSM8909 based platforms.
> > The topology consists of three NoCs that are partially controlled by a
> > RPM processor.
> > 
> > In the downstream/vendor kernel from Qualcomm there is an additional
> > "mm-snoc". However, it doesn't have a separate RPM clock assigned. It
> > looks like this is actually the same NoC in hardware and the "mm-snoc"
> > was only defined to assign a different "qcom,util-fact". In mainline we
> > can represent this by assigning the equivalent "ab_coeff" to all the
> > nodes that are part of "mm-snoc" downstream.
> Worth mentioning that snoc_mm used the same clock as snoc, which is not
> obvious with some of these older designs:
> 
> static DEFINE_CLK_VOTER(snoc_msmbus_a_clk,  &snoc_a_clk.c,  LONG_MAX);
> static DEFINE_CLK_VOTER(snoc_mm_msmbus_a_clk,  &snoc_a_clk.c,  LONG_MAX);
> 

Thanks, will try to clarify this in v2!

> [...]
> 
> > +
> > +static struct platform_driver msm8909_noc_driver = {
> > +	.probe = qnoc_probe,
> > +	.remove = qnoc_remove,
> > +	.driver = {
> > +		.name = "qnoc-msm8909",
> > +		.of_match_table = msm8909_noc_of_match,
> > +		.sync_state = icc_sync_state,
> > +	},
> > +};
> > +module_platform_driver(msm8909_noc_driver);
> And you may want this to be a bit higher up in the food chain!

I would prefer to keep this as-is for now since this is what it has been
intensively tested with. I do have a timing issue when interconnect is
configured for the debug UART, but moving to core_initcall() does not
help either. It seems like the ICC driver simply cannot be probed
earlier due to other dependencies, or due to the time the RPM needs
until it shows up.

At some point we should do a thorough review of the initcall levels for
all the Qualcomm-related core drivers and see if and in which cases
diverting from the defaults actually helps. I would leave this up for
future work right now, though.

> 
> Otherwise I don't see anything obviously wrong, I assume you tested
> this without clk/pd_ignore_unused, with rpmcc cleanup and can confirm
> the QoS programming went through without angry resets.
> 

Yes, all of that works in my tests. 🎉

Thanks for the review!

-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

