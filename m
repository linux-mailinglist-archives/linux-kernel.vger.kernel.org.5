Return-Path: <linux-kernel+bounces-33589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE4836BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533AC28822F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95A5C60D;
	Mon, 22 Jan 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Tdn0v5OP"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3DC5C5FB;
	Mon, 22 Jan 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937251; cv=none; b=Lc5HLRiTm3yjuYxs2DmdRGmR9kUTZYfKDvOsExkAwiRcXSDvQDLu4vZqtLMvCqV+ejYzf0eFh9nUIyijSRWgOQVF2VgVoUlMARnGdExa1VOLdzHNiJTR2MxLFnchs5HkbS0WNEFbaG5I65A8QJlt6UwtdO0B2CIGFZuMHou/Vk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937251; c=relaxed/simple;
	bh=zlhf19EFPz7bbFjFIicGOGy7fBH0wVnKFgM5wdqSwBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoTlsJKv71AReI0LI1WMg7zwswkietYQCyQcgK3f9knbh/0xWArvnEfwbnvjCzwCyzYUgb2H3Qe2KYZOAJ2JjtKZgA89eR5JTKIFds2D5KoEnz6J0SHObQvLVr+HO7lcdfHDAiBjJYt+ZuwdE9ygaTyAxE/0T8oOJ96VbVWCL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Tdn0v5OP; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1705937246; bh=zlhf19EFPz7bbFjFIicGOGy7fBH0wVnKFgM5wdqSwBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tdn0v5OPdoC9d880gaFyzfmLs+toLv+B2Y0Ui9kaiKdxAYoyTIUeOi5xdlSfRx/jx
	 faE1h9ncC6pJc7GUJ4kUW8ZHF0wHKwqlBNIQUadlEyNXWDuDYjPpSClx7a8XQub3Kg
	 Hi5tl5zb7U5zl3ALtyUR/e8JVFFdDZ+BoX+1GyW8=
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 22 Jan 2024 16:27:26 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 833A480139;
	Mon, 22 Jan 2024 16:27:26 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 74350180D58; Mon, 22 Jan 2024 16:27:26 +0100 (CET)
Date: Mon, 22 Jan 2024 16:27:26 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: resolve symlinks for O= properly
Message-ID: <Za6JXlKKGShvpfWC@buildd.core.avm.de>
Mail-Followup-To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231215160637.842748-1-masahiroy@kernel.org>
 <20240122141203.CWe3n5rG@linutronix.de>
 <Za6C2w0QIZDayA48@buildd.core.avm.de>
 <20240122150501.qCO5PPG6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122150501.qCO5PPG6@linutronix.de>
Organization: AVM GmbH
X-purgate-ID: 149429::1705937246-76F16F3F-11CD03E3/0/0
X-purgate-type: clean
X-purgate-size: 790
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Mon, Jan 22, 2024 at 04:05:01PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-01-22 15:59:37 [+0100], Nicolas Schier wrote:
> > Expanding tilde expandos is traditionally a shell feature, as you
> > already mentioned; and bash supports also expandos like '~+' and '~-'.
> > I think, we should leave the shell things in shells.
> > 
> > Thus, please update your shell scripts to be compliant to their
> > interpreting shell (e.g. use '$HOME' or switch the shell).
> 
> I reported that this change silently broke dash users. If you accept
> this then you could acknowledge it instead of suggesting workarounds.

I'm sorry, I didn't mean to upset you.  Yes, we were aware that the
change breaks some usage patterns.  Thanks for pointing that out.

Kind regards,
Nicolas

