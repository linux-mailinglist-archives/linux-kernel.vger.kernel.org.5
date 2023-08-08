Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6897747FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjHHTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjHHTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:22:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C265C10E9CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:45:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc0308d1e2so3195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691513141; x=1692117941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJuZXkPjtrPzoQoHiDKifLi16auN1OHDneNeJtSuxoc=;
        b=3uMaLkELr+RK8lvgx8FXUpzNUnthfRTeezpnbQU1L2FVf4pdcYFjepx26NbisMvG6L
         NiZxwGaJGrtzVel3SFx31Qp2Xg0LdbTtvLWNE4PN9MN9dW3noPsdGY646alOhG0Lej87
         o/0tohqvd3MLpeK38gfS1ErIeafVea+VM5nELd9PKEXyBm5HRLJyV1AFYMFZat7Gk9oA
         N5cZrHD2CZcsYbIzHR4HA/Cp80HR3lKqme0FhxAbdsLClSA15HVFxEh1vnEnIw/YGqaT
         FlpfAMUJYhqCouy456FQ1OmM3TJuhwQI8ga5haOKMhk57IH/MZWLphI13RBpYvSIpxdH
         7i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513141; x=1692117941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJuZXkPjtrPzoQoHiDKifLi16auN1OHDneNeJtSuxoc=;
        b=F2FrRkLgOXG20tzLnSzfbmR5U87n2YoHdYH3/foq4A0AGFtezrJCmpIt5Rz47RkvL+
         vN0WjArCH1UO2F1N1AWVM01+RhaPDhPBVI+s2SeXMEtsTfqxt5bIKvVCqmQU6uE9ltz7
         h0oPcBPy5/5XEELnOt+v7S3EFWtS897Ao7hurdrSMfXfNjpBDzqm+yCcGX/TJsmQdJ25
         VcsfIIhuCxSRJNrOc3q+CkSUziwHyRb4OIswux4PreTmY1REXXdYjahDMzRy3yGuB56C
         XueXy5sfd8ilHLeNjwxT7SZ/aVjd/rEShpfZj2YEweI8FVrwWTF/yM5V8WVLDwUGu7/t
         fv/A==
X-Gm-Message-State: AOJu0YwTK2m+UDCws/zCNXBxBWYehOy2FUJlUBW3ZjThPUajUzv1CFha
        xzI9vKC6dvCHGFA0olg69lvuwa3i+RtTRL01ddJvJnnvHo+zZY7aUBW1LA==
X-Google-Smtp-Source: AGHT+IH4N645iOuihNFlvtG0iOa31iTfRzQSw16SXZgPyyDBCAFbZMqSs/xOpq12oyp6HG1mkF0cp0UU+LWSvuagUA0=
X-Received: by 2002:a05:622a:1a12:b0:40f:db89:5246 with SMTP id
 f18-20020a05622a1a1200b0040fdb895246mr652424qtb.21.1691488733241; Tue, 08 Aug
 2023 02:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230802172654.1467777-1-dima@arista.com> <20230802172654.1467777-2-dima@arista.com>
