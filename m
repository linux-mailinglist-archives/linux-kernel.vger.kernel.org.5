Return-Path: <linux-kernel+bounces-148867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822988A8853
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C941F21502
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6471487E2;
	Wed, 17 Apr 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL+H5lBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9261487C6;
	Wed, 17 Apr 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369559; cv=none; b=ch5DLE2d4LYU8Uo2O4ofBIMxX8JqAQfhqMMd/TUzEFs/348JHRMNsLkEd4K1x2BrLdYItlu7R08ZSHxhRd4+y5nBIIrWrzOSev5teb6cVGk4vtdgZMw1zzW3X/ENXjFKmFcI1GGpVKIS2ZcYsMpjt/VBZgw7NrruqFN4WomUSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369559; c=relaxed/simple;
	bh=UZiJOhiexQp0bZizQPTKAWHNiRbtg+8aXN8vVVHAyTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owUPk2HXdRKuJ3xBvJBb0QEnCRtStKJqK6u5lWju0MRQfi7OXiErPtGJtc8xkRll5xYQS9hTNLknwiMlrh9dzUz1oy0psZPiXFwZirQ2ZpThh42QqZ4HBliLiKwCeSgdptcQPopJhh26N+C0kwMc3hpJwKhJYVAk1Wb394S6MME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL+H5lBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65873C2BD11;
	Wed, 17 Apr 2024 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369558;
	bh=UZiJOhiexQp0bZizQPTKAWHNiRbtg+8aXN8vVVHAyTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rL+H5lBs4TZGMqDH1ZjnQFpDjbQUWqKY3vSv9FtLbLusG/j0bPhVUj750XeNpd4KC
	 /xtzekKpiwXBiRb410H0JcwFWxS4AuzSgclt8RgBSk8N5lS1jJnFM95PjnSGygz7PG
	 SYJdvG07hcqHo3aQj008Jv/klLYQauj19mV1sSEvvpjYL5bg8Z3x4Xw0mIYX4H6Z69
	 cfvEq184UwO48YATqgmpbx8xT5kyWqtPxtvCOayF0HfI3dNDMq/0hkx/tQvjg+/Lvq
	 9NAkKr++ZQ6cAUML0ZIe8Ofct1rBrWrHeBGGQ3CKDzPuc2TvgBz9BaUUe1YTPFFuqa
	 2iVpA7ckmrCdQ==
Date: Wed, 17 Apr 2024 12:59:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: cp0613@linux.alibaba.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] tools/perf: Fix compiling with libelf on rv32
Message-ID: <Zh_x0_VSO72xyaer@x1>
References: <20240415095532.4930-1-cp0613@linux.alibaba.com>
 <CAP-5=fWZSPTtk+UjssH4Mhw11CAP0-jZcZAbCesdqrVCnZbu2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWZSPTtk+UjssH4Mhw11CAP0-jZcZAbCesdqrVCnZbu2Q@mail.gmail.com>

On Tue, Apr 16, 2024 at 08:04:55AM -0700, Ian Rogers wrote:
> On Mon, Apr 15, 2024 at 2:57 AM <cp0613@linux.alibaba.com> wrote:
> >
> > From: Chen Pei <cp0613@linux.alibaba.com>
> >
> > When cross-compiling perf with libelf, the following error occurred:
> >
> >         In file included from tests/genelf.c:14:
> >         tests/../util/genelf.h:50:2: error: #error "unsupported architecture"
> >         50 | #error "unsupported architecture"
> >                 |  ^~~~~
> >         tests/../util/genelf.h:59:5: warning: "GEN_ELF_CLASS" is not defined, evaluates to 0 [-Wundef]
> >         59 | #if GEN_ELF_CLASS == ELFCLASS64
> >
> > Fix this by adding GEN-ELF-ARCH and GEN-ELF-CLASS definitions for rv32.
> >
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo

