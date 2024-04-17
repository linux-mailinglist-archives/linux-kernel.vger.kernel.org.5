Return-Path: <linux-kernel+bounces-148118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0898A7DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A2F1F21258
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85A7D3EF;
	Wed, 17 Apr 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8zZj4Gg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904C29CEB;
	Wed, 17 Apr 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341845; cv=none; b=mAmRaDALmrft3O8KRQ8Z+m76umunMVwjyEkZwEfV13XibPUuXiXVa8eVxjHvfwX1M9rN/66s97v7Jr7Lz2Gyp1wMni/ymVLlDPX0D+8lG6pbxfmW+Y/ciSo4zUfsjUB8neFJEHmPQ90nsg2uXwii+3Ah5lXtcLi+uJPeLEk70Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341845; c=relaxed/simple;
	bh=QTEdJnoj/sTxJ2oxrmzVQaFX9Fj7lAqhSaplaJD9cKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlRMDYhTRjJ4HOMJfm1Fg35BADfL6afob+76AAW2wcUlXGHyHXExK8+7mom3Sn1MAUOUkOaLUe59vpGnJImlmp1wJT8QIy/CpJfA9kZ3fSmVcoklkebJvaFeVzuc/knrcLRhaF5wfNj7oHQH3kQ/RBG9uaIXblccStBV/3axZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8zZj4Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5379DC072AA;
	Wed, 17 Apr 2024 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713341844;
	bh=QTEdJnoj/sTxJ2oxrmzVQaFX9Fj7lAqhSaplaJD9cKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8zZj4Gg1NoHuTTgyPTJOtzjptzfvFvgIpA3MmwLDqRYDfFL51G6+iqxRbUJ48PLj
	 emLZbKzbBKngWKkVrmhlpn4/mWkkQwbZ/g00iUASvQi8fV+VRj83L6ByOg0ykN4jAi
	 hPdNdIjASyz7M8CPTMoWqIvxrMGHDaiDkxZtTZCw=
Date: Wed, 17 Apr 2024 10:17:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH] tools: hv: suppress the invalid warning for packed
 member alignment
Message-ID: <2024041708-juror-briskly-9c86@gregkh>
References: <1713340848-6901-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713340848-6901-1-git-send-email-ssengar@linux.microsoft.com>

On Wed, Apr 17, 2024 at 01:00:48AM -0700, Saurabh Sengar wrote:
> Packed struct vmbus_bufring is 4096 byte aligned and the reporting
> warning is for the first member of that struct which shouldn't add
> any offset to create alignment issue.
> 
> Suppress the warning by adding -Wno-address-of-packed-member flag to
> gcc.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

What commit id does this fix?

thanks,

greg k-h

