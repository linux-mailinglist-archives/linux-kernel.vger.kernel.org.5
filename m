Return-Path: <linux-kernel+bounces-77399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52848604C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721E81F26D85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5673F05;
	Thu, 22 Feb 2024 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="1R9QvXnh"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624773F26
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637120; cv=none; b=VTTzloe+8n3Xkwehq4u5TqOQMgMz/Jx9Bomg5I+mtQINHMNphfXvp6PaSB7xGF45U6j/MzSV/29Bwv0Q4caYECXH9xV34OzhPx3GPsuyMhGWMCa8PI+rEK3IsktYZGqdA+n7RtDAsbT08VXpf1qYFU065Waa3090UOro3K4z3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637120; c=relaxed/simple;
	bh=JdOecoChNZxfpRaacHzbVkkfU6PPZQpOa2pARH7Nstc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4SlfmW/8UbVameBeKTsWD4k86ZravWHX0P5OuAI5nnfZ2d+bgWS105hglnF4A+IV0KXy9El2x9h2IQE6hczVuU3/DE0TW3YmYAJE+fXCVp5fv8FBZxB+sDePgEozqnHpOW8GUEmWclV+zdYgusML2TNSCBdp7Xgksiwhc3+76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1R9QvXnh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso292a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708637116; x=1709241916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaDmAwP/ZWFzPXxp76X5TkdWpYeFgc29FvFBsoVliEE=;
        b=1R9QvXnhzlawcKDGDUVloo5TpiJuR2cJOuU7ARwZgT1wIYJo2AvJNshQSvvNgGh9zo
         ETGkHXdMHl6DE0Kvti47YIaFxCU8FYukfa1paqYztAkb7fzuiuoFEFy+KhX4W1jC2T1R
         RrBRLZqVyHYWWsvY1mcUUNHwWnrxW5es08D5VDCKoQBmF5xNLapK9/9Ms7EKd/Uw6AQi
         GGQLiXoWQjI/ce3+wHUEvXuKe2dKF+xoZZuRmUGcCwY0jk0jH9s66v01tT0J5Tj5+CIS
         jIUadZFWHgpIqXk9KNx2uEOyiNyhsUhfkekEJPo809SxQ/1Fz6ki/ySCnUpzsl2pABKQ
         5dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708637116; x=1709241916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaDmAwP/ZWFzPXxp76X5TkdWpYeFgc29FvFBsoVliEE=;
        b=a0u49eVkYt2H1DFoYTdXi82QyWP9Hb9UVMQVi4gKzVfS7yW4t8lPiedBYzHtuuTKMB
         4UgLWeIhKaYAg9mxGHqM9oaBMhLDVvk99uWzoi+Yr5E8F7da4xwcIGZDAfJu+vnyYxTV
         OBpaoFApQzztKrwxgAIYkvJmFrI6CaB532e5zXwOrT0oiH+YYxtYm+zmr03rOIv29z01
         eQX+O+sG7zs2fiieXqzeQFmbL//qjvKgbqx+mVj9OmZOvKN14siDXqsD+S9gLa4TVuyN
         DCcbRzhxvXCtrNvNnAa9tx+8ZkE1iKLWWCM3ETwX/CKqTbx+w4jjbuk63RS+VtzE44UY
         /W9A==
X-Forwarded-Encrypted: i=1; AJvYcCWHsU7PStvVQqfeFaBRnWW06TdcA+8y+CmiCoqDHSoe58lE06kGscfSvYLbVj/X6RwRgniVsVCn/72XowyaaAW2ifF7lFGzQhGkg+Fi
X-Gm-Message-State: AOJu0YyIAo6jVYfllKhS+Ah/IcK1N3BezlLZTtMaH2xNd35yVpsw1B3H
	AC1V6oM7tEQGXfIDUetv9kVicE2KBHSYbe3Ya5BYO3jzGPxta4mNKyLDVWPqJsr6GhbA9fGrnW7
	hCdOBO6YyyQCtBm60UHKe4yjCebO/FJJLsaAD
X-Google-Smtp-Source: AGHT+IFf/+5TjmM6G5SJoEbuJf/ocmkjBNJdrIb7PBYC/6ZYJFs7cxhzn/nx3glF2TCCvlASHwxrTpmBpiKBifZLBYs=
X-Received: by 2002:a50:bae7:0:b0:563:fc50:37f9 with SMTP id
 x94-20020a50bae7000000b00563fc5037f9mr508749ede.3.1708637116190; Thu, 22 Feb
 2024 13:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com> <446695cb-50b8-4187-bf11-63aedb6e9aed@gmail.com>
