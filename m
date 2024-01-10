Return-Path: <linux-kernel+bounces-22005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F068297CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7F71F25261
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886A40C1F;
	Wed, 10 Jan 2024 10:43:42 +0000 (UTC)
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439340C04;
	Wed, 10 Jan 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 8270ECC02D2;
	Wed, 10 Jan 2024 11:35:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Wed, 10 Jan 2024 11:35:03 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 1B3FCCC02D1;
	Wed, 10 Jan 2024 11:35:02 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 148BA343167; Wed, 10 Jan 2024 11:35:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id 12BD3343166;
	Wed, 10 Jan 2024 11:35:02 +0100 (CET)
Date: Wed, 10 Jan 2024 11:35:02 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: David Wang <00107082@163.com>
cc: ale.crismani@automattic.com, xiaolinkui@kylinos.cn, pablo@netfilter.org, 
    linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: Performance regression in ip_set_swap on 6.1.69
In-Reply-To: <20240110102342.4978-1-00107082@163.com>
Message-ID: <a4dfc3d9-f028-7ab4-c3a7-11dcbb12e377@netfilter.org>
References: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com> <20240110102342.4978-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jan 2024, David Wang wrote:

> I confirmed this on 6.7 that this was introduced by commit 
> 28628fa952fefc7f2072ce6e8016968cc452b1ba with following changes:
> 
> 	 static inline void
> 	@@ -1397,6 +1394,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
> 		ip_set(inst, to_id) = from;
> 		write_unlock_bh(&ip_set_ref_lock);
> 	 
> 	+       /* Make sure all readers of the old set pointers are completed. */
> 	+       synchronize_rcu();
> 	+
> 		return 0;
> 	 }
> 
> synchronize_rcu causes the delay, and its usage here is very confusing, 
> there is no reclaimer code after it.

As I'm seeing just the end of the discussion, please send a full report of 
the problem and how to reproduce it.

Best regards,
Jozsef
-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

