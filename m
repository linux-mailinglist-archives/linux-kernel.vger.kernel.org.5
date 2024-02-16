Return-Path: <linux-kernel+bounces-68601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04CE857CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0951DB21E47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4C51292E0;
	Fri, 16 Feb 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WTKygDLi"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B377F0D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088268; cv=none; b=B7I41PYXwkjljzBkf5KqP9PIhPZdPbgBrhgqL3c8UqXg5OKVK61XQ5Z3heqbISmMSLs6OLGcxaHK8oMhST8EbbMR1H6jJfa1sQDlCpgzrqjxxXWtrzhcF+gXSu1lHYWTl6YDVwven0p00sCdnvecGnJa0cAXT5+zAyq88Fgyb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088268; c=relaxed/simple;
	bh=w2l0ylVB1x/HuoHnk6UUEgl7ExtREHdymzM1UYAT1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+k8I7bQ2thhwrS0rRbqFJY1gumrJ/HNNykKsFwDSpfGJ/CzVIF8c6e2O46Hmbtppa/M76Q6FMvhew+20ZVyDPqvH22MG+6uo1NipvgmrpSj3iMCMDF41e9jjDcXNBKn6DDKIpkl1Thpff2wHMsZgFB2uib50QFTW+GK9NmbtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WTKygDLi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4121a8635a2so13011135e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708088263; x=1708693063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uiUzSTVrsxjbS/hZAUDiyEUoLZBQOXDndHGZfvZSTaI=;
        b=WTKygDLigFTY3fNr1ZdFSs9U6vmbKu+wQ+kpgjnmM1dJzKdQRXc3BoGrLvmDfPEq+5
         KZpzE2YUwiKE7Cjdb3rs4HmbRE42/G42KIU463H0g0FQ6nBKfmypXdl1DHqn+OH7cPG5
         bzbIOy/nAELJgthIpfYQdF4+eG5vpEbL5pxIzlITxMidFJ5vAnDUqmrFeo8pcBM8TVji
         5DFCizy6xhKuH63Bww1alwczIW4RW6KaszlkYstbJVMmYanjqzX3bgaPTw7mZ4g7+6i9
         3vBADDIHEMTy9cydTp89fqmVH3d+CCDRx7SGU3woDzCV0jOwKOrJlF7URSKdOefX4uN4
         huQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088263; x=1708693063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiUzSTVrsxjbS/hZAUDiyEUoLZBQOXDndHGZfvZSTaI=;
        b=w1hMVzDYhr42fozZu2FOmfuz3IV0aCxguQGvtVWcIQfRTkcrCuWX93AFCFU3JHHAgX
         Mjwz2gu7DWFas/OO6si/Dp811fXByouyi4V9DeCoi3i726A0p1y+WphRrOD9DRdzdqC9
         TFeMqhH8i8R6ySksYMVe/y6clY8eT0MbMTijnYq8oMwoU4MFJAHPD/zHGWjj9+MMwQ2l
         jWmRChMc3Nh6j6nkroGHHdBzAdM9TPwnD6whc44fBr8oARHzFlp6ylKMUGy2vhr1N/ct
         5LlGIY6wkrA+HKmMpYa7whX81DyU3oVCDGLw0uRJkDb0CEj9MqYSK0AWvWLRjp4916Px
         Vkzg==
X-Forwarded-Encrypted: i=1; AJvYcCXxcgGnfYdyZCIRrUx0XbL7g07b8z8HYoMv4ahIfISXydrO+A9w1UUtXcjWsMSqrEwKNsMXpoxAtlBXnD6y6fauGEBe6Qh3I8AhWczI
X-Gm-Message-State: AOJu0Yy92FRexWcpTZnX+shEVuPoR9YXfep7taJICtrQfNtzjwJIOko3
	Pfb4bvPm4zzk+7Wi2zxx83ciSMGwaLQourC+HLEDCGt0ui60iEUxDSE6XygF2BY=
X-Google-Smtp-Source: AGHT+IGPi7qDkQjeZAk9W6Bi0ss6+KHR3xR9GWNpIb52GnkGjYQgeYmsuPejkh0ek4HalEtqRY/qjg==
X-Received: by 2002:a05:600c:a386:b0:412:268f:1fa4 with SMTP id hn6-20020a05600ca38600b00412268f1fa4mr2698394wmb.1.1708088263594;
        Fri, 16 Feb 2024 04:57:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b00410d7e55e5asm2329981wmn.3.2024.02.16.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:57:42 -0800 (PST)
Date: Fri, 16 Feb 2024 13:57:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llu@fiberby.dk,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: sched: make skip_sw actually skip
 software
Message-ID: <Zc9bw8eHa5z_xh6Y@nanopsycho>
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-4-ast@fiberby.net>
 <CAM0EoMmyGwA9Q=RibR+Fc41_dPZyhBRWiBEejSbPsS9NhaUFVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmyGwA9Q=RibR+Fc41_dPZyhBRWiBEejSbPsS9NhaUFVQ@mail.gmail.com>

