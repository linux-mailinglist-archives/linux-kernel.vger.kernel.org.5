Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7857792BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbjIEQ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353930AbjIEIld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E3E6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D791E60AFA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D9C433C7;
        Tue,  5 Sep 2023 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693903289;
        bh=0FEt4XuiCupoBQ6w4wjOKxVM3NSL60l5Rgl/mPesGj0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dzEuwrOuckVM06GIWlpPtpXgBGfpTSsuhMVQMA65s3r9o5BXlcklA0FILdaqJaCqW
         LYDX1RsYmuR0Zg2YArZtkU+G06G/mftmP7ht3VcTcHxFrhOk5+mQUPRVz6hYdq3zFR
         in69ct1+0v5O3vEeGSEEiYfpF59qxYYOWEyNIWX/XA+5adlSbY2ZUUrrSRnT7hgk81
         Fh0K3GYPDXotbNmsZ1ZdFHJW61U0ou2/TPWoIaNyrF07soAK+oa2/sWhaZPHIUbLtM
         4NifjPKWufUknMhHN6A2PvdB0qXsWiM+WVNMWCgELUzU5w8ENbAy6oSz7DxNJvl/93
         HaFtWY2E4aDhg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0A54EDC62C2; Tue,  5 Sep 2023 10:41:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     David Wang <00107082@163.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
In-Reply-To: <49e1d877.1e64.18a63574e6a.Coremail.00107082@163.com>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
 <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
 <49e1d877.1e64.18a63574e6a.Coremail.00107082@163.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 Sep 2023 10:41:23 +0200
Message-ID: <87wmx5ovv0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"David Wang" <00107082@163.com> writes:

> At 2023-09-05 05:01:14, "Alexei Starovoitov" <alexei.starovoitov@gmail.co=
m> wrote:
>>On Mon, Sep 4, 2023 at 3:49=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>>>
>>> David Wang <00107082@163.com> wrote:
>>> > This sample code implements a simple ipv4
>>> > blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
>>> > which was introduced in 6.4.
>>> >
>>> > The bpf program drops package if destination ip address
>>> > hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
>>> >
>>> > The userspace code would load the bpf program,
>>> > attach it to netfilter's FORWARD/OUTPUT hook,
>>> > and then write ip patterns into the bpf map.
>>>
>>> Thanks, I think its good to have this.
>>
>>Yes, but only in selftests/bpf.
>>samples/bpf/ are not tested and bit rot heavily.
>
> My purpose is to demonstrate the basic usage of BPF_PROG_TYPE_NETFILTER ,=
  showing what bpf program and userspace program should do to make it work.
> The code is neither  thorough  enough to make a valid test suite,  nor  d=
etailed enough to make out a tool (Could be a start for a tool)
>
> samples/bpf is a good  place to start for  beginners to get along  with b=
pf quickly,   those  sample/bpf codes do help me a lot,
>   but selftests/bpf is not that  friendly, at least not friendly for begi=
nners, I think.=20=20=20
> There are already test codes for   BPF_PROG_TYPE_NETFILTER in selftests/b=
pf,  actually I did refer to those code  when I made this sample.
>
> Get a feeling samples/bpf would be deprecated sooner or later, hope that =
would not happen.
>
> Anyway, this sample code is not meant to test.=20

FYI, we maintain a Github repository with BPF example programs of
various types at https://github.com/xdp-project/bpf-examples

Happy to include this example there as an alternative to the in-tree
samples/bpf :)

-Toke
