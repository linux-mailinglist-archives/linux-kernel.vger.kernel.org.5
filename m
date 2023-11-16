Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5A7EDDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjKPJqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344978AbjKPJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE53187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700127995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GruoM/5/32+k91gDkX5IlRzhNe9lOGFcfel6ZoBid20=;
        b=hFrwg86SQuS4knRIeOwLid/MJV3SBJHCp0Vt1cLPTsH5cJyrFcnJarxh5xUyS099xwTN7e
        VIJsT72C4HKnPeXhWUQNEHgWyK3MvoVOasiBpJ28q9owKybYwN++NVi0fVfODOyezGZNSh
        k8htFwXou3M1vxvRYGXaYpHXAL4VHtg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-4sKcQmIKOmWZa3Zb-LbTQQ-1; Thu, 16 Nov 2023 04:46:33 -0500
X-MC-Unique: 4sKcQmIKOmWZa3Zb-LbTQQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5401de6ce9eso99353a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127993; x=1700732793;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GruoM/5/32+k91gDkX5IlRzhNe9lOGFcfel6ZoBid20=;
        b=MC0qoFt8TB/kVSD+khr/0bnF7XmReCjyB3kKi2Iwwha9CsQc4pdEh9qTdm+rw995Uc
         Hm5xMTLinhXWMaoKeHdw4jxvXHAM9vA33AxEhspoxE8TqqSoBC42ZzpeFGtjT4lZZM/L
         EVxGbT1PFdGauKVNTa+30ia+Mr5lctObKt7gnuX8CQvI2FuhdbrP6pfCOOkMbi0/LGtr
         4VMsWX08GPrA459LmbmgysTCacmvx6u5uuFVDmQ6TjfIhA5m3WeyyyVkd8NCHZrT4zkF
         6o3OX8TQRQZNq0rRRLK3xdkxiMDcrnBVFfkwPMjBWs1ZpjBAjiBk3z2m6v97150KLNta
         SZIA==
X-Gm-Message-State: AOJu0YxYHzcKuCn9drO6XU3h/JN4h1qNXZKW77SfInp0JfTl01/tVQnE
        sA72uIxXG/N5T9fTbozp3kbi04Bj5jbqGIMRL/R/RnjVzJEw0MR/b+r22KreV9KueERkIwy5f4b
        C9qXgbI1IMxJpjskT9KppSKMA
X-Received: by 2002:a05:6402:5518:b0:548:15e1:3b26 with SMTP id fi24-20020a056402551800b0054815e13b26mr456424edb.3.1700127992893;
        Thu, 16 Nov 2023 01:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6FMEPXWLzaTbwCpFj/1CLV+LAdXnP2IviLRo7oPmaJQCqz4fjhooDueXV1KR2Y44bOlBZPA==
X-Received: by 2002:a05:6402:5518:b0:548:15e1:3b26 with SMTP id fi24-20020a056402551800b0054815e13b26mr456412edb.3.1700127992587;
        Thu, 16 Nov 2023 01:46:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-98-67.dyn.eolo.it. [146.241.98.67])
        by smtp.gmail.com with ESMTPSA id v23-20020aa7cd57000000b005402a0c9784sm7495481edw.40.2023.11.16.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:46:32 -0800 (PST)
Message-ID: <59083303fc79497b2658ff15ac3c18b985e270ab.camel@redhat.com>
Subject: Re: [PATCH net] tipc: Remove redundant call to TLV_SPACE()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>, jmaloy@redhat.com,
        ying.xue@windriver.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Nov 2023 10:46:30 +0100
In-Reply-To: <20231114144336.1714364-1-syoshida@redhat.com>
References: <20231114144336.1714364-1-syoshida@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2023-11-14 at 23:43 +0900, Shigeru Yoshida wrote:
> The purpose of TLV_SPACE() is to add the TLV descriptor size to the size =
of
> the TLV value passed as argument and align the resulting size to
> TLV_ALIGNTO.
>=20
> tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
> tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
> call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
> redundancy.
>=20
> Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

The patch LGTM, but I think this is more a cleanup then a fix, please
re-submit it for net-next, dropping the Fixes tag (so it will not land
in stable tree).

With the above you can add:

Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/tipc/netlink_compat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
> index 5bc076f2fa74..db0365c9b8bd 100644
> --- a/net/tipc/netlink_compat.c
> +++ b/net/tipc/netlink_compat.c
> @@ -167,7 +167,7 @@ static struct sk_buff *tipc_get_err_tlv(char *str)
>  	int str_len =3D strlen(str) + 1;
>  	struct sk_buff *buf;
> =20
> -	buf =3D tipc_tlv_alloc(TLV_SPACE(str_len));
> +	buf =3D tipc_tlv_alloc(str_len);
>  	if (buf)
>  		tipc_add_tlv(buf, TIPC_TLV_ERROR_STRING, str, str_len);
> =20

