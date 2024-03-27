Return-Path: <linux-kernel+bounces-120259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3AF88D4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B962C4E06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5112822612;
	Wed, 27 Mar 2024 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDWU+iQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573E224CE;
	Wed, 27 Mar 2024 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509888; cv=none; b=g+Jhir92XJNeFkiNRmJE2rWhId+asD2jQsDP+KIhpZU6NIN5aKVJjxaZ6V6EMljCR6qpwMKVl8vZN8hY+br9E8Ha5zKzKXX7h4GdUoxScwt48g3Ltlu7fzNByIl+Ez3kAlkud3bgAF+xZCq40Pxr5c3J5BMi8k0MF+1TZmgjxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509888; c=relaxed/simple;
	bh=swRUZHqPSAsKm7MyUronTgrU3Z74pQl10GYnHPTJqgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/Dquk20RMGNpUsnA37cKpuPzwnsagXflVjNvn3A6doabxAvWfou4nCZg3FgV4m/7+tx3N61FaDWpEHdNCNIRDR/ZtUof1T9Mhg9u6jiDU9pLHKP/Ly/rLAVfcWuBAjX01qGO4WRxGg6yYDbclWQigJGdk0T/Ep3GnAbWWy2f60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDWU+iQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9040FC433F1;
	Wed, 27 Mar 2024 03:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711509888;
	bh=swRUZHqPSAsKm7MyUronTgrU3Z74pQl10GYnHPTJqgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDWU+iQWknd4MzlIneS396FveeIUkY+T2YYUwQ3Tyye/yN6k9jEyS2N9czQaCrill
	 P5LvgTSi7NrLrcjtz/B6qeJRzD/5WeRahq+cViGih42x5cPJ/Fz2QC54Q41mkXpLh+
	 VYk6Hp/tuY//j2mTseUXSIkfjMHlxc+rPrmICcGBUX/EorrFeuNoeNNxgnfM5MTOpq
	 Udx4Ua3e9C00tKCceySUDpW1duQpSFbIgZuKv67IFL2UMzEYXj+lvW5w0xOmweTxW7
	 TjDnk5SClokhNiAkf2pLvHfg9uvUrAxJQezaeHxULgnPzcodXfhp6t42p31lijeLXk
	 demyyvsilfIDw==
Date: Tue, 26 Mar 2024 20:24:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>, Michael Chan
 <mchan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>, Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next v2] tg3: Remove residual error handling in
 tg3_suspend
Message-ID: <20240326202442.6e80cf1a@kernel.org>
In-Reply-To: <20240327024430.GA1370891@maili.marvell.com>
References: <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
	<20240326183544.488242-1-kiryushin@ancud.ru>
	<20240327024430.GA1370891@maili.marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 08:14:30 +0530 Ratheesh Kannoth wrote:
> > @@ -18090,7 +18090,6 @@ static int tg3_suspend(struct device *device)
> >  {  
> Please address Michael Chan's comment to make this function return type to "void"
> instead of "int"

It's used as a callback in SIMPLE_DEV_PM_OPS(), how would that work?

