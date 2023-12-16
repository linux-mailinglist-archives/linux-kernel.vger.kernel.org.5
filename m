Return-Path: <linux-kernel+bounces-2368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F569815BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE50A1F225BB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83257347B8;
	Sat, 16 Dec 2023 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmRPJfIZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99FE3456D;
	Sat, 16 Dec 2023 21:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C6AC433C9;
	Sat, 16 Dec 2023 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702760797;
	bh=86vPSyj2wdEgjwC6reQcuCzSzgo1CbfVmSBV11WvmqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmRPJfIZag8T/QeRAvLMX2N/BuWesSE75fsbXI+G0E7wM4q4W5Um0d5EK1Mkiiuo7
	 0BjNAFQ55ZmU2WI0DmZpZLTgSfg6Odh72qcYmOwLaj4PuGaS+iInSFuw9flQjaB2XW
	 VbV+K3GyGCX9OjuJhrUlzuIyUa37ibuzZIFXdPcp/KYjypK2VtjqhdvDFaPGkEBTV2
	 K/NRMkE80+qAu+Fhe9QU+Df1qOrCyB/KqYF/Wc84bPnETXuOtQN4RXMUNUkmNvne2H
	 nmEygwzNpE7QNGVy8O8/MVKKf+C9bzit83zwFjTwo5VuRQA2l4YLFR9VFEKfNkj3po
	 MHD8eeBfTqF+Q==
Date: Sat, 16 Dec 2023 21:06:32 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
	jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, paul@paul-moore.com, serge@hallyn.com,
	syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 next] keys/dns: fix slab-out-of-bounds in
 dns_resolver_preparse
Message-ID: <20231216210632.GW6288@kernel.org>
References: <tencent_B0E34B701B7025C7BAFDBB2833BB9EE41B08@qq.com>
 <tencent_7D663C8936BA96F837124A4474AF76ED6709@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7D663C8936BA96F837124A4474AF76ED6709@qq.com>

On Thu, Dec 14, 2023 at 10:46:10PM +0800, Edward Adam Davis wrote:
> bin will be forcibly converted to "struct dns_server_list_v1_header *", so it 
> is necessary to compare datalen with sizeof(*v1).
> 
> Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
> Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/dns_resolver/dns_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This change looks correct to me.
And I agree that it addresses a problem introduced by the cited commit.
I also note that it depends on the cited commit, which is not present in net.

Reviewed-by: Simon Horman <horms@kernel.org>

