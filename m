Return-Path: <linux-kernel+bounces-137623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B564B89E4AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AFC1C2123E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7F158863;
	Tue,  9 Apr 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UFHKvRUW"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE72157A42;
	Tue,  9 Apr 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695870; cv=none; b=AV3g9nTmBEoZ0USuVVysN9gHUHlpbu7KIYrqO2+rXwsratXoGBd8cZkZOAdJ2itXiokS5p5+HlKXMwJbpH53ZEiVPsDo/Un7meeHLxSrdZVw7RwrQJIFwosh0ck5ZqjX4mcCbDgju9r937LuyIJRWvYOHKq0nlyEHHVggOrWmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695870; c=relaxed/simple;
	bh=x9uTbMryrYRPeYaxZYL/4WdL+gBS4SrJV9Y1ktnDkeM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jR6RXY+LQlLNn/+4LMemRy2PmQGmfjF4q0FUtwB6ESMOEPmRgEMazQzO2VqSdJrNqukMlotlttpNJVRbiqHogV8YO65IamYiXNzm/S7UGqQo6CTyiOKi7KA3OWdzwYqdnY5vN6W1G2aasC9nV77edTZXt8VLuDTOx1rfzoUoAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UFHKvRUW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712695865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4vCLj0Ij2TkOJ/jGCoTYZdEj+p3YFGzHYBfUFoB3xI=;
	b=UFHKvRUWJxaMo37hD9BdfQ1YuDYUiJ5kwlV0A6uIw4FYK1WugspdqPEZm4yzPlWdnWXhy8
	ip5zmfp6NbNMBGt4VnPo4hLOYWTKpeRuzLiRPJhCbE8pPXvhPU1wfOl2+jFsB5HIMYTjfX
	S0UBzMIYrx5KyH3T+6UOi1hBWVjz2eNIM873SRDVvGA1T4g1kROS5G6j1vnSPGTDgWUR7J
	zxoJsaP63zW5dVsuz/W5T+S5RNC3iaW9dT4lBw0iO+ZKjlNtC54XXwBOiSldzc+sJnI1pk
	jrR7mRfQA/hk74SPxl1ovibsw7XDboyk2C6FcJ0PdZoASTV8CJflw4uthuiRZw==
Date: Tue, 09 Apr 2024 22:51:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: pcm: perform power-down delay checks a bit faster
In-Reply-To: <171269542042.178415.9248384379060261944.b4-ty@kernel.org>
References: <90ae761a5b99640ece48363a7099ac2cf402bd37.1712684592.git.dsimic@manjaro.org>
 <171269542042.178415.9248384379060261944.b4-ty@kernel.org>
Message-ID: <772a45aeefeb0e63b85d9af17c971e2c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-09 22:43, Mark Brown wrote:
> On Tue, 09 Apr 2024 19:56:36 +0200, Dragan Simic wrote:
>> When checking whether the power-down delay should be ignored for a 
>> specific
>> PCM runtime, there's no need to keep going through all DAI link 
>> components
>> after any of them is found to be configured to use the power-down 
>> delay.
>> 
>> While there, fix a small typo in one of the comment blocks.
>> 
>> 
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> for-next
> 
> Thanks!
> 
> [1/1] ASoC: pcm: perform power-down delay checks a bit faster
>       commit: f78bf2c933c9cb3b61215378664f83c5abd25374

Great, thanks!

> All being well this means that it will be integrated into the 
> linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems 
> and
> send followup patches addressing any issues that are reported if 
> needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark

