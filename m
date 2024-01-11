Return-Path: <linux-kernel+bounces-23931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B782B410
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F711C23BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF25524B5;
	Thu, 11 Jan 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JRGixTjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270251C52;
	Thu, 11 Jan 2024 17:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B1AC433C7;
	Thu, 11 Jan 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JRGixTjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1704994110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQU+/B75My8JCV9QOfAoQaVoiZZKMfAX5WlSXQ7LsZ8=;
	b=JRGixTjkJkyB+Uod9GaN7lLh08tBREHRQxoQZ7jj0Nbgau90+b3coSzYv9vG7TbWLxoScs
	T7qUKY8z2bd5EF8gAw37yDEzxi8dxMibEfBH1ucidj0WndEwTeHR5zQa10wXvjYT+bOOqz
	xE+wnZ8NnWt5rjp5I/1MNgkKTSnXTIA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ec4b128a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 17:28:30 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f75aee31d2so51263487b3.2;
        Thu, 11 Jan 2024 09:28:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yzw2F+oyllVMWQLaoxnnemY4vERvIeEj911+u6v0awcx7JugZSI
	bEkDwbSbIdU0AJ9iXDf7SAai7azt5JbaxgYWpQ4=
X-Google-Smtp-Source: AGHT+IEuXaZRUafKB+5MH5F4r3WLlEO3IABB/ps1mlnaPrmjQdZWPBNDATAze8zyWp0pwB0VoEqbgAvv8SD47XTIM4M=
X-Received: by 2002:a81:ae53:0:b0:5fa:f8b7:80d4 with SMTP id
 g19-20020a81ae53000000b005faf8b780d4mr116484ywk.89.1704994108587; Thu, 11 Jan
 2024 09:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111154138.7605-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240111154138.7605-1-n.zhandarovich@fintech.ru>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 11 Jan 2024 18:28:16 +0100
X-Gmail-Original-Message-ID: <CAHmME9o9ZzdWCOmg_s4K4zUUb0BitE+9F7Ox-hCnSHaFQahGtA@mail.gmail.com>
Message-ID: <CAHmME9o9ZzdWCOmg_s4K4zUUb0BitE+9F7Ox-hCnSHaFQahGtA@mail.gmail.com>
Subject: Re: [PATCH net] wireguard: receive: annotate data-race around receiving_counter.counter
To: n.zhandarovich@fintech.ru
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot <syzkaller@googlegroups.com>, 
	syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Thanks. Jann pointed me at this a few days ago and I was just looking into it.

Send a v2 with Eric's suggestion and I'll queue it up?

Jason

