Return-Path: <linux-kernel+bounces-53631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BB84A5F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1789A1C23DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BE1888D1;
	Mon,  5 Feb 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2zG1CFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B216414F;
	Mon,  5 Feb 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159842; cv=none; b=TglY8xVnzIEaxYFhz2xxW/mPkiCa9JMtWpkgym6Ew85Zxw4yayih/2nR4ZwHb5IjMsQkxIdLPVFd6rXnEEr0Lbel5rUn83Iupi+OPEU0TPqQkMK6m6Zj+lBRE0GtZqKYpDEsQm8rFlMELhh+nLx/TxRQLlyKb4FakUF7BbInVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159842; c=relaxed/simple;
	bh=JHJpfUqaJyRZ4AI78rBIr1ZJeKJ3VKOnvFJCzFqVgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKHi+4PzIv3Hy7gsGRxdKJft1l5GtfSxddCPz/pcXj37WmwHAb8AT7HrALoeVh5ZHbcn8dePvmFNJSoFVnFouQhSlWvTpEOssiXA/jTs3qchViSP/jwguPms4ZQhA0qE9FKcg2Ufc0uP5VW+wjfYZjBl7nc0Hh1NtSKURsjx+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2zG1CFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4DCC41613;
	Mon,  5 Feb 2024 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159842;
	bh=JHJpfUqaJyRZ4AI78rBIr1ZJeKJ3VKOnvFJCzFqVgZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2zG1CFcKT3oEnya0uh3dINSsM6UsZJJO/NhVcjNIa7zOoB79x5Ihz3R3Ho+ptkqN
	 f4p4BHdxzer/HNG8cRc1CpAERDVY1Ln0QpDMl/pnoSMo/CmVfRf5mLCkl7Id63nlM1
	 BpVHL9lj7dzdc0p33/Ukj2Oqd9NHnHN6qk05K9Uk=
Date: Mon, 5 Feb 2024 04:50:47 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: make counter_bus_type const
Message-ID: <2024020541-reveler-urgency-30a0@gregkh>
References: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>

On Sun, Feb 04, 2024 at 01:02:30PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the counter_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

