Return-Path: <linux-kernel+bounces-28747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C98830288
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC1C1F2163D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA271429A;
	Wed, 17 Jan 2024 09:41:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60B13FF9;
	Wed, 17 Jan 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484507; cv=none; b=PSJy7CaI9v1tiKevJnNHMBRnxC9nl/NdVCMfS+mFyboKmd8OEM+vLe1wVniBIjxRq5YyWxkqoZDd8nAcfvB98cZvO3IIiL1WmRKf5vRpH1UkjAR04qr9HsLJ7xfR3glCd+n7mcXu3MC02RKffehGkMcGPLe3vMKXlVl+xwwiBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484507; c=relaxed/simple;
	bh=34o8/cCpihlSzvU1bdMHw4k+95VVwOtSxStV7OKrC84=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=BSlSFaEm22cv4hEOdijA9wReuWbnDPJ4yV94H+h932/pMwauTNJdJIG1AOMNrtmQuKGLetdpRksoA5Rh0rTkZB+2d6I3VoDQON8Dr0QfZFZX7vLriqJH/LcPyyAo/SATl0AKJR9RNtJc2qvoSFfwsKW7GgbRcjoTPL7/0shE40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FEB1DA7;
	Wed, 17 Jan 2024 01:42:30 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB2E03F766;
	Wed, 17 Jan 2024 01:41:42 -0800 (PST)
Date: Wed, 17 Jan 2024 09:41:40 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/3] firmware: arm_scmi: Register and handle limits
 change notification
Message-ID: <Zaeg1H9G5jOeOXh2@pluto>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108140118.1596-1-quic_sibis@quicinc.com>

On Mon, Jan 08, 2024 at 07:31:15PM +0530, Sibi Sankar wrote:
> This series registers for scmi limits change notifications and adds
> perf_notify_support/perf_opp_xlate interfaces which are used by the
> scmi cpufreq driver to determine the throttled frequency and apply HW
> pressure.
> 

Hi,

a few initial remarks from the mere SCMI standpoint.

Unlinke most SCMI protocols that expose domains info bits via an
*info_get protocol operation, PERF does no do this since (till now) there
wasn't a compelling reason (i.e. users)

Ulf recently in his GenPD/SCMI series recently started exposing something
and now you need to expose even more, adding also a new xlate ops.

For the sake of simplicity, I think that we could now expose straight
away the whole perf_domain_info and embedded structs via the usual *info_get.

After having done that, you can just drop your patch 1 and 2 since you
can access the needed info from the cpufreq_driver right away.

Having said, I have already such patch ready (for my internal testing), I
wll post it by the end of week after a minor cleanup, if you can bear with me.

Thoughts ?

Thanks,
Cristian

