Return-Path: <linux-kernel+bounces-82742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FE8688E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39ED41F25187
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC37A53378;
	Tue, 27 Feb 2024 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dljjroxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8D5336E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014788; cv=none; b=sMchoc02zxXN9gOwhWnYhTU1yrkO7sLrdMcF3u8X+4gutNQkxGudiMCMnue7DiwFVm0R+aVY2I//IFzI5AdlkH20z5liSeRxePbiy4hWR4Fx15tk4ejY/I7fxkSn9T99qAwqMQT44Gf+3EQjq0ZXlzV1b//B4ZaePOt1f4TmFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014788; c=relaxed/simple;
	bh=EwDCQ660IpA6YZkoSyNmnTjB1NTc/EFAo+lbeKBp8hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pb0irVwHV0cJSvsVfxj1tY8x1Ek3z4zKfsyzof1ruzIYgU3+L5+hLb6BOy4PZ0Jjr/L40+R+fxnx8FpD0HFV2zCzHyISebz0qa6Hqo5O3B+4it/f+BaDJn4+XjdORCvdRAl9bXegnQJ4hKoH+y2mvEvifVEui+drjr08O/CO2Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dljjroxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01686C433F1;
	Tue, 27 Feb 2024 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709014787;
	bh=EwDCQ660IpA6YZkoSyNmnTjB1NTc/EFAo+lbeKBp8hA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dljjroxCDLMbSCR9zceHBVLK/8jz2DfVbPmqSEqoG5saZIwiZESJaNsMhkikhpHG9
	 eZmqkFAftlHg24opTAky8iOGGLaJBsJgodE1hchheYrj6R/FqB2N1upCq7t/4kXiL4
	 W5sxzC42Inmp7JX5uya94EKK1UEosDNSI0j/sD9hl/Z8tlsnQ/LfvsUgC/f6ilOOD7
	 Deu8ar9JJxGAXjr1f9xJt9KkXxWCEHyaX6Tf3XETpSV1Byy3R5LMiXSDOJFxHskNpN
	 zD57hSDJtcW6KpIvIh441+iwnRuV+jWNf5bbl9ho5MKIgdsLwNMOsh17ZttEBHsC6r
	 p5relFewyNLtQ==
Message-ID: <61420716-72a0-4002-86cd-04beea52c89c@kernel.org>
Date: Tue, 27 Feb 2024 14:19:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/5 v2] f2fs: fix write pointers all the time
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-2-jaegeuk@kernel.org> <Zd00DE6mXbt509sX@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zd00DE6mXbt509sX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/27 8:59, Jaegeuk Kim wrote:
> Even if the roll forward recovery stopped due to any error, we have to fix
> the write pointers in order to mount the disk from the previous checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

