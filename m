Return-Path: <linux-kernel+bounces-122243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C154888F431
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C12A3E44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF71CAB2;
	Thu, 28 Mar 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkF3se81"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648F1CFB6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586785; cv=none; b=V3drsOud4xrikLFfmsLgsVJzBavUW6tGD4rDz6B2E96r4jBVp8nYYPOPfxOSdG8Uz5qVuR4/fZtJO0E7Psme+JzgNyWaI9+uv+SjlsWAzpq48KSsQR1bXzOkldKbC79ZKkBWs53/psLxIptftWpd5D++WlyHxv5meynrOix2n9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586785; c=relaxed/simple;
	bh=cIKRD/G7PLOI2YOYcwuWsF+zEX2GT3alAs4z8dQkNe0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkdsV27cDLKBTFr94XF7N9en2zoTpnG3kKHb2Hgy4xbNegNl9lW3nj6VZQ3f1beQhgK4kSJ+kM9+AlktPgStvU2yy5FmppavNnrrd65rV6GYml8iSBT6lHKGjDsxGHmqhTs3hQzffrXbMaisRD2oR7Zpfd0h72LtfbbTxL4SSj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkF3se81; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711586782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muo4TQlECPjAqvpC/FPfgccK18lah8VpjdpT8uaBVqU=;
	b=bkF3se81efQ5YHRWSvLynMHt0IVCbS8QJVBOZHZKMInYD+p1dYdiD+NsmBsIqAkSAWPovB
	JsyScgQZQJIvJ+tVIaNxXiDg+A4HWFoF073ORUyGvGJntVG8vu0nGgMPgND+L8bO4dpH/J
	pBXIBCE+HTRSsZWDWX9fB7OWkaJR748=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-SPOtB4T4PyqHH8uqUcZ6Qw-1; Wed, 27 Mar 2024 20:46:21 -0400
X-MC-Unique: SPOtB4T4PyqHH8uqUcZ6Qw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c465f6756so249886a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586779; x=1712191579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=muo4TQlECPjAqvpC/FPfgccK18lah8VpjdpT8uaBVqU=;
        b=YwCUtOet6yas03tPJTiRoR6RLNGnWH6s1FFkmGin+2+8PG7x2WqQMEq5TWXCAyRCWL
         1OvQus80NKrx9XzOwE79tQy84Hzex2EM+X5gMqm++0HAcEUMzYl98hpGQTRLESJhpkXh
         W1u1m2lzWS9n/vRLP67sDDGR+rcUV2xBwER5WSeirHpFPEBHtFJmrAKSRtqa4h1WZBse
         cBKboDioCDHug5ugJMqnT/aEk69EgJia2koz/jdhEaO2zdnALGRr3LU9z/jJRyonRLza
         4TgA6PDNgAmZEv/FnzK1cFbfFZdpKO65/UUbZIod4HoIdJ1M/Jqw2k4JZ+9sTyX66x9+
         aDIg==
X-Forwarded-Encrypted: i=1; AJvYcCXj4lzpqvkQo1Xi26S0utkCrZbMiQqze3m4wjZjxAe4P43jw8+MbwfQwfa7IGt/C5Nqqc5v+CgZchwByMCqOfAL9/VIRlcBrYeLKR45
X-Gm-Message-State: AOJu0Yw2zqJ3iM0Z75utdq2bmbfCLCkozGwI91l3sI21et48MCbH1/3k
	yWkDlS6Y156ish7P7HYlcFVOZOvQ/ynAVT81AEPiG7ttyutrkr9QaHr/NBgegz0cl+Ne3X120SS
	wU+96pK5ebR57lcOty+n5vj3xVxlsR/YXjahuBmf7QyD1sk313KuedS/78jWp/IDpNyzZFP+TPj
	0PK6FlTg8K+dSijd6XU2mcmQQ2ZyJPEdpWdGTNV7ACWuA7
