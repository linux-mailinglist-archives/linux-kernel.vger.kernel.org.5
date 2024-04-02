Return-Path: <linux-kernel+bounces-128313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37662895938
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DEB288E87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF913FD7F;
	Tue,  2 Apr 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h8yobq7g"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431A13DDCD;
	Tue,  2 Apr 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073881; cv=none; b=PrtDKaEg1LtOQooMTVnuWG+ABh1OX53DDRB1IatweXkWD9lIuZqrTaT+siNXWVSkwVO4qrYVF35NkRAj10ih9I6DERvl9OzWfFWNSoa96UL8o+9FJe26MDVzI1Od36gGNddRAfslDp1pzuRSuwRDZrGtS+j74PMmX2t95Ddup4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073881; c=relaxed/simple;
	bh=r3rXkjJCXBAjJQaXMwZ1SYdQThC6q0B48cUjEJI3E9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnjLbgcQPhU8FzzPw7qWtO34fUqSTM17etpXc0N491w7Qk0EEp6AYKQRrR/61Tubw+r1MNerGtXXHbw7FoF2EQ8F/J0Sg4YDz0RURoXXPKn3UPaaeyg2ZUIoyg2yWEHVVkhCQhrUhmvIcQgNA96qOzDVGwOTsN04jh4cqjwd6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=h8yobq7g; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1388F47C3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712073879; bh=XA/dHmCc2XwjIelH6niwtn8npP/q5+SSqhyQukiun7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h8yobq7gndSF1BcXzZ3nu+4jSRkncbKDo6EhXYJDel50j4F0tfcIyhPbECr+ACgb+
	 0Etgtl7n6QTk6l69n52FgvMb5Ef7Jo7T/43fVGjZahOa0enCc/0zkfCj2zooGDK5tQ
	 EC6+VbbI2DtR8vx06WlhgksW5+ozUeZPTE8/WNXu2PXy39Gjkl0dc96C0fTP0c8xHj
	 Sa+quF7yjpQ73rp/sMuYM+x2owy119xwAUWOs8cymEgSUF1iBY1HYS5YXomHdrE8ec
	 SiyhKfuDMX2MDNib03WB8yibguHRxOsP/GfhbPYBPCb9RrSt0Y+HGo80LknnxZXRKl
	 uFjBdzJBYEfqw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1388F47C3C;
	Tue,  2 Apr 2024 16:04:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Vegard Nossum
 <vegard.nossum@oracle.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] docs/zh_CN: Add dev-tools/ubsan Chinese translation
In-Reply-To: <20240302140058.1527765-1-dzm91@hust.edu.cn>
References: <20240302140058.1527765-1-dzm91@hust.edu.cn>
Date: Tue, 02 Apr 2024 10:04:38 -0600
Message-ID: <87v84zvjhl.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Translate dev-tools/ubsan.rst into Chinese, add it into
> zh_CN/dev-tools/index.rst.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/dev-tools/index.rst    |  2 +-
>  .../translations/zh_CN/dev-tools/ubsan.rst    | 91 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/ubsan.rst

This is (finally) applied, apologies for the delay.

Thanks,

jon

