Return-Path: <linux-kernel+bounces-72574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E5385B563
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0B11C2130C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023CF5CDF8;
	Tue, 20 Feb 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhdp8xxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FD5C5EF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418236; cv=none; b=TtHJxwx6w0cgZP7dFLMdcHhmSXzAf3GZv3MLGy1hjKq5RFqeoUf5MwWXAp2wAV/U1q/CxX/1/7VFzedHNmh1xcmXR4OyFzLPBet5S9ACgaiEmAHWrbsLND9k+s+oORpBSO/muAPWleYcEf38ut/29au30rqKYd7wN/O4pTO+NVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418236; c=relaxed/simple;
	bh=Ew477+9Ye5FRrxK0DgYG99Q0K0VY1K3xXdDV+za3xk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uowQLyVFmHb7oiglX6+xi29qGJm7N/EkSiOmDPKyx1WVwKVwaprEpxzPyqn2jxRBnat1ToVnrhbLKvqiYY3CwU5MwT3vvpnjUReWIw+MmwzdienqgiMdKXfNTxO+DSFqBvvwPPGFxrWM5N/pGtXQYxtBgTg5pNHIwoE7EQfhpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhdp8xxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3E3C43390;
	Tue, 20 Feb 2024 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418235;
	bh=Ew477+9Ye5FRrxK0DgYG99Q0K0VY1K3xXdDV+za3xk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hhdp8xxVKBWEjwjIcv/X7LNRlkOjOaaanXdE+jXuydZnn6UCneE/M/GvoQsGlY8vw
	 b4HBtmBudFQIqHtxj2C90zEJrtFaZLc4cGFfZyvzaznfCuw5FJ4dARp8JAty6okG/8
	 tlu46L05a+aHZw8IzH3587ODdy6r8kcIxhu3G6H+9vrn4ABL2ZeoCuRTbJqSAaCjst
	 WxZWNHiMwFxpbLojxhlrh4CIZDCTHgg5FJtY4O9Grs4lAyZcAnpw0zG38zet3/favt
	 APRaSpE/x5jG/wrzTYtNX/AGl5TOw4bhdL4tH9OZY7NWN2RzAMrKImtNYjQLZQp2PT
	 WM3QAAAG3eBJg==
Message-ID: <e752ba36-285e-449f-a888-88a0ecf424b1@kernel.org>
Date: Tue, 20 Feb 2024 16:37:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: separate f2fs_gc_range() to use
 GC for a range
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>
References: <20240213173812.1432663-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240213173812.1432663-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/14 1:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Make f2fs_gc_range() an extenal function to use it for GC for a range.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

