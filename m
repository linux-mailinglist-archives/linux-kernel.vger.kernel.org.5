Return-Path: <linux-kernel+bounces-117191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF288A87A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529771C6230B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B6513DB8D;
	Mon, 25 Mar 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="own2Vihg"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AA13D60C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375166; cv=none; b=Y7B5T43K8SxK8FqwzhQHaGwlkc7zbW20xfnIqMM6AizurXRLPTh0MJYLo9RWJlDoC4HY5eCbEI1ECI8Pi86AIuVSSNL0w9ATqvxqZcOd4cyJ3h+D7iIxxFJmKiU3jy2VmTS7AJz69nvI3jZs9WOzARtd+YgrsqjuRQqkqqt81aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375166; c=relaxed/simple;
	bh=aiMUPmr0TYR+OTuWbEB0NdvrDsA6Hxrr0DZTK4iOQcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAHqYSmnnRudrTit17Vh7GG3GOaH+SCBQTSJ9RJmml3yn5qgqSHXdp59CErvEjew2x1KmJoT9YZm1kPxuHcoNKksg1xHwXU9wNcm6oLcVmfK5E0TtrjCBPRWCqW01G+GoJwTwlkFJzbmQ61DhGuf1QMbEItj6vZZX5CPMhnI/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=own2Vihg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso10919a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711375163; x=1711979963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiMUPmr0TYR+OTuWbEB0NdvrDsA6Hxrr0DZTK4iOQcE=;
        b=own2VihgvevU9YRCiKVFXirQxnmo8wM2siZ5eSbqmQPWPzIs3Osl1KtBc+bYtB46U9
         o6bTZrWt3Wu8zEx7A02JB2o4iSjknT7Iwwrz4vhTuYpTx6MNZulo5zephBWPcLtI/1JO
         6uKzNKR2f06SrYKAZc+40kibTuBgCqAFjMi6v267inrTTMf06cGlTpxbh+Pyf7b0+sPC
         ab3zffwKi4/+i1Q7JpaxB+RdrpEU8/sgqaZHAnrR6/fw2QOr5OSygwBJua1Mwbdi44Rm
         2sCosPAC0je3Auu4/GWuxiJ59nGD0e8+mn8vDkk+M5QNGGCAfxF7Kcopjz58v6sQpOEZ
         g9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375163; x=1711979963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiMUPmr0TYR+OTuWbEB0NdvrDsA6Hxrr0DZTK4iOQcE=;
        b=oi7BBQ1KYrp2gbQm0ixcoobdFaf0vbGAeif2NBb46pQNqj845s05Y+zdncNzymvdzy
         m+GB88/JLd2KqghPAPPjs0UoiUWNiuCKCrYQlhQ1A33r6qipeOnQhmT9xVknjlh2Aq7l
         qS3XXP1N65vva+QFTGZZsRG/cmDAjDvmpcqu8p+smcJXtHGTwEYvLTeotXxQCUFZPlwY
         1vPw6YdNmFtyO9G1Vb2ft1CjOMf4L0AhTDKxx3FxefdOROiPfazpFqbNlJPcOox4IKyE
         kI+nMWZxGZM+9cZzqN0Ap0CdsNWoO2JmaQxQWnujLWn6G2kopEsuHuFImA74by4gQRQe
         vQmA==
X-Forwarded-Encrypted: i=1; AJvYcCVwKhILZpf1wlYxlb/y6XGuUmA8zEOiG5B32ThfRiSwg+u/Kh1MP2Dkor7s29jbPWBhT7h7hqHU9jvkIjG3KAW44nnYtyABTi96rjiz
X-Gm-Message-State: AOJu0Yy/2r3pyDz+nEWKssCSaQtIvclhrdUe5O1QcxJssK4xhRUuV3vK
	keXfDxXTkVExS6M2gplmBjGePI5wzT/ibNH+NQhc3hMTEuvLXV9skpScAcKWsc7VyyIUHj/gnea
	5cAtZHDLv94TLKxpn5pXEzNW5cQkhYfvlbRMj
X-Google-Smtp-Source: AGHT+IEV5wDD3dHJtuQglxOC11Br3likX/HODpqsYK/HFkeJhAxfTM6CLt/xt+yEevunobYcapuEhcWHhd7Md8ZPxBU=
X-Received: by 2002:aa7:d298:0:b0:56c:d26:5e59 with SMTP id
 w24-20020aa7d298000000b0056c0d265e59mr130158edq.1.1711375162985; Mon, 25 Mar
 2024 06:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5A50BC27A519EBD14E1B0A8685E89405850A@qq.com>
In-Reply-To: <tencent_5A50BC27A519EBD14E1B0A8685E89405850A@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Mar 2024 14:59:09 +0100
Message-ID: <CANn89i+gqBKX-BkY58M0vWfRLsOy2RqyFqX8cwjqo3xacYGXbA@mail.gmail.com>
Subject: Re: [PATCH v2] net: mark racy access on sk->sk_rcvbuf
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, Breno Leitao <leitao@debian.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 9:44=E2=80=AFAM linke li <lilinke99@qq.com> wrote:
>
> sk->sk_rcvbuf in __sock_queue_rcv_skb() and __sk_receive_skb() can be
> changed by other threads. Mark this as benign using READ_ONCE().
>
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
>
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
> v1 -> v2: include sk->sk_rcvbuf in __sock_queue_rcv_skb()

Reviewed-by: Eric Dumazet <edumazet@google.com>