X-Received: by 2002:a50:f610:0:b0:56c:3644:9945 with SMTP id c16-20020a50f610000000b0056c36449945mr1077040edn.7.1711586778969;
        Wed, 27 Mar 2024 17:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFidnp8svLeqqOiMFaZBQdHriQ6yQSJBxUFB9NmDeKPwAn4bbF2S49CUU2kuwcWR3b40LAt3ECQeQnDWDQh7H0=
X-Received: by 2002:a50:f610:0:b0:56c:3644:9945 with SMTP id
 c16-20020a50f610000000b0056c36449945mr1077024edn.7.1711586778491; Wed, 27 Mar
 2024 17:46:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Mar 2024 17:46:17 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325204740.1393349-1-ast@fiberby.net> <20240325204740.1393349-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325204740.1393349-4-ast@fiberby.net>
Date: Wed, 27 Mar 2024 17:46:17 -0700
Message-ID: <CALnP8ZbmCUM8EP-jAGaFqvMbYTm+=18AG0h-DEvZ81+Vrea9hw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: sched: make skip_sw actually skip software
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:47:36PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
..
>  +----------------------------+--------+--------+--------+
>  | tests with only skip_sw rules below:                  |
>  +----------------------------+--------+--------+--------+
>  | 1 non-matching rule        | 2694.7 | 3058.7 |  1.14x |
>  | 1 n-m rule, match trap     | 2611.2 | 3323.1 |  1.27x |
>  | 1 n-m rule, goto non-chain | 2886.8 | 2945.9 |  1.02x |
>  | 5 non-matching rules       | 1958.2 | 3061.3 |  1.56x |
>  | 5 n-m rules, match trap    | 1911.9 | 3327.0 |  1.74x |
>  | 5 n-m rules, goto non-chain| 2883.1 | 2947.5 |  1.02x |
>  | 10 non-matching rules      | 1466.3 | 3062.8 |  2.09x |
>  | 10 n-m rules, match trap   | 1444.3 | 3317.9 |  2.30x |
>  | 10 n-m rules,goto non-chain| 2883.1 | 2939.5 |  1.02x |
>  | 25 non-matching rules      |  838.5 | 3058.9 |  3.65x |
>  | 25 n-m rules, match trap   |  824.5 | 3323.0 |  4.03x |
>  | 25 n-m rules,goto non-chain| 2875.8 | 2944.7 |  1.02x |
>  | 50 non-matching rules      |  488.1 | 3054.7 |  6.26x |
                                            [A]

>  | 50 n-m rules, match trap   |  484.9 | 3318.5 |  6.84x |

Interesting. I can't explain why it consistently got 10% better than
[A] after the patch. If you check tcf_classify(), even though it
resumes to action, it still searches for the right chain. Maybe
something works differently in the driver.

In on the logs,
https://files.fiberby.net/ast/2024/tc_skip_sw/v2_tests/test_runs/netnext/te=
sts/non_matching_and_trap_007/tc.txt

filter protocol 802.1Q pref 8 flower chain 0
filter protocol 802.1Q pref 8 flower chain 0 handle 0x1
  vlan_ethtype ip
  eth_type ipv4
  dst_ip 10.53.22.3
  skip_sw
  in_hw in_hw_count 1
	action order 1: gact action trap
	 random type none pass val 0
	 index 8 ref 1 bind 1 installed 20 sec used 0 sec
	Action statistics:
	Sent 29894330340 bytes 439622505 pkt (dropped 0, overlimits 0 requeues 0)
	Sent software 0 bytes 0 pkt
	Sent hardware 29894330340 bytes 439622505 pkt
	backlog 0b 0p requeues 0
	used_hw_stats delayed

It matched nicely.

>  | 50 n-m rules,goto non-chain| 2884.1 | 2939.7 |  1.02x |
                                   [B]

If we compare [A] and [B], there's still a 5.9% increase, plus
not requiring somewhat hacky rules.

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


