Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896CE7A83F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjITNyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjITNyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:54:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DEAD;
        Wed, 20 Sep 2023 06:54:43 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-773ae5d2b1fso377165685a.2;
        Wed, 20 Sep 2023 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695218082; x=1695822882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVF06t7IZza16CFzCOJgQajEkOspYiDG67dNcLwWTqA=;
        b=H8IMUrKBcPWPk4ZyKKQAIo53+W7GSRbli2+0RrSu45mmGdiBXKzJUVmExCnfV8SJQj
         e7KaiyMUS6zi0rwLacOo5q6Ci8m6G4vmCt1D5Ti65ARS8+kiTjDe9fvAYOPhZIz1E5Ju
         pSXx9rhxOJTfqcsCgoPMFCMGySTGiJevv59jo/icKKzuBj4zlMT9DGTHQC9GEKiMtdiJ
         UPTOIlyL8OCPeM6HviFCM1xSGdY/XzRXnL4SNYd74IDaPBsQByMtfN3PBXDN7IWH/d+v
         7rxsCqoDgiE/Yq94iwHh8WyODtXB0OLn1H5TwLpVgH2mKV2pXRVu4Qws5tgX7KlIAfue
         gCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218082; x=1695822882;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FVF06t7IZza16CFzCOJgQajEkOspYiDG67dNcLwWTqA=;
        b=Zv/uA1jnTyquaVuldl2KvfbeB97Uh4vDBSbQZLsSycO1xXNz0C48v8tQ5Gb3RiRGxV
         NGp855YFFuTBHvYhL2CTaicU8hkMmnk1UJIo94q+kXJn/MeJW3PFwEV8HUqkN0r9or2C
         gyHHxpC8pjxGVpEhWN2K/hb28F4gMs3t1hzntdPGSh5fYjWXJWiUNja5qB439ARcX+Id
         xhMXm+puKfUA7FuOd9C6xXGh5Bh/swCFZ3xE56E6U32mUqZSh6Ht5hhE7CYCmvpdJyKv
         QHsp+EMzP11DzUOTN1uAdO2Dax1orQkj+DqEuwI6gb5sFdxcuuPBJ/GHVdg3NMWl+2SQ
         CerA==
X-Gm-Message-State: AOJu0Yz1HZJ54nGmlWZWecUbHO5Dy31sDVm/GOqIXIl6xtUeRfZ43heB
        zrcihNbwOZDW0MZ1ggy7Y7cIzcSC+yw=
X-Google-Smtp-Source: AGHT+IEF8xZCVveTfM6rspnqiBn7ZNNofTz733mxQ//7oM0FYPWLnypYaEAokeajcDlKDm96sVZ/ZA==
X-Received: by 2002:a05:620a:1407:b0:76f:98c:3f05 with SMTP id d7-20020a05620a140700b0076f098c3f05mr2500850qkj.76.1695218082632;
        Wed, 20 Sep 2023 06:54:42 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id m10-20020ae9e00a000000b0076f35d17d06sm4812021qkk.69.2023.09.20.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:54:42 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:54:42 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     dhowells@redhat.com,
        syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <650af9a2aa74_37bf362941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <108791.1695199151@warthog.procyon.org.uk>
References: <108791.1695199151@warthog.procyon.org.uk>
Subject: Re: [PATCH net v2] ipv4, ipv6: Fix handling of transhdrlen in
 __ip{,6}_append_data()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Including the transhdrlen in length is a problem when the packet is
> partially filled (e.g. something like send(MSG_MORE) happened previously)
> when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> transport header or account for it twice.  This can happen under some
> circumstances, such as splicing into an L2TP socket.
> 
> The symptom observed is a warning in __ip6_append_data():
> 
>     WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
> 
> that occurs when MSG_SPLICE_PAGES is used to append more data to an already
> partially occupied skbuff.  The warning occurs when 'copy' is larger than
> the amount of data in the message iterator.  This is because the requested
> length includes the transport header length when it shouldn't.  This can be
> triggered by, for example:
> 
>         sfd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
>         bind(sfd, ...); // ::1
>         connect(sfd, ...); // ::1 port 7
>         send(sfd, buffer, 4100, MSG_MORE);
>         sendfile(sfd, dfd, NULL, 1024);
> 
> Fix this by deducting transhdrlen from length in ip{,6}_append_data() right
> before we clear transhdrlen if there is already a packet that we're going
> to try appending to.
> 
> Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: David Ahern <dsahern@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: netdev@vger.kernel.org
> cc: bpf@vger.kernel.org
> cc: syzkaller-bugs@googlegroups.com
> Link: https://lore.kernel.org/r/75315.1695139973@warthog.procyon.org.uk/ # v1
> ---
>  net/ipv4/ip_output.c  |    1 +
>  net/ipv6/ip6_output.c |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 4ab877cf6d35..9646f2d9afcf 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1354,6 +1354,7 @@ int ip_append_data(struct sock *sk, struct flowi4 *fl4,
>  		if (err)
>  			return err;
>  	} else {
> +		length -= transhdrlen;
>  		transhdrlen = 0;
>  	}
>  
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 54fc4c711f2c..6a4ce7f622e9 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1888,6 +1888,7 @@ int ip6_append_data(struct sock *sk,
>  		length += exthdrlen;
>  		transhdrlen += exthdrlen;
>  	} else {
> +		length -= transhdrlen;
>  		transhdrlen = 0;
>  	}
>  

Definitely a much simpler patch, thanks.

So the current model is that callers with non-zero transhdrlen always
pass to __ip_append_data payload length + transhdrlen.

I do see that udp does this: ulen += sizeof(struct udphdr); This calls
ip_make_skb if not corked, but directly ip_append_data if corked.

Then __ip_append_data will use transhdrlen in its packet calculations,
and reset that to zero after allocating the first new skb.

So if corked *and* fragmentation, which would cause a new skb to be
allocated, the next skb would incorrectly reserve udp header space,
because the second __ip_append_data call will again pass transhdrlen.
If so, then this patch fixes that. But that has never been reported,
so I'm most likely misreading some part..

So on the surface this makes sense to me. But I need to read it more
closely still. The most risk-averse version would limit this change
explicitly to MSG_SPLICE_PAGES calls.

FWIW I think MSG_ZEROCOPY is somewhat immune compared to
MSG_SPLCE_PAGES solely because it is limited to TCP, UDP and RDS
sockets.
