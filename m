Return-Path: <linux-kernel+bounces-148807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C428A87A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF57282DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED3147C9E;
	Wed, 17 Apr 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nMtnDykE"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFC147C8A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367929; cv=none; b=RWV/ZQvdA6QnvB5tBskmryomYr+k9OIc69uFIYM0bk3NR8uzTqmnUs4L73+Kmsvp5EXNV0TtQZBY/xyzPz9pme3TieetnSAn+2OYovaBNTqp0iGEA6GwnNAW2t8GTsbiJR742stKXe8xEXqKCK5dfvuLI3FdEtmYNFBzWoSXXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367929; c=relaxed/simple;
	bh=uLgeUL+C/7Ff/mPtDOJn/RgT0bHJZ8IcFtXcqbCQ+lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTp0HvoESQAVGRMNEOisds/P5HvU2tep/3oTJLHhQ1jOcSUsy4Ze6odTUhBd8CgRR7fMYLCVJdytpoD+kc72VNNFaVr5ahIAXpHs80nTV+vzVbSWKlMIb4foicExEJGoiAFBM1tevIDs2tSTWHOSZwfiTlQ7t+Z530dR3jDZgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nMtnDykE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43HFVM8p016211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713367886; bh=OUs4KkgaD/FpvJ+2NJzXqe7hy3aMJMIJWA9eaTknY8E=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nMtnDykE1F1kxHm5GQfr4ZqPYU3K4i+JZ44Je1xsc+SeP+WWSIb60AnjNISDIjdih
	 Ih4ucOoOEjpm2vxAnjhJ6FsWtcVeJx/4+61j2OCSOnhDxtJuhT/msapmB/CpV6dEEP
	 4VQkk+Z1IczSdfxuRpDsu8XRMsZa6amXUgmYalqB6t87sglA+Br/ICuZj5cNWgkjsp
	 KGaxCjs7zVfxQl0u0k3rz3bW/2Ke7eGq5wze71vflPSO16lggQ3nIY0rm7UN7lQqm8
	 9HHg4MjglepgvNC8tSaEZlRyUQIeT6Lbochp4uvZ5bpYbfZlbduMxUTKurUDQCHaYa
	 09ARNt790bi+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 91D7115C0CBA; Wed, 17 Apr 2024 11:31:22 -0400 (EDT)
Date: Wed, 17 Apr 2024 11:31:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nam Cao <namcao@linutronix.de>
Cc: Mike Rapoport <rppt@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240417153122.GE2277619@mit.edu>
References: <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao>
 <20240416173030.257f0807@namcao>
 <87v84h2tee.fsf@all.your.base.are.belong.to.us>
 <20240416181944.23af44ee@namcao>
 <Zh6n-nvnQbL-0xss@kernel.org>
 <Zh6urRin2-wVxNeq@casper.infradead.org>
 <Zh7Ey507KXIak8NW@kernel.org>
 <20240417003639.13bfd801@namcao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417003639.13bfd801@namcao>

On Wed, Apr 17, 2024 at 12:36:39AM +0200, Nam Cao wrote:
> 
> However, I am confused about one thing: doesn't this make one page of
> physical memory inaccessible?

So are these riscv32 systems really having multiple terabytes of
memory?  Why is this page in the physical memory map in the first
place?

Inquiring minds what to know,

						- Ted