In-Reply-To: <20230802172654.1467777-2-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 11:58:41 +0200
Message-ID: <CANn89iKJBgYF7_Yu_wrw02+a4yj2Xw6wvd4JxMbDKwJu9cPxBQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for TCP-AO
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 7:27=E2=80=AFPM Dmitry Safonov <dima@arista.com> wro=
te:
>
> TCP-AO, similarly to TCP-MD5, needs to allocate tfms on a slow-path,
> which is setsockopt() and use crypto ahash requests on fast paths,
> which are RX/TX softirqs. Also, it needs a temporary/scratch buffer
> for preparing the hash.
>
> Rework tcp_md5sig_pool in order to support other hashing algorithms
> than MD5. It will make it possible to share pre-allocated crypto_ahash
> descriptors and scratch area between all TCP hash users.
>
> Internally tcp_sigpool calls crypto_clone_ahash() API over pre-allocated
> crypto ahash tfm. Kudos to Herbert, who provided this new crypto API.
>
> I was a little concerned over GFP_ATOMIC allocations of ahash and
> crypto_request in RX/TX (see tcp_sigpool_start()), so I benchmarked both
> "backends" with different algorithms, using patched version of iperf3[2].
> On my laptop with i7-7600U @ 2.80GHz:
>
>                          clone-tfm                per-CPU-requests
> TCP-MD5                  2.25 Gbits/sec           2.30 Gbits/sec
> TCP-AO(hmac(sha1))       2.53 Gbits/sec           2.54 Gbits/sec
> TCP-AO(hmac(sha512))     1.67 Gbits/sec           1.64 Gbits/sec
> TCP-AO(hmac(sha384))     1.77 Gbits/sec           1.80 Gbits/sec
> TCP-AO(hmac(sha224))     1.29 Gbits/sec           1.30 Gbits/sec
> TCP-AO(hmac(sha3-512))    481 Mbits/sec            480 Mbits/sec
> TCP-AO(hmac(md5))        2.07 Gbits/sec           2.12 Gbits/sec
> TCP-AO(hmac(rmd160))     1.01 Gbits/sec            995 Mbits/sec
> TCP-AO(cmac(aes128))     [not supporetd yet]      2.11 Gbits/sec
>
> So, it seems that my concerns don't have strong grounds and per-CPU
> crypto_request allocation can be dropped/removed from tcp_sigpool once
> ciphers get crypto_clone_ahash() support.
>
> [1]: https://lore.kernel.org/all/ZDefxOq6Ax0JeTRH@gondor.apana.org.au/T/#=
u
> [2]: https://github.com/0x7f454c46/iperf/tree/tcp-md5-ao
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/net/tcp.h        |  50 ++++--
>  net/ipv4/Kconfig         |   4 +
>  net/ipv4/Makefile        |   1 +
>  net/ipv4/tcp.c           | 139 +++------------
>  net/ipv4/tcp_ipv4.c      |  97 ++++++-----
>  net/ipv4/tcp_minisocks.c |  21 ++-
>  net/ipv4/tcp_sigpool.c   | 358 +++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcp_ipv6.c      |  60 +++----
>  8 files changed, 519 insertions(+), 211 deletions(-)
>  create mode 100644 net/ipv4/tcp_sigpool.c
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6d77c08d83b7..506138e69643 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1700,12 +1700,39 @@ union tcp_md5sum_block {
>  #endif
>  };
>
> -/* - pool: digest algorithm, hash description and scratch buffer */
> -struct tcp_md5sig_pool {
> -       struct ahash_request    *md5_req;
> -       void                    *scratch;
> +/*
> + * struct tcp_sigpool - per-CPU pool of ahash_requests
> + * @scratch: per-CPU temporary area, that can be used between
> + *          tcp_sigpool_start() and tcp_sigpool_end() to perform
> + *          crypto request
> + * @req: pre-allocated ahash request
> + */
> +struct tcp_sigpool {
> +       void *scratch;
> +       struct ahash_request *req;
>  };
>
> +int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size);
> +void tcp_sigpool_get(unsigned int id);
> +void tcp_sigpool_release(unsigned int id);
> +int tcp_sigpool_hash_skb_data(struct tcp_sigpool *hp,
> +                             const struct sk_buff *skb,
> +                             unsigned int header_len);
> +
> +/**
> + * tcp_sigpool_start - disable bh and start using tcp_sigpool_ahash
> + * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_a=
hash()
> + * @c: returned tcp_sigpool for usage (uninitialized on failure)
> + *
> + * Returns 0 on success, error otherwise.
> + */
> +int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c);
> +/**
> + * tcp_sigpool_end - enable bh and stop using tcp_sigpool
> + * @c: tcp_sigpool context that was returned by tcp_sigpool_start()
> + */
> +void tcp_sigpool_end(struct tcp_sigpool *c);
> +size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len);
>  /* - functions */
>  int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key=
,
>                         const struct sock *sk, const struct sk_buff *skb)=
;
> @@ -1761,17 +1788,12 @@ tcp_inbound_md5_hash(const struct sock *sk, const=
 struct sk_buff *skb,
>  #define tcp_twsk_md5_key(twsk) NULL
>  #endif
>
> -bool tcp_alloc_md5sig_pool(void);
> +int tcp_md5_alloc_sigpool(void);
> +void tcp_md5_release_sigpool(void);
> +void tcp_md5_add_sigpool(void);
> +extern int tcp_md5_sigpool_id;
>
> -struct tcp_md5sig_pool *tcp_get_md5sig_pool(void);
> -static inline void tcp_put_md5sig_pool(void)
> -{
> -       local_bh_enable();
> -}
> -
> -int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *, const struct sk_buff=
 *,
> -                         unsigned int header_len);
> -int tcp_md5_hash_key(struct tcp_md5sig_pool *hp,
> +int tcp_md5_hash_key(struct tcp_sigpool *hp,
>                      const struct tcp_md5sig_key *key);
>
>  /* From tcp_fastopen.c */
> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index 2dfb12230f08..89e2ab023272 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -741,10 +741,14 @@ config DEFAULT_TCP_CONG
>         default "bbr" if DEFAULT_BBR
>         default "cubic"
>
> +config TCP_SIGPOOL
> +       tristate
> +
>  config TCP_MD5SIG
>         bool "TCP: MD5 Signature Option support (RFC2385)"
>         select CRYPTO
>         select CRYPTO_MD5
> +       select TCP_SIGPOOL
>         help
>           RFC2385 specifies a method of giving MD5 protection to TCP sess=
ions.
>           Its main (only?) use is to protect BGP sessions between core ro=
uters
> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index b18ba8ef93ad..cd760793cfcb 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_TCP_CONG_SCALABLE) +=3D tcp_scalable.o
>  obj-$(CONFIG_TCP_CONG_LP) +=3D tcp_lp.o
>  obj-$(CONFIG_TCP_CONG_YEAH) +=3D tcp_yeah.o
>  obj-$(CONFIG_TCP_CONG_ILLINOIS) +=3D tcp_illinois.o
> +obj-$(CONFIG_TCP_SIGPOOL) +=3D tcp_sigpool.o
>  obj-$(CONFIG_NET_SOCK_MSG) +=3D tcp_bpf.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D udp_bpf.o
>  obj-$(CONFIG_NETLABEL) +=3D cipso_ipv4.o
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index aca5620cf3ba..e91931d0350e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4310,141 +4310,46 @@ int tcp_getsockopt(struct sock *sk, int level, i=
nt optname, char __user *optval,
>  EXPORT_SYMBOL(tcp_getsockopt);
>
>  #ifdef CONFIG_TCP_MD5SIG
> -static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig_pool);
> -static DEFINE_MUTEX(tcp_md5sig_mutex);
> -static bool tcp_md5sig_pool_populated =3D false;
> +int tcp_md5_sigpool_id =3D -1;
> +EXPORT_SYMBOL_GPL(tcp_md5_sigpool_id);
>
> -static void __tcp_alloc_md5sig_pool(void)
> +int tcp_md5_alloc_sigpool(void)
>  {
> -       struct crypto_ahash *hash;
> -       int cpu;
> +       size_t scratch_size;
> +       int ret;
>
> -       hash =3D crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> -       if (IS_ERR(hash))
> -               return;
> -
> -       for_each_possible_cpu(cpu) {
> -               void *scratch =3D per_cpu(tcp_md5sig_pool, cpu).scratch;
> -               struct ahash_request *req;
> -
> -               if (!scratch) {
> -                       scratch =3D kmalloc_node(sizeof(union tcp_md5sum_=
block) +
> -                                              sizeof(struct tcphdr),
> -                                              GFP_KERNEL,
> -                                              cpu_to_node(cpu));
> -                       if (!scratch)
> -                               return;
> -                       per_cpu(tcp_md5sig_pool, cpu).scratch =3D scratch=
;
> -               }
> -               if (per_cpu(tcp_md5sig_pool, cpu).md5_req)
> -                       continue;
> -
> -               req =3D ahash_request_alloc(hash, GFP_KERNEL);
> -               if (!req)
> -                       return;
> -
> -               ahash_request_set_callback(req, 0, NULL, NULL);
> -
> -               per_cpu(tcp_md5sig_pool, cpu).md5_req =3D req;
> +       scratch_size =3D sizeof(union tcp_md5sum_block) + sizeof(struct t=
cphdr);
> +       ret =3D tcp_sigpool_alloc_ahash("md5", scratch_size);
> +       if (ret >=3D 0) {
> +               tcp_md5_sigpool_id =3D ret;

tcp_md5_alloc_sigpool() can be called from multiple cpus,
yet you are writing over tcp_md5_sigpool_id here without any
spinlock/mutex/annotations ?

KCSAN would eventually file a report, and a compiler might very well
transform this to

tcp_md5_sigpool_id =3D random_value;
<window where readers might catch garbage>
tcp_md5_sigpool_id =3D ret;






> +               return 0;
>         }
> -       /* before setting tcp_md5sig_pool_populated, we must commit all w=
rites
> -        * to memory. See smp_rmb() in tcp_get_md5sig_pool()
> -        */
> -       smp_wmb();
> -       /* Paired with READ_ONCE() from tcp_alloc_md5sig_pool()
> -        * and tcp_get_md5sig_pool().
> -       */
> -       WRITE_ONCE(tcp_md5sig_pool_populated, true);
> +       return ret;
>  }
>
> -bool tcp_alloc_md5sig_pool(void)
> +void tcp_md5_release_sigpool(void)
>  {
> -       /* Paired with WRITE_ONCE() from __tcp_alloc_md5sig_pool() */
> -       if (unlikely(!READ_ONCE(tcp_md5sig_pool_populated))) {
> -               mutex_lock(&tcp_md5sig_mutex);
> -
> -               if (!tcp_md5sig_pool_populated)
> -                       __tcp_alloc_md5sig_pool();
> -
> -               mutex_unlock(&tcp_md5sig_mutex);
> -       }
> -       /* Paired with WRITE_ONCE() from __tcp_alloc_md5sig_pool() */
> -       return READ_ONCE(tcp_md5sig_pool_populated);
> +       tcp_sigpool_release(tcp_md5_sigpool_id);

race reading tcp_md5_sigpool_id

>  }
> -EXPORT_SYMBOL(tcp_alloc_md5sig_pool);
>
> -
> -/**
> - *     tcp_get_md5sig_pool - get md5sig_pool for this user
> - *
> - *     We use percpu structure, so if we succeed, we exit with preemptio=
n
> - *     and BH disabled, to make sure another thread or softirq handling
> - *     wont try to get same context.
> - */
> -struct tcp_md5sig_pool *tcp_get_md5sig_pool(void)
> +void tcp_md5_add_sigpool(void)
>  {
> -       local_bh_disable();
> -
> -       /* Paired with WRITE_ONCE() from __tcp_alloc_md5sig_pool() */
> -       if (READ_ONCE(tcp_md5sig_pool_populated)) {
> -               /* coupled with smp_wmb() in __tcp_alloc_md5sig_pool() */
> -               smp_rmb();
> -               return this_cpu_ptr(&tcp_md5sig_pool);
> -       }
> -       local_bh_enable();
> -       return NULL;
> +       tcp_sigpool_get(tcp_md5_sigpool_id);



>  }
> -EXPORT_SYMBOL(tcp_get_md5sig_pool);
>
> -int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
> -                         const struct sk_buff *skb, unsigned int header_=
len)
> -{
> -       struct scatterlist sg;
> -       const struct tcphdr *tp =3D tcp_hdr(skb);
> -       struct ahash_request *req =3D hp->md5_req;
> -       unsigned int i;
> -       const unsigned int head_data_len =3D skb_headlen(skb) > header_le=
n ?
> -                                          skb_headlen(skb) - header_len =
: 0;
> -       const struct skb_shared_info *shi =3D skb_shinfo(skb);
> -       struct sk_buff *frag_iter;
> -
> -       sg_init_table(&sg, 1);
> -
> -       sg_set_buf(&sg, ((u8 *) tp) + header_len, head_data_len);
> -       ahash_request_set_crypt(req, &sg, NULL, head_data_len);
> -       if (crypto_ahash_update(req))
> -               return 1;
> -
> -       for (i =3D 0; i < shi->nr_frags; ++i) {
> -               const skb_frag_t *f =3D &shi->frags[i];
> -               unsigned int offset =3D skb_frag_off(f);
> -               struct page *page =3D skb_frag_page(f) + (offset >> PAGE_=
SHIFT);
> -
> -               sg_set_page(&sg, page, skb_frag_size(f),
> -                           offset_in_page(offset));
> -               ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f))=
;
> -               if (crypto_ahash_update(req))
> -                       return 1;
> -       }
> -
> -       skb_walk_frags(skb, frag_iter)
> -               if (tcp_md5_hash_skb_data(hp, frag_iter, 0))
> -                       return 1;
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL(tcp_md5_hash_skb_data);
> -
> -int tcp_md5_hash_key(struct tcp_md5sig_pool *hp, const struct tcp_md5sig=
_key *key)
> +int tcp_md5_hash_key(struct tcp_sigpool *hp,
> +                    const struct tcp_md5sig_key *key)
>  {
>         u8 keylen =3D READ_ONCE(key->keylen); /* paired with WRITE_ONCE()=
 in tcp_md5_do_add */
>         struct scatterlist sg;
>
>         sg_init_one(&sg, key->key, keylen);
> -       ahash_request_set_crypt(hp->md5_req, &sg, NULL, keylen);
> +       ahash_request_set_crypt(hp->req, &sg, NULL, keylen);
>
> -       /* We use data_race() because tcp_md5_do_add() might change key->=
key under us */
> -       return data_race(crypto_ahash_update(hp->md5_req));
> +       /* We use data_race() because tcp_md5_do_add() might change
> +        * key->key under us
> +        */
> +       return data_race(crypto_ahash_update(hp->req));
>  }
>  EXPORT_SYMBOL(tcp_md5_hash_key);
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 09cffbc82d32..600e49b23fbe 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1220,10 +1220,6 @@ static int __tcp_md5_do_add(struct sock *sk, const=
 union tcp_md5_addr *addr,
>         key =3D sock_kmalloc(sk, sizeof(*key), gfp | __GFP_ZERO);
>         if (!key)
>                 return -ENOMEM;
> -       if (!tcp_alloc_md5sig_pool()) {
> -               sock_kfree_s(sk, key, sizeof(*key));
> -               return -ENOMEM;
> -       }
>
>         memcpy(key->key, newkey, newkeylen);
>         key->keylen =3D newkeylen;
> @@ -1245,15 +1241,21 @@ int tcp_md5_do_add(struct sock *sk, const union t=
cp_md5_addr *addr,
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
>         if (!rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_h=
eld(sk))) {
> -               if (tcp_md5sig_info_add(sk, GFP_KERNEL))
> +               if (tcp_md5_alloc_sigpool())
>                         return -ENOMEM;
>
> +               if (tcp_md5sig_info_add(sk, GFP_KERNEL)) {
> +                       tcp_md5_release_sigpool();
> +                       return -ENOMEM;
> +               }
> +
>                 if (!static_branch_inc(&tcp_md5_needed.key)) {
>                         struct tcp_md5sig_info *md5sig;
>
>                         md5sig =3D rcu_dereference_protected(tp->md5sig_i=
nfo, lockdep_sock_is_held(sk));
>                         rcu_assign_pointer(tp->md5sig_info, NULL);
>                         kfree_rcu(md5sig, rcu);
> +                       tcp_md5_release_sigpool();
>                         return -EUSERS;
>                 }
>         }
> @@ -1270,8 +1272,12 @@ int tcp_md5_key_copy(struct sock *sk, const union =
tcp_md5_addr *addr,
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
>         if (!rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_h=
eld(sk))) {
> -               if (tcp_md5sig_info_add(sk, sk_gfp_mask(sk, GFP_ATOMIC)))
> +               tcp_md5_add_sigpool();
> +
> +               if (tcp_md5sig_info_add(sk, sk_gfp_mask(sk, GFP_ATOMIC)))=
 {
> +                       tcp_md5_release_sigpool();
>                         return -ENOMEM;
> +               }
>
>                 if (!static_key_fast_inc_not_disabled(&tcp_md5_needed.key=
.key)) {
>                         struct tcp_md5sig_info *md5sig;
> @@ -1280,6 +1286,7 @@ int tcp_md5_key_copy(struct sock *sk, const union t=
cp_md5_addr *addr,
>                         net_warn_ratelimited("Too many TCP-MD5 keys in th=
e system\n");
>                         rcu_assign_pointer(tp->md5sig_info, NULL);
>                         kfree_rcu(md5sig, rcu);
> +                       tcp_md5_release_sigpool();
>                         return -EUSERS;
>                 }
>         }
> @@ -1379,7 +1386,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, i=
nt optname,
>                               cmd.tcpm_key, cmd.tcpm_keylen);
>  }
>
> -static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
> +static int tcp_v4_md5_hash_headers(struct tcp_sigpool *hp,
>                                    __be32 daddr, __be32 saddr,
>                                    const struct tcphdr *th, int nbytes)
>  {
> @@ -1399,38 +1406,35 @@ static int tcp_v4_md5_hash_headers(struct tcp_md5=
sig_pool *hp,
>         _th->check =3D 0;
>
>         sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> -       ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> +       ahash_request_set_crypt(hp->req, &sg, NULL,
>                                 sizeof(*bp) + sizeof(*th));
> -       return crypto_ahash_update(hp->md5_req);
> +       return crypto_ahash_update(hp->req);
>  }
>
>  static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_k=
ey *key,
>                                __be32 daddr, __be32 saddr, const struct t=
cphdr *th)
>  {
> -       struct tcp_md5sig_pool *hp;
> -       struct ahash_request *req;
> +       struct tcp_sigpool hp;
>
> -       hp =3D tcp_get_md5sig_pool();
> -       if (!hp)
> -               goto clear_hash_noput;
> -       req =3D hp->md5_req;
> +       if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
> +               goto clear_hash_nostart;
>
> -       if (crypto_ahash_init(req))
> +       if (crypto_ahash_init(hp.req))
>                 goto clear_hash;
> -       if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> +       if (tcp_v4_md5_hash_headers(&hp, daddr, saddr, th, th->doff << 2)=
)
>                 goto clear_hash;
> -       if (tcp_md5_hash_key(hp, key))
> +       if (tcp_md5_hash_key(&hp, key))
>                 goto clear_hash;
> -       ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -       if (crypto_ahash_final(req))
> +       ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
> +       if (crypto_ahash_final(hp.req))
>                 goto clear_hash;
>
> -       tcp_put_md5sig_pool();
> +       tcp_sigpool_end(&hp);
>         return 0;
>
>  clear_hash:
> -       tcp_put_md5sig_pool();
> -clear_hash_noput:
> +       tcp_sigpool_end(&hp);
> +clear_hash_nostart:
>         memset(md5_hash, 0, 16);
>         return 1;
>  }
> @@ -1439,9 +1443,8 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struc=
t tcp_md5sig_key *key,
>                         const struct sock *sk,
>                         const struct sk_buff *skb)
>  {
> -       struct tcp_md5sig_pool *hp;
> -       struct ahash_request *req;
>         const struct tcphdr *th =3D tcp_hdr(skb);
> +       struct tcp_sigpool hp;
>         __be32 saddr, daddr;
>
>         if (sk) { /* valid for establish/request sockets */
> @@ -1453,30 +1456,28 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const str=
uct tcp_md5sig_key *key,
>                 daddr =3D iph->daddr;
>         }
>
> -       hp =3D tcp_get_md5sig_pool();
> -       if (!hp)
> -               goto clear_hash_noput;
> -       req =3D hp->md5_req;
> +       if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
> +               goto clear_hash_nostart;
>
> -       if (crypto_ahash_init(req))
> +       if (crypto_ahash_init(hp.req))
>                 goto clear_hash;
>
> -       if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> +       if (tcp_v4_md5_hash_headers(&hp, daddr, saddr, th, skb->len))
>                 goto clear_hash;
> -       if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> +       if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
>                 goto clear_hash;
> -       if (tcp_md5_hash_key(hp, key))
> +       if (tcp_md5_hash_key(&hp, key))
>                 goto clear_hash;
> -       ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -       if (crypto_ahash_final(req))
> +       ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
> +       if (crypto_ahash_final(hp.req))
>                 goto clear_hash;
>
> -       tcp_put_md5sig_pool();
> +       tcp_sigpool_end(&hp);
>         return 0;
>
>  clear_hash:
> -       tcp_put_md5sig_pool();
> -clear_hash_noput:
> +       tcp_sigpool_end(&hp);
> +clear_hash_nostart:
>         memset(md5_hash, 0, 16);
>         return 1;
>  }
> @@ -2294,6 +2295,18 @@ static int tcp_v4_init_sock(struct sock *sk)
>         return 0;
>  }
>
> +#ifdef CONFIG_TCP_MD5SIG
> +static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
> +{
> +       struct tcp_md5sig_info *md5sig;
> +
> +       md5sig =3D container_of(head, struct tcp_md5sig_info, rcu);
> +       kfree(md5sig);
> +       static_branch_slow_dec_deferred(&tcp_md5_needed);
> +       tcp_md5_release_sigpool();
> +}
> +#endif
> +
>  void tcp_v4_destroy_sock(struct sock *sk)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
> @@ -2318,10 +2331,12 @@ void tcp_v4_destroy_sock(struct sock *sk)
>  #ifdef CONFIG_TCP_MD5SIG
>         /* Clean up the MD5 key list, if any */
>         if (tp->md5sig_info) {
> +               struct tcp_md5sig_info *md5sig;
> +
> +               md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1);
>                 tcp_clear_md5_list(sk);
> -               kfree_rcu(rcu_dereference_protected(tp->md5sig_info, 1), =
rcu);
> -               tp->md5sig_info =3D NULL;
> -               static_branch_slow_dec_deferred(&tcp_md5_needed);
> +               call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
> +               rcu_assign_pointer(tp->md5sig_info, NULL);
>         }
>  #endif
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index c8f2aa003387..5616b6a34bee 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -261,10 +261,9 @@ static void tcp_time_wait_init(struct sock *sk, stru=
ct tcp_timewait_sock *tcptw)
>                 tcptw->tw_md5_key =3D kmemdup(key, sizeof(*key), GFP_ATOM=
IC);
>                 if (!tcptw->tw_md5_key)
>                         return;
> -               if (!tcp_alloc_md5sig_pool())
> -                       goto out_free;
>                 if (!static_key_fast_inc_not_disabled(&tcp_md5_needed.key=
.key))
>                         goto out_free;
> +               tcp_md5_add_sigpool();
>         }
>         return;
>  out_free:
> @@ -349,16 +348,26 @@ void tcp_time_wait(struct sock *sk, int state, int =
timeo)
>  }
>  EXPORT_SYMBOL(tcp_time_wait);
>
> +#ifdef CONFIG_TCP_MD5SIG
> +static void tcp_md5_twsk_free_rcu(struct rcu_head *head)
> +{
> +       struct tcp_md5sig_key *key;
> +
> +       key =3D container_of(head, struct tcp_md5sig_key, rcu);
> +       kfree(key);
> +       static_branch_slow_dec_deferred(&tcp_md5_needed);
> +       tcp_md5_release_sigpool();
> +}
> +#endif
> +
>  void tcp_twsk_destructor(struct sock *sk)
>  {
>  #ifdef CONFIG_TCP_MD5SIG
>         if (static_branch_unlikely(&tcp_md5_needed.key)) {
>                 struct tcp_timewait_sock *twsk =3D tcp_twsk(sk);
>
> -               if (twsk->tw_md5_key) {
> -                       kfree_rcu(twsk->tw_md5_key, rcu);
> -                       static_branch_slow_dec_deferred(&tcp_md5_needed);
> -               }
> +               if (twsk->tw_md5_key)
> +                       call_rcu(&twsk->tw_md5_key->rcu, tcp_md5_twsk_fre=
e_rcu);
>         }
>  #endif
>  }
> diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
> new file mode 100644
> index 000000000000..65a8eaae2fec
> --- /dev/null
> +++ b/net/ipv4/tcp_sigpool.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <crypto/hash.h>
> +#include <linux/cpu.h>
> +#include <linux/kref.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/percpu.h>
> +#include <linux/workqueue.h>
> +#include <net/tcp.h>
> +
> +static size_t __scratch_size;
> +static DEFINE_PER_CPU(void __rcu *, sigpool_scratch);
> +
> +struct sigpool_entry {
> +       struct crypto_ahash     *hash;
> +       const char              *alg;
> +       struct kref             kref;
> +       uint16_t                needs_key:1,
> +                               reserved:15;
> +};
> +
> +#define CPOOL_SIZE (PAGE_SIZE / sizeof(struct sigpool_entry))
> +static struct sigpool_entry cpool[CPOOL_SIZE];
> +static unsigned int cpool_populated;
> +static DEFINE_MUTEX(cpool_mutex);
> +
> +/* Slow-path */
> +struct scratches_to_free {
> +       struct rcu_head rcu;
> +       unsigned int cnt;
> +       void *scratches[];
> +};
> +
> +static void free_old_scratches(struct rcu_head *head)
> +{
> +       struct scratches_to_free *stf;
> +
> +       stf =3D container_of(head, struct scratches_to_free, rcu);
> +       while (stf->cnt--)
> +               kfree(stf->scratches[stf->cnt]);
> +       kfree(stf);
> +}
> +
> +/**
> + * sigpool_reserve_scratch - re-allocates scratch buffer, slow-path
> + * @size: request size for the scratch/temp buffer
> + */
> +static int sigpool_reserve_scratch(size_t size)
> +{
> +       struct scratches_to_free *stf;
> +       size_t stf_sz =3D struct_size(stf, scratches, num_possible_cpus()=
);

This is wrong.   num_possible_cpus() could be 2, with two cpus numbered 0 a=
nd 8.

Look for nr_cpu_ids instead.

> +       int cpu, err =3D 0;
> +
> +       lockdep_assert_held(&cpool_mutex);
> +       if (__scratch_size >=3D size)
> +               return 0;
> +
> +       stf =3D kmalloc(stf_sz, GFP_KERNEL);
> +       if (!stf)
> +               return -ENOMEM;
> +       stf->cnt =3D 0;
> +
> +       size =3D max(size, __scratch_size);
> +       cpus_read_lock();
> +       for_each_possible_cpu(cpu) {
> +               void *scratch, *old_scratch;
> +
> +               scratch =3D kmalloc_node(size, GFP_KERNEL, cpu_to_node(cp=
u));
> +               if (!scratch) {
> +                       err =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               old_scratch =3D rcu_replace_pointer(per_cpu(sigpool_scrat=
ch, cpu),
> +                                       scratch, lockdep_is_held(&cpool_m=
utex));
> +               if (!cpu_online(cpu) || !old_scratch) {
> +                       kfree(old_scratch);
> +                       continue;
> +               }
> +               stf->scratches[stf->cnt++] =3D old_scratch;
> +       }


I wonder why you are not simply using something around __alloc_percpu()

> +       cpus_read_unlock();
> +       if (!err)
> +               __scratch_size =3D size;
> +
> +       call_rcu(&stf->rcu, free_old_scratches);
> +       return err;
> +}
> +
> +static void sigpool_scratch_free(void)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu)
> +               kfree(rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
> +                                         NULL, lockdep_is_held(&cpool_mu=
tex)));

