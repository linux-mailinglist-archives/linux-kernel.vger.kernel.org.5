Return-Path: <linux-kernel+bounces-99740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C7878C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67601F217FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF2BA26;
	Tue, 12 Mar 2024 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFCQx0JA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AAB66B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207815; cv=none; b=W+Q2Ma1O8SezGJYU4DvnQyHMh/VYqiT/TxxC5k9R8Ig9nbIgAhGc3vMq5vojRWxiASpRblcUuLPI+W01AhBbZsTZaadpwRr2/wfvnz6od6RHvXKo6zYWCtUGF/+2NdTVaV9yNjFWN2agBxjPmE5szKaNT0AApAacI1TbPK3wmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207815; c=relaxed/simple;
	bh=LTza99Xtbwi+Bmy3Kob27BW6F74NLEb1FZWr7xFLdMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyt/JmbQTQOnoXVLJ50JoWsQtBoH4KPR277sV7TVew0o8QwvJuY8rYsQ4qFP/t+0aQn0B7klY9n6oISzc80KIl+u6iXH49ORJos4kiUezMI8FXf8f6OZdHPad7pjg2Cns6HXQoJ85j3U+XxQjgrjD1t1kTijLaZN7PtXkl6rg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFCQx0JA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24EEC433C7;
	Tue, 12 Mar 2024 01:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207815;
	bh=LTza99Xtbwi+Bmy3Kob27BW6F74NLEb1FZWr7xFLdMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dFCQx0JAtEPq2R8Cqk4acEGfo+Bf2OrJFrSQju1WQALYQHXwvxbTNDujza4lgY9JC
	 zJkfKx6Gz7AJ4ZBegt9EjDTujoIjrI+tWj465a7f1lanwm6wDygiRqOAgB8jSEj1sJ
	 4eA21fTlL6UO+95aNTZ7QDmMQ4o8j8A53zgqYfQcmi7FJSJcBPvaUCN4W0BZ/Au58B
	 EIOuTNR5GxYvHosgEW8PE/BtAZP8VzGG3iPR2wKOCrX6taEUPAF3yOeCmgLIuUxOlF
	 wIrcOeYAzBcXlWjNzJTIL1OkN/OicQGnCeekIOJTUMHoxeWxcBdsS49YtBeZeSircy
	 9HRF3tTryuc7g==
Message-ID: <0a206e73-6d93-4e86-966e-994bff627997@kernel.org>
Date: Tue, 12 Mar 2024 09:43:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: prevent atomic write on pinned file
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240311235921.1832684-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240311235921.1832684-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/12 7:59, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since atomic write way was changed to out-place-update, we should
> prevent it on pinned files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

