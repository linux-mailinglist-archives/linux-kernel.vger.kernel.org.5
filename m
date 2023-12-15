Return-Path: <linux-kernel+bounces-975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988548148C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BE31F24975
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817D2D7A7;
	Fri, 15 Dec 2023 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgnkrExk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8F2D78C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECCBC433C8;
	Fri, 15 Dec 2023 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702645984;
	bh=lLwzrgxcaUHAFk47T3+S+izU8CDg1Vqs/F6ioCNsFls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mgnkrExkZI4ZZGrW7R4y/ZQkY8EHnZWPeO71l2kMfGk3j5YU/erIP774PK7AYgcqd
	 4kpuygxAiDTi02ZFjDrCCpe/3whoh8E8pnXiJROrygHTYu4x0kzpL4TNh/2FD6hzHE
	 0d/4yT4cGEtnWKWDF1JTld7+xpqNbQgGaI6ZxTa1Tr5ufNtVGHRALsWreuUVSeG+ii
	 zDrsEnL6Qjt2Ux1APozBcBShOZWOzMh6yiFxqTaYsJC+lFXN/Y8acZ825v5DxGWxsQ
	 b73AfwIiGDG0ba9lHQXZ06irb4ds1Xqm1YZfhwJwjgsrDgMZH7PlUXezS6zrj1vc+2
	 JAyE5yqBTTWVQ==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Donald Robson <donald.robson@imgtec.com>
Cc: frank.binns@imgtec.com, matt.coster@imgtec.com, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 daniel@ffwll.ch, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20231208160825.92933-1-donald.robson@imgtec.com>
References: <20231208160825.92933-1-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH] drm/imagination: Fixed infinite loop in
 pvr_vm_mips_map()
Message-Id: <170264598213.449619.12866525083643261549.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 14:13:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 08 Dec 2023 16:08:25 +0000, Donald Robson wrote:
> Unwinding loop in error path for this function uses unsigned limit
> variable, causing the promotion of the signed counter variable.
> 
> --> 204         for (; pfn >= start_pfn; pfn--)
>                        ^^^^^^^^^^^^^^^^
> If start_pfn can be zero then this is an endless loop.  I've seen this
> code in other places as well.  This loop is slightly off as well.  It
> should decrement pfn on the first iteration.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next-fixes).

Thanks!
Maxime


