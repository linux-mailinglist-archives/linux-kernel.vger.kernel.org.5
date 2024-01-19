Return-Path: <linux-kernel+bounces-31199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4D832A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BDD1C226E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4952F8E;
	Fri, 19 Jan 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="FuSzIgl6"
Received: from smtp118.iad3a.emailsrvr.com (smtp118.iad3a.emailsrvr.com [173.203.187.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CC52F7D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670816; cv=none; b=pf4x42IgPEqCdsynnB/V+TPfn4z5MdtNvwRBijvEHokSXxbB+Q/SjGazTXqkKMq8jGv3lxdfK9uSmPj3vCiy1QNwefmFuzB4TMU74AI4pYDRXsNDusCE/cL7RwpqD73SjhwAejWfLO/wdpRm93blmWagTwfcXjoIhapCfruaFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670816; c=relaxed/simple;
	bh=jn/3OKrZKPHfNR0rB1W2kg5Sp1mhbhjQaG/9nKadyv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coU6p3ExiJ1j4oGmFU5zr22uCQw6qM8MmwDaSIxHWMXmEZKQgRlbSSuEf8DD+C/vifkibRlrkGj5n0yUwPH5Wu/Z7nUGAgnrKKgCFXXjfKWmQcHhIKvaUCzv0Ej34uEpT6WFP+k1eLB6AkwObk6l+1ihgcl6VR3X9v4x/MLIL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=FuSzIgl6; arc=none smtp.client-ip=173.203.187.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1705670447;
	bh=jn/3OKrZKPHfNR0rB1W2kg5Sp1mhbhjQaG/9nKadyv0=;
	h=From:To:Subject:Date:From;
	b=FuSzIgl6UN+YVDJ2b6NGOug1Zemi2vCxvaUeodV0ab73b1FIMVDcQQ4P8PnDYE/os
	 I06VTASl2uG6MsYb5q8dlkgTblbV5lVdY755482iEvy2TGS/Pd81LfIuj14NKSPs2r
	 Dwg37rwXhZmmE66ca7CRhdzi8wfuJQkoDuPSdIqo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C2EFF24EDE;
	Fri, 19 Jan 2024 08:20:46 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: Matt Hsiao <matt.hsiao@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] misc: hpilo: fix inconsistent device numbers
Date: Fri, 19 Jan 2024 13:20:16 +0000
Message-ID: <20240119132032.106053-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 5ab2b5c7-4f68-4b27-8b47-1878e9f7d96c-1-1

There is a logical bug in the use of device numbers in the hpilo driver.
The bug does not actually occur because the maximum number of supported
iLO devices is currently fixed at 1.  Therefore, it's probably not worth
fixing in the "stable" kernel series.

Patch 1 fixes the bug.  Patch 2 just renames a variable for clarity.

1) misc: hpilo: fix inconsistent device numbers
2) misc: hpilo: rename device creation loop variable

 drivers/misc/hpilo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

