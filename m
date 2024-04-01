Return-Path: <linux-kernel+bounces-126535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE189392F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755D61C211CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A034DDA7;
	Mon,  1 Apr 2024 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bswvWu7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CED4416;
	Mon,  1 Apr 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961419; cv=none; b=CfAAEomtWYydq2F5IbV1QRbwKDACRHDW9IO23ql8ETvWANskh2/u3qD3+iDvjZSyEnS7kYrWuNfpYqODU/5/Qw6RWo8fV/5Kf+O6mQwIT/MdnjJJp0O7LfkCz3omPngfxhPh0wQrIK7eEv9Vs8dexlGjubT/ienBtOsO2tpIy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961419; c=relaxed/simple;
	bh=9hgQj4u8ELvFghX7HeUW/UJDK0JKDzLGYG5tkIEE9Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5kwBpo44m8Iqdi4eNbk8N8u1cGLg9WitPQMaH+XRPkUGyiHd4ZwzIf4YRPeyc5e93SEKmx9mRzzRd4zjMKM2HK9H/OWWm3pEuVQEq4bvci/8kLwpYJhidSV53+9Hf+7wVopUkI43fFsunogu9PSD09iAgT1mA706eJxQcMgfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bswvWu7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF06C43390;
	Mon,  1 Apr 2024 08:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711961418;
	bh=9hgQj4u8ELvFghX7HeUW/UJDK0JKDzLGYG5tkIEE9Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bswvWu7Us7jzRfjUdOlHMTISbpgV553r31hBaJeCdPVcx05ZW8bATLlGeWWOKmQ+h
	 XUHPScHKY/1YqXn24JsSsb0mOf4cdgXrAI7gL+LJHQoBLGblnLSCFP09YYLal0daBv
	 HiealdE1JUUCbG868oyMugfpoG0OyY229yu9TsQWgm4YoNIefn8ELhYB2Qs7mF7X1a
	 ndgdBzJo1IqMd2oNv94Nr2u5nq5ZYHL10yGYR3FxT/Ie83JEBzAlBp5F6xFbgX00Bg
	 o1vWRXSjLyKsZIOLVkYyNavgkjzHObtuYxbjN85e5+nD+qCPneEcv7cJVSlRx9oql4
	 I8yXy8G6h23BA==
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	linux-nilfs@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: (subset) [PATCH 6/9] nilfs2: fix out-of-range warning
Date: Mon,  1 Apr 2024 10:50:03 +0200
Message-ID: <20240401-dienlich-oboen-93121c59c71c@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328143051.1069575-7-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=brauner@kernel.org; h=from:subject:message-id; bh=9hgQj4u8ELvFghX7HeUW/UJDK0JKDzLGYG5tkIEE9Ds=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRxldouytW8UyWk83OVX6cd89vzd1izC+X+aQq0O21e4 9lWsEiro5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLOWYwMWzdpX3nxSM1+f8OZ m/LK/za8Z5M1WTR76aOKJy4r/jebzGRkeHXqXt8iTX+BexNTf1+bJsCuNVVx19S+TSqzdGf8yPP dxAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 15:30:44 +0100, Arnd Bergmann wrote:
> clang-14 points out that v_size is always smaller than a 64KB
> page size if that is configured by the CPU architecture:
> 
> fs/nilfs2/ioctl.c:63:19: error: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (argv->v_size > PAGE_SIZE)
>             ~~~~~~~~~~~~ ^ ~~~~~~~~~
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[6/9] nilfs2: fix out-of-range warning
      https://git.kernel.org/vfs/vfs/c/d20180d5dd10

