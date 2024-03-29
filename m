Return-Path: <linux-kernel+bounces-125414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7118925A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F9284E92
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CB12FB23;
	Fri, 29 Mar 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt5XZQ8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB043FBB4;
	Fri, 29 Mar 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745626; cv=none; b=CVPCGk9LD0NbPjQV8T2NNphifh6hmBZaegACNK3HaX/lTWENaRN6Fdlf4knmT1jZjTtE/cxgVHj9nX5tC5bpS5XTf8CDbYoJ8g3k8LTz7UeL48U8g6RJk1nD/BJIk/d7y/S9r0GuQb3dVmwVSdggts92/Fgf7pXeAN/MxmrFpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745626; c=relaxed/simple;
	bh=DPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/YgEleA7dhqMltk+cpaDAI5CB6Lxj8GtF3ftBqkh9p0yRW9z2he+RRe91fZHBJ+LqVhIsvHLMH0FT77gqRr4dYhRzsYZMFuBhQLc59ydGn2GoVeT3YNhGEpWwsNRFQlNo3N0K05H4mJRNmROttjq61J8Xwbz+5tyOFWqpx1HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt5XZQ8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A95C433C7;
	Fri, 29 Mar 2024 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711745625;
	bh=DPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nt5XZQ8AuFdzkpc2dRk4glfwOAVOcm1EdgvmJH132ePhRwjx5yZG7K5MDJf7XEaXf
	 DNUmTCxPOgEyg82a0x+w/HjPxm0ksMkeaCOMP/vZCOd9Xzx3wgYHLnO9JCshz15SQT
	 rMXaDnaBpPXSvZDu8fKKgkDjwpyBmbuvSAJQVLwDGgLMXs4WbAgKj4Swf1TEL7R6BY
	 7WPgwSohXsmR/Hlvjyyvl3pMa00trccpz/7FsrFsTzXSAyPZ+F+H/We6eRrIqvKQTE
	 Nt2XqeSYRkKbZraS9gxLxNtOsHaK4zygIPknpsWEa2Jr/9wVwM+l4r1fJB94AFXUB9
	 5iFtrKKt4p58Q==
Date: Fri, 29 Mar 2024 13:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329135344.1a310f31@kernel.org>
In-Reply-To: <20240329131857.730c6528@kernel.org>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
	<20240329131857.730c6528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 13:18:57 -0700 Jakub Kicinski wrote:
> > Sparse:
> > 
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_res' shadows an earlier one
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared here  
> 
> I don't see these building with LLVM=1 W=12 C=1
> and I really don't like complicating the code because the compiler
> is stupid. Can't you solve this with some renames? Add another
> underscore or something?

I'm stupid I tried on the test branch which already had your fix..

This is enough:

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..2270fbb99cf7 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -89,7 +89,7 @@ struct netdev_stat_ops {
 
 #define netif_txq_try_stop(txq, get_desc, start_thrs)			\
 	({								\
-		int _res;						\
+		int __res;						\
 									\
 		netif_tx_stop_queue(txq);				\
 		/* Producer index and stop bit must be visible		\
@@ -101,12 +101,12 @@ struct netdev_stat_ops {
 		/* We need to check again in a case another		\
 		 * CPU has just made room available.			\
 		 */							\
-		_res = 0;						\
+		__res = 0;						\
 		if (unlikely(get_desc >= start_thrs)) {			\
 			netif_tx_start_queue(txq);			\
-			_res = -1;					\
+			__res = -1;					\
 		}							\
-		_res;							\
+		__res;							\
 	})								\
 
 /**

