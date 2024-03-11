Return-Path: <linux-kernel+bounces-98693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F61877E09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E39281EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D692BB16;
	Mon, 11 Mar 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st0YsnIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB66224D7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152561; cv=none; b=cyEVPHGm4YQXHP4nRG0U3kCs5APWrkvgfzUTX/h5FU4A1Y3+uxJm9D2blDIsoqmykTX0jp7Tv/DXb7LkBP58uzW3ccW8JjzDDmvC2cvOyB1ctGNDXVpJO6yTOk8S8yfyckchlUF0kKdEn7hdam9qqRXtaHzPncjF5H+/nxKIQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152561; c=relaxed/simple;
	bh=NNHHZLyZv26sgBeGxvdVNmM6HJZ5hj9Zl2HSEx5V0/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+wto1cK2S6IlWeIsMf9RgKfZ52nXz9weNdeCzNRZjraqmgmgAjTVxCBR1p99dmwXC2elOVYhkZn8fF1kUd6u7M/auoclMoUem7vh3wIXRdF4u6YR4XjJT/JhHfeOwn0NJKK0FAPXoEuaITGMErBmnSZHb1mlmeCgupLogmK6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st0YsnIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B06C433F1;
	Mon, 11 Mar 2024 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710152560;
	bh=NNHHZLyZv26sgBeGxvdVNmM6HJZ5hj9Zl2HSEx5V0/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=st0YsnIN8DGk5svq78mSzUHDC3atE+DJb36P7okTncDE9FmR1rqvKST3bgJya3zEM
	 oMQJOKTyMi5spTD/HVc9cpSqAL5FO4Zr31VhUGOXZxf0LVryvMSo9DOqdT1QcRTlRe
	 roY7k3mTBTMzxitaPXdiQFaEjxbjXSRr7hPNS6iapQYlhRaBa3GYh2/Lq/+FgfSkqp
	 iisPjzvpm4Xy3y1z+vGBFVw6Uw8Hy/Fe3ssE30pj9UfnVeWNyMlNOQGWDeXe7pez81
	 Dd3GK7qpfd9PBnixfjmc702E1FZ9IDe/XYXNZE918RKD9lNNkDt4IEx+moF9+rYNIz
	 CypmM57h/jlow==
Message-ID: <9c68f756-5ac9-4074-a374-d62b6671f72b@kernel.org>
Date: Mon, 11 Mar 2024 18:22:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] f2fs: fix to handle error paths of
 {new,change}_curseg()
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1710143334-27653-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1710143334-27653-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/11 15:48, Zhiguo Niu wrote:
> {new,change}_curseg() may return error in some special cases,
> error handling should be did in their callers, and this will also
> facilitate subsequent error path expansion in {new,change}_curseg().
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

