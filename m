Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA2792BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjIEQ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347424AbjIEE2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:28:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F61B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:28:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40a47e8e38dso512021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 21:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693888115; x=1694492915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZSlyVx9HBHTYN+LF72l+YVKKff26y5vuPEjLykpW8c=;
        b=GjPig+f/n0w8S5h1eKNP/2iQgs3E5oE+96oIRBEC4BR8oW+1CXBbnUGmcfJxD0mRnV
         fzadwTHvUGbtmiLLr8TPlcUVFNeergcLVlINuqJBCYDoNwx2ZUisBkCjVHYDfhIZwE7a
         Rp8Y8aC21xgkY7XLfxJCV8NXF9TtEBZl/iZxyQuxTfy3Yl+f4Pdu66aFO6Kpnlq00zOt
         H+nv96vWRUu122UFg7Hykzhle2K52jZe5wtjM+vHXQ2JMBaINNj9Io/2PuuuXuSnRTQD
         MS6FrwwMAqV+aC6n/eMclFLluQQRBAMOd9Yv9tGYzyURfrRvj8fnEo8CGr1omrLX4y9N
         HltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693888115; x=1694492915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZSlyVx9HBHTYN+LF72l+YVKKff26y5vuPEjLykpW8c=;
        b=E5w1Rytn0DqiZV1xgleSnNkWaeqRMSQfexG05PTA+x8+57GVTxdFHZyWy1N6fa1EdK
         FS2QjqbT9A36ZzGGEUc+PBSsHkun1o+mWtvIBpGuJcwoXUKqtIQ9xt/oMpk2AXS3DMpV
         HliZNVGfnEK07ypU5O2ceWqEleoqXsqaWcipm8VcUur6IYN4vpYBSoRNRWVZ6V7W7UdN
         0LBfP8dfzWcvsdQDv023wtUl9PVijV6PXBUuUMj6UjusbQ5UrQdTKYgaXZAmWHJc7lix
         nbc3l3pTRW0gz2fmWOCsIQUcjTLKafgGhnzgS3zW27dIFseJOxHJwqQWZuWAchKqzLwr
         Y4bg==
X-Gm-Message-State: AOJu0YyXe9+XW8Nz9JLt4sueB/MNLDkHdRCy2dMofR1PAQ7ys1qKZzhF
        PTMhG8fX7xWtnR7h+ZGwL86aLMC5DEigJ/xMvV6NHQ==
X-Google-Smtp-Source: AGHT+IGqglOMykbX3m6JgqZb0puLb2cOJfyj0QjBlxrbCVrDrUbAfwK+UAbAW9v4DZKCoawnIDkrhfnSGVYF5mnmTlE=
X-Received: by 2002:a05:622a:1822:b0:403:b6ff:c0b with SMTP id
 t34-20020a05622a182200b00403b6ff0c0bmr326876qtc.6.1693888115327; Mon, 04 Sep
 2023 21:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230904154042.3081190-1-qtian@vmware.com>
In-Reply-To: <20230904154042.3081190-1-qtian@vmware.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 5 Sep 2023 06:28:24 +0200
Message-ID: <CANn89iKpj81ZJSn3ksS_P7EBwRjbbk=TnvOW8YF=ogHo5TXcwQ@mail.gmail.com>
Subject: Re: [PATCH net] net/ipv6: SKB symmetric hash should incorporate
 transport ports
To:     Quan Tian <qtian@vmware.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars Ekman <uablrek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 5:45=E2=80=AFPM Quan Tian <qtian@vmware.com> wrote:
>
> __skb_get_hash_symmetric() was added to compute a symmetric hash over
> the protocol, addresses and transport ports, by commit eb70db875671
> ("packet: Use symmetric hash for PACKET_FANOUT_HASH."). It uses
> flow_keys_dissector_symmetric_keys as the flow_dissector to incorporate
> IPv4 addresses, IPv6 addresses and ports. However, it should not specify
> the flag as FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL, which stops further
> dissection when an IPv6 flow label is encountered, making transport
> ports not being incorporated in such case.
>
> As a consequence, the symmetric hash is based on 5-tuple for IPv4 but
> 3-tuple for IPv6 when flow label is present. It caused a few problems,
> e.g. when nft symhash and openvswitch l4_sym rely on the symmetric hash
> to perform load balancing as different L4 flows between two given IPv6
> addresses would always get the same symmetric hash, leading to uneven
> traffic distribution.
>
> Removing the use of FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL makes sure the
> symmetric hash is based on 5-tuple for both IPv4 and IPv6 consistently.
>
> Reported-by: Lars Ekman <uablrek@gmail.com>
> Closes: https://github.com/antrea-io/antrea/issues/5457
> Signed-off-by: Quan Tian <qtian@vmware.com>
> ---
>  net/core/flow_dissector.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 89d15ceaf9af..b3b3af0e7844 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1831,8 +1831,7 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *=
skb)
>
>         memset(&keys, 0, sizeof(keys));
>         __skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
> -                          &keys, NULL, 0, 0, 0,
> -                          FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
> +                          &keys, NULL, 0, 0, 0, 0);
>
>         return __flow_hash_from_keys(&keys, &hashrnd);
>  }
> --
> 2.42.0
>

Networking patches for net branches must include a Fixes: tag, to help
automation.
(providing the sha1 in the changelog is requesting human investigation
for stable teams,
because a sha1 could be mentioned even if it is not the bug origin)

Fixes: eb70db875671 ("packet: Use symmetric hash for PACKET_FANOUT_HASH.")

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
