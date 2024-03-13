Return-Path: <linux-kernel+bounces-101021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382087A0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09776281441
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E710971;
	Wed, 13 Mar 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ymEmdV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68169C14F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293430; cv=none; b=qYqgeQRGulgGvoRZOMr/9nWBPOb8Oz/BCUQfyTWIIEeveW8AQWk6Rm7VtoQlWuDXurGckJym1zNtTDYMQm5cjjj1yKNVVI7KcwbKPBoxvd29HXrY4mIb++8KZekpRn1vMlBxcaBiWp7vD2cTi/QIMvZnHU/oIiZFl09dyjn9B9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293430; c=relaxed/simple;
	bh=6JRE1NMP92r9jyzept6E2/RoqBDzcqGI8JbPwPSrY1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FELFFJZRVVWw3qnODNW7GrFs9f2tIJLZgf7dCYm7Lj4usuP/CduPbHy5LPa1aceZ8ir/ms6kSEcVbPr1D4oNoQHeEiFlmNh2iWzk5qSopG1JnUxWRQ2A7gyH+TqRixQ0z0nZtr2Ucc2hOWG3X888kec4YmmWs2OVEvogJsFPa1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5ymEmdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 282A6C433B1;
	Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293430;
	bh=6JRE1NMP92r9jyzept6E2/RoqBDzcqGI8JbPwPSrY1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g5ymEmdVMHEV+tgD0Wu3lZYXbBAzie4o5P+8jY8fOF1M0MQbN5JKf24N5F2//bz+r
	 FBs2kxfVsY21bPcwla5XL8xLT0qwERK4L8DrqNc+6h2oCqhtFN7Adj9yW/v40w29eO
	 W5qYqwYMYqTNoYYcxe2RBj9M+1lEVP5WoTq/Mzxlcy+c3thiAtsNz2S7s7Hlict5at
	 1pdeuqU7ue6P+8SFYqn3ytahzzD9cM7XGhwtgRCOJ17RAlzQxhVMot8/uFJeuFBagw
	 YCf86J+AMjkR5nJRI3aIu6ppK841ffxUNXJXqvkVFuSwM/RVi/2C85o4keeV65gYn5
	 7Vm+zdWI2AOWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04B70D84BAF;
	Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2 2/2] f2fs: fix to handle error paths of {new,
 change}_curseg()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171029343001.17296.13667262889763299275.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 01:30:30 +0000
References: <1710143334-27653-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1710143334-27653-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 11 Mar 2024 15:48:54 +0800 you wrote:
> {new,change}_curseg() may return error in some special cases,
> error handling should be did in their callers, and this will also
> facilitate subsequent error path expansion in {new,change}_curseg().
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2,2/2] f2fs: fix to handle error paths of {new, change}_curseg()
    https://git.kernel.org/jaegeuk/f2fs/c/245930617c9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



