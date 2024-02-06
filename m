Return-Path: <linux-kernel+bounces-54448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC684AF67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F01C22C39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6692212AAEA;
	Tue,  6 Feb 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk0ux+z7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726839AD5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206003; cv=none; b=bUCB63J6EWHTEMdaGnlkA6K01URg097hkSwFTpj27Qm84X+S5jPTyHuezzEIp9OjMWC0WzRoRNP8lMooOM2XE8YNmEWAJiRYQHJyncOmPofRXmScKL95V3zfiLrEvVE009Qn5mc/MC6LykeJgQ7x9l/DBJWL2sqMs9KyDRVLP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206003; c=relaxed/simple;
	bh=obWOM6TFlo2FgGYkpzWWGKAuo5dtPTIDBPqBHEIf3FY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U1dvMtppLui6+3nJjleL9Nkl5mrrlT5PH9O6XNFnhxhlwhg0dqK2MDcX1ip5K03iwVPEd0vfB5dQyiNgGXbhybVCDyHPJqmiXvoPRlki7RaF1NYz2ugRkFrIe+eMc8+ZOAIQ11fGzrL0oVBX7J3K4go3fRiJ0Uox+9/GqzrUO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hk0ux+z7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707205999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=icL9xgt+okoiIa8KIawJnZGJufjcsaHmokkEgkrGkRw=;
	b=Hk0ux+z7Z2JUZe9IY8jl+yg1612S5YF7jlyyoOqHJ7VFmSOhVjRXZ2eJmIkcNRfFUZ1qJS
	grX31mGH+BhsP1V3uPBR82H1tX1RGd71a6NquGbkKkHr2aypEEXQySpJfyxXUZeLjsTb5R
	m2xPVvULp+1O6i23sahEdntLr7opjxM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-VGu6odaTOiOXzDwnH1IfgA-1; Tue, 06 Feb 2024 02:53:17 -0500
X-MC-Unique: VGu6odaTOiOXzDwnH1IfgA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ef6441d1aso7593755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205996; x=1707810796;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icL9xgt+okoiIa8KIawJnZGJufjcsaHmokkEgkrGkRw=;
        b=MAhfh16HVFUarqBxhOyXM2Sd8W3CWcmyYQxkcwB+vqhQFmn35cGRX97/qR84XTHURa
         LCgQC3RfHbRbm8w39Xmroyh0zXWHXOGBBJBeR8J6PEHZJJ2mWswoMGTJZwpexKg61Gyl
         4gUdWCR9iqSnJARRgxJJhoy3h2lFKgJIFCf4YmyJ0pgdKNiCxzEFxEx8hIKPhAUV8uPu
         ZsrnyRurWMBnqEIvno20l6tb812rur1SrV/hR/rW2+vgmqbkBvm5qbZg4A1BAmUMU7Df
         +3qqt4G7d3ZvGhy7Icrjz5aOpBbgvTjZY9m7vkwS2FiqAQXokFeB9GklkRBDnJHIuF2Z
         sxmg==
X-Forwarded-Encrypted: i=1; AJvYcCVgV9s2NP6yKIVvWU2gqQy9vbfY9bx/epRKqJe1cUnmMjnrnGjGAFqACojxvm9G8berxRx52bMJTixsp1Ka9Bwp520cNtuqDiWsHBe1
X-Gm-Message-State: AOJu0Yyx0bNJ/tvnjrAifCc6wz+7fvLJHr3LbJDell42enT3s2nbbDa1
	dZbSUlJZdbuNRvQMwj1jVm8QAXMoT/wlErjvBjgj/Y9HHFCExT1GQneItAL76KhlhsmRtiBs4pk
	h77BLziNKm9psTL6XBaT3xPRVF4DSC4yfAqVk85S81eVUTbcSe0yihYnFEyJQ3Q==
X-Received: by 2002:a05:600c:3d8e:b0:40f:e930:9ebe with SMTP id bi14-20020a05600c3d8e00b0040fe9309ebemr254398wmb.0.1707205996323;
        Mon, 05 Feb 2024 23:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe/30s9BtAjJknrNne4a3i19xDqYUQqrMKONRN7zRpgvM7EmA9DYgL8s0gna5HY/DwETdRLw==
