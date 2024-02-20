Return-Path: <linux-kernel+bounces-72891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62F685BA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C601C23F27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE4664DC;
	Tue, 20 Feb 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmHoVCMA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49D664BC;
	Tue, 20 Feb 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428039; cv=none; b=RMFx/74XsfMpXCmtwnvzCY1HcVrdmg5tAeeqUahtrOVJc1oB/Ybqjx7Apz3rJlsKPrN+2A2p6qEI9bssPzqxLkpdSevii3CGgk6W5mBOfLWD+X3QpigN7zDl5C56A0DBEyl1z0FvEzuhwy0433Q6apmeup2vInGDl5T2hbEvDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428039; c=relaxed/simple;
	bh=nav7JNLAJsljQhBqRSxUScFf80l0X4KVVYdgjcPHv3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVnVGY7vMYHQIonlrLk7AIuF5I6L9m38863CHRGXMhCu+f6z2LCNhOAtKud5G2aFqPGJeigEIkhzzHDsWnGBMpNn623g0J8JTA/MQd4bXs0dZ3Zh3g2LobqYVfzp+/8pdQt8fuerTHeT7+40nMzPZh5Vqb9pfIPBii+IZEi+xgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmHoVCMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26F6C43390;
	Tue, 20 Feb 2024 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428038;
	bh=nav7JNLAJsljQhBqRSxUScFf80l0X4KVVYdgjcPHv3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmHoVCMAjoLlr/csoW4DNN7PwGhpUrGBcZpQiXniD1BXMpERzwXV4lSI2DWbgg4co
	 yuKo2fQowzqbb6BBOS1sNUQ7vSQE3W0vIRRCC8mZYq9stuews4IdwRSmZNc37eXBez
	 oDvungYZJSq3koynq3gt3Wf0T99XruNdsAjWY3/khyidWjFdCkGs4o+RcnomlOfjiM
	 X+CW7SqAoVSxIK7ZrQtJOB+zY+0wAm8Wd/oz2br+Dwkmbs8jS6PirMzy9kiRSbW9Fk
	 8yiutcdEmzC2bR6cRqJQdxstpyVF12nutL+hhNQuouRQd6v3UtNnt4dWo0JpHi2G9C
	 qxhUqLgf6+yOw==
Date: Tue, 20 Feb 2024 11:20:32 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-ppp@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/12] net: bridge: constify the struct device_type usage
Message-ID: <20240220112032.GT40273@kernel.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-3-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-3-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:25PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the br_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


