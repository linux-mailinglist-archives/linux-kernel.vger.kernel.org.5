Return-Path: <linux-kernel+bounces-59799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E392584FBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F7128C6C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049F80C18;
	Fri,  9 Feb 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEpw02yt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641980BF5;
	Fri,  9 Feb 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503482; cv=none; b=iSJ8yvLqaoZV1bfasdjC6YRrqrXrDVDh6EjQnj2jsJncSm3GYzegdWmwMWgM2eTK6j8Z7Hn7uqKMvRvrjCxLEFyfEal3z5PTfghc0gxMRTOoKHlmBEIhy+81V9kqeLQqraxzXa4K8ibOI6pIChMG5cilS4L0UUNUQlkR96xGhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503482; c=relaxed/simple;
	bh=tLTv0k0kR0PhtOkai7lknktAVx0vxUkm/l921c3uNp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv4+79WU630ZPhdNzhFXkyAdnuQODgBoOKkrvOfLDM+0XHgl2U1sLFDpznxuBbCX9hhwQzmbZaDkM3gBDOsGs0CfErBeV96IkNzajFLHxZ+u8m02yPwebAFP0t2veymzBYW2O6DZMJt1NT1f1zp/kwdBbpex95YVkbX3mAb+eKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEpw02yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D90FC433C7;
	Fri,  9 Feb 2024 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707503481;
	bh=tLTv0k0kR0PhtOkai7lknktAVx0vxUkm/l921c3uNp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEpw02ytUPktxLTT7wwmh2QljRzlyMA3XDbmzjRYjKxPS+LnLSNgw1AvV1NxXtjXg
	 SXcFj48GJvoV3xeh5Bvx4agqeYmpHe5GHa0W6AMd6BMj+CJ937L8pnxGnP0Rj4uqFN
	 3XQe8gYxqyaGgHRdj814xmiERoZY6Dbl8KTs5OVmfIzfUiOR4HmcJeTx+plhHhEOsJ
	 CGP+d7fs8XKBXd7D12wGowc6XTFaa3i0cxLT4w/4roCaPbgNjBepAVo0AMXkhhdgsl
	 auXjYnVzpC9NfHmeo24SNBrQgRXclow/Dd27jnyxYq9F/XNGHDBm0N8l3qip+I+kis
	 ke2IS9ssnYV9A==
From: Will Deacon <will@kernel.org>
To: linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com,
	Hojin Nam <hj96.nam@samsung.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	KyungSan Kim <ks0204.kim@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [PATCH v3] perf: CXL: fix mismatched cpmu event opcode
Date: Fri,  9 Feb 2024 18:31:07 +0000
Message-Id: <170749755450.2629231.7963849540411447249.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2>
References: <CGME20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2> <20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Feb 2024 10:34:15 +0900, Hojin Nam wrote:
> S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
> r3.0 3.3.9 Table 3.43. However, it is defined as 3 in macro definition.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf: CXL: fix mismatched cpmu event opcode
      https://git.kernel.org/arm64/c/719da04f2d12

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

