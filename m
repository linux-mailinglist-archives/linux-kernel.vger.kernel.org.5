Return-Path: <linux-kernel+bounces-65084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49972854793
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27441F211E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4E18C3A;
	Wed, 14 Feb 2024 10:54:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92B125BB;
	Wed, 14 Feb 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908056; cv=none; b=O0ULDOA9g1GxqyxAv4GnSd2m/elr6b2Ial8n13r0Su4rVoqEfVmMZgX5SSymU96M/jfiOQqPySRqjeUbkR4DPY7/wmMVRAXfau3hdiEz1yOtlEGJaqGnQaiTLi1vY4jnyOhOHNxY2CbABJBPWN+RFIo4v3nhxIcw1ekCUyt+FPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908056; c=relaxed/simple;
	bh=T72cP4eIgPr/rxmsuBNLbrsbqc47TJVvRRR+yxW7iOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSfxr56x/xmNCqK4lS8CmA1A4I57k5eL/AGmT6GmhPKe1TXnrhLvrlXp+Cpm3DmHyK+X1Pju/4KUlTJbcnnFfEBOGkrXd0WzNnTgjJglgWHW1viVpL9Yt3jamCbOTRd/aq0aX7viQYBfmnQjWWhSqAstDl/XOlKc4snKVAM3slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794A0C433F1;
	Wed, 14 Feb 2024 10:54:14 +0000 (UTC)
Message-ID: <6067898e-eaac-4266-b4a3-388db9a918fa@xs4all.nl>
Date: Wed, 14 Feb 2024 11:54:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where
 needed
Content-Language: en-US, nl
To: Arnd Bergmann <arnd@arndb.de>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20240213095555.454392-1-arnd@kernel.org>
 <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
 <ZcyW8zn14iIbn45X@kekkonen.localdomain>
 <2027d488-a245-4492-bc17-27e17af575fd@app.fastmail.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <2027d488-a245-4492-bc17-27e17af575fd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 11:48, Arnd Bergmann wrote:
> On Wed, Feb 14, 2024, at 11:33, Sakari Ailus wrote:
>> Hi Hans, Arnd,
>>
>> On Wed, Feb 14, 2024 at 11:24:41AM +0100, Hans Verkuil wrote:
>>> Arnd, Sakari,
>>>
>>> Is this something that needs to go to v6.8? Or just v6.9?
>>>
>>> Do we need a Fixes tag?
>>
>> The patch seems to be related to this:
>> <URL:https://lore.kernel.org/oe-kbuild-all/202402130955.f6uxzdCA-lkp@intel.com/>.
>>
>> So most likely yes, and Cc: stable, too.
> 
> Ah, so lkp bisected it to that commit, which means it was
> already broken in 6.5, but I'm fairly sure the bug is even
> older then, as your commit seems to have only uncovered
> an existing problem.
> 
> It was definitely working before ff3cc65cadb5 ("media: v4l: async,
> fwnode: Improve module organisation") in linux-5.13, but it's not
> clear if that is the culprit. It's probably safe to backport
> to v5.15 and higher.
> 
>     Arnd

If it has been broken for so long, then should we bother with v6.8?

I'm not saying we should, I just like to get your opinion on this.

Regards,

	Hans

