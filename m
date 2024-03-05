Return-Path: <linux-kernel+bounces-92427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B4872002
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395361F21D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10448593A;
	Tue,  5 Mar 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIIavN0w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756C5A7A4;
	Tue,  5 Mar 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645012; cv=none; b=gBICQwvlYSBELwW/jn94m4jx2fCaxTPnpC4jVw9QPebK/+j5nk+GjhWL3p4mlMWXkYgdlj9H6vATK3xkafyQ1APeqgi8GjTEvPcaEjUjy0BK2gJo6ZXTA+QlKVfhClYwZq05FWfdMxrt3KbeX3lLy2BQQZgUg8KL0ZpgbMetAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645012; c=relaxed/simple;
	bh=ZjacMFRjFcKPH1OLTek2CYbT+B+oPwe4QFvsl3DXWm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n++0Cfmbtm0NMOpOqT/TbamTPf3QN13uT/suAdYGsOGVIElP2gvXhI+BdM9FHFTAe15Zo+tMBdD7SBM9V5fRL333s9m5jiPz2f9Oa5BVvekyEJeiKFmtLr+nAzjPYsLOdox95sYje0bqmRwFN3AhTHMnkcqVExlTrJxDiNXF4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIIavN0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAD0C43390;
	Tue,  5 Mar 2024 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709645011;
	bh=ZjacMFRjFcKPH1OLTek2CYbT+B+oPwe4QFvsl3DXWm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIIavN0waKQKcV1EyO/wpS0H1pK1jeNJn1GezqFBjIrilCwRrLz/8IxcKXDOPIJ6h
	 y5/NRftgrdirKEByRlN0f7N3w/LBCM3m8U7lFve3SHcDDiKnP9Oq4h8yJsRKDd2qQU
	 dl6UjOhXGDASmp/uwgIEXgamHMk8O7QkENPcwYSQawYdOJvFsTxAF1Y8WxelnNjvhK
	 s0szFET8QHzUo/8iul8FbbxY9wTwNNbG5/pCmdac+WqtqzOiG52kd5846uzfQVHK10
	 CAF4tqHJ4PHqLZnlgBzm+MDWgZNrZ8+LaUBkD3QED+h8DSvhDs6xhpI6w92jyXzk4n
	 OX7hiN0Rwwccg==
Date: Tue, 5 Mar 2024 13:23:26 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] sock: Use unsafe_memcpy() for sock_copy()
Message-ID: <20240305132326.GE2357@kernel.org>
References: <20240304212928.make.772-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304212928.make.772-kees@kernel.org>

On Mon, Mar 04, 2024 at 01:29:31PM -0800, Kees Cook wrote:
> While testing for places where zero-sized destinations were still showing
> up in the kernel, sock_copy() and inet_reqsk_clone() were found, which
> are using very specific memcpy() offsets for both avoiding a portion of
> struct sock, and copying beyond the end of it (since struct sock is really
> just a common header before the protocol-specific allocation). Instead
> of trying to unravel this historical lack of container_of(), just switch
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
> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
>  v3: fix inet_reqsk_clone() comment
>  v2: https://lore.kernel.org/lkml/20240216232220.it.450-kees@kernel.org
>  v1: https://lore.kernel.org/lkml/20240216204423.work.066-kees@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>

