Return-Path: <linux-kernel+bounces-24996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5782C5D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C371C218FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8216416;
	Fri, 12 Jan 2024 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syp/kiR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE216414;
	Fri, 12 Jan 2024 19:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624FAC433F1;
	Fri, 12 Jan 2024 19:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705087496;
	bh=y0huQnU9oMGn7IN7Ez+xSZgABDWDJ5ofq6Kwhw1pbos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Syp/kiR1zkDOEBcshkFbeKkEhfxFkVS/uYNzqoxE4WhbhTXEBxuqrmc6vUA0Rg//W
	 je/8a6WWG/bYoBWGiN9e8mT3IePfSEjE7JpVbtysTxJjLOA2/yKkFRWjdkH3vnqaHg
	 3N+AKPdYVZ1IDwL5HdmkPHTkwGwjuWjEFD2Gga+yoAccE66FWScffp0z+I3w5qRUrT
	 juYMCf9lP0Fu4DXlJWcOyiWtMU7+8V6aeMVXRC9MkIfKjuNcnPZ85adD0inl8Ld1yd
	 43AQzaBiZqb2xEOxmYvJMglMaY6knQK0Rp81yRwJn272wPPTjHm4zJFhBQz/Q/ezOf
	 o27kF7FW6noyQ==
Date: Fri, 12 Jan 2024 11:24:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simo Sorce <simo@redhat.com>, Steve Dickson
 <steved@redhat.com>, Kevin Coffman <kwc@citi.umich.edu>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Message-ID: <20240112112454.0840bcf3@kernel.org>
In-Reply-To: <20240112084540.3729001-1-alexious@zju.edu.cn>
References: <20240112084540.3729001-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 16:45:38 +0800 Zhipeng Lu wrote:
> +	if (ret) {
> +		p = ERR_PTR(ret);
> +		goto out_free;
> +	};

cocci says:

net/sunrpc/auth_gss/gss_krb5_mech.c:458:2-3: Unneeded semicolon
-- 
pw-bot: nap

