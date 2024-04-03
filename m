Return-Path: <linux-kernel+bounces-128938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD67896208
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57DF28C65B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FED168A8;
	Wed,  3 Apr 2024 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/gD7LKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F121429B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108036; cv=none; b=PnNCcH5ACVhL8zlZU2QE7OJgfyy1ffuagVuYnhLxrMSYeBAQYx5Rypj/K0XcLgKgv4qfOKwBFAgCEFZdtl7wculMHqXUfcOxSL0s0RW94/UTk3z9Lld4vNt2E/o6xUd3sroTX6SxTZwtG21nNRFNJD/CpOUm9zlJ7VNhcFLq8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108036; c=relaxed/simple;
	bh=C8sszQNY/WLlDhKfcbkKR7fRMCxjBLqA2FWczM45YG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD+AQL5LuIV+xcEnhLefN8TZcE+0gl0wmfXUARFfHoAPN7RQm2DKhTHIrjbYSrcMlrDnYzYloyhsg0/n1CvfsTdfFMpKpHsoia1gJ4uM/qBfwJomjnWgByAuFu8GtYlf2Fj266PktYB4XWkqF1XV3Oy62tLvQlayPX0esbWdqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/gD7LKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E806C433F1;
	Wed,  3 Apr 2024 01:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108035;
	bh=C8sszQNY/WLlDhKfcbkKR7fRMCxjBLqA2FWczM45YG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N/gD7LKNv9xTOZE0YEWWY2DWR8yo/frfKk6sVSKI6Mdx0gJIXAtW+tWzxlzLVKdpb
	 +CflV6ZUqiFJDeGUrOMhQQ/EgirdI0P3UMnTk5IzEXWqKedMFtu/9KI5DKQSlsxUD/
	 7SYel0gBdfJTIvFnTGc8xHyWwwoR8qgsIa44+BZlpI0sDjcdfkV/NOYFURAbHVkijR
	 XMcspL0LS8xE5cKIIFWk7RoaJ2PJdygPKgRr+yf/GgOHmTCTXGaeOsba1d0LqeSVYh
	 eXup7BmEcGaqrcE4AYhLtr8XVVjW/fWa1+QWJZtfmGof/9p1BAfKvrnOuuAxAw34P4
	 VUuvlx+ULR6zA==
Message-ID: <dc850b72-687c-43f6-887e-7587f7593d59@kernel.org>
Date: Wed, 3 Apr 2024 09:33:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [f2fs-dev] f2fs: use f2fs_get_node_page when write inline
 data
To: wangzijie <wangzijie1@honor.com>, "jaegeuk@kernel.org"
 <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "wangbintian(BintianWang)" <bintian.wang@honor.com>
References: <2073e8995f5444aeaf7133b87ec07de8@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <2073e8995f5444aeaf7133b87ec07de8@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/1 21:48, wangzijie wrote:
> From: Zijie Wang <wangzijie1@honor.com>
> Date: Mon, 1 Apr 2024 21:24:08 +0800
> Subject: [PATCH] [f2fs-dev] f2fs: use f2fs_get_node_page when write inline data
> 
> We just need inode page when write inline data, use
> f2fs_get_node_page() to get it instead of using dnode_of_data,
> which can eliminate unnecessary struct use.
> 
> Signed-off-by: Zijie Wang <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

