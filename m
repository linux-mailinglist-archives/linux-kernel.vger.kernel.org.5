Return-Path: <linux-kernel+bounces-48496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF5845CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA0F1F28BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3D5A4D4;
	Thu,  1 Feb 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMSzLDGQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41D5A4C8;
	Thu,  1 Feb 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804074; cv=none; b=PjDf/JeRYwhLyD0+ylcKlK6AMGwYgP1iuJ2OdfuPMU2CI21pyYf/6IKFgkJAUwYMKXRqkYAnjiBD2TbLxOOR1GzD4vEszf3dK9eC2fAhpzRSY59rwRWvOOYeE3mnW4GJSp1DR22ApnwtvE68I1jYSQnTFt0OuY2MmTHuB8dwuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804074; c=relaxed/simple;
	bh=fL+mqoeAP69Ozy0K1qxjeempqX3CG58iRFcZX/I0owM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr+6VtMTP874b+uFK68Rj8L4osY5aGplqZ/M/neplO+uifxDV8j9jPbZd4QTKWlXdF8z94U7SkK4IHiUidNfAQ5gPUyAcQRthRXEeHZ+ND6whemUjoLS2oiDxwJpPgorScCMPae7mU2uQGTLYh4JiYPL8NwHAfUBp0QJGJARP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMSzLDGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3836CC433F1;
	Thu,  1 Feb 2024 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804073;
	bh=fL+mqoeAP69Ozy0K1qxjeempqX3CG58iRFcZX/I0owM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMSzLDGQwdu+tn3RMp5EMyuGOb0ezNNMVQu9Q9KWIn8WZO3NOueR4LXGwmHxMVd5o
	 6fPIIicVJzYyieMLvLJwK0rVpxerY4o0WCGbpaqI5wjMvHjsRggPOUi/7gnCI1hyN0
	 YEddoH454pqLTf+KnqNNov62LiBi8A1MLIMe9s6YzHaMNmmc/NdBfQMaIh//v7vtvu
	 EWEIu14guJB3DS5BIqJM5OB7hgvjo+M/obCZrUIbxje9tash+Ppq1EikglfiBwv/pJ
	 400++ONXl1kmmp3JEcoYHFM2jy7tzqTblt28f0Vei4vRWacvKsRUIe7CvbOsSKNmqD
	 jXhTibztvtv4w==
Date: Thu, 1 Feb 2024 08:14:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: dqs: NIC stall detector
Message-ID: <20240201081432.3fa70c6c@kernel.org>
In-Reply-To: <20240131102150.728960-1-leitao@debian.org>
References: <20240131102150.728960-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 02:21:48 -0800 Breno Leitao wrote:
> Breno Leitao (1):
>   net: sysfs: Fix /sys/class/net/<iface> path

Let me take this on in, but the other one is not a fix,
so it has to go to net-next.

