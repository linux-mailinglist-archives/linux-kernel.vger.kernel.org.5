Return-Path: <linux-kernel+bounces-141755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0E8A22F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE161F22C82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBEF1FBA;
	Fri, 12 Apr 2024 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYIhgFQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249A17E9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712882129; cv=none; b=JNZUf2plqOfhT8VQ2C+tMgUOEsDrotKwXyKMpApYm54J+m2hdVgO8uhCHhN/DSRxYwaEuhWnYf826CdqlJcOH53+pmocbUIF9lwbVIsLo1GSIjC8aDOYLvqleG95FyRTqsR4u3z485tJlJyGt5aKPiCpdXo+Of+J6bIh38olKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712882129; c=relaxed/simple;
	bh=Zd0UnFAEVBYqLc+J6a48EFFUgrWUs/hzCkKQ2PDZS2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqLZSAy94wuXPtpysOxfKttlt4o+XvGyAedaEtnXVArVk+Jo2OhtCm0+7MolgvL29iLZMXHWS0yvcqcY+6bVqg/LZ2cCF2SA9NQ4PE3Pr/sTBhqgPcF5q6DQ+XM/6ybGYe8GPYaQa27uoqVARypzUMEvaQ14XlFQDZF1Q65a6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYIhgFQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14897C072AA;
	Fri, 12 Apr 2024 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712882128;
	bh=Zd0UnFAEVBYqLc+J6a48EFFUgrWUs/hzCkKQ2PDZS2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYIhgFQIiT4iU75zL3wCYTbWNWJ/nSFuIdTCPwelmcdDqb+wV5nzItJAoy2tC0M2T
	 66atD6/HhXNVH47sP29ioke+bUdnd6piQqIZMA5G5LxA6VaJ6xjxq8k/Pb+PR2b7bI
	 ptVq2tMkZiURcQA3QKMeXnO1bQ535zAilkMduhbwffK7KaZM05XEnFBKlx+2sx0eXc
	 I4KukZFIuNi5BQn8phHt2clbN6hKs9jPyO5AsfenqsVBsTz93A7q6PgJvbk9i8O6uJ
	 Pfr3cS2+vgh5NVqQQHG5Dnt7pP2dT1xl+BSYN/Ibzj/z6XX5yL9jI1dnfQZN6arLwd
	 9F2Wym3OmgHQA==
Date: Thu, 11 Apr 2024 18:35:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6]  nvme-fabrics: short-circuit connect retries
Message-ID: <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-1-dwagner@suse.de>

On Tue, Apr 09, 2024 at 11:35:04AM +0200, Daniel Wagner wrote:
> The first patch returns only kernel error codes now and avoids overwriting error
> codes later. Thje newly introduced helper for deciding if a reconnect should be
> attempted is the only place where we have the logic (and documentation).
> 
> On the target side I've separate the nvme status from the dhchap status handling
> which made it a bit clearer. I was tempted to refactor the code in
> nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
> with something nice yet. So let's keep this change at a minimum before any
> refactoring attempts.
> 
> I've tested with blktests and also an real hardware for nvme-fc.

Thanks, series applied to nvme-6.9.

