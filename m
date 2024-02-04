Return-Path: <linux-kernel+bounces-51677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45750848E2C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B392283917
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8661224F1;
	Sun,  4 Feb 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMAbKJKp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A7224D5;
	Sun,  4 Feb 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054267; cv=none; b=Auidw0V+EPI02o4/413imUa8k1C8+pqQXZjhfKJAnaAGvIGX+38UUkDMJbRiPHSeeXo8I5r2TeoGWetyuDbHZi+CsAy3CVmdfWfqnjewLgktQz4n3uLYj+jQrYm2WmL8Sw3vjOuCOtW7syLA0PS/EnYR+nv/Mb45TTduKW6jI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054267; c=relaxed/simple;
	bh=AHc2676r5M0CoCDOAnzBPdlZNgm6r4jCBTuDpQqUGWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWcvBbgwZBEHj1f5u9g2NYBdy/Eb9CnDoAET9OJ2ZYFRSbeJW84GeZJ37Vox5kV3gl5MSNvapoTHKNVIOAGT1hpoJPoz7z9dYsSQTnFxPVQ4o2r7JoRz3dLbPbeLlDLTFpejR+q3jaPDi0LFu6dLb5xwpTHNFKDQEi8A+RF7tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMAbKJKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4FFC433C7;
	Sun,  4 Feb 2024 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054266;
	bh=AHc2676r5M0CoCDOAnzBPdlZNgm6r4jCBTuDpQqUGWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMAbKJKpd8pcJfTNYrnp5MSIpzXzvxChMzjR/NGw4K8K16ezkICBpXXe7Mx0mwMrY
	 KGeVxnq/S+MgyUuZHIQVveuuz9yMajr8CopMjIhDeL7Ldi/2n/Xgj9I/R6ZIseVmT0
	 G9Pto8iqjcfEMvW/v9ZKRMDw95KtxoLZls6JizdiVH+qp6pqPxdhfuieYPbbI34uGn
	 PjcrKWnjPpg9T7ek5GUXKSiYNCYAj3Wa+dUldafCgzsp+qj57qKjaI6JbKtMWw2VKU
	 VyGVJUlqqZ8Yo7kBeYR9l6ZaBKz2A1v0vi2zJS5fSjvIuX9pFTipIrpd1FEg9DTeZN
	 xwNhUQqGGrG9Q==
Date: Sun, 4 Feb 2024 13:44:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Message-ID: <20240204134415.7dad8b66@jic23-huawei>
In-Reply-To: <20240127165948.518a9ca0@jic23-huawei>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
	<20240127160405.19696-5-petre.rodan@subdimension.ro>
	<20240127165948.518a9ca0@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 16:59:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 27 Jan 2024 18:03:58 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> 
> > Add triggered buffer feature.
> > 
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>  
> 
> Rest of series looks fine to me, but I'll leave it on list for
> a few days at least for others to comment.

Applied to the togreg branch of iio.git and initially pushed out
as testing for 0-day to take a look-see at it!

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 


