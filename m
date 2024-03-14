Return-Path: <linux-kernel+bounces-103138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2287BB7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B671C20F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC96CDB6;
	Thu, 14 Mar 2024 10:40:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5356EB49
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412858; cv=none; b=OELjq4ALiRhPl9gjms1Pt4ZAqRVRESwHZjv2zxamEWJ/sI+SgqVAfmPfIB5ohM2oc5NhuihiDJiFcWP1SJrw2esyq1h6taq/5GF7R5DTv+txqJ1TdR1Ovgyk7rmTNqsgZjUxOLqjCZtpg6lMGHDx+DRLf5g5hJLBCBcKW/K8i6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412858; c=relaxed/simple;
	bh=3Uu+DDKFl8I6QZLxbU1n7j7cxGoRwBqynxfwwny0T/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyfVrhvUDvArewvRVh71/QhEK04miIz6MrQF0/aPVH6mY39UNPsTtzTWondhzzZT+qNKgq90P/BI03GztmhZPONNY8dR7bdDG01YGMKQ+n5VirHeOutAOHYT/Pj3BM4nssCLTRzQo5TOo773OZ9z9kErrVUMEvmvMsSEnK10+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0E9EDA7;
	Thu, 14 Mar 2024 03:41:30 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CC3D3F73F;
	Thu, 14 Mar 2024 03:40:53 -0700 (PDT)
Date: Thu, 14 Mar 2024 10:40:50 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viacheslav Bocharov <adeep@lexina.in>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 0/4] soc: amlogic: add new meson-gx-socinfo-sm driver
Message-ID: <ZfLUMoN_ZU-xLfpA@bogus>
References: <20240314070433.4151931-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314070433.4151931-1-adeep@lexina.in>

On Thu, Mar 14, 2024 at 09:59:50AM +0300, Viacheslav Bocharov wrote:
> The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
> unique SoC ID starting from the GX Family and all new families.
> But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
> chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.
>

How old or new are these SoCs ? The reason I ask is that it is really
sad to see vendors still creating their custom interfaces for such things
despite the standard SMCCC interface SOC_ID introduced in SMCCC v1.2 some
time in 2020.

Hopefully they migrated to the std interface and just use the driver in
the kernel without needing to add this every time they fancy playing
with the interface for no reason.

-- 
Regards,
Sudeep

