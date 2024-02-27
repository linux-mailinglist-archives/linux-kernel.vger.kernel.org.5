Return-Path: <linux-kernel+bounces-83153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD99868F93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B923C284444
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8107913A25B;
	Tue, 27 Feb 2024 11:59:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63B913956D;
	Tue, 27 Feb 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035189; cv=none; b=OWYYGqiNc4wTmI/q37EI16sJOy4D/w8TCo53hw/cY/fZU+iytVMQ8ci16S6ssGHE1qbfyikpmWr67bw7RhZSBcDmf177uIv4Ni6M2jniyxwUpjlTEneBuRb6xjfm4HgbUOQhUi1xbP8qni10R2Fhe1qVMvjZLzBStoqOSAlWq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035189; c=relaxed/simple;
	bh=N+pqaHgZ/tM+tK1gUTsRz9DX/zibBkg+MJUSL9cCN5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RE6J5xeEV7CLVRx/y9A7q7z+9Wdqp2e+nirU95f1UZtv59X8lZxBeWlBTQfxFCxKvCPIObz6hnBtOHH4Mso8GalWijKn5xQqZTC3xoHLvX1qk648fhzVjjWjMXg1nwXXKrLSWFR5LMWWPeqHExYdpSmu+4USVeIl6+GFOnDOeJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FAD5DA7;
	Tue, 27 Feb 2024 04:00:23 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3302F3F6C4;
	Tue, 27 Feb 2024 03:59:43 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Tao Zhang <quic_taozha@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] coresight: tpdm: Change qcom,dsb-element-size to qcom,dsb-elem-bits
Date: Tue, 27 Feb 2024 11:59:37 +0000
Message-Id: <170903510731.167995.14511047100459065780.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218094322.22470-1-quic_jinlmao@quicinc.com>
References: <20240218094322.22470-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 18 Feb 2024 01:43:18 -0800, Mao Jinlong wrote:
> As unit of dsb element size is bit, change qcom,dsb-element-size to
> qcom,dsb-elem-bits. And CMB uses -bits suffix as well. There is no
> TPDM node in any DT now. Make such change before any TPDM node is added
> to DT.
> 
> Change since V2:
> 1. Use fwnode_property_read_u32 to read the proprety value.
> 
> [...]

Hi

I have applied the set with slight modification to the commit description as
suggested by Krzysztof for Patch 1.


[1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
      https://git.kernel.org/coresight/c/7f6860e85606
[2/2] coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits
      https://git.kernel.org/coresight/c/a4f3057d19ff

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

