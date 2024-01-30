Return-Path: <linux-kernel+bounces-44290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEE7841FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB4B1F26FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333B605D6;
	Tue, 30 Jan 2024 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po3eGOF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B860B81;
	Tue, 30 Jan 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608010; cv=none; b=C1z1Z4HcaBhIEmx30duYdige24KRN6UV4UcL+3wpPlBgPxn9xWRRAlkv3IzgWQAG8hFSrqiRtzim6Q0HluT83lwBAvcxD4mqwKony+/apo7Qh8AzKaFvZiF3Yi60cEqaz6jSXzwVN5i5iamY4+Um9aIJ/6Z7r9oc7Khwv1fJzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608010; c=relaxed/simple;
	bh=ZqPxrlZ2qFmSLhlJK+pFXtWobfegdINoLA1VE1bjxvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDnTWIciTYYvDCmKlVVJsViYptUCeJ05n3MsG+r3SILfMr2VckTtYuQWuhHwNkbgyzwE6bGwQwChAFAmJG/1z5WJ0RTKuXViKrfnKPhotvFx124DdwhauqazLoScMGANLP/QJLryEIyV1AU4Eb/9k3ahURawjr+QFYPZX+1Nvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po3eGOF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA58C433F1;
	Tue, 30 Jan 2024 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706608009;
	bh=ZqPxrlZ2qFmSLhlJK+pFXtWobfegdINoLA1VE1bjxvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=po3eGOF1yNw3Te3hIZzs7AwImuUzo2MHQpXMPAowEAna6vCcrrxfM0LyK8qGaBhmf
	 dLBZWzN+d++8hSNCFD6cncw9KjoJOn8xRMhzmnf3T6M2wTKbQmgZtxpBpEYNqFo9Z3
	 3yrcav4theveeugvkpD9uElChKX83Y9N389q1ZcsC+11eoaB/O3VkzqZ7q6xFudIQ3
	 7XLAOKDJwZ3carHABhsI38wYTsy/OWlRiIYtu2mlIYj4DFpEXikvkmAcy5Pso3faaC
	 1aWmKRAEIWFYnY43phLhe8ZBvZvp99haQwSYnvKUhle/VdxRRjdXWF3whi/6EaZWWw
	 0RKoJ7kq6VpbQ==
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iov_iter: Avoid wrap-around instrumentation in copy_compat_iovec_from_user()
Date: Tue, 30 Jan 2024 10:46:38 +0100
Message-ID: <20240130-eintopf-bezug-5e4722dd363e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183729.work.991-kees@kernel.org>
References: <20240129183729.work.991-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=brauner@kernel.org; h=from:subject:message-id; bh=ZqPxrlZ2qFmSLhlJK+pFXtWobfegdINoLA1VE1bjxvc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTuONp4d+GcWsmltf9FW14y5DxeqPm4vi2v8Z7uPLU2d mPLlBl7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy8w3DX6HpGp+OnRZRKmT+ 075Ldv+2W8ZV/Xca+2dbcUr5LuWeepqR4WJynVtr44RPc4xLm/SYrJhOlzyb4Ps4i+ePzZqUgsW z2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 10:37:29 -0800, Kees Cook wrote:
> The loop counter "i" in copy_compat_iovec_from_user() is an int, but
> because the nr_segs argument is unsigned long, the signed overflow
> sanitizer got worried "i" could wrap around. Instead of making "i" an
> unsigned long (which may enlarge the type size), switch both nr_segs
> and i to u32. There is no truncation with nr_segs since it is never
> larger than UIO_MAXIOV anyway. This keeps sanitizer instrumentation[1]
> out of a UACCESS path:
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

[1/1] iov_iter: Avoid wrap-around instrumentation in copy_compat_iovec_from_user()
      https://git.kernel.org/vfs/vfs/c/2d5099585c5b

