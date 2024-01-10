Return-Path: <linux-kernel+bounces-22360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD6829C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821CE1F24615
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392434B5B4;
	Wed, 10 Jan 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ypZPRcPB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F455ECF;
	Wed, 10 Jan 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704897089;
	bh=6HC5IEm/hZtyU1ep9WTyrEat/6wqniqFyQTDH7oldac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ypZPRcPBiCi4FSvhHWtelzW8Iqz7OsmAJXu7A0010JJ6IC4YdDDrk+fNTpFydaGFE
	 t7EA2TpIdOCMnxk3osEoWznAWmWcBV+Xi7sNtEHM8A4HMYJaEx7VXKITOhb2HbbCFm
	 /SwMxRVHlH5Nvh522RlG2QPrORYNanGU4a0JB6tKL6waTNC1LzLagthUKmWLKTvgLR
	 FNiNbH3NLNegRyTmigohyJidyWD8io6G4Wb30VopiBFdSyy5ePtoLkVWQPtMm7TKOM
	 EkdQcebT70VhD9Y3/0G/U6sMgTaNkqe6E5hN/Rov4hGt6WNQIMKPfkWhtrZOkvoCnK
	 X0pZ5H1nHU7FQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8C1ED378045F;
	Wed, 10 Jan 2024 14:31:28 +0000 (UTC)
Message-ID: <54f3facf-375d-4d23-9003-5ffbda2284dc@collabora.com>
Date: Wed, 10 Jan 2024 15:31:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: mediatek-hw: Wait for CPU supplies before
 probing
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, "Hector.Yuan" <hector.yuan@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20240110142305.755367-1-nfraprado@collabora.com>
 <20240110142305.755367-3-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240110142305.755367-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/01/24 15:23, Nícolas F. R. A. Prado ha scritto:
> Before proceeding with the probe and enabling frequency scaling for the
> CPUs, make sure that all supplies feeding the CPUs have probed.
> 
> This fixes an issue observed on MT8195-Tomato where if the
> mediatek-cpufreq-hw driver enabled the hardware (by writing to
> REG_FREQ_ENABLE) before the SPMI controller driver (spmi-mtk-pmif),
> behind which lies the big CPU supply, probed the platform would hang
> shortly after with "rcu: INFO: rcu_preempt detected stalls on
> CPUs/tasks" being printed in the log.
> 
> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



