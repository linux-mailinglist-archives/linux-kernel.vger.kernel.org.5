Return-Path: <linux-kernel+bounces-79791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BF38626C2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7EA1F2141B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3A4C618;
	Sat, 24 Feb 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVCvPsWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EDA48CCC;
	Sat, 24 Feb 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799157; cv=none; b=p2Jd1X/cb/N1Xi6Gc0Zq4xZYUtVA9pF4Kh4+41PxWoETi1ruobHRkMho7q4k7R4+c+UmxcWSfMSbCWTPEDQf4Mi1WgcS/cJ7epFBm4ubvLdHvTiTdACUYWBmdopIeEvh7yJmI1FbgxMqI9BRzEJhW7u5VJuS/Zgtsy/UK+DonX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799157; c=relaxed/simple;
	bh=6qIEIBbnamDZsAni6xH7hZKxfCne9tGbYo0M8AKGDio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhY2+NnKDJbcWdPT0f6ngU76UjUIL3NZY1O1ZAJANC//v3P/hAt/x3j/JfQeNL10qxutsS5MuRoRjZzGvyQg7dmHl1VRMVtIxQkX9a3N0f38O6E1NVUKSpziF9devTwv9wXQlVJBKPmdOU6MAKEiGpVkjuiPuMuAtHSOnDrAPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVCvPsWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6C8C433F1;
	Sat, 24 Feb 2024 18:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708799157;
	bh=6qIEIBbnamDZsAni6xH7hZKxfCne9tGbYo0M8AKGDio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVCvPsWZZua6/EShBz8R/yPVNFZgPS7hwwx/yOw2+RNybu73DsqPNUUIEvGMdcKbU
	 2VmM5V1TCIn7qi9VrAm4Qjr6NmvJAFBGjwSRtJpjV/2ZImtutGUiAMkAreBGvgPWSy
	 05XCSl0qXWm3JzYiITqFOv0V+5POcPJSX2th2alnJUxn97gYR8wG/BkU4ykfEynJUK
	 5WAqIVBzsHylv+sMow3TY0dBsY4WIiM4HPRWyq3UiaJJ/RKsNz96zVYLcUd8w8h/Ll
	 Apaoow/NAu3pJROifOTjB3ndsS4iAsi9Fosdhwgr7KVVF3b6G4/bpwjDkq4ixzexCj
	 CfDHhdlgmPlvQ==
Date: Sat, 24 Feb 2024 18:25:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: humidity: hdc3020: add reset management
Message-ID: <20240224182541.577133a5@jic23-huawei>
In-Reply-To: <20240220-hdc3020-pm-v1-4-d8e60dbe79e9@gmail.com>
References: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
	<20240220-hdc3020-pm-v1-4-d8e60dbe79e9@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 22:14:58 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The HDC3020 provides an active low reset signal that must be handled if
> connected. Asserting this signal turns the device into Trigger-on Demand
> measurement mode, reducing its power consumption when no measurements
> are required like in low-power modes.
> 
> According to the datasheet, the longest "Reset Ready" is 3 ms, which is
> only taken into account if the reset signal is defined.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Rest of this series looks good to me.

Hopefully you'll soon have a sensible base and can drop patch 1.
Ideal is Greg takes my pull request shortly and I rebase the tree
asap so that I can get a clean base for a second pull request late
this week.  The aim is 1 week in linux-next (usually in via char-misc
not my tree) before the merge window opens.  So busy week ;)

Thanks,

Jonathan