Thu, Feb 15, 2024 at 06:49:05PM CET, jhs@mojatatu.com wrote:
>On Thu, Feb 15, 2024 at 11:06 AM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>>
>> TC filters come in 3 variants:
>> - no flag (no opinion, process wherever possible)
>> - skip_hw (do not process filter by hardware)
>> - skip_sw (do not process filter by software)
>>
>> However skip_sw is implemented so that the skip_sw
>> flag can first be checked, after it has been matched.
>>
>> IMHO it's common when using skip_sw, to use it on all rules.
>>
>> So if all filters in a block is skip_sw filters, then
>> we can bail early, we can thus avoid having to match
>> the filters, just to check for the skip_sw flag.
>>
>>  +----------------------------+--------+--------+--------+
>>  | Test description           | Pre    | Post   | Rel.   |
>>  |                            | kpps   | kpps   | chg.   |
>>  +----------------------------+--------+--------+--------+
>>  | basic forwarding + notrack | 1264.9 | 1277.7 |  1.01x |
>>  | switch to eswitch mode     | 1067.1 | 1071.0 |  1.00x |
>>  | add ingress qdisc          | 1056.0 | 1059.1 |  1.00x |
>>  +----------------------------+--------+--------+--------+
>>  | 1 non-matching rule        |  927.9 | 1057.1 |  1.14x |
>>  | 10 non-matching rules      |  495.8 | 1055.6 |  2.13x |
>>  | 25 non-matching rules      |  280.6 | 1053.5 |  3.75x |
>>  | 50 non-matching rules      |  162.0 | 1055.7 |  6.52x |
>>  | 100 non-matching rules     |   87.7 | 1019.0 | 11.62x |
>>  +----------------------------+--------+--------+--------+
>>
>> perf top (100 n-m skip_sw rules - pre patch):
>>   25.57%  [kernel]  [k] __skb_flow_dissect
>>   20.77%  [kernel]  [k] rhashtable_jhash2
>>   14.26%  [kernel]  [k] fl_classify
>>   13.28%  [kernel]  [k] fl_mask_lookup
>>    6.38%  [kernel]  [k] memset_orig
>>    3.22%  [kernel]  [k] tcf_classify
>>
>> perf top (100 n-m skip_sw rules - post patch):
>>    4.28%  [kernel]  [k] __dev_queue_xmit
>>    3.80%  [kernel]  [k] check_preemption_disabled
>>    3.68%  [kernel]  [k] nft_do_chain
>>    3.08%  [kernel]  [k] __netif_receive_skb_core.constprop.0
>>    2.59%  [kernel]  [k] mlx5e_xmit
>>    2.48%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear
>>
>
>The concept makes sense - but i am wondering when you have a mix of
>skip_sw and skip_hw if it makes more sense to just avoid looking up
>skip_sw at all in the s/w datapath? Potentially by separating the
>hashes for skip_sw/hw. I know it's a deeper surgery - but would be

Yeah, there could be 2 hashes: skip_sw/rest
rest is the only one that needs to be looked-up in kernel datapath.
skip_sw is just for control path.

But is it worth the efford? I mean, since now, nobody seemed to care. If
this patchset solves the problem for this usecase, I think it is enough.

In that case, I'm fine with this patch:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>



>more general purpose....unless i am missing something
>
>> Test setup:
>>  DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
>>  Data rate measured on switch (Extreme X690), and DUT connected as
>>  a router on a stick, with pktgen and pktsink as VLANs.
>>  Pktgen was in range 12.79 - 12.95 Mpps across all tests.
>>
>
>Hrm. Those are "tiny" numbers (25G @64B is about 3x that). What are
>the packet sizes?
>Perhaps the traffic generator is a limitation here?
>Also feels like you are doing exact matches? A sample flower rule
>would have helped.
>
>cheers,
>jamal
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>  include/net/pkt_cls.h | 5 +++++
>>  net/core/dev.c        | 3 +++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>> index a4ee43f493bb..a065da4df7ff 100644
>> --- a/include/net/pkt_cls.h
>> +++ b/include/net/pkt_cls.h
>> @@ -74,6 +74,11 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
>>         return block && block->index;
>>  }
>>
>> +static inline bool tcf_block_has_skip_sw_only(struct tcf_block *block)
>> +{
>> +       return block && atomic_read(&block->filtercnt) == atomic_read(&block->skipswcnt);
>> +}
>> +
>>  static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
>>  {
>>         WARN_ON(tcf_block_shared(block));
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index d8dd293a7a27..7cd014e5066e 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3910,6 +3910,9 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>>         if (!miniq)
>>                 return ret;
>>
>> +       if (tcf_block_has_skip_sw_only(miniq->block))
>> +               return ret;
>> +
>>         tc_skb_cb(skb)->mru = 0;
>>         tc_skb_cb(skb)->post_ct = false;
>>         tcf_set_drop_reason(skb, *drop_reason);
>> --
>> 2.43.0
>>

