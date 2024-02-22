Return-Path: <linux-kernel+bounces-76827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70B85FD36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBC91C256A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63C415351E;
	Thu, 22 Feb 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MNaqjWLp"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D9150983
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617301; cv=none; b=b/VRZFbj9vUWN8DETWE5iyoMkAIrn+sZ0xW6MjhEkKfm2xB7hULONSE9bEOXMu2u08G5YhCD16KYY/OM7idZqMcEpU4QLWKx7XSBEkjajtoZMeZcJ9OWrFwmFO2e3dSMg5OiCHppBGj2DjSoAkj/B29zhQcmYcJUUONs2Xa8UMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617301; c=relaxed/simple;
	bh=JfkoAz50awV0qbSc4V8fA6NAcDNFyoem9HJGiEOJz1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pj/kswTnylJ4xnTNcSXyE8csxt3idYyARly/p66aTN3FfTiXhyx5yTWglBXTQyPnPtyTFJAjsdDD+d+ekb1tcq2EQ2Iz4xbMyNn1fi9TDFhpiNdWShC6eKXlPLR45l4U6RkRDoEpGFNqcdtpiNwBoZlEN9dr5nmscSnAb33kJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MNaqjWLp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFsgVA030847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617284; bh=va26ubDfjVqf3AasDsVt7PlhmdIYT6yVBEJCl7RCZ30=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MNaqjWLpudSxaj/AaFOC0P7YTx4DaEB9lUWtJ3bsQpzmFPpTc8hk5Ls1gHY3ECQK8
	 rRwsrKFot3+in98amj+uWbVshXUHdDJemZztPzallI9sPZRRYvmC/TZYMuCwkgUj1E
	 segZ5B/e0HUAprShlmxk0U8aGUHPKEDCwcnpSSPqfP0BN7Qc+EpOT5joJ+2bHLMbCJ
	 21jhUKZsQtMdecOkhy/PIIATYkDYxc7kRA9LUG/riPsSDlYD+V0Z3zdpGcmQJGwcuW
	 BT6iXzAXBLv1Krn1gFR/ieEF353VA1+SupSoa0/+Emto3+Aztn9tjGm3/PJ7IV/yfD
	 60Ye/VLMWg5MA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 40DD215C1489; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] ext4: forbid commit inconsistent quota data when errors=remount-ro
Date: Thu, 22 Feb 2024 10:54:35 -0500
Message-ID: <170861726752.823885.428276685390671750.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119062908.3598806-1-yebin10@huawei.com>
References: <20240119062908.3598806-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Jan 2024 14:29:08 +0800, Ye Bin wrote:
> There's issue as follows When do IO fault injection test:
> Quota error (device dm-3): find_block_dqentry: Quota for id 101 referenced but not present
> Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 101
> Quota error (device dm-3): do_check_range: Getting block 2021161007 out of range 1-186
> Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 661
> 
> Now, ext4_write_dquot()/ext4_acquire_dquot()/ext4_release_dquot() may commit
> inconsistent quota data even if process failed. This may lead to filesystem
> corruption.
> To ensure filesystem consistent when errors=remount-ro there is need to call
> ext4_handle_error() to abort journal.
> 
> [...]

Applied, thanks!

[1/1] ext4: forbid commit inconsistent quota data when errors=remount-ro
      commit: d8b945fa475f13d787df00c26a6dc45a3e2e1d1d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

