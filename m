Return-Path: <linux-kernel+bounces-33758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686AD836E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21306284125
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E44C3B2;
	Mon, 22 Jan 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWv1opR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98593EA75;
	Mon, 22 Jan 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943621; cv=none; b=LLODi67vTvky8oMqo6pawNi3dpjKzK2soglrk0h0OxzYigFMAbV8ge3H8SlfzVqKTrtprJO9rTB7P7b5ubadrZFcOhKqH9sQPE9fWwbUazfrf45+FeDNvzuPF8fTVQZs53xZskFEcqB8RVVZlBu6Wrnx2yps0gnx4ZHNeZCwgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943621; c=relaxed/simple;
	bh=bTxjd+qZSv1qFxwXubj1oMBpkIEEgxymwDM9Dh+JF6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1NX+wNgCeDCBVT5cPs2B1qF0+1SCi53A6mIXCdYClWoS/HOgh+iPM+cmGSvRxAkw5AVTwK1oGjwmMllBbmt3G6WlpW6JwB9JKfqKlg62qKyhwimdS3zzVtE1RX346VSxgbnzWnnEMWLsrUFvH+IKsRz+GgHIDHHeCFHpk9uxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWv1opR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649E0C433C7;
	Mon, 22 Jan 2024 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705943620;
	bh=bTxjd+qZSv1qFxwXubj1oMBpkIEEgxymwDM9Dh+JF6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWv1opR2q95xCpR0+3/hSNvNDyw56ylkajM5zYiRbcsJ+lWi18mTHAzOW2WRdlm2w
	 rC8tazrjEsZd+l/QI04MEFtVlQ/4c4D4iQey7g6MLZryV6J35Lr7JYRgyIUSHLfKoD
	 10H5hp7Ycm/nKHiibOTCpi+KvW7v7VBhMHoZmwyo=
Date: Mon, 22 Jan 2024 09:13:39 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: Re: [PATCH v1] PM: sleep: Use bool for all 1-bit fields in struct
 dev_pm_info
Message-ID: <2024012230-attitude-diligence-cb4e@gregkh>
References: <12380944.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12380944.O9o76ZdvQC@kreacher>

On Mon, Jan 22, 2024 at 05:11:26PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> For some 1-bit fields in struct dev_pm_info the data type is bool, while
> for some other 1-bit fields in there it is unsigned int, and these
> differences are somewhat arbitrary.
> 
> For consistency, change the data type of the latter to bool, so that all
> of the 1-bit fields in struct dev_pm_info fields are bool.
> 
> This also reduces the size of struct device on my x86 systems by 8 B,
> from 1120 B to 1112 B.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm.h |   32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

