Return-Path: <linux-kernel+bounces-91790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A38716AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D37E1F217A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA9C7E567;
	Tue,  5 Mar 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O05N7aVH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4564C637;
	Tue,  5 Mar 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623255; cv=none; b=ntqBIAyYuKqf0LOvxZfmsUy1HRh1hx2jqmwncPWm00BZeyiXiTl18SFkUKEM9dkbVz0XiHSQTLUvWqglFamNwmLzFOFyI5Dg2ncN3fSHmKThKwybaobMdaMboAdjdfPl7lHGxJYpp8kWangMR+4FzbZcAo6kkiXuuu5kArrihbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623255; c=relaxed/simple;
	bh=zFjSuqayaH6d64jubRBM0LNPzNUI0Q3ZqFdzCrmPSuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTl9ufm5K8LSwtlyAsfB7IVN62UCHozOTDDRc3xceXlWMef2j+1TFt9TsUbVBj9rLOUXxkskL7FftHAd/ifBMDizHNygbE9Kpts9ZH8iRUF9Al8A6KoCgla0vY1TCddMf0AQFfGEE1AMBqvDyl0wQZj/21K6+qdObHFF61xA2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O05N7aVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463D6C433F1;
	Tue,  5 Mar 2024 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709623254;
	bh=zFjSuqayaH6d64jubRBM0LNPzNUI0Q3ZqFdzCrmPSuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O05N7aVHPAFl3roBucA5BWEoIXIWkOIfVgBJA/rSdWiPU68tg0P8K9isu3SxuyFS2
	 FfJNJBKjWExEeUHUG5jVQI7HirUQxSILJIUzloXkGJxKvmbIu/rJjGJcinDpU9Fwz6
	 +PyKR/OMsCFqEFKe8aTGpbcBvm/qfBs7uDRnGSww=
Date: Tue, 5 Mar 2024 07:20:51 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
	jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
	stable@vger.kernel.org, alexandre.chartre@oracle.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, yuanzhu@bytedance.com
Subject: Re: [External] Re: [PATCH v2 0/3] Support intra-function call
 validation
Message-ID: <2024030502-chief-cornstalk-5248@gregkh>
References: <20240228024535.79980-1-qirui.001@bytedance.com>
 <2024030438-dropout-satisfy-b4c4@gregkh>
 <2024030404-conjoined-unlined-05c0@gregkh>
 <c98aa910-7b14-401d-a257-274682bb7486@bytedance.com>
 <2024030506-observant-clamor-1c8f@gregkh>
 <7d8c1898-85e0-4291-8023-c17d80c75c94@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8c1898-85e0-4291-8023-c17d80c75c94@bytedance.com>

On Tue, Mar 05, 2024 at 02:28:52PM +0800, Rui Qi wrote:
> No problem with make allmodconfig, the compiler I use is gcc version 8.3.0 (Debian 8.3.0 -6).

That is a _VERY_ old compiler, does it even support all of the retbleed
and other stuff needed here?  Try something newer, I see this failing on
gcc-12 and probably gcc-13.

thanks,

greg k-h

