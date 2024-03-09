Return-Path: <linux-kernel+bounces-98009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1F877346
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66CF1C20E01
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC1446A4;
	Sat,  9 Mar 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMmGgB5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197F16FF22;
	Sat,  9 Mar 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009236; cv=none; b=PZvx3mxnDnK4UIORREf/klwYireqihfwI6G6xevqF7CXXG6WLhPQ4K3zY9ke+2RGyQNbJGaoNIPicHI9BNhpdS83eVZQvwZw6b+0my66ravRrvvY1unKcS7LBSIhhx/ex5gLZSKKzGBSQOXf0Xs2I2+KG3fuZecMNbzTxiHgnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009236; c=relaxed/simple;
	bh=V4BVn+p29jgKIEBrnrJ3faIeVM+yxyyl+7AFMGtnH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBoh8RotpC1CyxmxQN1NIvedGL58KgzJZ/yTtRR5OlCBMBHTPyX+U60Whr2HO1COmafx5QKGlUFBae7WDb4/Zg71fqk3msVonhCj9PpeMJmJwF5udf9HuLIKQQ+/fzByBgWfO/iX83xfG6V01ZUGK520pS1obghKZXd6TEfDmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMmGgB5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC3DC433C7;
	Sat,  9 Mar 2024 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009236;
	bh=V4BVn+p29jgKIEBrnrJ3faIeVM+yxyyl+7AFMGtnH0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GMmGgB5ZGTU0byoloLB3ufSybDONQ/KEUnQHiWLD5fCXkYiMa6L+mSgxdKo5EtfBK
	 cI9K9DFxV+tv9JFybeSCZwCyPFPqbcbY8UOS5JPHveV3N7gRJzG6WMMdY62vD25L+2
	 R1j0iCmrCsnte5JNnawVZkqwhzMHJTgh/g8abZT7vUg074sosXG50YmWXbS16/5nTH
	 mjLBYnFpBj5UNsEDzctHruT9XCzNR4CRLkelIwuRoTCXxvt/hK5exeys9TJ+iN4CyG
	 h0FC344So3IiUKdBwQw2Hlnw3mTb77GKMhYWtAIIDTPAaV2Y+At/aI4PmVF3D50qoj
	 M4xMOdWiaUFaQ==
Date: Sat, 9 Mar 2024 18:33:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@amd.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] Drop casting to void in dev_set_drvdata
Message-ID: <20240309183342.578161e7@jic23-huawei>
In-Reply-To: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
References: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 03 Mar 2024 23:34:38 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The C standard specifies that there is no need to cast from a pointer to
> void [1].
> 
> The vast majority of the users of dev_set_drvdata do not cast their
> pointers to void, and the few that do so should be fixed before it
> spreads by following bad examples (which I was about to do here [2]).
> 
> The very specific cases where the cast avoids warnings (e.g. droping
> const) have been kept as they are.
> 
> [1] C Standard Committee: https://c0x.shape-of-code.com/6.3.2.3.html
> [2] https://lore.kernel.org/linux-iio/20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com/T/#t
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (4):
>       char: xilinx_hwicap: drop casting to void in dev_set_drvdata
>       io: light: st_uvis25: drop casting to void in dev_set_drvdata
>       iio: humidity: hts211: drop casting to void in dev_set_drvdata
>       iio: imu: st_lsm6dsx: drop casting to void in dev_set_drvdata
> 
>  drivers/char/xilinx_hwicap/xilinx_hwicap.c   | 2 +-
>  drivers/iio/humidity/hts221_core.c           | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  drivers/iio/light/st_uvis25_core.c           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240303-void_in_dev_set_drvdata-2d8cae908e49
> 
> Best regards,

Thanks for tidying these up.

Applied to the togreg-normal branch of iio.git.
This will get rebase on rc1 once available and become togreg.

Jonathan

