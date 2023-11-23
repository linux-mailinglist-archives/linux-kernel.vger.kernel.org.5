Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B577F642D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbjKWQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjKWQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86C61B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700757697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvhyGiocd9S/WTnrqejrqxwkYC77vaP/alpx7EwV9GM=;
        b=CQMKBqY7wT4J0kAZuksI3FdYBJE3ux4zCzZ9wotrWA23ciZQ/F1DJCkMwlq3qiWoVU2QP/
        vTvUuzgMyUH1CvnkEpcUSgew//eqaYedszDzHH8nxGffgOTyL7fxfZxaileU7Y0CKd0BjJ
        Y4GTzmJqyTVl++C2Of22cmn+JHpX3AY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-ZNdKwPc-NrqBcPO7uXOs3Q-1; Thu, 23 Nov 2023 11:41:36 -0500
X-MC-Unique: ZNdKwPc-NrqBcPO7uXOs3Q-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b85151df1fso55286b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757696; x=1701362496;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvhyGiocd9S/WTnrqejrqxwkYC77vaP/alpx7EwV9GM=;
        b=ngLOg27j7hGwAj35M9oEaNd5gICfVihcm2LAplhD0BMPi/WJu47usR7/EW4FAIkyNE
         /etJjYD3ainaydji8JI34XDuO6feY2Qo8UXZe3XuFLZwC8Pb6c1ct0+BSEpRRmpIiyCh
         73BVsZw3NkOhzh2M9QC894JWqXLwpmKKEDPHRHXe9+f7ZGCT9QaJSeVOyCpiwIHgjChe
         iD1lzNFvhMWzMs4SC7UPuwxzWY3RhukDjxNTn6YPpCt5zJcjG7A59YGEV25c8fATDV38
         cYY/Jsti+fN/M/ZnDp97fLODhfOCTObexxiUxfRhVTYY+4OUgIPIOLZ3SryHwrreVSOJ
         peXg==
X-Gm-Message-State: AOJu0Yw8Jt0RbrLNlZwCcws2hYysYY6gKbCXweolmi8tr+r9ftAX+bY+
        B0FPaNoDGupbdED738s/yGqZA/pxxfQNUV7utLaqcrkawsZK/yfceKlyjr4ZdYeQfFYvETFque5
        zPeK7ytHbbRPz2UF4WhhxOi9g
X-Received: by 2002:a05:6871:7a0:b0:1e9:8a7e:5893 with SMTP id o32-20020a05687107a000b001e98a7e5893mr7587427oap.5.1700757695789;
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+04e1Vh52SolmH+Vji6UaC0k0qOLwcDodNnPANnkt/IexnCF9rxr6HrQ6ayqhb8e6Z3MdsQ==
X-Received: by 2002:a05:6871:7a0:b0:1e9:8a7e:5893 with SMTP id o32-20020a05687107a000b001e98a7e5893mr7587413oap.5.1700757695521;
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id o3-20020ac86d03000000b0041abcc69050sm582431qtt.95.2023.11.23.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
Message-ID: <c1f1f869346f4d6fc90eac6d131454b85fa676be.camel@redhat.com>
Subject: Re: [PATCH] mptcp: fix uninit-value in mptcp_incoming_options
From:   Paolo Abeni <pabeni@redhat.com>
To:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martineau@kernel.org,
        matthieu.baerts@tessares.net, matttbe@kernel.org,
        mptcp@lists.linux.dev, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 23 Nov 2023 17:41:31 +0100
In-Reply-To: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
References: <000000000000545a26060abf943b@google.com>
         <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-23 at 09:23 +0800, Edward Adam Davis wrote:
> Added initialization use_ack to mptcp_parse_option().
>=20
> Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/options.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cd15ec73073e..c53914012d01 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>  			mp_opt->suboptions |=3D OPTION_MPTCP_DSS;
>  			mp_opt->use_map =3D 1;
>  			mp_opt->mpc_map =3D 1;
> +			mp_opt->use_ack =3D 0;
>  			mp_opt->data_len =3D get_unaligned_be16(ptr);
>  			ptr +=3D 2;
>  		}

LGTM, and syzbot tested it.

Acked-by: Paolo Abeni <pabeni@redhat.com>

@Edward: for future similar patches, please add also the=C2=A0tested tag
from syzbot, will make tracking easier.

Thanks!

Paolo

