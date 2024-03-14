Return-Path: <linux-kernel+bounces-103013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA4C87B9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1970E2837E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE76BFA2;
	Thu, 14 Mar 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8oFIJAz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988A6BB45;
	Thu, 14 Mar 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406600; cv=none; b=lYz/l5lXGcHkIWv7HUBmbOaSr1V/oUEdvknUMStak6sBNrkSVF6dkxNR4KC/IhSWvurlIzmUYSdr/UByTcJr4ayGijvpLksjPIKu65pZtSPjaMnblmLw8u9WcnyhHJv6W39iVUIBv0bQcG45xnWZaP2f0W2X+Hk9Kt9cuL9NfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406600; c=relaxed/simple;
	bh=Py12VRbMdvVtfACD906rKN/O+uZfySHQwj9jlidK6BQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=G3HNFa4nOcFWyAEhtbMLch+7aHlYyhXRHfllRWdETgPyIx2JcOdCjFypgleSh6kETEIPnPgEUlBOtb938wTo+meZILMrIgCEkHVchV+qF9Q9w2qr4jcLWYhJBAY/rqKLDWImKNd7QhuVAaPIWxiGbTPAO9xlGNK5bj9bSw4VULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8oFIJAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C60BC433C7;
	Thu, 14 Mar 2024 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710406600;
	bh=Py12VRbMdvVtfACD906rKN/O+uZfySHQwj9jlidK6BQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=a8oFIJAzxiH4GpOSFGQVCtrCcnaXB9VB9CT7nBejXkRsL0OSFYgHJ6/ldVCRAmo6H
	 oKsPB9hYigEfgXXqk/PT5F/4XoDVYeD9veC4VDmHK649jguTFhhHtjr9KSutwuzzyI
	 W2Xjtwr7TZnY3WIRH1gYLgavB4CtBpT79rnDaUIn97F5QOTJAB/3g76ZMMYeQGvtNf
	 wiUs1mzJTIegjmkbfNqqWkZZDRpohUzIOa+JqPZHC4HZul62T0u/iUCId/AxkD4+hd
	 MG5nIkcxzd7lTLl/Jk8LWhjrVCxuwcUs4A2UQW2lhDG4EfmXpUQhOYbvNK1j0O5TbO
	 uXahCjWNrIkyg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: use "break" on default case to prevent warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240313001305.18820-1-rdunlap@infradead.org>
References: <20240313001305.18820-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>,
 =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>, linux-wireless@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>, llvm@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171040659685.2399140.4522460188387409537.kvalo@kernel.org>
Date: Thu, 14 Mar 2024 08:56:38 +0000 (UTC)

Randy Dunlap <rdunlap@infradead.org> wrote:

> Having an empty default: case in a switch statement causes a warning
> (when using Clang; I don't see the warning when using gcc),
> so add a "break;" to the default case to prevent the warning:
> 
> drivers/ssb/main.c:1149:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
> 
> Fixes: e27b02e23a70 ("ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403130717.TWm17FiD-lkp@intel.com/
> Cc: Michael Büsch <m@bues.ch>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: llvm@lists.linux.dev
> Acked-by: Michael Büsch <m@bues.ch>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Patch applied to wireless-next.git, thanks.

6c700b35a534 ssb: use "break" on default case to prevent warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240313001305.18820-1-rdunlap@infradead.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