In-Reply-To: <446695cb-50b8-4187-bf11-63aedb6e9aed@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 22:25:02 +0100
Message-ID: <CANn89iJxCT0Bcmqjdd1kp4VCf5i3Me7yATsZXO7SkYTPQ9BOAA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: gro: set {inner_,}network_header in
 receive phase
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, shuah@kernel.org, liujian56@huawei.com, horms@kernel.org, 
	aleksander.lobakin@intel.com, linyunsheng@huawei.com, therbert@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:05=E2=80=AFPM Richard Gobert
<richardbgobert@gmail.com> wrote:
>
> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("ud=
p:
> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in th=
e
> complete phase of gro. The functions always return skb->network_header,
> which in the case of encapsulated packets at the gro complete phase, is
> always set to the innermost L3 of the packet. That means that calling
> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer=
_
> L3/L4 may return an unexpected value.
>
> This incorrect usage leads to a bug in GRO's UDP socket lookup.
> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> *_hdr functions return network_header which will point to the innermost L=
3,
> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> encapsulated packets.
>
> Reproduction example:
>
> Endpoint configuration example (fou + local address bind)
>
>     # ip fou add port 6666 ipproto 4
>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap =
fou encap-dport 5555 encap-sport 6666 mode ipip
>     # ip link set tun1 up
>     # ip a add 1.1.1.2/24 dev tun1
>
> Netperf TCP_STREAM result on net-next before patch is applied:
>
> net-next main, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.28        2.37
>
> net-next main, GRO disabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.01     2745.06
>
> patch applied, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
>
>     131072  16384  16384    5.01     2877.38
>
> This patch fixes this bug and prevents similar future misuse of
> network_header by setting network_header and inner_network_header to thei=
r
> respective values during the receive phase of GRO. This results in
> more coherent {inner_,}network_header values for every skb in gro_list,
> which also means there's no need to set/fix these values before passing
> the packet forward.
>
> network_header is already set in dev_gro_receive and under encapsulation =
we
> set inner_network_header. *_gro_complete functions use a new helper
> function - skb_gro_complete_network_header, which returns the
> network_header/inner_network_header offset during the GRO complete phase,
> depending on skb->encapsulation.
>
> Fixes: 57c67ff4bd92 ("udp: additional GRO support")
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h        | 14 +++++++++++++-
>  net/8021q/vlan_core.c    |  3 +++
>  net/ipv4/af_inet.c       |  8 ++++----
>  net/ipv4/tcp_offload.c   |  2 +-
>  net/ipv4/udp_offload.c   |  2 +-
>  net/ipv6/ip6_offload.c   | 11 +++++------
>  net/ipv6/tcpv6_offload.c |  2 +-
>  net/ipv6/udp_offload.c   |  2 +-
>  8 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/gro.h b/include/net/gro.h
> index b435f0ddbf64..89502a7e35ed 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -177,10 +177,22 @@ static inline void *skb_gro_header(struct sk_buff *=
skb,
>         return ptr;
>  }
>
> +static inline int skb_gro_network_offset(struct sk_buff *skb)
> +{
> +       return NAPI_GRO_CB(skb)->encap_mark ? skb_inner_network_offset(sk=
b) :
> +               skb_network_offset(skb);
> +}
> +
>  static inline void *skb_gro_network_header(struct sk_buff *skb)
>  {
>         return (NAPI_GRO_CB(skb)->frag0 ?: skb->data) +
> -              skb_network_offset(skb);
> +              skb_gro_network_offset(skb);
> +}
> +
> +static inline void *skb_gro_complete_network_header(struct sk_buff *skb)
> +{
> +       return skb->encapsulation ? skb_inner_network_header(skb) :
> +               skb_network_header(skb);
>  }
>
>  static inline __wsum inet_gro_compute_pseudo(struct sk_buff *skb, int pr=
oto)
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index f00158234505..8bc871397e47 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -478,6 +478,9 @@ static struct sk_buff *vlan_gro_receive(struct list_h=
ead *head,
>         if (unlikely(!vhdr))
>                 goto out;
>
> +       if (!NAPI_GRO_CB(skb)->encap_mark)
> +               skb_set_network_header(skb, hlen);
> +
>         type =3D vhdr->h_vlan_encapsulated_proto;
>
>         ptype =3D gro_find_receive_by_type(type);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 835f4f9d98d2..c0f3c162bf73 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1564,7 +1564,9 @@ struct sk_buff *inet_gro_receive(struct list_head *=
head, struct sk_buff *skb)
>
>         NAPI_GRO_CB(skb)->is_atomic =3D !!(iph->frag_off & htons(IP_DF));
>         NAPI_GRO_CB(skb)->flush |=3D flush;
> -       skb_set_network_header(skb, off);
> +       if (NAPI_GRO_CB(skb)->encap_mark)
> +               skb_set_inner_network_header(skb, off);
> +
>         /* The above will be needed by the transport layer if there is on=
e
>          * immediately following this IP hdr.
>          */
> @@ -1643,10 +1645,8 @@ int inet_gro_complete(struct sk_buff *skb, int nho=
ff)
>         int proto =3D iph->protocol;
>         int err =3D -ENOSYS;
>
> -       if (skb->encapsulation) {
> +       if (skb->encapsulation)
>                 skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IP));
> -               skb_set_inner_network_header(skb, nhoff);
> -       }
>
>         iph_set_totlen(iph, skb->len - nhoff);
>         csum_replace2(&iph->check, totlen, iph->tot_len);
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 8311c38267b5..8bbcd3f502ac 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -330,7 +330,7 @@ struct sk_buff *tcp4_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>
>  INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int t=
hoff)
>  {
> -       const struct iphdr *iph =3D ip_hdr(skb);
> +       const struct iphdr *iph =3D skb_gro_complete_network_header(skb);
>         struct tcphdr *th =3D tcp_hdr(skb);
>
>         th->check =3D ~tcp_v4_check(skb->len - thoff, iph->saddr,
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 6c95d28d0c4a..7f59cede67f5 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -709,7 +709,7 @@ EXPORT_SYMBOL(udp_gro_complete);
>
>  INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int n=
hoff)
>  {
> -       const struct iphdr *iph =3D ip_hdr(skb);
> +       const struct iphdr *iph =3D skb_gro_complete_network_header(skb);
>         struct udphdr *uh =3D (struct udphdr *)(skb->data + nhoff);
>
>         /* do fraglist only if there is no outer UDP encap (or we already=
 processed it) */
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index cca64c7809be..db7e3db587b9 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, i=
nt off, int proto)
>                 off +=3D len;
>         }
>
> -       skb_gro_pull(skb, off - skb_network_offset(skb));
> +       skb_gro_pull(skb, off - skb_gro_network_offset(skb));
>         return proto;
>  }
>
> @@ -236,7 +236,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_rece=
ive(struct list_head *head,
>         if (unlikely(!iph))
>                 goto out;
>
> -       skb_set_network_header(skb, off);
> +       if (NAPI_GRO_CB(skb)->encap_mark)
> +               skb_set_inner_network_header(skb, off);
>
>         flush +=3D ntohs(iph->payload_len) !=3D skb->len - hlen;
>
> @@ -259,7 +260,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_rece=
ive(struct list_head *head,
>         NAPI_GRO_CB(skb)->proto =3D proto;
>
>         flush--;
> -       nlen =3D skb_network_header_len(skb);
> +       nlen =3D skb_gro_offset(skb) - off;
>
>         list_for_each_entry(p, head, list) {
>                 const struct ipv6hdr *iph2;
> @@ -353,10 +354,8 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct=
 sk_buff *skb, int nhoff)
>         int err =3D -ENOSYS;
>         u32 payload_len;
>
> -       if (skb->encapsulation) {
> +       if (skb->encapsulation)
>                 skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
> -               skb_set_inner_network_header(skb, nhoff);
> -       }
>
>         payload_len =3D skb->len - nhoff - sizeof(*iph);
>         if (unlikely(payload_len > IPV6_MAXPLEN)) {
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index bf0c957e4b5e..79eeaced2834 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -29,7 +29,7 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head=
, struct sk_buff *skb)
>
>  INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int t=
hoff)
>  {
> -       const struct ipv6hdr *iph =3D ipv6_hdr(skb);
> +       const struct ipv6hdr *iph =3D skb_gro_complete_network_header(skb=
);
>         struct tcphdr *th =3D tcp_hdr(skb);
>
>         th->check =3D ~tcp_v6_check(skb->len - thoff, &iph->saddr,
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index 6b95ba241ebe..897caa2e39fb 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -164,7 +164,7 @@ struct sk_buff *udp6_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>
>  INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int n=
hoff)
>  {
> -       const struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
> +       const struct ipv6hdr *ipv6h =3D skb_gro_complete_network_header(s=
kb);
>         struct udphdr *uh =3D (struct udphdr *)(skb->data + nhoff);

My intuition is that this patch has a high cost for normal GRO processing.
SW-GRO is already a bottleneck on ARM cores in smart NICS.

I would suggest instead using parameters to give both the nhoff and thoff v=
alues
this would avoid many conditionals in the fast path.

->

INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int
nhoff, int thoff)
{
 const struct ipv6hdr *ipv6h =3D (const struct ipv6hdr *)(skb->data + nhoff=
);
 struct udphdr *uh =3D (struct udphdr *)(skb->data + thoff);
..
}

INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int
nhoff, int thoff)
{
       const struct ipv6hdr *iph =3D  (const struct ipv6hdr *)(skb->data + =
nhoff);
       struct tcphdr *th =3D (struct tcphdr *)(skb->data + thoff);

Why storing in skb fields things that really could be propagated more
efficiently as function parameters ?

