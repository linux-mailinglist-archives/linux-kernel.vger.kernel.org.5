Return-Path: <linux-kernel+bounces-102444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6E687B215
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D68F28A42D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168747A6F;
	Wed, 13 Mar 2024 19:42:31 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E1225AA;
	Wed, 13 Mar 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358950; cv=none; b=rlGUbk6i6bxjda2EN6gJ3NQLX/77qTK4YdQ3TTlcZKW+o4wkxf9bvxeZGU3iJKaemBH9HfRtiBxKZoEnTEblAZn9oFu9H/vzG7bQ4modODcRLUtX7DLedXTJaCulX3lpBXXvjiRa3krtskgUFsEICAGiXtzkn5gIEOXGilCLVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358950; c=relaxed/simple;
	bh=/vIfaDdu3Q5cNuz3JLcVHVc3X2jfmA0JFBfrkRQdH2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA8yF+RcYceU8n9I/uj+ZrqY4Odfeuly3uUcA3FyHmO/UthQYuWR/xut20E90pxGKpmmygvbCJQRjfzJrBdsL+wKpwgl5aft7VWZn6IxE2hEpCxPidLzJTb5NZjrMXWYk5ovW8SJj5g/dfDh+re5hMjuMnrzjkOei4/M5wEO8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 79E4272C8FB;
	Wed, 13 Mar 2024 22:42:21 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 68DAC7CCB3A; Wed, 13 Mar 2024 21:42:21 +0200 (IST)
Date: Wed, 13 Mar 2024 21:42:21 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>
Cc: LSM List <linux-security-module@vger.kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
Message-ID: <20240313194221.GA18631@altlinux.org>
References: <00734a64-a5fe-420c-bf6e-bee27c9d83be.ref@schaufler-ca.com>
 <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>

On Wed, Mar 13, 2024 at 12:32:37PM -0700, Casey Schaufler wrote:
> LSM: use 32 bit compatible data types in LSM syscalls.
> 
> Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
> and lsm_get_self_attr() from size_t to u32. This avoids the need to
> have different interfaces for 32 and 64 bit systems.
> 
> Cc: stable@vger.kernel.org
> Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
> Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>


-- 
ldv

