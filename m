Return-Path: <linux-kernel+bounces-123661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2D890C52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57C5291A38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425513AA24;
	Thu, 28 Mar 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="Bae5Bg09"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8581386DC;
	Thu, 28 Mar 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660501; cv=none; b=st69lM96BkQRmaOZaHSBhQ9TDcfOKY9ULyviznxm7GoHy4Hnqnv4pXSBXHMnq2cDVRXkvi4zwIjy9nHSnNPuzbkt7/A4WAF1Rn+nCbMDfa7ZUZT0cvYTBkkeeOKioROg4fSvQ66RK/zFluMoF4GuV1k112aEqhkYkRtyFbAGcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660501; c=relaxed/simple;
	bh=9z0mgMAwNHiFsfGgfZzfnkUgXdttGFyaKKH2e0u+YYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAdtqNc+Ye4Z+38czxX207WsL/vOaQMGHhG9kTr07ScxkQ7TVp0PKET53FEWNjkeCcQYm0TJKVeOULqLK/DeTe993kTvWm9aefjP377DymJaXmT0Tf3zNc/KTfHiOHsshU7rWakj+9MnzgO9GQrkq3+57nYN0fNVH1Gx/SvlpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=Bae5Bg09; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1711660486; bh=9z0mgMAwNHiFsfGgfZzfnkUgXdttGFyaKKH2e0u+YYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Bae5Bg09dsERm0deJ770aWjxUXnye6XJnSDNJGMUS930v86BsO1XwY1CVcuCmE82n
	 d178rS8JltOeJ6rEglozEJzCbs+tjIOiQmgXSCzKcf6w6WkPpoDyJ5OlhCJO51JfKq
	 mCs4/MoVcmrsY5bJVmTpdSvV2h9NxQnyOqjLpHsNcoRbH6gdVyDxdl0RGgrknqiSs4
	 +pM2rLnEXZmaSTBVbJT0OahnejWvlPvuchcpDPUiwsAiCD08l5qglPNV91781gN9Ll
	 /JhVQRWptJPXu9y418lhwJhrh3ta0LoWB0SePlt4X465vuRBaGXk/CUm4CJJORAMoT
	 br/ijvjmsh/Jg==
To: Arnd Bergmann <arnd@kernel.org>, Kees Cook <keescook@chromium.org>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Jeff Johnson <quic_jjohnson@quicinc.com>, Dmitry
 Antipov <dmantipov@yandex.ru>, Hancheng Yang <hyang@freebox.fr>, Remi
 Pommarel <repk@triplefau.lt>, Johannes Berg <johannes.berg@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath9k: work around memset overflow warning
In-Reply-To: <20240328135509.3755090-3-arnd@kernel.org>
References: <20240328135509.3755090-1-arnd@kernel.org>
 <20240328135509.3755090-3-arnd@kernel.org>
Date: Thu, 28 Mar 2024 22:14:45 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wmpm12ka.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-9 and some other older versions produce a false-positive warning
> for zeroing two fields
>
> In file included from include/linux/string.h:369,
>                  from drivers/net/wireless/ath/ath9k/main.c:18:
> In function 'fortify_memset_chk',
>     inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main=
c:140:3:
> include/linux/fortify-string.h:462:25: error: call to '__write_overflow_f=
ield' declared with attribute warning: detected write beyond size of field =
(1st parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
>   462 |                         __write_overflow_field(p_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Using a struct_group seems to reliably avoid the warning and
> not make the code much uglier. The combined memset() should even
> save a couple of cpu cycles.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

