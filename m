Return-Path: <linux-kernel+bounces-80436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32B86686A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128A128176B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BDD11CAB;
	Mon, 26 Feb 2024 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6uxVAo6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92138101C3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916328; cv=none; b=tFicO6uSXUk/pynFbATmB366TQF2/K91F8XugkstlsWR3qVFpqvjI9VeTv3KVLz4kOVSQW98p+nNDyOz5u7v4WSetkHIXrAtJN0JM0DvKn25yCVAqflvRO0lTmdqmvoWIw9BnJqYl5AMfpOvC/XEtsSZjMUx6x/bLeN3zoVHt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916328; c=relaxed/simple;
	bh=RfBWpLaLGNc6IDMNpsE0Yy7Ub8NnNUuIZa8qRbfcZvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a6wWSEQOOVvbtchwQnY3kkeLWB5txBzy0Vi/jxb/ct2eV0MWhHOQeZhSTMweFDBPrHTUvsSQmRiELYtF8kXhA0ohmEt6nc6gKLwoduaLAJlOjTWm+yOoV9lAeh2VnBfbaoCbdLNEqzubvLmP3h1TcVAhy9HhPTB3Co074ujbIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6uxVAo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360C8C433F1;
	Mon, 26 Feb 2024 02:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708916328;
	bh=RfBWpLaLGNc6IDMNpsE0Yy7Ub8NnNUuIZa8qRbfcZvI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Y6uxVAo6kDfvR+tACBcxtJLT9K42alVgDRsv0T1vZ3t3xr4VBT3661Q8qjkvtc+/G
	 DWokoik9zZyMyWVel+RNcu7DmWBok8kyOOGWfRWtHSymUGYScIYmhD+eEBHoAPxpI4
	 DkTY02DwM8+br93DOBnnQG0Cf4lyGJ1fw/J1rF3XBhnbzMLAJKnRVLZkeAnJLTs+2k
	 4CnWA9RAzzQczzufMFeA+GpyDUpfFQ8Zu5xE7mVuOCWmxqAgxw9yGqOzw7HeJ5Li+w
	 Z0spdDPSRAEgOiDoc2s3dbk4k37qtu8kS2yEHYRP2/A4Q6+8qHjtqoc4251EfA1o48
	 bfDWyJfSOQESw==
Message-ID: <6b2854fd-8999-4671-a243-d78139f8a40f@kernel.org>
Date: Mon, 26 Feb 2024 10:58:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: prevent an f2fs_gc loop during
 disable_checkpoint
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-4-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240223205535.307307-4-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/24 4:55, Jaegeuk Kim wrote:
> Don't get stuck in the f2fs_gc loop while disabling checkpoint. Instead, we have
> a time-based management.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

