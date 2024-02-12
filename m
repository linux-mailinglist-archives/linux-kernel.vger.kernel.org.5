Return-Path: <linux-kernel+bounces-61603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3565851420
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9801C20E00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137DE3A1B4;
	Mon, 12 Feb 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS06yfiY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C503A8C3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743365; cv=none; b=rhx4nzO+vPfZ2z1RDTcf85okz/Di1vwsJdZuHNXoklSfC1xUOq9d/AzwYPcZ+sU/x2vSCCAyScfd/GdvC7lhoiJDWkPp+1s46DNVjEq2n+gvHeIHBHPzyl6zKV0gKr4jmCaQyVQChdSldNEIDLeiMvcyRogcCQGNnsnhE95/b6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743365; c=relaxed/simple;
	bh=ZFSAXopDMZCjTdY1fpM24iNylF7FaL1HTB5ZZDomxNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6yn3eWRLCVl/WYnsisHaq1Da/TTHIoT7dDKujhttlB1Cj78WxNZ89rZslaP0xgF1xhCyjDrvqguBAwwtFDINkhKoJZl3WCqRedmpfiXvWduoXtpwZKjGugGR0g484VL5qXSCH7b7lA/mXeTFpH2YjWg8yA6+163rxeMzAHM9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS06yfiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FF8C433F1;
	Mon, 12 Feb 2024 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743364;
	bh=ZFSAXopDMZCjTdY1fpM24iNylF7FaL1HTB5ZZDomxNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RS06yfiYLA34+Q0JfqmqTs3avQfnhukBM9eJp0xzhNEYh/5m7/2ze+OWWO8JW/9Wv
	 NGz78mqefrRGea7knKfGZEWP+Pl6l8qW6eRSulJbpbCHMNxB3rGLL1I/cSYG2gzrJz
	 JtVmJpb0qfVdVd0SJ8Cpka1BXfofdmHwTCZYxBOeJVBTihguUoiht5EwRiIIuPqYK9
	 gkSA5OENh5lL5dmpVP2u2VPvoiYU3xIpE5V4EuxNzbYA+BcLqL7FAbtz3A4cCPWsBc
	 uGFU7NS0xtfO7h+DRMxUk64UE3hJoo42KSWQWmxHRNz0bxhSyb9GNREFKlpZ2K9duY
	 beshAT02c0Shg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Luca Vizzarro <Luca.Vizzarro@arm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <aahringo@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] filelock: always define for_each_file_lock()
Date: Mon, 12 Feb 2024 14:09:06 +0100
Message-ID: <20240212-seicht-ruhig-d577ffd40f50@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212-flsplit3-v1-1-019f0ad6bf69@kernel.org>
References: <20240212-flsplit3-v1-1-019f0ad6bf69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=brauner@kernel.org; h=from:subject:message-id; bh=ZFSAXopDMZCjTdY1fpM24iNylF7FaL1HTB5ZZDomxNQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSekqhO8Q5/+1M6yCZ/5wb+/4fVFBWzjK5wm/224GUyu xU88e3HjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkEezL8s9+h8Gmj14Ut99NY q45FilxNf1KkqJB/LpxR4qj6tIYDNgz/tH9c8PmUblq1IUJQ0iF+zd7Vas6h9/LS732pfNJv8sq LFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 Feb 2024 07:24:05 -0500, Jeff Layton wrote:
> ...and eliminate the stub version when CONFIG_FILE_LOCKING is disabled.
> This silences the following warning that crept in recently:
> 
> fs/ceph/locks.c: In function 'ceph_count_locks':
> fs/ceph/locks.c:380:27: error: unused variable 'lock' [-Werror=unused-variable]
>   380 |         struct file_lock *lock;
> 
> [...]

Thanks Jeff and thanks Arnd!

---

Applied to the vfs.file branch of the vfs/vfs.git tree.
Patches in the vfs.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.file

[1/1] filelock: always define for_each_file_lock()
      https://git.kernel.org/vfs/vfs/c/582a3bf999df

