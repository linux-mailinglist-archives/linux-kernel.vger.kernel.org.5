Return-Path: <linux-kernel+bounces-29920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249883152F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3519C1C21187
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8812B71;
	Thu, 18 Jan 2024 08:56:22 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E746125A4;
	Thu, 18 Jan 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568182; cv=none; b=hi820GGcF5qoIFGtCRg4I+LqFR4lY6rzT0zfhTNpqFMxdwhCT+4R/BNNb5Lxs864DT62vesqz+urvofn4Fmq5Cw/04F5mPjwCXRGmWoDCc9yVCtDQRE1L+xZ5h6ZzaRIvjvlr1FNdCeioUla2R4t7TeFqdv0fMxcrvFK3JnP4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568182; c=relaxed/simple;
	bh=6UEbkC6Uz+XVAzitmU1FaoCrGwDvahmcFEg1+YlZeH0=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=s9l7aBzIlcovGgblCVzyeGab5KpM+CPJbXjtnairBx2c92wSKd2XJJyFgX47nYxHzp1RKIRzg26nwTySNGCRy1ZGa91TyexHYTHtuFBVC6x8wzNaGhsXbHN5mOva/APynG0hFno+uzs1RLokrFgCVia7rbkvUM1eFr8Mwrg09dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1HuU-1rOin60jHu-002qo5; Thu, 18 Jan 2024 09:10:54 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 02/13] rust: error: move unsafe block into function call
Date: Thu, 18 Jan 2024 09:10:43 +0100
Message-ID: <20240118081043.20703-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALNs47vgfs+cFhYsTZU_RE5WxFZ4euMAhuKESJE6m7PFy0JTzQ@mail.gmail.com>
References: <CALNs47vgfs+cFhYsTZU_RE5WxFZ4euMAhuKESJE6m7PFy0JTzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kHADZcrp0dWzQt8WjQ0aquu0Y6gnR74KksxY2wXQXjIgNJmSV0t
 4KxUeXf0jaNxoeE4NMBRta6BjOrfFs2hMeyBiohHyCflOGG9a1bsKYgtoidqtg/gEcKtNpf
 5zFIJXDMlrSSo9KoRcIMpi45C5gJWUgP5bM15DNDNwc/PaeVbnd9xBROOgAZ5H5q/+fBwOJ
 OeW94ribThuLnPpU9GjpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lEgSvVlN96Y=;RUafqrZMhLZfe+8g03BEftJNnv1
 clHtEqM8l9cNv9m0YvDYjdFEOLsPXgz4KVfQjesccCYiTpsjnrwclEKugfWGrP5oG/bZpCiws
 KztCUwhDBiNR72+z/w631WlJEAEBaFCw/H/4c/aEBNuwcKTXvKXTyGONWIIBJUOgxfYOqYSh8
 s72TBp4+qRTvqC0OTLLeMCVMBv3TyO8M5kAfQ6/4yAgnwgYLtuhcqRa+HmlSxHwsZZIcGodWW
 Bx5keU95jDsdLDx6eAIWlS0bwmKMxOI3g6qbMLiYikhC+SNfsOwAqKVdPQLcy/fQ05HNqoc+V
 fmZ5aaglFLutJGR7oJDKc5N8acJFSoy3N1RsYblUA4GoN/nlHGowSSWCb973kgO/d0rAJ9YRR
 J/NbDFgEblnO7qn1vw5bLufuuQxQvsN44KNJASnGaz3l5C4AOt6zDLu5VQfrdgpIumnW0JcGT
 2ftYP7RCwpOXIowB9DG0GSmFTB+r6HTOEOw3vcujbzkJQuxfYKy0i1FR0AIVH4veYxetbVU0H
 OhBezKz6ZguWxcFwy5CUXJgZ9vynL7374Nmkzp+8vNKYmA+KsFnU7nJQOhGVSJQlTMrpngS8c
 js+fFIfzkAIW6FUlYkaAgyF6fWthbQZ0zVEs3eK+WthQQ1Tq8OEfeuF34UwZXsKM1ypNp89qb
 RytoFKVomqMS1OU5M3D/stFDiqMV4u0ZdbPCP7I5Ro34ponZQtVMtQ06BjgAudWE3P9UAIgYy
 ODtSBfNArXCsHH70y2rx+EuxfjwRM9tXFmfHrtryA+XfpIUWczAUMTzjJZIiWFDV9G7tpzI1R
 u7g5JO5ptZSQ8u4pVLAH0VMpO4KwhC5vKMe+3aFRv7I9kb4kENVQa0MtfFQ8qEeSBuU3h6xTW
 tmH70nsxPs/xj/g==

> If you're up for it, that safety comment could also be improved.
> Something like
>
>    // SAFETY: `pdev` points to a valid platform device

Thanks, will include something like that in a v2.

Just to make sure I got it correctly: Index is bounds checked [1] and
thus there is no need to include it in the comment. Please object if
that is wrong.

[1]: https://elixir.bootlin.com/linux/v6.7/source/drivers/base/platform.c#L63

