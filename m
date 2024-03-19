Return-Path: <linux-kernel+bounces-107704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A54880078
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEA21F2275F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6C65BA8;
	Tue, 19 Mar 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJdDexdM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90E657D1;
	Tue, 19 Mar 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861817; cv=none; b=kL2HgKHYNQah3VCMKwkMX5cWZ6cM4PpXzqi9PltrpsmFjgz6X3/vM/vXWM2pPsMtenqpOIz3R86m0tX+EEKA7q9NJpI+Q/DK13AXl8h0QxiTXrnM/+jbO0KzRwIwUwQ3iQSleySsOiGoUF3cyf+TI1ng+7jChPLprnjI0YIsUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861817; c=relaxed/simple;
	bh=eAU/0bPyetc3NrXiJYE10ficvbSuecshK9WUGE4wdhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1YtznEs+Xun7qDr870rEr6OiCw7DMJRA/Ht3fDJZNKH3vk+n82S6fkCzFC4yiMICEZA7GYARqMCsh+xRVKjwnBissgeA4t/jovhaulAUZCmqiItT4SH9vX53zKKNo4n/Ina3CZDvEXqjvMc68E+/xMShXj8mH+WNootG+XwIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJdDexdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B676C433C7;
	Tue, 19 Mar 2024 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710861816;
	bh=eAU/0bPyetc3NrXiJYE10ficvbSuecshK9WUGE4wdhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJdDexdMrOwXd0bgFdkhF8OT0J+gNPZqiM8UobfHg54Qjy9iP0+J8rQgCYLaUPfxw
	 hfZTlFS2628mCbkCg02Xlphf00GRoenVU4FFEnTiybeHodvtQjiN8BIJ4yp5bYEfzN
	 TV1STfZoaythFEohRl76L0PKkia+u5QlL8rt/N4koP+hHjtfN5FpqEve71xduco0uo
	 Jr5CGY6mOCEp/C+pK4sHmY7taR7NijajVrR9RQdsAOtRHVKHN4iC/I01XhbMlQ2G3G
	 Y/Ug+nqgYGq0mdpalXlbyLMZiu9ba3732R8Dr7ibcOeg9PXcWbFljxaAHs3Rmj7MDL
	 FSuPp8ZxdH1EA==
From: Christian Brauner <brauner@kernel.org>
To: ecryptfs@vger.kernel.org,
	Brian Kubisiak <brian@kubisiak.com>
Cc: Christian Brauner <brauner@kernel.org>,
	code@tyhicks.com,
	mhalcrow@us.ibm.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Fix buffer size for tag 66 packet
Date: Tue, 19 Mar 2024 16:23:24 +0100
Message-ID: <20240319-garten-faultiere-0961ff0b22de@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5j2q56p6qkhezva6b2yuqfrsurmvrrqtxxzrnp3wqu7xrz22i7@hoecdztoplbl>
References: <5j2q56p6qkhezva6b2yuqfrsurmvrrqtxxzrnp3wqu7xrz22i7@hoecdztoplbl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=brauner@kernel.org; h=from:subject:message-id; bh=eAU/0bPyetc3NrXiJYE10ficvbSuecshK9WUGE4wdhs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT+XPsh/sq1VdldrI25nSdmn5eWuHLyXtHh7TeWmfyQL Be6s99Zt6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiqa8YGZb++G6mcJuJ8ZW2 63fvoxG1i+/Mqe4KnJTnJvjzJas60wxGhiWrZy84HlJ/8K3HCzmDZ3F9reYLH4pqhr67/4DpbcW MT4wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 17 Mar 2024 07:46:00 -0700, Brian Kubisiak wrote:
> The 'TAG 66 Packet Format' description is missing the cipher code and
> checksum fields that are packed into the message packet. As a result,
> the buffer allocated for the packet is 3 bytes too small and
> write_tag_66_packet() will write up to 3 bytes past the end of the
> buffer.
> 
> Fix this by increasing the size of the allocation so the whole packet
> will always fit in the buffer.
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

[1/1] ecryptfs: Fix buffer size for tag 66 packet
      https://git.kernel.org/vfs/vfs/c/616483acbd0b

