Return-Path: <linux-kernel+bounces-156440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1D8B02CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D6B22B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD836157A42;
	Wed, 24 Apr 2024 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/+AgfUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9315442D;
	Wed, 24 Apr 2024 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942138; cv=none; b=fNVYV3iJNBtb/183RvhvfiDMzflbKjtcDRh9Pr96+VssYXQiK/Q5RddUYyU6n19+oI4s7A0rAUf+bsKjgMRj1954QA9S9tPoWvloW2efM1LAyhXlxweM63LKYORQaorndF+Xkp2SI1gpjiEUMhySU12niPyNdMiBsqFUORJPVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942138; c=relaxed/simple;
	bh=wkE3W+22CVpJ0PjMaWxui7H6nzgdHzhedQLXhXr74Tk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RtMR+YyRpoiuHCaMpdkCMOQSPcfoeJgSYKK3yY4uhRlbVzJRLrGaq5QfLf5XPxP8jYQ8DVUZq++yckIhY9nFbDEaT8XU7oIYwjMsCenFvonXW76JLJBBtbncnyLftrVs9b7abWbc2C4utYd6mxqeZRaTeZfKVJU0PJ4pDbDarw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/+AgfUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285FAC113CE;
	Wed, 24 Apr 2024 07:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713942137;
	bh=wkE3W+22CVpJ0PjMaWxui7H6nzgdHzhedQLXhXr74Tk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=M/+AgfULA7Zu9GK2yTDzkigB53nvLLd3d1vUndHMcmsc1g57ImtwD43CK/+4SgK4R
	 H5gAD0m3J99pme5K82OalSZghgmq+Ts8fOlyJnzqXw34jQVoGdaabejvBEF81R2jQZ
	 ZeqJFTsmX1U5NlwxMhcECU3y7qTOfjxqNH+f1gkMYC3aRImElR5d7hCwDJLNGybI95
	 KCX6ojacP22AunjeFadvhVcwqhHdwKl9JWbumjaJPPdI+WxInCeC8wYlQSJMmLKzoK
	 /aoI488Ltx8CdugyYFwAWRNhibIUCHitPxeu5BCtUhxqoHYxagJ+mSK/PjGIFrjcFO
	 z2VbMWaLATLOg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Apr 2024 10:02:14 +0300
Message-Id: <D0S5S2NL1N5P.3Q0SM01VIZBJX@kernel.org>
Cc: =?utf-8?b?5YiY5Y+MKOi9qeWxuSk=?= <ls123674@antgroup.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bojun Zhu" <zhubojun.zbj@antgroup.com>, "Huang, Kai"
 <kai.huang@intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
 <02fe00c3b10e4476d500ad7a34024b7eae5e3c97.camel@intel.com>
 <85dfbebc-a2d5-4828-b3b9-f929cd6e30cf@antgroup.com>
In-Reply-To: <85dfbebc-a2d5-4828-b3b9-f929cd6e30cf@antgroup.com>

On Wed Apr 24, 2024 at 9:46 AM EEST, Bojun Zhu wrote:
> Based on the the discussion among you, Jarkko and Reinette,
> I will keep the need_resched() and wrap the logic in using sgx_resched(),
> as suggested by Jarkko.

Sounds like a plan :-)

> Regards,
>
> Bojun

BR, Jarkko

