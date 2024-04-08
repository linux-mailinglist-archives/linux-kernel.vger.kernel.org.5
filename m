Return-Path: <linux-kernel+bounces-134878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30C89B829
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F7D1C21845
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A7249ED;
	Mon,  8 Apr 2024 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzXbdAqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA172232A;
	Mon,  8 Apr 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560299; cv=none; b=PFjhTnEWwEg6wzp7l6KOosYJ+//Ba9104LpMg22DICJdwtXBpbBG6K+z2gglI5o1TysDduMmibrPKgtG8dCF7LD1/aoxT4HkbuxQiJXDxucIszdvVoxzH1/Y7WevMeL7JlfYZPrh8t4Ujh6GN63elI1HRxHiiiKMeWTDjORNTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560299; c=relaxed/simple;
	bh=pGHQpCZ+Yr6iZMOAV2LPzkSk5nqBaiHVUORfWaGQ52Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErVBf8/FUACD1gMkSZ4MErNn10mMmIxno9lGLOHU86c5YDDJ+k3rxgxXw4WW1cJHQa/cKEOe50WWF6ey1RWUR5HJv1V4UYssGgAYjlob3kIGxeb9u8RD2CotpqpT+duvTn91OH7yXwaaskzLORXif3HFRgPLQsNNTIolSs5jZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzXbdAqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB57C433F1;
	Mon,  8 Apr 2024 07:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712560299;
	bh=pGHQpCZ+Yr6iZMOAV2LPzkSk5nqBaiHVUORfWaGQ52Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzXbdAqKEF1/uMn9bULpyVGDj8Rgx3G7S12NMzUWSTRD4haErpwkYgM3bgRdXWOIT
	 nCrjmoSHpxQTY6D7aHRH3CWsI5NiEvr7qoj9KcVnfKkOqFccEayt/CP02Lyze6iOLE
	 E7I6P64lDNirO4NpIGJHwHaVjpGJ3U4OZfmkiG9UN+7q7Tt/psytCn9EB7N4FDaMtc
	 rUjD0R8LxGR1exRl8DIxtEcf4GRzzdp0MEpdSjv65WgPjbh4t7JPpl55zjPU4bCRwB
	 YJuP357YaJAbDuKklkmwKI8qPAa07U9PiSpkwwyA2GI2DlwGaqvJpkm584HGmIVrky
	 M6XAXRmDXofzw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rtjAC-000000007Ws-1Svi;
	Mon, 08 Apr 2024 09:11:33 +0200
Date: Mon, 8 Apr 2024 09:11:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
Message-ID: <ZhOYpHXz6t0fkzZ2@hovoldconsulting.com>
References: <20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org>

On Mon, Apr 08, 2024 at 04:06:40AM +0300, Dmitry Baryshkov wrote:
> If a probe function returns -EPROBE_DEFER after creating another device
> there is a change of ending up in a probe deferral loop, (see commit
> fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER").
> 
> In order to prevent such probe-defer loops caused by qcom-pmic-typec
> driver, use the API added by Johan Hovold and move HPD bridge
> registration to the end of the probe function.

You should be more specific here: which function called after
qcom_pmic_typec_probe() can trigger a probe deferral?

I doubt that applies to tcpm->port_start() and tcpm->pdphy_start() in
which case the bridge should be added before those calls unless there
are other reasons for not doing so, which then also should be mentioned.

I suspect the trouble is with tcpm_register_port(), but please spell
that out and mention in which scenarios that function may return
-EPROBE_DEFER.

Johan

