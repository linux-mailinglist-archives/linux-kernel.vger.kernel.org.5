Return-Path: <linux-kernel+bounces-101228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58087A449
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BFB21A16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A61D21111;
	Wed, 13 Mar 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZqD1Xh"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9061F93F;
	Wed, 13 Mar 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319947; cv=none; b=qd8l+eFjvnEydkbuHKTYBedLNJDFH37xVQHpaVfc/funS3KZWnemBWbRpiwDTMnyT354HoWOG/V5hPJir0H9dil+4pOZXwmVF6Amp43LQAj3qjN7mYFcwvk3GgaMJvCoHxrSmyJHM9+I7yLb+GQKQ2+2CU1YugpmY9AnoDjKHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319947; c=relaxed/simple;
	bh=MBGoPePJfGD927BQzBl+0QOCTgtJGQa5eqdTJMY7LcM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UtJgmrPPcqrdctG71G8qIFf6w3QBX0fj2oElYA9JhnA8IK9uK9mOPbu9kX5hSnv7fsH/WBPY6qgng6b/mu3sown17Y9P9Wxtf5vQf4kJFYKM4wI0FRx6MUd1tsMvLsC0+I9xrx+o5f69to7LlnuAffUqDcHNSTIUs17NjE8SBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brZqD1Xh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78810ba2ff1so233169485a.3;
        Wed, 13 Mar 2024 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710319943; x=1710924743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiyXUYdI9F2JA3CsusbHXE/Pdh1jVbsVBwhd+PEGfCY=;
        b=brZqD1Xh35m0etdW7y9eHKDAVI92YU6Gx/ZIIgyLvtP7k9nTkinahOu6WE2zx3UzPV
         Y9dMBKQ72PRQIxmqVb8G9AYaiAWLgMbyxVsvoXssdrn14AG6umc/hOqd6A0kf6qpwsoQ
         UTEgYT0AA7wTTQTTSCvChmGZlhS80TAsARxYDDULolzA8mxbqBZBU+oNic+tdPcWlI4H
         fow2nJmtxpzq4VX+7Ah8oq6F4c1Ioqn+KNxuwBNDzZg1hoowVaS4pQpd0V63/r6Ab3zq
         8R+qI8QekRDvkI1xe2yIUeiVBOWoeHefYdlfpkkpvCYxIYnhxrO929UUUNwL2efMsV11
         Y7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710319943; x=1710924743;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NiyXUYdI9F2JA3CsusbHXE/Pdh1jVbsVBwhd+PEGfCY=;
        b=WA98mBItfk7aYRCSpEWQmFPLgyqWE9fb9Fcv5r5fU+Y96wZ637Tm6c8jV/srqVi9M/
         renkJ4lkqvul6JR9sikgIQ3nlKt+rbROH/dUaITIpVXcZ7MkbD58dIwiQsIHIL5L9rOu
         YOC0sNXSwY/dSTuxMuI333xdEr7c85oXKhyBhFK12RfbJsIzAyClkOvD19/4hIzhpGIs
         8kG6Y4GddkFvNp7wGICH+smwgXa+hBWBdGuo6Vq73rO+BUkEPrn17cdZ/cA33Bdqtt0t
         qXDORqBU82VNSz7LnSa1mEaqwqo8AURcL0QIfRoy8j/SOyw/7SpYsJit5+osZfbHDOiN
         sKkw==
X-Forwarded-Encrypted: i=1; AJvYcCWhS+UUMqnMtEo6eaGWOihlAiOeqOwJlZlpnm8BD/jMWVNry/Y1KXQ0cRl7nXP9RMBk96+lAldxeApGXUGUuXZpDlqNe5cWAsE4Lf0hLxy1xRei4HnsNvWtMAEizt05F184TWzgHWhWW7peppZUeVDPcoRMVteja4HF
X-Gm-Message-State: AOJu0YykB6Et1lGdkw7uhF2SzewKhkC3pjj1K4BXQMmdiLWDY0ECbJxO
	hYdTaELXxC1413MAkLB5hT/3AMzHX1GsbAcIxkloNhvwXw/CkCmb
X-Google-Smtp-Source: AGHT+IENqpNPUVCBD2bYLTHTCzOlVlxtqfauB/mV5DQpC8fHVxO4vHszbRwC1Xogc4MtuxBvNUDr+g==
X-Received: by 2002:a05:620a:1a0f:b0:788:5866:788a with SMTP id bk15-20020a05620a1a0f00b007885866788amr15818667qkb.9.1710319943582;
        Wed, 13 Mar 2024 01:52:23 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id 26-20020a05620a04da00b0078838695dfasm4466818qks.59.2024.03.13.01.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:52:23 -0700 (PDT)
Date: Wed, 13 Mar 2024 04:52:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kernel@quicinc.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 bpf <bpf@vger.kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>
Message-ID: <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
In-Reply-To: <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
> > Bridge driver today has no support to forward the userspace timestamp
> > packets and ends up resetting the timestamp. ETF qdisc checks the
> > packet coming from userspace and encounters to be 0 thereby dropping
> > time sensitive packets. These changes will allow userspace timestamps
> > packets to be forwarded from the bridge to NIC drivers.
> > 
> > Setting the same bit (mono_delivery_time) to avoid dropping of
> > userspace tstamp packets in the forwarding path.
> > 
> > Existing functionality of mono_delivery_time remains unaltered here,
> > instead just extended with userspace tstamp support for bridge
> > forwarding path.
> 
> The patch currently broke the bpf selftest test_tc_dtime: 
> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
> 
> In particular, there is a uapi field __sk_buff->tstamp_type which currently has 
> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time. 
> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at 
> ingress or a delivery time set by user space).
> 
> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not 
> necessarily mean mono after this patch. I thought about fixing it on the bpf 
> side such that reading __sk_buff->tstamp_type only returns 
> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk 
> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
> 
> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp, 
> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the 
> skb->mono_delivery_time. The expectation is this could change skb->tstamp in the 
> ingress skb and redirect to egress sch_fq. It could also set a mono time to 
> skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then 
> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp, 
> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects 
> BPF_SKB_TSTAMP_DELIVERY_MONO also.
> 
> I ran out of idea to solve this uapi breakage.
> 
> I am afraid it may need to go back to v1 idea and use another bit 
> (user_delivery_time) in the skb.

Is the only conflict when bpf_skb_set_tstamp is called for an skb from
a socket with sk_clockid set (and thus SO_TXTIME called)?

Interpreting skb->tstamp as mono if skb->mono_delivery_time is set and
skb->sk is NULL is fine. This is the ingress to egress redirect case.

I don't see an immediate use for this BPF function on egress where it
would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono,
but skb->sk != NULL and skb->sk->sk_clockid != CLOCK_MONOTONIC.

Perhaps bpf_skb_set_tstamp() can just fail if another delivery time is
already explicitly programmed?

    skb->sk &&
    sock_flag(sk, SOCK_TXTIME) &&
    skb->sk->sk_clockid != CLOCK_MONOTONIC

Either that, or unset SOCK_TXTIME to make sk_clockid undefined and
fall back on interpreting as monotonic.



