Return-Path: <linux-kernel+bounces-124179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48B889137A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B711F228CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D693D57E;
	Fri, 29 Mar 2024 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOgKwuua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E53C082
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692725; cv=none; b=ZPq4Dt79HqSKGHktWplDAB4mESYG0rhU3/H6YSPk4dniWHkfJZV0awFpZi0Nila0t3RKBCrpcY+FPdXYA9reHPIJI5wuUs2AK9JKTgXgPmIVmqqjLG3l8ciV/Ty38hA4WdTrAOuq29bsYwFo9Wp9MrO3gVAjM7X2RMqh7UEUHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692725; c=relaxed/simple;
	bh=nViNlG+k83BRarAWiFwh0vdzjQxl1IIHESNxB85xLrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlEA/DsOsM+Zddpy96Busg/2T0rsSS2Ku8sER+qz9Mu7xQ0vpmUFaa+Th4S2y7vta3c/g+neK0XFUZzKP/Q/oIYAMqtywTvL4HSzRuRkmx2hig9axBLxT3fVW8Ryh+b9WL9vWdGRAuWMbp9KaBxYN9qlWWixYl0kD0EupUIF6qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOgKwuua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12D2C433C7;
	Fri, 29 Mar 2024 06:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711692724;
	bh=nViNlG+k83BRarAWiFwh0vdzjQxl1IIHESNxB85xLrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vOgKwuuaZlx09jwqLXxq0EJ9Yxu4+tBmKwr3XOLs/SY1KTpwOrVNJ9zwUKPLOz1+k
	 Ut2vf2ofvJlp5hKp0agF6rtLQEpMg2mWZGgsc+3qFhlzk8Qg1qWhWDcqvMN0T5wLxK
	 6yNRFMcCjwu/6300GYiE2KsLf0aOB/xtdSxd7g7hv3Wukz/UCew4Q3ZJTbvJSH3lFX
	 z+qK3wk1aUGm6iZgGVRkFlE4TZsTo+Q8r/CO0kRDeNbUwezUI9+WfZKyK+EqezgYMg
	 Lwonz8fRCNVi/xDJXXuCS1vCytCf1E9498REllcklpyefhs33bOTYgi5r57iMStJh+
	 NaT4zogz49MUg==
Message-ID: <17202690-ace2-4a88-92c2-2149f434fa56@kernel.org>
Date: Fri, 29 Mar 2024 14:11:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] f2fs: fix to adjust appropirate defragment pg_end
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1711529620-17576-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1711529620-17576-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/27 16:53, Zhiguo Niu wrote:
> A length that exceeds the real size of the inode may be
> specified from user, although these out-of-range areas
> are not mapped, but they still need to be check in
> while loop, which is unnecessary.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

