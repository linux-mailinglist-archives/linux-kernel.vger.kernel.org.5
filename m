Return-Path: <linux-kernel+bounces-88040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59A86DC86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1A01C20C96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E4F69D1B;
	Fri,  1 Mar 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATpIz0oS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EBB69D12
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279835; cv=none; b=S56KoKPOai8vp1Fi7Xhi3UOBtUf5WEE4YZFl1IxV+EyVHhjBc9lMk1J1wgMBH6Trvh4vDgXDMe4ftg3/lg1apl+hxrSqwOcs8cjwnwGfd5ZYxP1ExgK8YcR04rPh+GCsciJnsb4613R50POTqSAT8cnmC0rpdkDXM2uqKxvuGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279835; c=relaxed/simple;
	bh=CHUPehzpnqDUL/S7r7nL44zvPml24zgHN2A2W0Jyn7I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mGPkiYCuz1HYI11rvZH0bDVjVNQsL8xgIKXDCu42sp31oEyAnZXP3PV+Gj5W3SMbgBeOmAM8Cs+QTG57zTFE89uFPt0zGMxlQ0V92RZSeXWyW7VWP9569nuu/32shVa5vEvX5CgwrX2aUNuFDYX66UtAennwH1OjPAn7iHv27MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATpIz0oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EBBC433B1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709279834;
	bh=CHUPehzpnqDUL/S7r7nL44zvPml24zgHN2A2W0Jyn7I=;
	h=From:Date:Subject:To:Cc:From;
	b=ATpIz0oSo/gK/EpPg59IiWjihX1ams+mT+tazvzEVG+TdU6Laxdk2JtiZiysldcBL
	 GRQkjG9bc/pj3X5uE7Koru5bQwtSbZAVWF5QIAWJMu1fVGTv3Cf6MVlcBP1F7Ek2zD
	 q1eZbZhcpRMHR5onbA3CPls8ETu4ZMDbV5TgVwsq3ATmW1SjiVT1zC7knsdk3YWfSY
	 smKJKxVSmsAGFGdymNRHHz1KumpGQl1VL8NyWHZbSGKGhGBSHyqKr2hpvwjVfBZ0D/
	 zquT/BoH90HBpDuPMjjcGUwrqdb7aMwwlZyKz8FtfE7+q4DYKa7TqHXeZkgE5dcXhK
	 BkGTIdnx67sCQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bba0ac2e88so1842362b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:57:14 -0800 (PST)
X-Gm-Message-State: AOJu0YyrUawF8WhjY3/VEy0jxsbH6vuDyuM4bHNpHD+vLmLozpH4ACZi
	kRggh246LphXYjJfCxHMONGUhUGUd8JhJbu6Y3Sw1unfJreXC07rHXPULV36GObgJmV73mAQifK
	Gy5H4eeQyhn5leihPnznARF0VT5M=
X-Google-Smtp-Source: AGHT+IExkxzMuez6FEuzaIuyoQKb9g2Bh/wzU1xcXfkd8N05J2fSrp44VIpZ6jfZjbc0BHaru1e99Sbd7CU13YQ5LC0=
X-Received: by 2002:a05:6808:8ca:b0:3c1:bdaa:bfd8 with SMTP id
 k10-20020a05680808ca00b003c1bdaabfd8mr1837820oij.22.1709279833964; Thu, 29
 Feb 2024 23:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5844:0:b0:51d:7041:beda with HTTP; Thu, 29 Feb 2024
 23:57:13 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 1 Mar 2024 16:57:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Jsoq=62ZaJxniETCexEFGxn3cBS42gdibuKYTJxbJkQ@mail.gmail.com>
Message-ID: <CAKYAXd8Jsoq=62ZaJxniETCexEFGxn3cBS42gdibuKYTJxbJkQ@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.8-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat fixes pull request for v6.8-rc7. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit c02197fc9076e7d991c8f6adc11759c5ba52ddc6:

  Merge tag 'powerpc-6.8-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
(2024-02-17 16:59:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.8-rc7

for you to fetch changes up to 3a7845041eb7235f2fb00ef0960995da5be63b11:

  exfat: fix appending discontinuous clusters to empty file
(2024-02-18 14:41:18 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Fix ftruncate failure when allocating non-contiguous clusters.

----------------------------------------------------------------
Yuezhang Mo (1):
      exfat: fix appending discontinuous clusters to empty file

 fs/exfat/file.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

