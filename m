Return-Path: <linux-kernel+bounces-141769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D288A2331
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBB2852C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCABDD2FE;
	Fri, 12 Apr 2024 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU0QkRzq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26F53A7;
	Fri, 12 Apr 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885249; cv=none; b=Am4ZWW6IbtuNz9yntRj0sqUR3g8urNy2G83oPeomntNV+1zyyu5FbXrRqRJt+pPxq/dVaprobn0POz0dbTlsiH9ICGM4afkhqxTfC19sU4lovucoEMwOuiyNMkwKXH6i7UpIGfbXW6AqYS6dTY8Ncs/X7zmJ1/s/pQFtPC/NwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885249; c=relaxed/simple;
	bh=AdQR+Ykk1nVNGxNzIUVcsTFj4K/amO6Cbpouhiut5Rs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvCpsh5pPCKGF7gpG8sfG7I4lNPpqmZVO7ukuRqs2kWX3+Z8BC5yfW5sXm09u29VZpD58ITwv8Hl9tWaGPVlxeupxodCZnZQgZ0Fe67zbP95TBgOi0/Cd2655RNXIPadNVdljQUrOKKinBMaTSB/1GipAHWggoRxSk/95Ei89e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU0QkRzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEDFC2BD10;
	Fri, 12 Apr 2024 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712885248;
	bh=AdQR+Ykk1nVNGxNzIUVcsTFj4K/amO6Cbpouhiut5Rs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kU0QkRzqeWTLAnFjzj5UUdskKpbt1GilonSLA4xQS/+fca1sXaADxF0u19k2Zm0Hc
	 1V6g7zY3G1Hi+c4q0GuNXdzT4aIgrT+c0dN6MFe8u0+c1Yfp+Is3b3EWRynxxPzWyA
	 EoeOxRZ0r9xXHUTRsLSDW2D1zKbsxO0KPygEGLpLsyS9heytlQczs6HZCE9FoZ3/In
	 pIpyP88CzQOffXVjBzehAQ6O0C8p7fXx+AadkvO+OpEFLMaBJWp0NWaRRNS19M/Mv9
	 BpRXxgnl0OC/hkD9MnjpG0dCTzwBPdyac75WxNrDb+NU/Nd9HwqhB6wzQaCBpRXt7C
	 dC+FooX3aCunw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] clk: qcom: fix module autoloading
Date: Thu, 11 Apr 2024 20:27:22 -0500
Message-ID: <171288524181.749915.13370942844752795329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410155356.224098-1-krzk@kernel.org>
References: <20240410155356.224098-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Apr 2024 17:53:56 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.  Clocks are considered core
> components, so usually they are built-in, however these can be built and
> used as modules on some generic kernel.
> 
> 

Applied, thanks!

[1/1] clk: qcom: fix module autoloading
      commit: 1aab318f1e4900fac325e0d55a0591108ea0cfbb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

