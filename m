Return-Path: <linux-kernel+bounces-116889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92F088A4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1621C3C12C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40CF82D9D;
	Mon, 25 Mar 2024 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc/oiVqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF917F360;
	Mon, 25 Mar 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363628; cv=none; b=mC0aYT5jthMyrKQtgLFWEMzo5kxq94n3PAT+wIJsupBzxbH8UfnzQ5QHJwhp9Nscn6Y/5k9DnjjxuHqJ+U9rnDLqZkawIGCeMPVr4dkUt1njJ8yk+8MdArLmXGWnp2n1TlnXoJyCAJ15mWCxjz7frFmpzu0z7grV52001f6M1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363628; c=relaxed/simple;
	bh=r31SBBkS3IQnuOXsL/OAJ6hP04pjUORZG5Mw9x9NTps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upYCVodHZGfsNqGQFY7OpterR1d2At4oLbmamKtF/fDKwgLiOqZ4jx/S1VgCAsBQl7V7kJfZYytlgxaTM4gKc+5zyEr2FwUy41ueD4dxFWkX1L1Efs9vIlgOt59LbFEMs2ysBFddm99RaHWugQNwZ+vmChbmNvPMuuNh9FAmRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc/oiVqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BCEC433C7;
	Mon, 25 Mar 2024 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711363626;
	bh=r31SBBkS3IQnuOXsL/OAJ6hP04pjUORZG5Mw9x9NTps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kc/oiVqO1kdaPxCngGTgEuTZRx8Y+Ojs1SmR2fp3nID5XXQkoQlMVliY8frbY0Yj/
	 GKB4+E8wU/4J3dgkVBqX6mENGL6NOrJlG9n9DAF+TqPB2RIf6ZSb41cqHdcFlgi07H
	 vTEwvK06xi7vBRu4cGK/YtAyetBSoZPRo7dmG8RPKJoHx1yE9GZTxlagrtp4lHSzSz
	 Wxfg7Xq+F6OHeWZ4KnHtlc4MQW2eG9YJXwwvgOFnfUS4e8sd6Am85BYwBtAuihjK85
	 HQGSTX+yyOKfAL1jfSzXd8Juu2luHou2rDFr63/NqORZ8t1IWcQqyiCWKLDT9lnsvj
	 vq9w/OLWiE9Rw==
From: Miguel Ojeda <ojeda@kernel.org>
To: sashal@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.8 196/715] bpf: don't infer PTR_TO_CTX for programs with unnamed context type
Date: Mon, 25 Mar 2024 11:46:29 +0100
Message-ID: <20240325104629.76523-1-ojeda@kernel.org>
In-Reply-To: <20240324223455.1342824-197-sashal@kernel.org>
References: <20240324223455.1342824-197-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha, all,

I got this one while built-testing 6.8.y for LoongArch with Rust enabled:

    kernel/bpf/btf.c:5690:10: error: expression which evaluates to zero treated as a null pointer constant of type 'const struct btf_type *' [-Werror,-Wnon-literal-null-conversion]
     5690 |                 return false;
          |                        ^~~~~

Upstream fb5b86cfd4ef ("bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()") changed the function into another one, including its return type to `bool`, so it seems that one is a stable dep or perhaps making it return `NULL` here.

Hope that helps!

Cheers,
Miguel