X-Received: by 2002:a05:600c:3d8e:b0:40f:e930:9ebe with SMTP id bi14-20020a05600c3d8e00b0040fe9309ebemr254388wmb.0.1707205995971;
        Mon, 05 Feb 2024 23:53:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgl822PQpTYd3y8770KJ+eBsN6Jld3qSZlxNoUNaHQRBR03y4ae+h0Y+NL0L57Sd6l4BjfSJ/w1d6GwxKOSNDE6FXMRDErbrOG3dl6v9C7YtALDRZMy3mTKktTBFV6iD18ZadZ/YvfAWviloaA/DXDu/u8Kk0cUc9CtoL6yGLrUed25LB2TC4HedoP5hr5Ft6Is6iuRbEyCp1zFQxPHGTea0/0PbZTzGFUKqvAAFlV8FwqeA6tKQL4xmkhm/KuiXFfCcaXuhBlCZ6mgldcwWeNn0Js9qGpScABAvcuYeDujWPl9B/r5BPLi0k1GuzmY6b/MATAkJV6Db7XAwYmRjYVSjlQrJ2LaFRerJhbuw5kng==
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c078a00b0040fe078fb03sm1052920wmo.32.2024.02.05.23.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:53:15 -0800 (PST)
Message-ID: <fd487c4e7cbf9842c810f497be31acdd76e6682c.camel@redhat.com>
Subject: Re: [PATCH net] tipc: Check the bearer type before calling
 tipc_udp_nl_bearer_add()
From: Paolo Abeni <pabeni@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>, jmaloy@redhat.com, 
 ying.xue@windriver.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, 
	syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com
Date: Tue, 06 Feb 2024 08:53:14 +0100
In-Reply-To: <20240131152310.4089541-1-syoshida@redhat.com>
References: <20240131152310.4089541-1-syoshida@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 00:23 +0900, Shigeru Yoshida wrote:
> syzbot reported the following general protection fault [1]:
>=20
> general protection fault, probably for non-canonical address 0xdffffc0000=
000010: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
> ...
> RIP: 0010:tipc_udp_is_known_peer+0x9c/0x250 net/tipc/udp_media.c:291
> ...
> Call Trace:
>  <TASK>
>  tipc_udp_nl_bearer_add+0x212/0x2f0 net/tipc/udp_media.c:646
>  tipc_nl_bearer_add+0x21e/0x360 net/tipc/bearer.c:1089
>  genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
>  genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
>  genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0xd5/0x180 net/socket.c:745
>  ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
>  ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
>  __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> The cause of this issue is that when tipc_nl_bearer_add() is called with
> the TIPC_NLA_BEARER_UDP_OPTS attribute, tipc_udp_nl_bearer_add() is calle=
d
> even if the bearer is not UDP.
>=20
> tipc_udp_is_known_peer() called by tipc_udp_nl_bearer_add() assumes that
> the media_ptr field of the tipc_bearer has an udp_bearer type object, so
> the function goes crazy for non-UDP bearers.
>=20
> This patch fixes the issue by checking the bearer type before calling
> tipc_udp_nl_bearer_add() in tipc_nl_bearer_add().
>=20
> Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
> Reported-and-tested-by: syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail=
com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5142b87a9abc510e14fa [1=
]
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/tipc/bearer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 2cde375477e3..878415c43527 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -1086,6 +1086,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct=
 genl_info *info)
> =20
>  #ifdef CONFIG_TIPC_MEDIA_UDP
>  	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
> +		if (b->media->type_id !=3D TIPC_MEDIA_TYPE_UDP) {
> +			rtnl_unlock();
> +			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
> +			return -EINVAL;
> +		}
> +

The patch LGTM, thanks!

As a side note, this function could probably deserve a net-next follow-
up consolidation the error paths under a common label.

Cheers,

Paolo


