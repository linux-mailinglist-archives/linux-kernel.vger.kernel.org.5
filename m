Return-Path: <linux-kernel+bounces-55244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1A84B9A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B1C1F2334D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F213342F;
	Tue,  6 Feb 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehA8qnAk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0982133292
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233586; cv=none; b=QNTjmgvZz/iAaP64nnYdlIUkHxTUa02xfKDssdCJ3MI9WMM3Mny3Cua9cU4hG7TEw5R7IMrKGp7i+cYTLsNoV+8j3gVHVu20QZKElnca41lsokGZsDpGQGAh7iIQOVz8ndSJsoE3iirog9aEghPeI6qyXF8tsC6PCLsQPsA2lUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233586; c=relaxed/simple;
	bh=OQw3lVpMqfp1xcmosx34hdMqA15+eVbnLrtSFoZslf8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mQTh6KqOrJKFA829WOLFM6WQ6Fq5NB+PAVdmmRCgMnOeVz3ziaL6PyU7VmpPIgSYayF/c0cyXIxsmz+c88HMYF4AdC6nYDKsZ9XLpqJTtILOZqiXO3RgbTzpWADSPSe1H/cJUKKOoyvkEflwaU01NnZNm/lEhJ4H8rl/zeiHATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehA8qnAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707233583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UH3pC3OauWYW0doLNxmVyQyieQhLCY1X5oQbk2wcI7o=;
	b=ehA8qnAklYicuyr8rcV9xEz9rA8MHo5hS6uea3dwoKBV5rEKlgtp0Mf1+bfWct32mk4nY9
	vwQuGJHjUA+yzcW7DaSxqyRK22W6V/1GNJulT3h3/ua7sz0BfxHLYuqXBIeNnK9KtvOXU4
	GvXASHezL5lOPFrjbH2Kg16RbSqrwCs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-KNDpV7JYNfCFgIHXzcpOKg-1; Tue, 06 Feb 2024 10:33:01 -0500
X-MC-Unique: KNDpV7JYNfCFgIHXzcpOKg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d746417ea3so55319355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233580; x=1707838380;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UH3pC3OauWYW0doLNxmVyQyieQhLCY1X5oQbk2wcI7o=;
        b=JN8nJo8G3v3mNK/K9NRipXMyejL9rIuggSd6HCu//tSLajTpZ+v7BhnqK6UDPQtHcj
         BLchGhM80cuhPS1vIK6pZpnErkiznZtfAayVjvotgVH37MB9g+kWTEX3H1uIawoL0aB1
         GcP4oMMqcE+hf0S9YvMvqF9ouve3W6pDC46gvvMJ8jDPj1SRhszAcvFfDOe2g+SNlsnN
         HC9FQyABpW6W5BpzH4b4chhS1Z1Quguqu7lzO+USsLSqKbbUdm0LVyNuFsYwRwL33R0o
         0TwvKOSOfsQYOZSsYAOslP2aUHWeC+LwI9+/HqLFwiko1LPlhtKfUe642XzTjpo1jVhE
         pf6Q==
X-Gm-Message-State: AOJu0Yx7HXWeXumDuSV6xl2hVKS0/CIxxz1ETVYBTbLs4+U1I86BhQy1
	l4TPnf7gofyzxuODzbADfdlUzAQN4rQ0TwWVaSoK32ZDdHEOmtrYSyjw/CK3jZfvmPgQqyePlOm
	Ny//fChCWddj5cEsrjEEJsZstndxeyW6PxNJdm/w3wBS78FwXHFaXrJrewETirQ==
X-Received: by 2002:a17:903:2444:b0:1d8:ee28:a305 with SMTP id l4-20020a170903244400b001d8ee28a305mr1952181pls.54.1707233580334;
        Tue, 06 Feb 2024 07:33:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESBLHvPXXOjPF0JNEbDaJFBQCaJR93BZRketQ5sbVM78+KwarJtaiDiRjPVOZMLpkhDbo3lA==
