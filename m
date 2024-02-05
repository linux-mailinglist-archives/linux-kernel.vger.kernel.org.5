Return-Path: <linux-kernel+bounces-53192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412084A1E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674021C237CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF4D481DC;
	Mon,  5 Feb 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMApkbRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD9481B1;
	Mon,  5 Feb 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156938; cv=none; b=TVL2TsvfBpcdM8b1ZXOzyAKFZaCsLFbuxq8JYNwQQeOGVjrw40PsTj7wTMtz4+EX6MyiTxccWk1g3//iBALisgnPRPhJ3NLs8yqdXIY3uQuVHJgzGK9gyDk5m/fcv8Zho7UOCt/AWd/Dfmam19lG+2+0xZi89x31EZLRxUbRqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156938; c=relaxed/simple;
	bh=nmCN9F4V3Q87GixPq9VeXFDsHOAxfspOp7xM3WpI5IQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=hKCYh8RgzF4+1c2FJv6cnTT/Mo98ZPigd/VWahYkiQICHIPsBE4r0DzZPe5psXcdmfzhTAGbr5DXpW5uV4LC1JJULeduYjzOrSdlSCJa2RbZCbBKjVNrDkAaJRkAAe1xvDFzD317tZb5vFZ7QYsEAnNjvPmrhXo4gvHc+u7mKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMApkbRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFBDC433C7;
	Mon,  5 Feb 2024 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707156937;
	bh=nmCN9F4V3Q87GixPq9VeXFDsHOAxfspOp7xM3WpI5IQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rMApkbRZo9lmpWL/Qxvy5QmaNQYqmpn2SaxNZdNnfuUGi6cNODSgZq5sTAzvCjIKU
	 Cb/4o60mh7raJRAARfluwqxWFI3eGEFpVDv6raxgArwMlYJbnyLUMaFCReHUE+gNGu
	 UVYW5q8BOTWgv3k568vDZyCFpa6++J0rzy2joUWfk1x+uW7gy0WpVVZyVkmjIiUecJ
	 sieU1FzAApe1khXLUh1h2jMtEwbWyPWHSg4JJt5eWofvXm4x7ioT/OpRDJkyGNN10n
	 8IqaA/SwD/QuGt8kWuGqcTkyDzYJ9A9ROJcK9edrpGUvdrDPcRK/bff9QWQqft/39m
	 31JggXZv8wnmA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240126075336.2825608-1-alexious@zju.edu.cn>
References: <20240126075336.2825608-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: alexious@zju.edu.cn, "John W. Linville" <linville@tuxdriver.com>,
 Marcelo Tosatti <marcelo@kvack.org>, libertas-dev@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715693385.1586694.8942581336995921583.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 18:15:35 +0000 (UTC)

Zhipeng Lu <alexious@zju.edu.cn> wrote:

> In the for statement of lbs_allocate_cmd_buffer(), if the allocation of
> cmdarray[i].cmdbuf fails, both cmdarray and cmdarray[i].cmdbuf needs to
> be freed. Otherwise, there will be memleaks in lbs_allocate_cmd_buffer().
> 
> Fixes: 876c9d3aeb98 ("[PATCH] Marvell Libertas 8388 802.11b/g USB driver")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Patch applied to wireless-next.git, thanks.

5f0e4aede01c wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240126075336.2825608-1-alexious@zju.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