I wonder why bothering about freeing some space ? One scratch buffer
per cpu is really small.

> +       __scratch_size =3D 0;
> +}
> +
> +static int __cpool_try_clone(struct crypto_ahash *hash)
> +{
> +       struct crypto_ahash *tmp;
> +
> +       tmp =3D crypto_clone_ahash(hash);
> +       if (IS_ERR(tmp))
> +               return PTR_ERR(tmp);
> +
> +       crypto_free_ahash(tmp);
> +       return 0;
> +}
> +
> +static int __cpool_alloc_ahash(struct sigpool_entry *e, const char *alg)
> +{
> +       struct crypto_ahash *cpu0_hash;
> +       int ret;
> +
> +       e->alg =3D kstrdup(alg, GFP_KERNEL);
> +       if (!e->alg)
> +               return -ENOMEM;
> +
> +       cpu0_hash =3D crypto_alloc_ahash(alg, 0, CRYPTO_ALG_ASYNC);
> +       if (IS_ERR(cpu0_hash)) {
> +               ret =3D PTR_ERR(cpu0_hash);
> +               goto out_free_alg;
> +       }
> +
> +       e->needs_key =3D crypto_ahash_get_flags(cpu0_hash) & CRYPTO_TFM_N=
EED_KEY;
> +
> +       ret =3D __cpool_try_clone(cpu0_hash);
> +       if (ret)
> +               goto out_free_cpu0_hash;
> +       e->hash =3D cpu0_hash;
> +       kref_init(&e->kref);
> +       return 0;
> +
> +out_free_cpu0_hash:
> +       crypto_free_ahash(cpu0_hash);
> +out_free_alg:
> +       kfree(e->alg);
> +       e->alg =3D NULL;
> +       return ret;
> +}
> +
> +/**
> + * tcp_sigpool_alloc_ahash - allocates pool for ahash requests
> + * @alg: name of async hash algorithm
> + * @scratch_size: reserve a tcp_sigpool::scratch buffer of this size
> + */
> +int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size)
> +{
> +       int i, ret;
> +
> +       /* slow-path */
> +       mutex_lock(&cpool_mutex);
> +       ret =3D sigpool_reserve_scratch(scratch_size);
> +       if (ret)
> +               goto out;
> +       for (i =3D 0; i < cpool_populated; i++) {
> +               if (!cpool[i].alg)
> +                       continue;
> +               if (strcmp(cpool[i].alg, alg))
> +                       continue;
> +
> +               if (kref_read(&cpool[i].kref) > 0)
> +                       kref_get(&cpool[i].kref);
> +               else
> +                       kref_init(&cpool[i].kref);

This looks wrong. kref_init() should be called once, after allocation,
not based on kref_read().


> +               ret =3D i;
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < cpool_populated; i++) {
> +               if (!cpool[i].alg)
> +                       break;
> +       }
> +       if (i >=3D CPOOL_SIZE) {
> +               ret =3D -ENOSPC;
> +               goto out;
> +       }
> +
> +       ret =3D __cpool_alloc_ahash(&cpool[i], alg);
> +       if (!ret) {
> +               ret =3D i;
> +               if (i =3D=3D cpool_populated)
> +                       cpool_populated++;
> +       }
> +out:
> +       mutex_unlock(&cpool_mutex);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(tcp_sigpool_alloc_ahash);
> +
> +static void __cpool_free_entry(struct sigpool_entry *e)
> +{
> +       crypto_free_ahash(e->hash);
> +       kfree(e->alg);
> +       memset(e, 0, sizeof(*e));
> +}
> +
> +static void cpool_cleanup_work_cb(struct work_struct *work)

Really this looks over complicated to me.

All this kref maintenance and cpool_mutex costs :/

> +{
> +       bool free_scratch =3D true;
> +       unsigned int i;
> +
> +       mutex_lock(&cpool_mutex);
> +       for (i =3D 0; i < cpool_populated; i++) {
> +               if (kref_read(&cpool[i].kref) > 0) {
> +                       free_scratch =3D false;
> +                       continue;
> +               }
> +               if (!cpool[i].alg)
> +                       continue;
> +               __cpool_free_entry(&cpool[i]);
> +       }
> +       if (free_scratch)
> +               sigpool_scratch_free();
> +       mutex_unlock(&cpool_mutex);
> +}
> +
> +static DECLARE_WORK(cpool_cleanup_work, cpool_cleanup_work_cb);
> +static void cpool_schedule_cleanup(struct kref *kref)
> +{
> +       schedule_work(&cpool_cleanup_work);
> +}
> +
> +/**
> + * tcp_sigpool_release - decreases number of users for a pool. If it was
> + * the last user of the pool, releases any memory that was consumed.
> + * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_a=
hash()
> + */
> +void tcp_sigpool_release(unsigned int id)
> +{
> +       if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
> +               return;
> +
> +       /* slow-path */
> +       kref_put(&cpool[id].kref, cpool_schedule_cleanup);
> +}
> +EXPORT_SYMBOL_GPL(tcp_sigpool_release);
> +
> +/**
> + * tcp_sigpool_get - increases number of users (refcounter) for a pool
> + * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_a=
hash()
> + */
> +void tcp_sigpool_get(unsigned int id)
> +{
> +       if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
> +               return;
> +       kref_get(&cpool[id].kref);
> +}
> +EXPORT_SYMBOL_GPL(tcp_sigpool_get);
> +
> +int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acq=
uires(RCU_BH)
> +{
> +       struct crypto_ahash *hash;
> +
> +       rcu_read_lock_bh();
> +       if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg)) {
> +               rcu_read_unlock_bh();
> +               return -EINVAL;
> +       }
> +
> +       hash =3D crypto_clone_ahash(cpool[id].hash);
> +       if (IS_ERR(hash)) {
> +               rcu_read_unlock_bh();
> +               return PTR_ERR(hash);
> +       }
> +
> +       c->req =3D ahash_request_alloc(hash, GFP_ATOMIC);
> +       if (!c->req) {
> +               crypto_free_ahash(hash);
> +               rcu_read_unlock_bh();
> +               return -ENOMEM;
> +       }
> +       ahash_request_set_callback(c->req, 0, NULL, NULL);
> +
> +       /* Pairs with tcp_sigpool_reserve_scratch(), scratch area is
> +        * valid (allocated) until tcp_sigpool_end().
> +        */
> +       c->scratch =3D rcu_dereference_bh(*this_cpu_ptr(&sigpool_scratch)=
);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(tcp_sigpool_start);
> +
> +void tcp_sigpool_end(struct tcp_sigpool *c) __releases(RCU_BH)
> +{
> +       struct crypto_ahash *hash =3D crypto_ahash_reqtfm(c->req);
> +
> +       rcu_read_unlock_bh();
> +       ahash_request_free(c->req);
> +       crypto_free_ahash(hash);
> +}
> +EXPORT_SYMBOL_GPL(tcp_sigpool_end);
> +
> +/**
> + * tcp_sigpool_algo - return algorithm of tcp_sigpool
> + * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_a=
hash()
> + * @buf: buffer to return name of algorithm
> + * @buf_len: size of @buf
> + */
> +size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len)
> +{
> +       if (WARN_ON_ONCE(id > cpool_populated || !cpool[id].alg))
> +               return -EINVAL;
> +
> +       return strscpy(buf, cpool[id].alg, buf_len);
> +}
> +EXPORT_SYMBOL_GPL(tcp_sigpool_algo);
> +
> +/**
> + * tcp_sigpool_hash_skb_data - hash data in skb with initialized tcp_sig=
pool
> + * @hp: tcp_sigpool pointer
> + * @skb: buffer to add sign for
> + * @header_len: TCP header length for this segment
> + */
> +int tcp_sigpool_hash_skb_data(struct tcp_sigpool *hp,
> +                             const struct sk_buff *skb,
> +                             unsigned int header_len)
> +{
> +       const unsigned int head_data_len =3D skb_headlen(skb) > header_le=
n ?
> +                                          skb_headlen(skb) - header_len =
: 0;
> +       const struct skb_shared_info *shi =3D skb_shinfo(skb);
> +       const struct tcphdr *tp =3D tcp_hdr(skb);
> +       struct ahash_request *req =3D hp->req;
> +       struct sk_buff *frag_iter;
> +       struct scatterlist sg;
> +       unsigned int i;
> +
> +       sg_init_table(&sg, 1);
> +
> +       sg_set_buf(&sg, ((u8 *)tp) + header_len, head_data_len);
> +       ahash_request_set_crypt(req, &sg, NULL, head_data_len);
> +       if (crypto_ahash_update(req))
> +               return 1;
> +
> +       for (i =3D 0; i < shi->nr_frags; ++i) {
> +               const skb_frag_t *f =3D &shi->frags[i];
> +               unsigned int offset =3D skb_frag_off(f);
> +               struct page *page;
> +
> +               page =3D skb_frag_page(f) + (offset >> PAGE_SHIFT);
> +               sg_set_page(&sg, page, skb_frag_size(f), offset_in_page(o=
ffset));
> +               ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f))=
;
> +               if (crypto_ahash_update(req))
> +                       return 1;
> +       }
> +
> +       skb_walk_frags(skb, frag_iter)
> +               if (tcp_sigpool_hash_skb_data(hp, frag_iter, 0))
> +                       return 1;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(tcp_sigpool_hash_skb_data);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Per-CPU pool of crypto requests");
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 1b4529e833a1..47d798cede56 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -670,7 +670,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int=
 optname,
