Return-Path: <linux-kernel+bounces-85864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAD86BC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664D62876A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6964115CE;
	Thu, 29 Feb 2024 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz3x1Mf7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC0627
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164991; cv=none; b=O3naF0KOqPZ7V5izzB5QxVGE6Kqb4vPRwsynhl6kjfe9uFHonNzAtd2LxctnS2qahV+MTMIrZbPTnwqCKlru8p0N6z55NQ+L6zBKVHbgRuWdSVXlvdeNmqP1KRWrdRDFKdh1M8uIhI9yqGAB5WWI4hhFk06y4xIfss3LjNwsS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164991; c=relaxed/simple;
	bh=2eNs+NXleXBM3q2RwiONecNdyT91kbmW24oSBEL3gjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAxkfH4qXv6VT1toLv+IRoZpwzWRAHMQ8KLBr98dSrCy7SSOMjIdkr4/FKWp8F4qP90F4VdZMUllZFv1yt1ika76h5y4+TIwx7AQfJZjQj4G4H6CPQZAGGUb4QYt0P0H9utQmTuSzQwLm6fhjVFGtMiM+8tuUwGYD/fPbHKdSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz3x1Mf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FBBC433F1;
	Thu, 29 Feb 2024 00:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709164991;
	bh=2eNs+NXleXBM3q2RwiONecNdyT91kbmW24oSBEL3gjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kz3x1Mf7vZMBEzfdWop9nxw6gIhMT4qJ3ja8RuMVdoZXD5zP6R/dOV7YgYyYoGhZ3
	 bsA0LD+hyV6DYLSyr01vxFx7hi8zVBP+zPibn40vMU2C8lL5JfQrSVFr41Z10oee6S
	 DHT49ltyMaufEeOOwxV7NQ/tJ+JjWXryb3t6rZkasfxfLjBAQz6Ibt11lrlWZn6ea5
	 k7AWv+k/ksa+/r7pXrg+2c7ILEdKXoDPJXg2pI8jCmn6ia4xIJ0eEYA0/VuP1ywWCx
	 Ve0MeblfA6mSU5ioqs3cshNHqUQo2/ysuYbH0wE8VtwxNv/P7vUeqrf4AktWSAvTZ2
	 uHBMva28Qy8mw==
Date: Wed, 28 Feb 2024 16:03:09 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Vince Weaver <vincent.weaver@maine.edu>, Dave Jones <dsj@fb.com>,
	Jann Horn <jannh@google.com>, Miroslav Benes <mbenes@suse.cz>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nilay Vaish <nilayvaish@google.com>
Subject: Re: [PATCH v2 06/11] x86/unwind/orc: Convert global variables to
 static
Message-ID: <20240229000309.ibtuk7gr27d7cbxz@treble>
References: <cover.1587808742.git.jpoimboe@redhat.com>
 <43ae310bf7822b9862e571f36ae3474cfde8f301.1587808742.git.jpoimboe@redhat.com>
 <20240228183507.78c5f130@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228183507.78c5f130@gandalf.local.home>

On Wed, Feb 28, 2024 at 06:35:07PM -0500, Steven Rostedt wrote:
> On Sat, 25 Apr 2020 05:03:05 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > These variables aren't used outside of unwind_orc.c, make them static.
> > 
> > Also annotate some of them with '__ro_after_init', as applicable.
> 
> So it appears that crash uses "lookup_num_blocks" to be able to do
> back-traces with the ORC unwinder. But because it's now static, crash can no
> longer do that.

Hm, but why?  Even a static variable has a known address.

-- 
Josh

