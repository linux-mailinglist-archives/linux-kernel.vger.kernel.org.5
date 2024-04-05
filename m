Return-Path: <linux-kernel+bounces-133075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8E899E70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5941C224E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054A16D4F5;
	Fri,  5 Apr 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HuCUokmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBB16D4C5;
	Fri,  5 Apr 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324158; cv=none; b=cQEgmuEw1+ihHou2h1NC00r/WqFFm8fFFlzxo6HHH5r9TtCOUkH/gHQVjGOxbjAXmx/4TQaOUEeyP+q++jvuRQU9xwhAjARLtULjAvq03zGXNWBWNOmB8styPGvP+KXEjja4AlGNewPnpxXk2SuJXzR3VJyAWE70TSGo+BpDZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324158; c=relaxed/simple;
	bh=EhVVh5GZIIEIV/3Uxi1NPA4AOB1c9kMHyH66uTSLA4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s02d1IT32ExxdtIsWFjofb0kEvus8KW1HHzzCXOXpO0rVfRr5c7ewEgigrBdcLojYoOLWtgnV/4OrhsHJUktkg3utxUEph/s8xSk7hQwQJGaCX2mwCL+Ukx/LRjJADWKunSglDBLjpsYmUpLKrnXn7+OOEJK6WleslvYukLnfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HuCUokmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A2FC433C7;
	Fri,  5 Apr 2024 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712324158;
	bh=EhVVh5GZIIEIV/3Uxi1NPA4AOB1c9kMHyH66uTSLA4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuCUokmcH7wC/XtzVv3fJkeuNaCI5eFiD7z/fMW14hC5wcC16v6T6GAQ3mtVqYRoc
	 SewQ312Ll13CAnOJJZnOPpTvfwmsxuHJatMtVi+K3HejTptx8FS1JrfgtWn1fa5/C2
	 O6B5v0TL5IPa2WUCNjBeKEOCMdhc3dKD/qemq6Vc=
Date: Fri, 5 Apr 2024 15:35:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Hagberg <ehagberg@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Russ Anderson <rja@hpe.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <2024040543-enticing-ferris-2fb5@gregkh>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <ZgABC1oQ9YJW6Bw3@gmail.com>
 <20240325020334.GA10309@hpe.com>
 <ZgFY24QT7470ZGnV@gmail.com>
 <CAJbxNHeqY3QevjH3=BuD=DhB0YK6ZvPDbOn_m-LOYAfY81MqhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJbxNHeqY3QevjH3=BuD=DhB0YK6ZvPDbOn_m-LOYAfY81MqhA@mail.gmail.com>

On Fri, Apr 05, 2024 at 09:13:36AM -0400, Eric Hagberg wrote:
> On Mon, Mar 25, 2024 at 6:58 AM Ingo Molnar <mingo@kernel.org> wrote:
> > Anyway, I've reverted this in tip:x86/urgent:
> >
> >   c567f2948f57 Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."
> 
> I see that this hasn't been reverted in the longterm branches it made
> it into already (6.1.x and 6.6.x, for example) - is it expected to be
> reverted there as well? I'd think it should be, until this is all
> sorted out.
> 

The revert is queued up for the next round of stable updates.

thanks,

greg k-h

