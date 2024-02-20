Return-Path: <linux-kernel+bounces-72410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3485B2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10221C2240A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF859173;
	Tue, 20 Feb 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq4C/18l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181059149
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410539; cv=none; b=RT2i6RRQP0lA8v5pKuVeYoZNJEaqDMB0oJaIMk6BezBRc1c0l7qiYVnooJvM9W3+y5KfDICfS1TRXPteuAoLlNDuoYbZJxrnBAwyDN+icVk5eFHp6tc0VwQEmPHmIjdldmkJtnNT/VA0lQsIJwwEvhkIqIr/pzpri5DderSYJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410539; c=relaxed/simple;
	bh=Ikjos80Zh4ll9+FUW8GvMvm0wxmlexe33zUqOA66Oe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSYRttsY0lpnKoxtyMBwkQK9VC/sBjuvTN4x/c459eR1/X5sm+jumezzXteyBptskuFuX5L9LvvkprIa8uuu7u8unwZ6awSApUNfdXuAKMpGLDuFByAjFVkSxce/m3V0Z+2c/kWp+BF79uFY6JeXJTLeNQGoyWgBAKhXSCbsJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq4C/18l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4BEC43394;
	Tue, 20 Feb 2024 06:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708410538;
	bh=Ikjos80Zh4ll9+FUW8GvMvm0wxmlexe33zUqOA66Oe4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mq4C/18lAi4M7zsAm4LZ/+yCdlf1E4TTdePQzBVcrGiEM+51rNbUfT5llkiwyaf1J
	 zr1YL0j+kZg6cFhsnRDru4TiXgAmO7KYH8XEY6ZiTk02lt6g10Sl9NTOMUGolUH/dO
	 xmqd8eGOWpIxMrYpDz8Dt+KNJzDdTgFe2Qgplie2bR97Ch2y1l19N24fukS2hSCAfQ
	 Pa29ZgiUyrKTELJqSUsPEvMys4IYsE1fjjJ/zv64q+OkP7bm9y1GaI9aTDUTJc3KK4
	 GHSCH3eIhi7BVWXEu+waTfomTQeNlJZZxCSqkig/jfvDZqZslAhNbblSxo76ViR9Mh
	 +3y2WG+i7YfJg==
Message-ID: <3c8a3170-3a73-4c97-aeac-0d86356a0f03@kernel.org>
Date: Tue, 20 Feb 2024 14:28:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] f2fs: stop checkpoint when get a out-of-bounds
 segment
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1708409484-27326-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1708409484-27326-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/20 14:11, Zhiguo Niu wrote:
> There is low probability that an out-of-bounds segment will be got
> on a small-capacity device. In order to prevent subsequent write requests
> allocating block address from this invalid segment, which may cause
> unexpected issue, stop checkpoint should be performed.
> 
> Also introduce a new stop cp reason: STOP_CP_REASON_NO_SEGMENT.

Can you please adjust f2fs-tools as well?

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

