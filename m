Return-Path: <linux-kernel+bounces-124029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA8891162
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940E428D925
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A838E335D8;
	Fri, 29 Mar 2024 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF+h+IEq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA23FE23;
	Fri, 29 Mar 2024 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678037; cv=none; b=D0JeEgd+qYYvHXUPhG1MkyMmXQnDlB83mrK9uhjwfBHiWcm/6ZypS2zgj9kGLp46yjAe067s5AFWTiRmYVg83blqILduO+4L4QwRfsc1w/rn8bMQTIYjo1ZCp1emeuuNOj5IIjlBNji2V9VGYkC8P4ULQvx0wgJSufbx4aDl/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678037; c=relaxed/simple;
	bh=KnFsRG5uU0swr/0jv8y6Fz/zFZwoBCacd2B8giAjCcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVCdlYx2xVhmBC1GqbSahQotG2z/PMCZ2gdTsGAo3edkZ7RlETTXVjDTKQ84Fz7yc9HXcmO8npRKF1CkpN4CinkMsaOR4QoPAy2SAW+wEKFdiP8VAzq1UXJGOKWMFJBoqQY6A0YmwV5LP2MV+vCH1HNoYBcNxymj7ne4HROc8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF+h+IEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D681AC433F1;
	Fri, 29 Mar 2024 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711678036;
	bh=KnFsRG5uU0swr/0jv8y6Fz/zFZwoBCacd2B8giAjCcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jF+h+IEqR0QUUAB2rJXByyFaCEX1Bl7QVhHo/R6c7P9G8PmUL5L2CEYLDeJfb+wUa
	 JAvZCsKIKJwaDWoYKREO+k2IWXHQxQHX06tnMDO4sRsSyR4qKmGUJV/aXsSbaSjY8+
	 I76WHfpuNYxfLSASyrqD8dOG/FPEuekP7JZ+oSASwjCxxbsFsOzXifca2AvmG49phI
	 yJcdFl+BWJ3Xg4/P0oGEOQ2RAmGh65GigNz+RrfEI5Fg2OypUvb4e7UHGOPF9C3Y5D
	 5vRVxy5B3T855aF4mgrbBv19VbhgFXa0of82DC7LNrRGM9N+C6o9mw7fuMIf10LHBf
	 1gDOKOM6GEAMA==
Date: Thu, 28 Mar 2024 19:07:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
Message-ID: <20240328190714.16e3f86a@kernel.org>
In-Reply-To: <20240327114330.1826631-5-shaojijie@huawei.com>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
	<20240327114330.1826631-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 19:43:30 +0800 Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> Add support to query scc version by devlink info for device V3.

What's SCC? Does none of the generic versions fit the bill?
https://docs.kernel.org/next/networking/devlink/devlink-info.html#generic-versions

If not you still have to document the meaning of this component
in Documentation/networking/devlink/hns3.rst
-- 
pw-bot: cr

