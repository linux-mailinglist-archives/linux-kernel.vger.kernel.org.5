Return-Path: <linux-kernel+bounces-142008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2758A260C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031C6B22B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD21C6B6;
	Fri, 12 Apr 2024 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WeqD9saA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F841BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901474; cv=none; b=JHagaL+5qBaKHgUto3po2zEX1qtqxIEqmWnPp37FCKJvDKwG6CVsSg8PrNslQsZIBq9xF0onM9mWxVh2Yyu+NjyZUX/PZOIjca+HMEGb4mO5Zn1Pi4oCYusUwtJ+aVdm4I7L9tL6vAeof89gZyf13tbX+KhiP97vpHLQD2AG9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901474; c=relaxed/simple;
	bh=oJPkC238Iod2FQetv56pnlrxaJrm3LWtaawuw9o0MVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtftOKzRT3swmINdoSDM86Ppq2jbAUr6PelB0K9h5MquCH6QGAvmKEz0hPStQa2mcJTqv5Oox/eTXZe27jl2hRVAnIujGTP6vVkNm8lj7wWmq7KrsUgpikvPRm26xBakuuXnv/CQ5fycri8Dg6vLbdfMACNJuzej3YQx1wmcejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WeqD9saA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F60C2BBFC;
	Fri, 12 Apr 2024 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712901473;
	bh=oJPkC238Iod2FQetv56pnlrxaJrm3LWtaawuw9o0MVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeqD9saAgaCVnrAkxKLY7mjJIezKB5Pj1tIc5AsvkAPV+fqpKP2ChOf+8Yo2Ts9b6
	 Nccf+oANHBHy+cH8f1NobpK9l2tAgCAMN9tmg0r1NVQaqIDmyFtqLjg3/w9anEiUOO
	 IEjBQVdto8cbZddzU0xUiCzD1jLdFan69HryHhvU=
Date: Fri, 12 Apr 2024 07:57:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] misc/pvpanic: add support for normal shutdowns
Message-ID: <2024041240-twice-deem-16cf@gregkh>
References: <20240412-pvpanic-shutdown-v2-1-5e544417bc17@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412-pvpanic-shutdown-v2-1-5e544417bc17@weissschuh.net>

On Fri, Apr 12, 2024 at 12:03:57AM +0200, Thomas Weiﬂschuh wrote:
> Shutdown requests are normally hardware dependent.
> By extending pvpanic to also handle shutdown requests, guests can
> submit such requests with an easily implementable and cross-platform
> mechanism.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> To: Arnd Bergmann <arnd@arndb.de>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> Changes in v2:
> - Drop RFC status

Nope, still there :(

