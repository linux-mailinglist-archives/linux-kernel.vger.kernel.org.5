Return-Path: <linux-kernel+bounces-9554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67181C777
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3E3B23DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB95156C6;
	Fri, 22 Dec 2023 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vuk2jPz4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0914F81
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934D6C433C9;
	Fri, 22 Dec 2023 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703238147;
	bh=z/tiJSMVWXqC12XFPo9+kkp+1TdZ2JIgbr5cdKaqwmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vuk2jPz4wh4meIIQHckwcmFm8kuPJyl+gz4ciXVFVngNDoXqmthsvyRcTtIWmG/Uq
	 g+j+tX1Ws+CWp3Mly68U41eBNwIxOhMup9AhHB+PaQp3CjG1BqFOri0IuvgX17l9SV
	 ZT5oabiFLFT+sVN4eYkkPGH09X624L2mF+sJL8zxzXcyZ288oAQXXZPEGJkgsT/0Dn
	 U0gZekzyfTMkwlA7glPNEDorrMBW7HPnTPT9vs3SZnx1vmkoUsxIpQdDj2ckSUa6Ay
	 yzmQmrgn/zeKldXavNy2dGdQSsthZ2gxMC+0CJJIAwVfjrunuO3Jiwu0rRV3Ob2rtX
	 Z87ZtduhUWhlw==
Message-ID: <e2b88b1d-7d76-4eed-9eea-f4cca188c2c2@kernel.org>
Date: Fri, 22 Dec 2023 17:42:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] f2fs: Add error handling for negative returns from
 do_garbage_collect
Content-Language: en-US
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231222032901.3861649-1-yangyongpeng1@oppo.com>
 <20231222032901.3861649-2-yangyongpeng1@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231222032901.3861649-2-yangyongpeng1@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/22 11:29, Yongpeng Yang wrote:
> The function do_garbage_collect can return a value less than 0 due
> to f2fs_cp_error being true or page allocation failure, as a result
> of calling f2fs_get_sum_page. However, f2fs_gc does not account for
> such cases, which could potentially lead to an abnormal total_freed
> and thus cause subsequent code to behave unexpectedly. Given that
> an f2fs_cp_error is irrecoverable, and considering that
> do_garbage_collect already retries page allocation errors through
> its call to f2fs_get_sum_page->f2fs_get_meta_page_retry, any error
> reported by do_garbage_collect should immediately terminate the
> current GC.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

