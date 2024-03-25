Return-Path: <linux-kernel+bounces-116934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEBB88A6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55D7CA0897
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A361B6319;
	Mon, 25 Mar 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGX4Menv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A484FC9;
	Mon, 25 Mar 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366005; cv=none; b=rBZ0kJrt9E+nHbCqT+6t9jmi6gckCpJ0svrxXHqizlDLhSVOVYgwcnUx0aLaKwA/TGJtfxxJQn4QjIuIqnvMJqd44yDP4HDxQnxDxKEu/T300E9d2VZm0NFgPjpQ38qEzvrMtmQe5UuDA7x7FVFV/Xz38jNbA8prcBTwArkIQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366005; c=relaxed/simple;
	bh=An2UwF9x6dgnpYqkhbXszdQ0aCLrxrPuJDtyF61zUeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+uWLGfXS5SYvki1ZM9b/5qzRVqcchGbVT8FK2ZKDKgF25K4wmZGAYNPMnBZbLzucd0w476gdTb5K5RUW159TUSc+e9esYrGaZ3jiyUtpMoTkrgmWveUY74ZCSWfQrRuCZ8Z74ffA7sGAqz5a62YCq1AYZZlGLH8Z6Kx6zs5xOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGX4Menv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFFEC433F1;
	Mon, 25 Mar 2024 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711366005;
	bh=An2UwF9x6dgnpYqkhbXszdQ0aCLrxrPuJDtyF61zUeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGX4MenvEXlJtE8QMiGtYHm7ikUnSoeQv3SFRndu4eDeI71ZcNcEDwlNznt9C+iQf
	 smSCXAlMyKAU9PqP2hyadlqXEJF7YeDQ9ELdTSJyQWQxy+Nflefq/qv7cB7b6oQc3q
	 hVjmXg0/EIXo+P9cdUk5hcfGkoNJFs03tgb9lU+wNUsGF6m7yl/KFiaI8iyT3Z7OJG
	 oNKpUbvxcTN69IPBW4wpT2sEJDSUVKJo6BmstG01fNzIj5zcx6ZYB6iwz0ultFOI97
	 P8a93moGFsNbRUehCtfw9NheioZfD36YlqBnVb7be+lDaQpvhX343YL8skJ0x5ITn0
	 OFufOtDk44o7A==
Date: Mon, 25 Mar 2024 07:26:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Song Liu <song@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.10 033/238] md: implement ->set_read_only to hook into
 BLKROSET processing
Message-ID: <ZgFfc2b6VsX_QSu4@sashalap>
References: <20240324234027.1354210-1-sashal@kernel.org>
 <20240324234027.1354210-34-sashal@kernel.org>
 <20240325010435.GA23652@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240325010435.GA23652@lst.de>

On Mon, Mar 25, 2024 at 02:04:35AM +0100, Christoph Hellwig wrote:
>How did we end up backporting all these block layer API changes?

They were brought in as a dependency for 9674f54e41ff ("md: Don't clear
MD_CLOSING when the raid is about to stop").

It's possible to work around bringing them during backport, but I
preferred to bring the dependencies instead.

-- 
Thanks,
Sasha

