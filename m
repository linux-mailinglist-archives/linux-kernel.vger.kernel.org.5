Return-Path: <linux-kernel+bounces-76825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A085FD29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF874288123
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C7152E07;
	Thu, 22 Feb 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nB0CSrmR"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7511150990
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617298; cv=none; b=AO/K2Ya5Gz4jMZBMeyC5TXI3EuVeakiiBSzQLigdJ0n9YKwESRvWoC6OMIhruXy8/sonTRqVcqjTYa8WOAUaiktslYjhGPNij9NNc5ldRsy4mRCXmGV+j/ugdLn05PPwKU1v25d37G4h0cSyPPmqWlotvgtek832ceCM/xON9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617298; c=relaxed/simple;
	bh=3gudls+qOVnJJ2Z6I9k9ViRZ5gG6pFI5d3hFmaBqiQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl/k7J8UAcrGPztmwrVBvFdk7Chzd6auJnZpZO0KQIkQdQ6HjN7X1aGfTXAe+NYHcluiTHknmJwSTu/XD9yzRW+KLbfaXOwC7i84YBS7vHzUIu/KUPhcu14fV92hawwTUAyNfXOD6eTPSbvge3CkYW12bOGQ9IKGKRq6VJaZY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nB0CSrmR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFsecV030805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617282; bh=4KEodA6HsyUJpOvCLWhuiNIE3cmXsNuj9MIhHoVGIbg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=nB0CSrmRqnuPeJ6MRMK9Lmu+KQ1kiW6i+QPDCS9EHP61D74dRvAl7ReMpf4OGR+ru
	 llQPE/s8QafEMOwvPx8PvsnPzYJBlYo3KGWa+sj1u6HKvMoUwwNHCv9HkaTZZ3bAm0
	 Sc7S30hAxxAakHQkj8Cwwj7lb9S8khafxxA0t7QKzP7jOkff70DOpFx9uVqUX+q6rv
	 q3UG3UZQaxXwuYq9D/OlD3qzC5SyBjccYz+8t+mHRzqgTAXQZ5cHbv+nQNiiZe0/Y+
	 pKHwQU8ThMPnPQkoXdE05idJjyCov2r54JFTF5w0bZJBmOru75B0pIEgojIqxaX5SW
	 pc0XEKO1Nu8bw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3A90F15C1443; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, ravib@amazon.com, stable@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Yongqiang Yang <xiaoqiangnk@gmail.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix corruption during on-line resize
Date: Thu, 22 Feb 2024 10:54:32 -0500
Message-ID: <170861726754.823885.5472128846628604301.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215155009.94493-1-mheyne@amazon.de>
References: <20240215155009.94493-1-mheyne@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Feb 2024 15:50:09 +0000, Maximilian Heyne wrote:
> We observed a corruption during on-line resize of a file system that is
> larger than 16 TiB with 4k block size. With having more then 2^32 blocks
> resize_inode is turned off by default by mke2fs. The issue can be
> reproduced on a smaller file system for convenience by explicitly
> turning off resize_inode. An on-line resize across an 8 GiB boundary (the
> size of a meta block group in this setup) then leads to a corruption:
> 
> [...]

Applied, thanks!

[1/1] ext4: fix corruption during on-line resize
      commit: 3a944549dd26ccaf1f898a4be952e75a42bf37dd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

