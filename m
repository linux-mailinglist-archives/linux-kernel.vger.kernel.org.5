Return-Path: <linux-kernel+bounces-69390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D45285885C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5564B276B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4471482FE;
	Fri, 16 Feb 2024 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JABqaPdL"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E20146900;
	Fri, 16 Feb 2024 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121221; cv=none; b=B+p4LpbRF/UXPymJjfRC1HFn2fw/oofhoR5f+51kC4JAYnkFxX9DsTqe/2uCZ8yN++msDCwhLi2JZHh7JSaXGqE6lXeQOzkkPbX6UFFF/+PojzDJ43aag9i/dC6ElU/KdQMbL9wcc4lc8CeI0LSrbEMTIfO1S2BdazZB+TY+uzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121221; c=relaxed/simple;
	bh=6WONRnosR0Fp6iJnVPXy3F6vPXXlIX/5qT82o+Br1wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvnIGdmI2liC23SJyRXhtyZj2edKIj96b3sO8mPXbYEHHSq3SsmRIJ/HB5kQJbfzMn+Nzp5GGHBNfByqDHK7NyCpx3mluY8ICP8LL/kgmnoad1hPe4tbnZ76a2ehrYwquu7upcPkH2gnKEKsRGDZkz/jFMWWPynnDZZ2ac/AenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JABqaPdL; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708121217; x=1739657217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=luqn3+mL66LkEnqJW2Idc2GGi5UV6QGJD0hWMbRsxiY=;
  b=JABqaPdL++w9JKhXsmLGNZXYGGQp028otuk2JQmLbwiPJezkpTOdwtYJ
   3FRk/TsM9UTKeVrAPrPGNPreKWxIajc8Ye9lufPBHjyPX9FBOlrc0M+ZE
   84CHBYYBHDcQUrOh97rogmBaq6W+QKW9OOX1ueyCmrkdEZPBp7Z/OcKse
   8=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="185388154"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 22:06:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:31833]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.112:2525] with esmtp (Farcaster)
 id b2c3214c-81a0-4661-9e5f-a145032dd5b0; Fri, 16 Feb 2024 22:06:48 +0000 (UTC)
X-Farcaster-Flow-ID: b2c3214c-81a0-4661-9e5f-a145032dd5b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 22:06:48 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 16 Feb 2024 22:06:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <keescook@chromium.org>
CC: <alexander@mihalicyn.com>, <davem@davemloft.net>, <dhowells@redhat.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<leitao@debian.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH] sock: Use unsafe_memcpy() for sock_copy()
Date: Fri, 16 Feb 2024 14:06:29 -0800
Message-ID: <20240216220629.71672-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216204423.work.066-kees@kernel.org>
References: <20240216204423.work.066-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kees Cook <keescook@chromium.org>
Date: Fri, 16 Feb 2024 12:44:24 -0800
> While testing for places where zero-sized destinations were still
> showing up in the kernel, sock_copy() was found, which is using very
> specific memcpy() offsets for both avoiding a portion of struct sock,
> and copying beyond the end of it (since struct sock is really just a
> common header before the protocol-specific allocation). Instead of
> trying to unravel this historical lack of container_of(), just switch
> to unsafe_memcpy(), since that's effectively what was happening already
> (memcpy() wasn't checking 0-sized destinations while the code base was
> being converted away from fake flexible arrays).
> 
> Avoid the following false positive warning with future changes to
> CONFIG_FORTIFY_SOURCE:
> 
>   memcpy: detected field-spanning write (size 3068) of destination "&nsk->__sk_common.skc_dontcopy_end" at net/core/sock.c:2057 (size 0)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

I confirmed unsafe_memcpy() is just memcpy() without fortified checks.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  net/core/sock.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 0a7f46c37f0c..b7ea358eb18f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2053,8 +2053,9 @@ static void sock_copy(struct sock *nsk, const struct sock *osk)
>  
>  	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));
>  
> -	memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
> -	       prot->obj_size - offsetof(struct sock, sk_dontcopy_end));
> +	unsafe_memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
> +		      prot->obj_size - offsetof(struct sock, sk_dontcopy_end),
> +		      /* alloc is larger than struct, see sk_prot_alloc() */);
>  
>  #ifdef CONFIG_SECURITY_NETWORK
>  	nsk->sk_security = sptr;
> -- 
> 2.34.1

