Return-Path: <linux-kernel+bounces-94555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CE387414D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65A62825CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F80141981;
	Wed,  6 Mar 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm9XkIXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E42E62A;
	Wed,  6 Mar 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756387; cv=none; b=qqs3NBQRXv5FJa2ExTFYL0nyQKqeKfhX7Su6gB5l7yjx522VZJf8X8WJTfHWfO5IA/P3+TFvp2d1hZ3Zc3q21IyPHwMCrlzgZdpczWpeuvikCHV5nPWTgyptYPWDEPRTRvoc7yuAEEkEN2GeKechouP0Ryag82ddwSCT1YvWaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756387; c=relaxed/simple;
	bh=R+UzOju8HbmeP/9dWzNSlLna0T1zG/TTyxsr4sNEKsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwlCCZeohnwykIP28EE+Du0EgUx3KO09QYTzeAMEgGJz2gdRMH6e6RCPGuPjzvGjKdz7NoAzfZSK7R3gK/tgbmTsDbqegLbGI9QdVn5SKbLrKdM3o8IGNsax6PfQJ45E03ywrMUIOph7TGCrcd3LplBX3GDOoAci/s0hsuhvz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm9XkIXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9DDC433C7;
	Wed,  6 Mar 2024 20:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709756386;
	bh=R+UzOju8HbmeP/9dWzNSlLna0T1zG/TTyxsr4sNEKsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mm9XkIXT01OM5cPcQtU9FU3t17+otzKkUrRiUMfzwdrnRgkTnARyvG+4h6Tb3cFxT
	 bQhSNHm1qXhbDUguEZznnIdjC4Ti5k91Nw4uo4Dz0nOcbsvkPOiG9aCInAuarNSPUe
	 PhWLqsKPxU9nddUlonRdH1KGUH4wC0dnJdj7eRfJunC76Hrb8cTad3dmH/cFzMpTlE
	 bvi43a7B6pic4N+vGsV+vkEQI8m+5rN++H9Kq6qIrz2ZfHsWE/rGK29AUdfDMb7Bpm
	 yrIFamkVtnE5eHAIbWFhmrnrCf6NVPt7Lg/IMM0B91zXBMyffa4xpLgSu4/aFtrwBq
	 13Epqu27sVKdw==
Date: Wed, 6 Mar 2024 17:19:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/4] perf annotate: Improve memory usage for symbol
 histogram
Message-ID: <ZejP3gBHh2pWpKaf@x1>
References: <20240304230815.1440583-1-namhyung@kernel.org>
 <CAM9d7chkbcV14PtjhretGLkhUh2mF7sGx9Y0fvG3kZE8aUqpeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chkbcV14PtjhretGLkhUh2mF7sGx9Y0fvG3kZE8aUqpeg@mail.gmail.com>

On Wed, Mar 06, 2024 at 10:26:24AM -0800, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Mon, Mar 4, 2024 at 3:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > This is another series of memory optimization in perf annotate.
> >
> > v2 changes:
> >  * fix a bug when offset is bigger than 16 bits
> 
> Are you ok with this now?

I'll try to check soon, thanks for checking out.

- Arnaldo

