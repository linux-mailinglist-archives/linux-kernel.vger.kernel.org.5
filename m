Return-Path: <linux-kernel+bounces-167480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE88BAA1B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86206B226C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6374714F9D2;
	Fri,  3 May 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeYepBBl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9914EC5E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729436; cv=none; b=HfkUDwGQ6iVEUH+Ce36Idcm9boHoCjBWGZ5j28Na7BZk/I0TUsWJ9q0xfWDPAjtrBqnl6+5YLMjQcKSn4BB8vdZpjLseQH//UBEk9LNVt+bfImgDfTkOcviuigQW4o9CI5rG7FTIBHRYQRGBC+FDchEDmEdyQYcMvT0K530kIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729436; c=relaxed/simple;
	bh=lJxzmuu1bFS3wx/ZflP92QkYs1r6odL4UVFyIzzAV2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaWgyaSC713aua172jY+KLVn9yxFa3h4sbJBLOueIqIW8Ms8NNepM4mu1G0BNTW3VrmP77M6BgXXrxJBcfcVKMF24jstVPECAgIP5t8OGhpd6UaXF3FbHMaDOJy1GbhvuthpLaUi0hrnlNm6czNod/FtB/1tXpGRrBAxPPXUumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeYepBBl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714729433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHNTro5D+vIIe9fiP9wi2QF3PY1y9XG9IVvIqGNQrhk=;
	b=EeYepBBlHErUHQpgZBStQKmvljqrczSfUPQym6KFO+NZFr5GKy/hVWDkOihNeSlRdUfETr
	GrSvXkNjTE44RZVvsV7noYREPCHKoopaxXYJs9oW2EtRw8aNw9G9W9slH4XbjQ0yBnKuTe
	vW4S514Ydt1dTRrJUTx4lv8iZdGCOVc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-gjT6sSffNPi_4zfKbMsjTQ-1; Fri, 03 May 2024 05:43:51 -0400
X-MC-Unique: gjT6sSffNPi_4zfKbMsjTQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5986a5bc1dso40814866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729430; x=1715334230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHNTro5D+vIIe9fiP9wi2QF3PY1y9XG9IVvIqGNQrhk=;
        b=dussGRidRxktQNl0PyTaNhS30ClqYdbePorlWBXRVeq9DtD8eWmVld2x3zYM8XHwof
         ZpzeqFB0Ew+eYaPbYjWs/0jOx1hWp6PUZt0TtQw9NKcgeADV9T3UtdwsYLUNSp4+9nsS
         4VgwBfUeD/wBSFfb7eCvjjNbApTnA/BRJQ47rh4sBOaiA9iVME4LHbu1kq66E0iFmrkT
         5z2eind9rF4XbQ6ON5+ax9vNsyRNQvAJVtH5T3tljLpvKMJ9IX3crudkKfAaADXbpUXC
         LDaUEMNTIeLiG6Qoa4wLXTOH/LkSM9hEdpSH88Re/rEAPuj7eY5mAWNZBolsul/oG/vy
         7gvw==
X-Forwarded-Encrypted: i=1; AJvYcCWIo71B9u5EDBhyiClQ9kydL1ZpcruY513uxoYU5TQXUaP9oELPDfp61gomuRehsycszzdZ4sccHxpgBBui1ujQResNOBcL94hgMjk3
X-Gm-Message-State: AOJu0YymZtF1hFw0QxcXDPWmZzUNdJIvbl9xDxu9LvL2g5Zx3pQhAwv7
	C3zHWHzK2HABg33Wyhd3YNhu7+yBn6PfFEVDCtXDwpy5GGGU8NwxsTZrGHEgZck6gO5rAwAAlFg
	6DUf7bFoF5UujBjntRhLlI7FF76NcPbscfUguiPGe6MX47GEt2ar9aO+2YtIWbw==
X-Received: by 2002:a17:906:4aca:b0:a59:574d:8c5c with SMTP id u10-20020a1709064aca00b00a59574d8c5cmr1148956ejt.64.1714729430107;
        Fri, 03 May 2024 02:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEM9nZgzXgbemyPxcEFcTytqP/l3dvnuKmL4zLeLwxhfi7PGVoadPM1uBAXUD3zjQW7L9Z8Q==
X-Received: by 2002:a17:906:4aca:b0:a59:574d:8c5c with SMTP id u10-20020a1709064aca00b00a59574d8c5cmr1148935ejt.64.1714729429471;
        Fri, 03 May 2024 02:43:49 -0700 (PDT)
Received: from [172.16.2.75] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id jy3-20020a170907762300b00a597cd2731bsm1001297ejc.80.2024.05.03.02.43.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2024 02:43:48 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
 Donald Hunter <donald.hunter@gmail.com>, linux-kernel@vger.kernel.org,
 dev@openvswitch.org
Subject: Re: [PATCH net-next 6/8] net:openvswitch: add psample support
Date: Fri, 03 May 2024 11:43:48 +0200
X-Mailer: MailMate (1.14r6029)
Message-ID: <72F692D6-621D-4E02-AAE2-AC63CC99FEBE@redhat.com>
In-Reply-To: <20240424135109.3524355-7-amorenoz@redhat.com>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-7-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 24 Apr 2024, at 15:50, Adrian Moreno wrote:

> Add support for psample sampling via two new attributes to the
> OVS_ACTION_ATTR_SAMPLE action.
>
> OVS_SAMPLE_ATTR_PSAMPLE_GROUP used to pass an integer psample group_id.=

> OVS_SAMPLE_ATTR_PSAMPLE_COOKIE used to pass a variable-length binary
> cookie that will be forwared to psample.
>
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
>
> In order to simplify the internal processing of the action and given th=
e
> maximum size of the cookie is relatively small, add both fields to the
> internal-only struct sample_arg.
>
> The presence of a group_id mandates that the action shall called the
> psample module to multicast the packet with such group_id and the
> user-provided cookie if present. This behavior is orthonogal to
> also executing the nested actions if present.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

This is not a full review yet. Just some comments, as I=E2=80=99m looking=
 at the user-space patch first and added similar comments.

I=E2=80=99ll do a proper review of this series once I=E2=80=99m done with=
 user-space part.

//Eelco

> ---
>  Documentation/netlink/specs/ovs_flow.yaml |  6 ++
>  include/uapi/linux/openvswitch.h          | 49 ++++++++++----
>  net/openvswitch/actions.c                 | 51 +++++++++++++--
>  net/openvswitch/flow_netlink.c            | 80 ++++++++++++++++++-----=

>  4 files changed, 153 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/=
netlink/specs/ovs_flow.yaml
> index 4fdfc6b5cae9..5543c2937225 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> @@ -825,6 +825,12 @@ attribute-sets:
>          name: actions
>          type: nest
>          nested-attributes: action-attrs
> +      -
> +        name: psample_group
> +        type: u32
> +      -
> +        name: psample_cookie
> +        type: binary
>    -
>      name: userspace-attrs
>      enum-name: ovs-userspace-attr
> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/open=
vswitch.h
> index efc82c318fa2..e9cd6f3a952d 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -639,6 +639,7 @@ enum ovs_flow_attr {
>  #define OVS_UFID_F_OMIT_MASK     (1 << 1)
>  #define OVS_UFID_F_OMIT_ACTIONS  (1 << 2)
>
> +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
>  /**
>   * enum ovs_sample_attr - Attributes for %OVS_ACTION_ATTR_SAMPLE actio=
n.
>   * @OVS_SAMPLE_ATTR_PROBABILITY: 32-bit fraction of packets to sample =
with
> @@ -646,15 +647,27 @@ enum ovs_flow_attr {
>   * %UINT32_MAX samples all packets and intermediate values sample inte=
rmediate
>   * fractions of packets.
>   * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling eve=
nt.
> - * Actions are passed as nested attributes.
> + * Actions are passed as nested attributes. Optional if
> + * OVS_SAMPLE_ATTR_PSAMPLE_GROUP is set.
> + * @OVS_SAMPLE_ATTR_PSAMPLE_GROUP: A 32-bit number to be used as psamp=
le group.
> + * Optional if OVS_SAMPLE_ATTR_ACTIONS is set.
> + * @OVS_SAMPLE_ATTR_PSAMPLE_COOKIE: A variable-length binary cookie th=
at, if
> + * provided, will be copied to the psample cookie.

As there is a limit of to the cookie should we mention it here?

>   *
> - * Executes the specified actions with the given probability on a per-=
packet
> - * basis.
> + * Either OVS_SAMPLE_ATTR_PSAMPLE_GROUP or OVS_SAMPLE_ATTR_ACTIONS mus=
t be
> + * specified.
> + *
> + * Executes the specified actions and/or sends the packet to psample
> + * with the given probability on a per-packet basis.
>   */
>  enum ovs_sample_attr {
>  	OVS_SAMPLE_ATTR_UNSPEC,
> -	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
> -	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. =
*/
> +	OVS_SAMPLE_ATTR_PROBABILITY,	/* u32 number */
> +	OVS_SAMPLE_ATTR_ACTIONS,	/* Nested OVS_ACTION_ATTR_

Missing * after OVS_ACTION_ATTR_

> +					 * attributes.
> +					 */
> +	OVS_SAMPLE_ATTR_PSAMPLE_GROUP,	/* u32 number */
> +	OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,	/* binary */

As these are general sample options, I would not add the PSAMPLE referenc=
e. Other data paths could use a different implementation. So I guess OVS_=
SAMPLE_ATTR_GROUP_ID and OVS_SAMPLE_ATTR_COOKIE would be enough.

>  	__OVS_SAMPLE_ATTR_MAX,
>
>  #ifdef __KERNEL__
> @@ -665,13 +678,27 @@ enum ovs_sample_attr {
>  #define OVS_SAMPLE_ATTR_MAX (__OVS_SAMPLE_ATTR_MAX - 1)
>
>  #ifdef __KERNEL__
> +
> +/* Definition for flags in struct sample_arg. */
> +enum {
> +	/* When set, actions in sample will not change the flows. */
> +	OVS_SAMPLE_ARG_FLAG_EXEC =3D 1 << 0,
> +	/* When set, the packet will be sent to psample. */
> +	OVS_SAMPLE_ARG_FLAG_PSAMPLE =3D 1 << 1,
> +};
> +
>  struct sample_arg {
> -	bool exec;                   /* When true, actions in sample will not=

> -				      * change flow keys. False otherwise.
> -				      */
> -	u32  probability;            /* Same value as
> -				      * 'OVS_SAMPLE_ATTR_PROBABILITY'.
> -				      */


Not sure if you can actually do this, you are changing a structure that i=
s part of the UAPI. This change breaks backwards compatibility.


> +	u16 flags;		/* Flags that modify the behavior of the
> +				 * action. See SAMPLE_ARG_FLAG_*.
> +				 */
> +	u32  probability;       /* Same value as
> +				 * 'OVS_SAMPLE_ATTR_PROBABILITY'.
> +				 */
> +	u32  group_id;		/* Same value as
> +				 * 'OVS_SAMPLE_ATTR_PSAMPLE_GROUP'.
> +				 */
> +	u8  cookie_len;		/* Length of psample cookie. */
> +	char cookie[OVS_PSAMPLE_COOKIE_MAX_SIZE]; /* psample cookie data. */

Would it make sense for the cookie also to be u8?

>  };
>  #endif
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 6fcd7e2ca81f..eb3166986fd2 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -24,6 +24,7 @@
>  #include <net/checksum.h>
>  #include <net/dsfield.h>
>  #include <net/mpls.h>
> +#include <net/psample.h>
>  #include <net/sctp/checksum.h>
>
>  #include "datapath.h"
> @@ -1025,6 +1026,34 @@ static int dec_ttl_exception_handler(struct data=
path *dp, struct sk_buff *skb,
>  	return 0;
>  }
>
> +static int ovs_psample_packet(struct datapath *dp, struct sw_flow_key =
*key,
> +			      const struct sample_arg *arg,
> +			      struct sk_buff *skb)
> +{
> +	struct psample_group psample_group =3D {};
> +	struct psample_metadata md =3D {};
> +	struct vport *input_vport;
> +	u32 rate;
> +
> +	psample_group.group_num =3D arg->group_id;
> +	psample_group.net =3D ovs_dp_get_net(dp);
> +
> +	input_vport =3D ovs_vport_rcu(dp, key->phy.in_port);
> +	if (!input_vport)
> +		input_vport =3D ovs_vport_rcu(dp, OVSP_LOCAL);
> +
> +	md.in_ifindex =3D input_vport->dev->ifindex;
> +	md.user_cookie =3D arg->cookie_len ? &arg->cookie[0] : NULL;
> +	md.user_cookie_len =3D arg->cookie_len;
> +	md.trunc_size =3D skb->len;
> +
> +	rate =3D arg->probability ? U32_MAX / arg->probability : 0;
> +
> +	psample_sample_packet(&psample_group, skb, rate, &md);

Does this mean now the ovs module, now is dependent on the presence of ps=
ample? I think we should only support sampling to psample if the module e=
xists, else we should return an error. There might be distributions not i=
ncluding psample by default.

> +
> +	return 0;
> +}
> +
>  /* When 'last' is true, sample() should always consume the 'skb'.
>   * Otherwise, sample() should keep 'skb' intact regardless what
>   * actions are executed within sample().
> @@ -1033,11 +1062,12 @@ static int sample(struct datapath *dp, struct s=
k_buff *skb,
>  		  struct sw_flow_key *key, const struct nlattr *attr,
>  		  bool last)
>  {
> -	struct nlattr *actions;
> +	const struct sample_arg *arg;
>  	struct nlattr *sample_arg;
>  	int rem =3D nla_len(attr);
> -	const struct sample_arg *arg;
> +	struct nlattr *actions;
>  	bool clone_flow_key;
> +	int ret;
>
>  	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
>  	sample_arg =3D nla_data(attr);
> @@ -1051,9 +1081,20 @@ static int sample(struct datapath *dp, struct sk=
_buff *skb,
>  		return 0;
>  	}
>
> -	clone_flow_key =3D !arg->exec;
> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
> -			     clone_flow_key);
> +	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
> +		ret =3D ovs_psample_packet(dp, key, arg, skb);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (nla_ok(actions, rem)) {
> +		clone_flow_key =3D !(arg->flags & OVS_SAMPLE_ARG_FLAG_EXEC);
> +		ret =3D clone_execute(dp, skb, key, 0, actions, rem, last,
> +				    clone_flow_key);
> +	} else if (last) {
> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> +	}
> +	return ret;
>  }
>
>  /* When 'last' is true, clone() should always consume the 'skb'.
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netl=
ink.c
> index f224d9bcea5e..1a348d3905fc 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2561,6 +2561,9 @@ static int __ovs_nla_copy_actions(struct net *net=
, const struct nlattr *attr,
>  				  u32 mpls_label_count, bool log,
>  				  u32 depth);
>
> +static int copy_action(const struct nlattr *from,
> +		       struct sw_flow_actions **sfa, bool log);
> +
>  static int validate_and_copy_sample(struct net *net, const struct nlat=
tr *attr,
>  				    const struct sw_flow_key *key,
>  				    struct sw_flow_actions **sfa,
> @@ -2569,10 +2572,10 @@ static int validate_and_copy_sample(struct net =
*net, const struct nlattr *attr,
>  				    u32 depth)
>  {
>  	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
> -	const struct nlattr *probability, *actions;
> +	const struct nlattr *probability, *actions, *group, *cookie;
> +	struct sample_arg arg =3D {};
>  	const struct nlattr *a;
>  	int rem, start, err;
> -	struct sample_arg arg;
>
>  	memset(attrs, 0, sizeof(attrs));
>  	nla_for_each_nested(a, attr, rem) {
> @@ -2589,7 +2592,19 @@ static int validate_and_copy_sample(struct net *=
net, const struct nlattr *attr,
>  		return -EINVAL;
>
>  	actions =3D attrs[OVS_SAMPLE_ATTR_ACTIONS];
> -	if (!actions || (nla_len(actions) && nla_len(actions) < NLA_HDRLEN))
> +	if (actions && (!nla_len(actions) || nla_len(actions) < NLA_HDRLEN))
> +		return -EINVAL;
> +
> +	group =3D attrs[OVS_SAMPLE_ATTR_PSAMPLE_GROUP];
> +	if (group && nla_len(group) !=3D sizeof(u32))
> +		return -EINVAL;
> +
> +	cookie =3D attrs[OVS_SAMPLE_ATTR_PSAMPLE_COOKIE];
> +	if (cookie &&
> +	    (!group || nla_len(cookie) > OVS_PSAMPLE_COOKIE_MAX_SIZE))
> +		return -EINVAL;
> +
> +	if (!group && !actions)
>  		return -EINVAL;
>
>  	/* validation done, copy sample action. */
> @@ -2608,7 +2623,19 @@ static int validate_and_copy_sample(struct net *=
net, const struct nlattr *attr,
>  	 * If the sample is the last action, it can always be excuted
>  	 * rather than deferred.
>  	 */
> -	arg.exec =3D last || !actions_may_change_flow(actions);
> +	if (actions && (last || !actions_may_change_flow(actions)))
> +		arg.flags |=3D OVS_SAMPLE_ARG_FLAG_EXEC;
> +
> +	if (group) {
> +		arg.flags |=3D OVS_SAMPLE_ARG_FLAG_PSAMPLE;
> +		arg.group_id =3D nla_get_u32(group);
> +	}
> +
> +	if (cookie) {
> +		memcpy(&arg.cookie[0], nla_data(cookie), nla_len(cookie));
> +		arg.cookie_len =3D nla_len(cookie);
> +	}
> +
>  	arg.probability =3D nla_get_u32(probability);
>
>  	err =3D ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_ARG, &arg, sizeof(arg=
),
> @@ -2616,12 +2643,13 @@ static int validate_and_copy_sample(struct net =
*net, const struct nlattr *attr,
>  	if (err)
>  		return err;
>
> -	err =3D __ovs_nla_copy_actions(net, actions, key, sfa,
> -				     eth_type, vlan_tci, mpls_label_count, log,
> -				     depth + 1);
> -
> -	if (err)
> -		return err;
> +	if (actions) {
> +		err =3D __ovs_nla_copy_actions(net, actions, key, sfa,
> +					     eth_type, vlan_tci,
> +					     mpls_label_count, log, depth + 1);
> +		if (err)
> +			return err;
> +	}
>
>  	add_nested_action_end(*sfa, start);
>
> @@ -3553,20 +3581,38 @@ static int sample_action_to_attr(const struct n=
lattr *attr,
>  		goto out;
>  	}
>
> -	ac_start =3D nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
> -	if (!ac_start) {
> -		err =3D -EMSGSIZE;
> -		goto out;
> +	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
> +		if (nla_put_u32(skb, OVS_SAMPLE_ATTR_PSAMPLE_GROUP,
> +				arg->group_id)) {
> +			err =3D -EMSGSIZE;
> +			goto out;
> +		}
> +
> +		if (arg->cookie_len &&
> +		    nla_put(skb, OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,
> +			    arg->cookie_len, &arg->cookie[0])) {
> +			err =3D -EMSGSIZE;
> +			goto out;
> +		}
>  	}
>
> -	err =3D ovs_nla_put_actions(actions, rem, skb);
> +	if (nla_ok(actions, rem)) {
> +		ac_start =3D nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
> +		if (!ac_start) {
> +			err =3D -EMSGSIZE;
> +			goto out;
> +		}
> +		err =3D ovs_nla_put_actions(actions, rem, skb);
> +	}
>
>  out:
>  	if (err) {
> -		nla_nest_cancel(skb, ac_start);
> +		if (ac_start)
> +			nla_nest_cancel(skb, ac_start);
>  		nla_nest_cancel(skb, start);
>  	} else {
> -		nla_nest_end(skb, ac_start);
> +		if (ac_start)
> +			nla_nest_end(skb, ac_start);
>  		nla_nest_end(skb, start);
>  	}
>
> -- =

> 2.44.0


