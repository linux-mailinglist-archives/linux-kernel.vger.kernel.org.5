Return-Path: <linux-kernel+bounces-79796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655208626E0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17431F21AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215BA481C6;
	Sat, 24 Feb 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXS8g5AQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433A2907;
	Sat, 24 Feb 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708801647; cv=none; b=IR7za7tYqTyvw4Zrb83jtkdDN5da5JGTj0FBfUCaDly6ST1XiQMteotib0qJGhIswdPgMV+5y5wX0QDeDTg4Oyq4fG8vRxGxnZMZ5bN4JCuCY+4bS+NR1bjJe7K9eHvV0sdQm6eOiA1ZkHfjn74v6vmM5xFvVRhQX8r7u4/wk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708801647; c=relaxed/simple;
	bh=pGzmRAR6shNRHzEOILZaVt3X0H6f2I4FwdTANqZadn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbObY+Uz8NCjIJFfLPu1QjGvLFi0RDUM60UJzhF/7XXaLmeJoSSbBGPM88hAWrI1F8h6Pjlef4zVtt3EsjkFO6iYTOd/uFELXhEtdan+dfclnSClvAAdN+nrg5vcCOfE0Q0YEjVibEwlHtSAo501/4q28GAlb8eR8HylMJGWgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXS8g5AQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DACC433F1;
	Sat, 24 Feb 2024 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708801646;
	bh=pGzmRAR6shNRHzEOILZaVt3X0H6f2I4FwdTANqZadn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXS8g5AQIVVjOo+PRDd6trzN31YcFBgmzneSlc6qyXs+AT5TxPkvrcczhSquKhzfx
	 PYcAO8VmQif5TsRfGmzFMWCm71/YR3ptppMJzcb/kYkR4fk+BCl8Agryont3BZtiuA
	 /yEGaD331NXffUFCQ/3Tc+YrNZAaUuw755rjum89KDt9ggrjTmpvNq7yxY1P94Khnm
	 ocsP1tYWnZZbf8qtxBDIQ7UOgxuHi3GfBveWtdOjaRdsQ7ybS58Pa42iAqP2CcU2TG
	 ysXoRxucpmDseDR2kkYeDprWdZdVIz+AaGpxM8UplnXbFdvYSlVeFnclGh6VnDLcJ5
	 e91YzhSq2cn3Q==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than clearing young
Date: Sat, 24 Feb 2024 11:07:23 -0800
Message-Id: <20240224190724.45681-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGsJ_4xZQGgzFxEMTJby5MBb22GKV3+X_pLdz1E-1m_hzM4x5A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Barry,

On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote:

[...]
> 
> BTW，
> Hi SeongJae,
> I am not quite sure if damon also needs this, so I have kept damon as is by
> setting ignore_references = false.  MADV_PAGEOUT is an explicit hint users
> don't want the memory to be reclaimed, I don't know if it is true for damon as
> well. If you have some comments, please chime in.

Thank you for calling my name :)

For DAMON's usecase, the document simply says the behavior would be same to
MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same change
should be made for DAMON's usecase, or update DAMON document.


Thanks,
SJ

> 
> >
> > Thanks.
> 
> Thanks
> Barry

