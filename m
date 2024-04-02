Return-Path: <linux-kernel+bounces-127598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7792894E30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C6FB24319
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1D356766;
	Tue,  2 Apr 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d3NshYrw"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1244C601
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048551; cv=none; b=rorTcc+my9IDUBWirvkeovaS3luBc2iR/KC0I055fWxYh4GnOlI4coiAiYSUxoNQ12bJrS+voCAio4t0wMRiGUHGknrJIGb4vHtEzH2Pqwl4g8WY5pFjTUEl19JmbmYeCU2r1Jn4PGaBPiqpySGN8kOL2/Ct4jEOfHZYHg/M1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048551; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okQC32HFCIgy1erzRXV/t9wgIj9l8BuAmkLbZAKj9TCxk6KT7FKqA80ZAui1jWFV3mRfYp1Mb/26UhC/6wUktuRndQfab33e63YYdXoXu3B1DPSgcDkwi6Hv9+p1poCXbKJ2pUi5lxOtSSOQG2PaWdz7zUkKY482TgrGX7d8lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d3NshYrw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4560662b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048549; x=1712653349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=d3NshYrwWuE0PPBewoeqmyKsTKuz/7d2vAO8xjWkq/yE0Tep03KSNkVTWEYiJ1gGPM
         R1m5iWzmckxDpCVZ6vkOzLlA75uaiQRajozDUX1SL/Gveon6Zx+unDQNOKKajxUwL6M6
         KFxyA7kMizAfxGx6YCo+x9m1a5TSxBBDKuw4wRU9MhUFaDvzERp96hqsX6pja2LYflbJ
         FtyiKmSKPEkbKAfZKPo6r3ehWhnYnbO8J9xqVhp6H+QkAIA5LrPt/38yl3ovjA9CbrPS
         t8N1iC8EpjJLEN6F+efTQt6NKlsUlCgS7GOvRRaRgDnlTtqtKwioXxvUE6/7TTIEbkLI
         rTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048549; x=1712653349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=aC7sX6UfgEA3lB+FjQRFULoLiVg0sj2p62GbuYr8sFQicapQffXej6dutQ4X4So/K5
         g32ZJAscxgvpdoKdq28MWFbj/4CrervVAno76/AEwq3kqHkQ+OhH/cN14611K9qK6N8K
         BsPMkz//oZA7/dVNV5568zRMqJkmDLbwds3a5fvi0eTa0rHyksQB3MtlIMUTXMxYqmVR
         BGUlO1ZNSSjiX3VQ/YWnMY/9eRudullCHRKymWP2CGR+51ywdIuIs3L3A9VkCvQ2QeK5
         ceQH9XfbVHXe3ifNgTCGI+0sSaAw46jWxVodL0tpoyoUuEUVSr/7GdBm756MAWVJRvF5
         tXrg==
X-Forwarded-Encrypted: i=1; AJvYcCXYGmJaq7h+h8R9HGc53Sp0thl+2xUefXdvbzUqNG6HuO+Jn8NTmbHgG+Kxqki7TC5w3JbzyVs1CHTy2VVT22n3apqbdIrzOx7kiCZy
X-Gm-Message-State: AOJu0YxubCkjpPCOHoiO+SxvOhsbtj3PebKcVdh1+8q2oRUzpiXJHI7p
	845J99fDcDSk6A9bUD7BS4bEntPHotkWhmhSshoTD6e3QE6bm7KC6ezPYzcl9dgSL8O+JqvhWfR
	nuvh/iwXQjSOpGuA3OzveQN3MrkP0I7BfkuXkjg==
X-Google-Smtp-Source: AGHT+IGNSFtfd8t/rR4qshARGm+Nq9SLa4tWyMVyEN+9NXoW3WAZd8KkusAbyE4DFMdzARx0uQPrKEhTyc7mssup7Aw=
X-Received: by 2002:a05:6a20:8417:b0:1a5:6abb:7503 with SMTP id
 c23-20020a056a20841700b001a56abb7503mr11175022pzd.49.1712048549313; Tue, 02
 Apr 2024 02:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004fbc7a0614cc4eb9@google.com>
In-Reply-To: <0000000000004fbc7a0614cc4eb9@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:02:18 +0200
Message-ID: <CAGn+7TUcN9bw-iOM-idzoV43u+GHSRW1t3HuQkOEdv5Tt+TiNw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in tick_setup_sched_timer
To: syzbot <syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr

