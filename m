Return-Path: <linux-kernel+bounces-77466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB568605B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5852863B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6A17C66;
	Thu, 22 Feb 2024 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALccgJyS"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0C3210;
	Thu, 22 Feb 2024 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641076; cv=none; b=r/69RkuQagThRvou86bkBlQxVdfp+ux0aS31hHhg+ASktLCmSkIr21Bv5zi/Ips9q893T1BdBE6Nl1vY7a0hwDZPFfztusspUkkAzRIrbVpjatw124FwD4gw4jA9P2NHezzCbhtEhKFjU9g40yX6HuuRa9GLnZKAog4B6wfvM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641076; c=relaxed/simple;
	bh=jfEAu4u+DYkHDDPZ8LKbEu+DqNm0bzS7n/+/kqA4rhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNJ9TB/LscyhVQLCycoeM7tapZmjrASztQ9yqNw0i8lI/hgK3KM2TrknNp04wTSIxSlaXyWzL9yzGrmZ+bedngbq7PwGf9bA4J2rTkrCxdgHgkgmfUH7xxkARilBBNKNHEQ0TyKhm1QAVxsZBU308Bf7U2DbkjwWxIv0mPFxk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALccgJyS; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso108433241.0;
        Thu, 22 Feb 2024 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708641074; x=1709245874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab/IT6/MTQMwvIdmwcFZA4zrjfI72quSWHH2rUYlwu8=;
        b=ALccgJySIsqj67q6Yu+Lni2fL+WgazScqpa34goul4qVHbKu2YvPmvXBF4nEUGSrqv
         CFa+dkJyXf/GjWIZdXHb/i/ixuWoRfbGB8N1Q0WRhxL3ctYiaz9wo7ThTv+6pO7xKPD+
         0omW3SFwPA3hpwLTbWxLCE5yMW/7+B8h18rbsuYCEQtRvSp0A12KX3FaLOEuisLRtk9h
         ndhijdXoq3uAQOxnFGGvucw1cHp/272IkzPX0FNgMnv1EKeV7pZqcA9ucMETx6uWxeqF
         2ZwgfIDBIo6y9HWYkvngRrsFIRFGT/QyQKfK7YmxhTla1tyH6nZZHJt5Ys8ClXKTa0SJ
         /gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708641074; x=1709245874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab/IT6/MTQMwvIdmwcFZA4zrjfI72quSWHH2rUYlwu8=;
        b=MLQ7j0H4poZjQAO3lh3LhFnO4Hzt5K1TBW646htcPoduytmQ/bNlsGqsFq+ABxHCQl
         iPiPl+brPGl/C9BJ28he8ulGkSjb1mbVBtwmDxUvhn1TiGItwRkk0jIOhApt3IW4SACO
         TW+5LiooF6jSy6O6FLhQHMhA9zyjjw0xvGR58IK7cRvGuNovsJb6HrwLYoUHPhLTLntX
         PiQzb6Q/w4GXcpZlpygwOYyp8O0MiOtnyhNdUEAi5WL6ruQP8DdtEiRt9l5vpyOVY3c/
         Z7M63HsTa6uKyhUsq2is0EWkctuqKbYCeRVRlorJE0445G2gj/beZ6bHBxnHEOYMXmDl
         VErA==
X-Forwarded-Encrypted: i=1; AJvYcCW/NTwesQ2KY3TNB3VN4iHE9S13ax1/N/lwcJE0kmC2H7BL8jsty2UdP3ShQuxM6Ge+TXwpJJnEs4BIDTmPKVef3X5+B+i7pfmoebCNbBMMM/MCSUFJY+DTwjUvlUhQmNFB/ztx
X-Gm-Message-State: AOJu0YxMnMtEdyD5YWqXttDYP83nVnTo3T0VCXi2T2mMr8Ffo24n0OkT
	h5KzuJmKiB0k018kWBDK0uaJqp+bE0OlxN+xHFFRjnRZrkyROU6ld4/i6MjvM8D+2Q05HS5y/w7
	XRVzgUq2ECGRgRG94+lYsjGbDsLg=
X-Google-Smtp-Source: AGHT+IHxX4rGwPtr7rcccr5jt3glXidlbiYp/cZzSmtq7u0kH7YbVS5kUwMj83xG2QcuxiOwqjCkQ4vP3SmIulJD6SY=
X-Received: by 2002:a67:fd43:0:b0:470:51ac:89a4 with SMTP id
 g3-20020a67fd43000000b0047051ac89a4mr244735vsr.34.1708641073362; Thu, 22 Feb
 2024 14:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com> <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>
In-Reply-To: <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 22 Feb 2024 14:31:02 -0800
Message-ID: <CAHsH6GvX7zYSoA7JVemRtunWWSaew1S11Y996WAGt6B9d8=cOA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: geneve: enable local address bind for
 geneve sockets
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org, amcohen@nvidia.com, 
	petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com, bpoirier@nvidia.com, 
	gavinl@nvidia.com, martin.lau@kernel.org, daniel@iogearbox.net, 
	herbert@gondor.apana.org.au, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 22, 2024 at 12:54=E2=80=AFPM Richard Gobert
<richardbgobert@gmail.com> wrote:
>
> This patch adds support for binding to a local address in geneve sockets.

Thanks for adding this.

> It achieves this by adding a geneve_addr union to represent local address
> to bind to, and copying it to udp_port_cfg in geneve_create_sock.

AFICT in geneve_sock_add(), geneve_socket_create() is only called if there'=
s
no existing open socket with the GENEVE destination port. As such, wouldn't
this bind work only for the first socket in the namespace?

If that is the case, then perhaps binding the socket isn't the right
approach, and instead geneve_lookup() should search for the tunnel based on
both the source and destination IPs.

Am I missing something?