>                               cmd.tcpm_key, cmd.tcpm_keylen);
>  }
>
> -static int tcp_v6_md5_hash_headers(struct tcp_md5sig_pool *hp,
> +static int tcp_v6_md5_hash_headers(struct tcp_sigpool *hp,
>                                    const struct in6_addr *daddr,
>                                    const struct in6_addr *saddr,
>                                    const struct tcphdr *th, int nbytes)
> @@ -691,39 +691,36 @@ static int tcp_v6_md5_hash_headers(struct tcp_md5si=
g_pool *hp,
>         _th->check =3D 0;
>
>         sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> -       ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> +       ahash_request_set_crypt(hp->req, &sg, NULL,
>                                 sizeof(*bp) + sizeof(*th));
> -       return crypto_ahash_update(hp->md5_req);
> +       return crypto_ahash_update(hp->req);
>  }
>
>  static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_k=
ey *key,
>                                const struct in6_addr *daddr, struct in6_a=
ddr *saddr,
>                                const struct tcphdr *th)
>  {
> -       struct tcp_md5sig_pool *hp;
> -       struct ahash_request *req;
> +       struct tcp_sigpool hp;
>
> -       hp =3D tcp_get_md5sig_pool();
> -       if (!hp)
> -               goto clear_hash_noput;
> -       req =3D hp->md5_req;
> +       if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
> +               goto clear_hash_nostart;
>
> -       if (crypto_ahash_init(req))
> +       if (crypto_ahash_init(hp.req))
>                 goto clear_hash;
> -       if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> +       if (tcp_v6_md5_hash_headers(&hp, daddr, saddr, th, th->doff << 2)=
)
>                 goto clear_hash;
> -       if (tcp_md5_hash_key(hp, key))
> +       if (tcp_md5_hash_key(&hp, key))
>                 goto clear_hash;
> -       ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -       if (crypto_ahash_final(req))
> +       ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
> +       if (crypto_ahash_final(hp.req))
>                 goto clear_hash;
>
> -       tcp_put_md5sig_pool();
> +       tcp_sigpool_end(&hp);
>         return 0;
>
>  clear_hash:
> -       tcp_put_md5sig_pool();
> -clear_hash_noput:
> +       tcp_sigpool_end(&hp);
> +clear_hash_nostart:
>         memset(md5_hash, 0, 16);
>         return 1;
>  }
> @@ -733,10 +730,9 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
>                                const struct sock *sk,
>                                const struct sk_buff *skb)
>  {
> -       const struct in6_addr *saddr, *daddr;
> -       struct tcp_md5sig_pool *hp;
> -       struct ahash_request *req;
>         const struct tcphdr *th =3D tcp_hdr(skb);
> +       const struct in6_addr *saddr, *daddr;
> +       struct tcp_sigpool hp;
>
>         if (sk) { /* valid for establish/request sockets */
>                 saddr =3D &sk->sk_v6_rcv_saddr;
> @@ -747,30 +743,28 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
>                 daddr =3D &ip6h->daddr;
>         }
>
> -       hp =3D tcp_get_md5sig_pool();
> -       if (!hp)
> -               goto clear_hash_noput;
> -       req =3D hp->md5_req;
> +       if (tcp_sigpool_start(tcp_md5_sigpool_id, &hp))
> +               goto clear_hash_nostart;
>
> -       if (crypto_ahash_init(req))
> +       if (crypto_ahash_init(hp.req))
>                 goto clear_hash;
>
> -       if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> +       if (tcp_v6_md5_hash_headers(&hp, daddr, saddr, th, skb->len))
>                 goto clear_hash;
> -       if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> +       if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
>                 goto clear_hash;
> -       if (tcp_md5_hash_key(hp, key))
> +       if (tcp_md5_hash_key(&hp, key))
>                 goto clear_hash;
> -       ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -       if (crypto_ahash_final(req))
> +       ahash_request_set_crypt(hp.req, NULL, md5_hash, 0);
> +       if (crypto_ahash_final(hp.req))
>                 goto clear_hash;
>
> -       tcp_put_md5sig_pool();
> +       tcp_sigpool_end(&hp);
>         return 0;
>
>  clear_hash:
> -       tcp_put_md5sig_pool();
> -clear_hash_noput:
> +       tcp_sigpool_end(&hp);
> +clear_hash_nostart:
>         memset(md5_hash, 0, 16);
>         return 1;
>  }
> --
> 2.41.0
>
