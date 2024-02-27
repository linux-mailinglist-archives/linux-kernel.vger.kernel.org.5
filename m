Return-Path: <linux-kernel+bounces-83374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AAC869644
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D6A1C20D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7A313EFF4;
	Tue, 27 Feb 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQrFWlet"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AC13A26F;
	Tue, 27 Feb 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042989; cv=none; b=UXNFnRzHyIPGsvkF7Xx20UflY/zHK3oarDmtTPnmfnrDGScGA0jr/sg3XK/7CrS2okdMZgHHs/biSoZ0kY4TeiqxQL1wThwkUCM9K/yYRvP0TP+wdeM5maJf5ri4cbxeU5euiLIn0citOiRpNyLYzx4hki+Db/RDzqSgcYDx66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042989; c=relaxed/simple;
	bh=wV6QZR2qT4rRd6CSyxNn9IloQC3bXp4VXdMAoWg5Uq8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QS2srbsQYX45ILQeHcmX1XkbLUNYjw/fiaQByfd63jI5WWk9rHtXBVoXx1goHSRM74qmkaIPEMOb06ZzCFoQ/kgG49KNVEC/1NTiozqJfiid1KZ3ezydD9nucGNLiAx4rOjVm1z7YckoBdMcZ0ww4Ws4Ei5AJ7e9s8IdQjxbCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQrFWlet; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709042988; x=1740578988;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wV6QZR2qT4rRd6CSyxNn9IloQC3bXp4VXdMAoWg5Uq8=;
  b=eQrFWletTNwsflYvemO5EnBkYkICjTVZ/EO2LaglZyWg+c+WCdMD4yHg
   yMOjWCuG33NfjOyEVdQPzwBMDJn/Ocd9Q59q04gcjF14zbSwtTKKcoIWN
   F/qMzJ2OiGbTTcpp+hmnUF/lqMxmOoQ9YxvuRf/I+a6Da9pFH13juHzb/
   8LKC8AbAQKDQ7p+cPP27G9Y02Gf0bRAClMThpZUeR2fwE1O0gGdWaTD/G
   OpJeAQAK9AnRdihjrDjzuHX6jcRuuhayp20cHLHybHJhbmf1F2VQXHpOu
   xeTsysAFC1AaBy4Qq4FJBXfPrlXnIiZqGtxO25gvysh91kWZPrsV0jJrW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3938482"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3938482"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:09:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="30226639"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:09:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 16:09:41 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Shyam-sundar.S-k@amd.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86/amd/pmf: Do not use readl() for policy
 buffer access
In-Reply-To: <20240227140500.98077-1-W_Armin@gmx.de>
Message-ID: <7867a727-9bdf-2e48-2a90-c1f31b312c9f@linux.intel.com>
References: <20240227140500.98077-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Feb 2024, Armin Wolf wrote:

> The policy buffer is allocated using normal memory allocation
> functions, so readl() should not be used on it.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 16973bebf55f..70d09103ab18 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -249,8 +249,8 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
>  	u32 cookie, length;
>  	int res;
> 
> -	cookie = readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
> -	length = readl(dev->policy_buf + POLICY_COOKIE_LEN);
> +	cookie = dev->policy_buf[POLICY_COOKIE_OFFSET];
> +	length = dev->policy_buf[POLICY_COOKIE_LEN];

Hmm, the next question is, is it okay to get just 8 bits instead the full 
dword (the policy_buf is unsigned char *)?

-- 
 i.


