Return-Path: <linux-kernel+bounces-33848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CFC836F78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C431E1C2772B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301046547;
	Mon, 22 Jan 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ACLB1y0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596746534;
	Mon, 22 Jan 2024 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945300; cv=none; b=RIZWzOFQfpmhfKCiYMgwJQ89cqKE2FiFAzinoW+KJpmQrbz7mTz6ufGirsAWmEM4TckeK5/xISzxFaaHpwPDjWDb8CIeSaqnhIb/1wjQTnNYH4NUoVfudOeuer0d5Lzaen8PZAylg2vsRdc+lM3NIVi7KxQ7c59fYV2cveXKSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945300; c=relaxed/simple;
	bh=EjB54Fiuvky1GDd2UuuoLzSaTR4idN7GX5Je3M57nhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umCtwo1eJr/PozBpITK4fW7C7PQwrCVVuRR9yol9S7JYb268HZamzIOL1FWdrMs5Ygzv85jilaZw2PFE3izyeo6pIbBxbJhmX9qdEGmuWzAwJwSrXSkmMn8UMz/z+qo2yprrBUIfzFG2QSVeG6cx6kjZWuxASqfUVp3B3hzFZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ACLB1y0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1CEC433F1;
	Mon, 22 Jan 2024 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945299;
	bh=EjB54Fiuvky1GDd2UuuoLzSaTR4idN7GX5Je3M57nhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACLB1y0XJWt7hI2oMVBuNN3bYiNC15yy/6Qq3gBj8pXjbs5BmnUUkW0sBad5KtcXv
	 EYoT3V7XVJpQ2tnhpefJ58y13gx8deGhPBKsQbeJ6vYCx6EzmcYp9due6WtM0hSKxb
	 4padF4ADH4UZJ4Q6nv1umPlhfZlXJO2F341PWwPk=
Date: Mon, 22 Jan 2024 09:41:38 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "quic_charante@quicinc.com" <quic_charante@quicinc.com>,
	"david@redhat.com" <david@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"quic_cgoldswo@quicinc.com" <quic_cgoldswo@quicinc.com>
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Message-ID: <2024012205-undrilled-those-2435@gregkh>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
 <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>

On Thu, Jan 18, 2024 at 05:23:58PM +0000, Joakim Tjernlund wrote:
> Could this patch be backported to stable? I have seen similar OOMs with
> reserved_highatomic:4096KB
> 
> Upstream commit: 04c8716f7b0075def05dc05646e2408f318167d2

Backported to exactly where?  This commit is in the 4.20 kernel and
newer, please tell me you aren't relying on the 4.19.y kernel anymore...

thanks,

greg k-h