Eyal.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  drivers/net/geneve.c               | 58 +++++++++++++++++++++++++++---
>  include/net/geneve.h               |  6 ++++
>  include/uapi/linux/if_link.h       |  2 ++
>  tools/include/uapi/linux/if_link.h |  2 ++
>  4 files changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 32c51c244153..d0b4cb0e7c51 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -57,6 +57,7 @@ struct geneve_config {
>         bool                    ttl_inherit;
>         enum ifla_geneve_df     df;
>         bool                    inner_proto_inherit;
> +       union geneve_addr saddr;
>  };
>
>  /* Pseudo network device */
> @@ -451,7 +452,8 @@ static int geneve_udp_encap_err_lookup(struct sock *s=
k, struct sk_buff *skb)
>  }
>
>  static struct socket *geneve_create_sock(struct net *net, bool ipv6,
> -                                        __be16 port, bool ipv6_rx_csum)
> +                                        __be16 port, bool ipv6_rx_csum,
> +                                        union geneve_addr *local_addr)
>  {
>         struct socket *sock;
>         struct udp_port_cfg udp_conf;
> @@ -463,9 +465,15 @@ static struct socket *geneve_create_sock(struct net =
*net, bool ipv6,
>                 udp_conf.family =3D AF_INET6;
>                 udp_conf.ipv6_v6only =3D 1;
>                 udp_conf.use_udp6_rx_checksums =3D ipv6_rx_csum;
> +               memcpy(&udp_conf.local_ip6,
> +                      &local_addr->sin6.sin6_addr,
> +                      sizeof(local_addr->sin6.sin6_addr));
>         } else {
>                 udp_conf.family =3D AF_INET;
>                 udp_conf.local_ip.s_addr =3D htonl(INADDR_ANY);
> +               memcpy(&udp_conf.local_ip,
> +                      &local_addr->sin.sin_addr,
> +                      sizeof(local_addr->sin.sin_addr));
>         }
>
>         udp_conf.local_udp_port =3D port;
> @@ -572,7 +580,8 @@ static int geneve_gro_complete(struct sock *sk, struc=
t sk_buff *skb,
>
>  /* Create new listen socket if needed */
>  static struct geneve_sock *geneve_socket_create(struct net *net, __be16 =
port,
> -                                               bool ipv6, bool ipv6_rx_c=
sum)
> +                                               bool ipv6, bool ipv6_rx_c=
sum,
> +                                               union geneve_addr *local_=
addr)
>  {
>         struct geneve_net *gn =3D net_generic(net, geneve_net_id);
>         struct geneve_sock *gs;
> @@ -584,7 +593,7 @@ static struct geneve_sock *geneve_socket_create(struc=
t net *net, __be16 port,
>         if (!gs)
>                 return ERR_PTR(-ENOMEM);
>
> -       sock =3D geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
> +       sock =3D geneve_create_sock(net, ipv6, port, ipv6_rx_csum, local_=
addr);
>         if (IS_ERR(sock)) {
>                 kfree(gs);
>                 return ERR_CAST(sock);
> @@ -672,7 +681,8 @@ static int geneve_sock_add(struct geneve_dev *geneve,=
 bool ipv6)
>         }
>
>         gs =3D geneve_socket_create(net, geneve->cfg.info.key.tp_dst, ipv=
6,
> -                                 geneve->cfg.use_udp6_rx_checksums);
> +                                 geneve->cfg.use_udp6_rx_checksums,
> +                                 &geneve->cfg.saddr);
>         if (IS_ERR(gs))
>                 return PTR_ERR(gs);
>
> @@ -1203,7 +1213,7 @@ static void geneve_setup(struct net_device *dev)
>  }
>
>  static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] =3D {
> -       [IFLA_GENEVE_UNSPEC]            =3D { .strict_start_type =3D IFLA=
_GENEVE_INNER_PROTO_INHERIT },
> +       [IFLA_GENEVE_UNSPEC]            =3D { .strict_start_type =3D IFLA=
_GENEVE_LOCAL6 },
>         [IFLA_GENEVE_ID]                =3D { .type =3D NLA_U32 },
>         [IFLA_GENEVE_REMOTE]            =3D { .len =3D sizeof_field(struc=
t iphdr, daddr) },
>         [IFLA_GENEVE_REMOTE6]           =3D { .len =3D sizeof(struct in6_=
addr) },
> @@ -1218,6 +1228,8 @@ static const struct nla_policy geneve_policy[IFLA_G=
ENEVE_MAX + 1] =3D {
>         [IFLA_GENEVE_TTL_INHERIT]       =3D { .type =3D NLA_U8 },
>         [IFLA_GENEVE_DF]                =3D { .type =3D NLA_U8 },
>         [IFLA_GENEVE_INNER_PROTO_INHERIT]       =3D { .type =3D NLA_FLAG =
},
> +       [IFLA_GENEVE_LOCAL]     =3D { .len =3D sizeof_field(struct iphdr,=
 saddr) },
> +       [IFLA_GENEVE_LOCAL6]    =3D { .len =3D sizeof(struct in6_addr) },
>  };
>
>  static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -1544,6 +1556,31 @@ static int geneve_nl2info(struct nlattr *tb[], str=
uct nlattr *data[],
>                 cfg->inner_proto_inherit =3D true;
>         }
>
> +       if (data[IFLA_GENEVE_LOCAL]) {
> +               if (changelink && cfg->saddr.sa.sa_family !=3D AF_INET) {
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL]=
, "New local address family does not match old");
> +                       return -EOPNOTSUPP;
> +               }
> +
> +               cfg->saddr.sin.sin_addr.s_addr =3D nla_get_in_addr(data[I=
FLA_GENEVE_LOCAL]);
> +               cfg->saddr.sa.sa_family =3D AF_INET;
> +       }
> +
> +       if (data[IFLA_GENEVE_LOCAL6]) {
> +               if (!IS_ENABLED(CONFIG_IPV6)) {
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6=
], "IPv6 support not enabled in the kernel");
> +                       return -EPFNOSUPPORT;
> +               }
> +
> +               if (changelink && cfg->saddr.sa.sa_family !=3D AF_INET6) =
{
> +                       NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6=
], "New local address family does not match old");
> +                       return -EOPNOTSUPP;
> +               }
> +
> +               cfg->saddr.sin6.sin6_addr =3D nla_get_in6_addr(data[IFLA_=
VXLAN_LOCAL6]);
> +               cfg->saddr.sa.sa_family =3D AF_INET6;
> +       }
> +
>         return 0;
>  change_notsup:
>         NL_SET_ERR_MSG_ATTR(extack, data[attrtype],
> @@ -1724,6 +1761,7 @@ static size_t geneve_get_size(const struct net_devi=
ce *dev)
>                 nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_UDP_ZERO_CS=
UM6_RX */
>                 nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_TTL_INHERIT=
 */
>                 nla_total_size(0) +      /* IFLA_GENEVE_INNER_PROTO_INHER=
IT */
> +               nla_total_size(sizeof(struct in6_addr)) + /* IFLA_GENEVE_=
LOCAL{6} */
>                 0;
>  }
>
> @@ -1745,6 +1783,11 @@ static int geneve_fill_info(struct sk_buff *skb, c=
onst struct net_device *dev)
>                 if (nla_put_in_addr(skb, IFLA_GENEVE_REMOTE,
>                                     info->key.u.ipv4.dst))
>                         goto nla_put_failure;
> +
> +               if (nla_put_in_addr(skb, IFLA_GENEVE_LOCAL,
> +                                   info->key.u.ipv4.src))
> +                       goto nla_put_failure;
> +
>                 if (nla_put_u8(skb, IFLA_GENEVE_UDP_CSUM,
>                                !!(info->key.tun_flags & TUNNEL_CSUM)))
>                         goto nla_put_failure;
> @@ -1754,6 +1797,11 @@ static int geneve_fill_info(struct sk_buff *skb, c=
onst struct net_device *dev)
>                 if (nla_put_in6_addr(skb, IFLA_GENEVE_REMOTE6,
>                                      &info->key.u.ipv6.dst))
>                         goto nla_put_failure;
> +
> +               if (nla_put_in6_addr(skb, IFLA_GENEVE_LOCAL6,
> +                                    &info->key.u.ipv6.src))
> +                       goto nla_put_failure;
> +
>                 if (nla_put_u8(skb, IFLA_GENEVE_UDP_ZERO_CSUM6_TX,
>                                !(info->key.tun_flags & TUNNEL_CSUM)))
>                         goto nla_put_failure;
> diff --git a/include/net/geneve.h b/include/net/geneve.h
> index 5c96827a487e..8dcd7fff2c0f 100644
> --- a/include/net/geneve.h
> +++ b/include/net/geneve.h
> @@ -68,6 +68,12 @@ static inline bool netif_is_geneve(const struct net_de=
vice *dev)
>                !strcmp(dev->rtnl_link_ops->kind, "geneve");
>  }
>
> +union geneve_addr {
> +       struct sockaddr_in sin;
> +       struct sockaddr_in6 sin6;
> +       struct sockaddr sa;
> +};
> +
>  #ifdef CONFIG_INET
>  struct net_device *geneve_dev_create_fb(struct net *net, const char *nam=
e,
>                                         u8 name_assign_type, u16 dst_port=
);
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index ab9bcff96e4d..e4a0cdea734b 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1419,6 +1419,8 @@ enum {
>         IFLA_GENEVE_TTL_INHERIT,
>         IFLA_GENEVE_DF,
>         IFLA_GENEVE_INNER_PROTO_INHERIT,
> +       IFLA_GENEVE_LOCAL,
> +       IFLA_GENEVE_LOCAL6,
>         __IFLA_GENEVE_MAX
>  };
>  #define IFLA_GENEVE_MAX        (__IFLA_GENEVE_MAX - 1)
> diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linu=
x/if_link.h
> index a0aa05a28cf2..438bd867ec38 100644
> --- a/tools/include/uapi/linux/if_link.h
> +++ b/tools/include/uapi/linux/if_link.h
> @@ -888,6 +888,8 @@ enum {
>         IFLA_GENEVE_TTL_INHERIT,
>         IFLA_GENEVE_DF,
>         IFLA_GENEVE_INNER_PROTO_INHERIT,
> +       IFLA_GENEVE_LOCAL,
> +       IFLA_GENEVE_LOCAL6,
>         __IFLA_GENEVE_MAX
>  };
>  #define IFLA_GENEVE_MAX        (__IFLA_GENEVE_MAX - 1)
> --
> 2.36.1
>

