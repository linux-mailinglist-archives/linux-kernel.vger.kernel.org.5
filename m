Return-Path: <linux-kernel+bounces-102761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268887B6F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0473B22E98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5775DDC5;
	Thu, 14 Mar 2024 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dr5/Oo6J"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56829C8F3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388514; cv=none; b=aszPNga5JNoi38yVxZxNN8W+34ir+qKFzBXU9ity9JVNa5VmCUrZkVnzd2kjDYOQX28RHwTWbku+pQPiW0BRbC6us0LtTrb2cYo6lrG+7dLCjMMyAqZIeHs1GATUH9VeFqeJPy9wCFzy33HgvreGqxs9m8GTx19tNyEx1KWrUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388514; c=relaxed/simple;
	bh=TSjb5kKr71IZo4aIoklR+N5ASgrPafOemLfJHoCPdY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sx9ixJJQABJREbW0b0oOLeofxEQgb7IIU3fcCkI83tV+va2Gv97M7kRWCN/MT7DBz5eb+LJtEK6uyWRQhVFiw5b6FpG64GI9qeh6RqRvtucnCh8XLRvteBbBxpQReMy1kTz+5IK6m774pMBeoStqza+IAnk6tX90AqQZH1Ks9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dr5/Oo6J; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42E3snPd003036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710388491; bh=AvNLx2MZZmUfIZ52kPuRs6GSVepWGaRvDEyCw/zq9bQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dr5/Oo6JqmMBORYUCELRUyJmbwUEKTdYoS2KcLEOn2iiTl/YWMSAkuYnV9N6feDEO
	 9josqWyqZiJYUshwztT+e12vGO4eUSac4/fNi5ELJeeStJiOOI4dODvZEmbGLEaDzs
	 BWdCMlN15Pyqa63r0Kv61SGk/+Ja5zNF+JovGOd1D9GDFHl7Fe2mzAWEzF8QMG81Ty
	 FenpUDXbf9p1c265gQCepP62c1lhbJthqLaz/mCNmfG1Ldgq+VYGY0jQq3YYPlFV0W
	 Y0rEjMGJ0bQcXFp4FpMsUUUMspXUlw1iVWHmmeFFcAWQ8vERqEVL6RMVmNgL4YfHBg
	 3GYItVLaHRtMw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E9ED415C0225; Wed, 13 Mar 2024 23:54:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: kunit: use dynamic inode allocation
Date: Wed, 13 Mar 2024 23:54:41 -0400
Message-ID: <171038847843.855927.17076324311685588663.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227161548.2929881-1-arnd@kernel.org>
References: <20240227161548.2929881-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Feb 2024 17:15:39 +0100, Arnd Bergmann wrote:
> Storing an inode structure on the stack pushes some functions over the warning
> limit for stack frame size:
> 
> In file included from fs/ext4/mballoc.c:7039:
> fs/ext4/mballoc-test.c:506:13: error: stack frame size (1032) exceeds limit (1024) in 'test_mark_diskspace_used' [-Werror,-Wframe-larger-than]
>   506 | static void test_mark_diskspace_used(struct kunit *test)
>       |             ^
> 
> [...]

Applied, thanks!

[1/1] ext4: kunit: use dynamic inode allocation
      commit: d60c53694c6ff560963590971720d632bb3d481e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