X-Received: by 2002:a17:903:2444:b0:1d8:ee28:a305 with SMTP id l4-20020a170903244400b001d8ee28a305mr1952159pls.54.1707233580035;
        Tue, 06 Feb 2024 07:33:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKBqG0I44jTjMg83EEm7Akc5/WaqBvDY3sdY9ogcaShEJfm1zpQSLth5N/h/8xQJekOLWYy7F7su8ucAwTlrDCdEh4rvoL/AfTPg1HLnVJecNgX96GXFKTAh8Y6nW9ZW2pJYfkWalzEAD549UM+IErlGNWZTvI64FzOta90G/5QhrzgSbo65tV6vt3lQf0PM6bmYYNe5xXqLZzNm5FJFcZrKmMvMncyt6kJOtTsEUqPTEVBjEU+83y+Z9GuIsxEWmDwLcffnQf+3e/Fmn8jh9d0jOXglHIIezU52JZ5cZngJNtbYS2lpt6nPsrE/rGs5J9/cnDoq3gfksxaCX0FxNa0VkbFIbM7cs61ZBgJyFmhDnV6J/J
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902e04300b001d755acec64sm2012484plx.189.2024.02.06.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:32:59 -0800 (PST)
Date: Wed, 07 Feb 2024 00:32:54 +0900 (JST)
Message-Id: <20240207.003254.225686181087639011.syoshida@redhat.com>
To: pabeni@redhat.com
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com
Subject: Re: [PATCH net] tipc: Check the bearer type before calling
 tipc_udp_nl_bearer_add()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <fd487c4e7cbf9842c810f497be31acdd76e6682c.camel@redhat.com>
References: <20240131152310.4089541-1-syoshida@redhat.com>
	<fd487c4e7cbf9842c810f497be31acdd76e6682c.camel@redhat.com>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 06 Feb 2024 08:53:14 +0100, Paolo Abeni wrote:
> On Thu, 2024-02-01 at 00:23 +0900, Shigeru Yoshida wrote:
>> syzbot reported the following general protection fault [1]:
>> 
>> general protection fault, probably for non-canonical address 0xdffffc0000000010: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
>> ...
>> RIP: 0010:tipc_udp_is_known_peer+0x9c/0x250 net/tipc/udp_media.c:291
>> ...
>> Call Trace:
>>  <TASK>
>>  tipc_udp_nl_bearer_add+0x212/0x2f0 net/tipc/udp_media.c:646
>>  tipc_nl_bearer_add+0x21e/0x360 net/tipc/bearer.c:1089
>>  genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
>>  genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
>>  genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
>>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
>>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
>>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>>  netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
>>  netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg+0xd5/0x180 net/socket.c:745
>>  ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
>>  ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
>>  __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> 
>> The cause of this issue is that when tipc_nl_bearer_add() is called with
>> the TIPC_NLA_BEARER_UDP_OPTS attribute, tipc_udp_nl_bearer_add() is called
>> even if the bearer is not UDP.
>> 
>> tipc_udp_is_known_peer() called by tipc_udp_nl_bearer_add() assumes that
>> the media_ptr field of the tipc_bearer has an udp_bearer type object, so
>> the function goes crazy for non-UDP bearers.
>> 
>> This patch fixes the issue by checking the bearer type before calling
>> tipc_udp_nl_bearer_add() in tipc_nl_bearer_add().
>> 
>> Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
>> Reported-and-tested-by: syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=5142b87a9abc510e14fa [1]
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>  net/tipc/bearer.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
>> index 2cde375477e3..878415c43527 100644
>> --- a/net/tipc/bearer.c
>> +++ b/net/tipc/bearer.c
>> @@ -1086,6 +1086,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
>>  
>>  #ifdef CONFIG_TIPC_MEDIA_UDP
>>  	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
>> +		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
>> +			rtnl_unlock();
>> +			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
>> +			return -EINVAL;
>> +		}
>> +
> 
> The patch LGTM, thanks!
> 
> As a side note, this function could probably deserve a net-next follow-
> up consolidation the error paths under a common label.

Thank you for commenting. I'll make a patch to clean up the error paths.

Thanks,
Shigeru

> 
> Cheers,
> 
> Paolo
> 


