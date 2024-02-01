Return-Path: <linux-kernel+bounces-48892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161738462E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC92A1F25A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBED3FB14;
	Thu,  1 Feb 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3er++EI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20473F8CC;
	Thu,  1 Feb 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824231; cv=none; b=qLRE3UphPINC2AvL+0pj4saXH0K4tya1YXGInxBz9uywc/F9UMPbeTm2aF/H8czWWgSBs8yT/GtkPX1RMf8k4dDvwYU3gAMT7uKuLhQcg2BWzD/i9J5+thviJ0sea0XWys1svaBlMeBAx08cK2/w4t5Y9OXvgoEn8t4MlYfW6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824231; c=relaxed/simple;
	bh=d+q6ve5CBRw/2MSaAxqWXKnJ1dwYOY+ordJjCePXBm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd/MZaOIz4CRGi7ah33iBrKWZ+65bYx5aUq943THmehjkT05Yle1laM2BfyVcdpR7AYqqptNIwffrH4P0XY4+p7ng8F20J8Q4T0FwxQB1XpuRRA4j/gvUBWl0ZATYoxsD5lXeYpoMlUKwaWo1vAbDGmbUetMO3MqZxr4GTLdUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3er++EI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06387C433C7;
	Thu,  1 Feb 2024 21:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824231;
	bh=d+q6ve5CBRw/2MSaAxqWXKnJ1dwYOY+ordJjCePXBm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3er++EILPaUnEmrS575drGp2XiA1P9x7zo2fByf31/le2W+ls2s6RWVUG0dDh7Cm
	 OohlJuH1yOKSRWfWM/O/Ln1MqNFX5VFbejUSN2LPLl2PkgLVM4aVzuU8qmG+zutWPR
	 g5AyXLjDaRg3ZJaEKEDIQshvSJCMmpTOUwUECk+HN9JfbG+c5REOTq8UQiMdSCFztS
	 MoCutikVC06IooE8U0RWxoH4xeQHJNtxADdH/nBkwmHZM6QtidLv95lrJ9YalXnQ5n
	 QNiX98Mh5DrdeQAm2P1LgW90SNVLtLJdTKCHcEiVwm9U/NdYBBeGwhpAOId2qg2YJ3
	 NjYAlubtBNgNQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CDFB140441; Thu,  1 Feb 2024 18:50:28 -0300 (-03)
Date: Thu, 1 Feb 2024 18:50:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.8
Message-ID: <ZbwSJAayut8nXSXw@kernel.org>
References: <20240201202254.15588-1-acme@kernel.org>
 <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
 <ZbwJrkkQbUxw-hyb@kernel.org>
 <CAHk-=wgVxsBrf9hme-VQ+h+h6j3V9n_ph0ALT1EANDiEKy3uHg@mail.gmail.com>
 <ZbwMjWO-AD1eB1a_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbwMjWO-AD1eB1a_@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Feb 01, 2024 at 06:26:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 01, 2024 at 01:21:16PM -0800, Linus Torvalds escreveu:
> > On Thu, 1 Feb 2024 at 13:14, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > I should've known better and not send the noisy JSON changes at this
> > > point in time.
> > 
> > Arnaldo, it's not the JSON changes in the history.
> > 
> > It's the absolute garbage in the *tag* itself. It's crazy. Do this"
> > 
> >    git fetch   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
> > perf-tools-fixes-for-v6.8-1-2024-02-01
> > 
> >    git cat-file tag FETCH_HEAD
> > 
> > and see complete and utter garbage in the tag contents.
> > 
> > Note: that is not a change *made* by the tag. It's literally just
> > garbage content in the tag *message* itself.
> > 
> > You have something *seriously* wrong with your scripting or tag
> > creation workflow.
> 
> Ok, I'll check, as I said I switched machines, I must've screwed up
> something.

	I created that tag, then realized I made a mistake, did a "git
show that-tag > /tmp/foo" to save the cover letter, then when recreating
e signed tag used the contents of that temp file, but forgot to remove
the end that contained the previous HEAD, d0h.

	I fixed the tag and force pushed it now, I looked at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/tag/?h=perf-tools-fixes-for-v6.8-1-2024-02-01

	And it has what was intended, hopefully no craziness now...

	Double checking:

[acme@quaco linux]$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools-fixes-for-v6.8-1-2024-02-01
remote: Enumerating objects: 2084, done.
remote: Counting objects: 100% (1075/1075), done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 2084 (delta 1055), reused 1071 (delta 1053), pack-reused 1009
Receiving objects: 100% (2084/2084), 1.18 MiB | 1.15 MiB/s, done.
Resolving deltas: 100% (1589/1589), completed with 551 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
 * tag                                 perf-tools-fixes-for-v6.8-1-2024-02-01 -> FETCH_HEAD
[acme@quaco linux]$ 
[acme@quaco linux]$ git cat-file tag FETCH_HEAD | tail
  - Also, without tooling effects: asm-generic/unaligned.h, mount.h, fcntl.h, kvm headers.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR2GiIUctdOfX2qHhGyPKLppCJ+JwUCZbwOmQAKCRCyPKLppCJ+
J/TkAP92DD1ZKmc9WzlJ8vpbz+nXwvMIDTRSSBnvYPiDNSL6xAEAkX92qWUQ35RS
faz2v593RZ4VfthcAEl5P6FXEhHhfAc=
=pDc1
-----END PGP SIGNATURE-----
[acme@quaco linux]$ 

- Arnaldo

