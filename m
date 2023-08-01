Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57576AA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjHAHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjHAHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3E1269E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690875869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqXQpdHpV8Ezvm5Ot+Q+uVycSyLQP6CCe0dWhYuT94Y=;
        b=AbwqoXFIabWbBrLZJ2sT/rz/ZIZDBHr3TQ50vwUookdn9edEEAogWwwKrby05jKJmMKe70
        vJGCJP5Xi9Ij6YEH7FxRxtQ2JpfI1vFEKBkSA8lXHf+83xKQjNXnVIjqMD/WFytmZxKOs9
        QMyzCv7c5hkbPZJmvnTHdNkog4uD5V0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ZwWQmZI-O9S23JKDL7j9zg-1; Tue, 01 Aug 2023 03:44:28 -0400
X-MC-Unique: ZwWQmZI-O9S23JKDL7j9zg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76c7cffef41so108993585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 00:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690875868; x=1691480668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqXQpdHpV8Ezvm5Ot+Q+uVycSyLQP6CCe0dWhYuT94Y=;
        b=WisodW811FIkVwgLddm3yQac4zIUyTkhXmzX9nSUQPPGiG+mhMuKHq8XgD8XmI/ZRs
         C2jg/yrXVEIUainSGYIhQE74j5B0cuwJTFw158sl7AoYyLjHaKA6j76MJriXF29IuapS
         rSpzILkjmUYJIUvmY8Txh7kBHLpEtE8dy0/wIPLtnnMj/KEPMLYp3Y9N7HhHcB1QPCsR
         8yA6vf2ZNWDW45VDLjgi69HtDSPGzqjm+uaXqJgwLPk93Zop5QItDpy7COnDc+iUCqrX
         FTeEGkSsfgeL2mRdyV0N9Gbct/G3VAQhOZF2rI784tL7ufHge4Yp5Hu0nhw4IeSNb/Iq
         VOig==
X-Gm-Message-State: ABy/qLbcaMam+xwXdan40NDK53r0sl6FNPSpUo3FS/X7bsaqXz9i+fgE
        Q+15UYQimrry1JGvM4W1EH5qR2YOaKdy63dikptdFDirBLtQA9Du9yH40ALz5mzBh7w2D7NKI0b
        sb3TcmX3vAXkfpJCKd1o9jN+3
X-Received: by 2002:a05:620a:2401:b0:763:a1d3:196d with SMTP id d1-20020a05620a240100b00763a1d3196dmr11749448qkn.0.1690875868208;
        Tue, 01 Aug 2023 00:44:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFtiHX4Gzu39qMYgYQMXjB5BxCkE29IapHRH0veL6ley9egkDZ2BXpTaPJcFd+GV6SCcVoAqg==
X-Received: by 2002:a05:620a:2401:b0:763:a1d3:196d with SMTP id d1-20020a05620a240100b00763a1d3196dmr11749443qkn.0.1690875867867;
        Tue, 01 Aug 2023 00:44:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id os28-20020a05620a811c00b00767e98535b7sm3961257qkn.67.2023.08.01.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 00:44:27 -0700 (PDT)
Message-ID: <19a3a2be3c2389e97cacd7e7ab93b317b016ef94.camel@redhat.com>
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
From:   Paolo Abeni <pabeni@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, tglozar@redhat.com
Date:   Tue, 01 Aug 2023 09:44:23 +0200
In-Reply-To: <64c882fd8c200_a427920843@john.notmuch>
References: <20230728064411.305576-1-tglozar@redhat.com>
         <87ila0fn01.fsf@cloudflare.com> <64c882fd8c200_a427920843@john.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-31 at 20:58 -0700, John Fastabend wrote:
> Jakub Sitnicki wrote:
> >=20
> > On Fri, Jul 28, 2023 at 08:44 AM +02, tglozar@redhat.com wrote:
> > > From: Tomas Glozar <tglozar@redhat.com>
> > >=20
> > > Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
> > > allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> > > GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exi=
st
> > > patchset notes for details).
> > >=20
> > > This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps =
to
> > > BUG (sleeping function called from invalid context) on RT kernels.
> > >=20
> > > preempt_disable was introduced together with lock_sk and rcu_read_loc=
k
> > > in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and u=
pdate
> > > in parallel"), probably to match disabled migration of BPF programs, =
and
> > > is no longer necessary.
> > >=20
> > > Remove preempt_disable to fix BUG in sock_map_update_common on RT.
> > >=20
> > > Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> > > ---
> >=20
> > We disable softirq and hold a spin lock when modifying the map/hash in
> > sock_{map,hash}_update_common so this LGTM:
> >=20
>=20
> Agree.
>=20
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>=20
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
>=20
> >=20
> > You might want some extra tags:
> >=20
> > Link: https://lore.kernel.org/all/20200224140131.461979697@linutronix.d=
e/
> > Fixes: 99ba2b5aba24 ("bpf: sockhash, disallow bpf_tcp_close and update =
in parallel")

ENOCOFFEE here (which is never an excuse, but at least today is really
true), but I considered you may want this patch via the ebpf tree only
after applying it to net.

Hopefully should not be tragic, but please let me know if you prefer
the change reverted from net and going via the other path.

Thanks!

Paolo

