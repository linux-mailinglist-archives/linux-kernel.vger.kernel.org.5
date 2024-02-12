Return-Path: <linux-kernel+bounces-61150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E2850E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D611C21B69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1FB79F5;
	Mon, 12 Feb 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9seXi69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E993C15;
	Mon, 12 Feb 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723017; cv=none; b=HyQ8qEGul0k+aCT9dKeZB7HXwlPJ2rSzpQ4QEUvR5EivavVvJKCUL36wxmtPhGthED+2rBsGbF/sMrzHUCnqoRUEGMvyt4i8b4gMkt+Qs7bl7ZR3nrUwmK3os5LoFTyJ+X3rw7QAGWOUTkZesEvjwFa282YdJVjhaHLma/xlhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723017; c=relaxed/simple;
	bh=5ZtGkjFCl6djdwxTqGPR+0NEcozcrzHsCmqfFSLMTD0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eHOvnt1bZlpc10RrJokW3Vh92UyF3+rsmRabSAecheuvQ21FLRPsKpuCy8oHvxfm90PQUwA+vOgSJ0ld01Sv5HHEFjXDt9gIv5Hcn/RAtIXLUfO+KTzshiySlhcvwYUj8wz0QUvUuiYw0jaOCykQGd232todfH5NzeiEQ0jWja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9seXi69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096E7C433C7;
	Mon, 12 Feb 2024 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707723017;
	bh=5ZtGkjFCl6djdwxTqGPR+0NEcozcrzHsCmqfFSLMTD0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=U9seXi69JQMl4nsmT/AONvOQ0c9EHp4UpTvScLv+rzzbQoWeOgA8LX0yXs0E7aEaC
	 innSf5YRFbriV152llACcZFJikkTOjfcK/mTOwUjnX/YfNCyMoJgpCYfA5Fgdzanu6
	 76BdwCPmwIOHcaUfTm0CKRAhzr/U0stWZ+nKUIm07qqcrTKzRueqNsf5Ds0mybgYXU
	 H2BEoch8BPfW1WwBK+OyT2nIenGtqJ0HmX9K0ZXVX2L7blt15QA+XHPb9j5sWxbO38
	 rXe9gZLximcsRvMBTGQI5FijP8A3gSzliGkiTq3bNi5tievMbTFxXv8F/7xBTYlISk
	 B9y3J1LQdFLfA==
From: Kalle Valo <kvalo@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  Lukasz Luba <lukasz.luba@arm.com>,
  LKML <linux-kernel@vger.kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Stanislaw Gruszka
 <stanislaw.gruszka@linux.intel.com>,  Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,  Zhang Rui <rui.zhang@intel.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Petr Machata
 <petrm@nvidia.com>,  linux-wireless@vger.kernel.org,  Shawn Guo
 <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Manaf Meethalavalappu
 Pallikunhi <quic_manafm@quicinc.com>
Subject: Re: [PATCH v1 6/9] iwlwifi: mvm: Set THERMAL_TRIP_WRITABLE_TEMP
 directly
References: <3232442.5fSG56mABF@kreacher> <3757041.MHq7AAxBmi@kreacher>
Date: Mon, 12 Feb 2024 09:30:11 +0200
In-Reply-To: <3757041.MHq7AAxBmi@kreacher> (Rafael J. Wysocki's message of
	"Fri, 09 Feb 2024 15:10:24 +0100")
Message-ID: <87eddif8cc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the iwlwifi code do that.
>
> No intentional functional impact.
>
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For wireless patches we use "wifi:" prefix in the title, if you can
still change the patch please add that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

