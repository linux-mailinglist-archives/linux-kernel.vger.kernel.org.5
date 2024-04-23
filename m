Return-Path: <linux-kernel+bounces-155797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AAC8AF742
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D187F1F225C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D391411C7;
	Tue, 23 Apr 2024 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A30vLFBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1028DC9;
	Tue, 23 Apr 2024 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900294; cv=none; b=Ig5Ai/aYeFXaGHSa2AOwu3iqhwucgkiLfm6dT5JkV67Jtbg6AIfQZrBVMA05hH/A6Pa9N1CVh1E+CM1yYkSNn3RZqWFdjBhbr5VBhe0QI/NNYr4h4esPGpvQjAcRrCRNc/WjAAVdJXI5yNtCWbeNj+o6jTYpu9wR3tSSTCZhmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900294; c=relaxed/simple;
	bh=gU5DjyFVcSjRr2SRhtji211Cs+TNH+YaJyyQsi8/VJM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=caIR2uyvMFwEjGGDIWqErk0N5k1hhY6g4zLirovRk2MpEW7pnxsNVOUgnaqTh8dXZvTvCEP14JhhfpskpmH+ixZaQTLwY5SFPnyrlIvYOQAtBk+SPEo3QN2ijlG0mlV9TxRXlaiKg3JopHUzznDB1j73mRkZZS0nfVzBYSgVV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A30vLFBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAFDC116B1;
	Tue, 23 Apr 2024 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713900294;
	bh=gU5DjyFVcSjRr2SRhtji211Cs+TNH+YaJyyQsi8/VJM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=A30vLFBPiR0pchWkzdGhcSUjqEPyqAQIcwaoYd0KLkqzW8fOwWlx7oD+jPSboDeD5
	 OEZZAVh+KA6sW4i1XEnbr2Lkr6w8xcVZxsTi6Lbs/4S7MEpwQQcCkdjO5arNxsM8wu
	 j1Mi4tNQfBO8SZ9VyKh2y7bh6VSciuqYPKXJNyECB/oup5lqfMPfj+5+fOHNtuwP+4
	 bWzukIpPHyTER3SP1ivEylGQsnR8/h8OqTIUqzzaihcwKYhIGPU2q0XX/FLOOr6zV5
	 xqJ5PFZ4NIN6S8Rs3WtBsVffY9olobd4HaPTAi1xiMaqGTJrzel8DBo0XsVPOxX812
	 H8obg44KBdjWw==
Message-ID: <cc21ff5ddd8fbe07e75fdffd596c0aa1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240423110304.1659456-6-sashal@kernel.org>
References: <20240423110304.1659456-1-sashal@kernel.org> <20240423110304.1659456-6-sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 6/8] clk: Don't hold prepare_lock when calling kref_put()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sasha Levin <sashal@kernel.org>, mturquette@baylibre.com, linux-clk@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 23 Apr 2024 12:24:51 -0700
User-Agent: alot/0.10

Quoting Sasha Levin (2024-04-23 04:03:01)
> From: Stephen Boyd <sboyd@kernel.org>
>=20
> [ Upstream commit 6f63af7511e7058f3fa4ad5b8102210741c9f947 ]
>=20
> We don't need to hold the prepare_lock when dropping a ref on a struct
> clk_core. The release function is only freeing memory and any code with
> a pointer reference has already unlinked anything pointing to the
> clk_core. This reduces the holding area of the prepare_lock a bit.
>=20
> Note that we also don't call free_clk() with the prepare_lock held.
> There isn't any reason to do that.

You'll want the patch before this, 8358a76cfb47 ("clk: Remove
prepare_lock hold assertion in __clk_release()"), to avoid lockdep
warnings. And it looks like the problem was reported on v5.15.y so all
5 patches from the series would need a backport.

 8358a76cfb47 clk: Remove prepare_lock hold assertion in __clk_release()
 6f63af7511e7 clk: Don't hold prepare_lock when calling kref_put()
 9d05ae531c2c clk: Initialize struct clk_core kref earlier
 e581cf5d2162 clk: Get runtime PM before walking tree during disable_unused
 9d1e795f754d clk: Get runtime PM before walking tree for clk_summary

