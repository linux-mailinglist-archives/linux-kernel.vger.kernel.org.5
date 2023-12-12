Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796E080ECB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376502AbjLLNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266BCA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702386122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pwd7BiRfpK47/Io5shbJP3Cy3f59uwOes8Wr8Lvrva8=;
        b=Ur5xyQJz2Iu56LGK2+aTXleWINn+c4/hbq3togwQwk/qgsRAB0GaNRsdEW9oCrXIrkZoWy
        NBA9kSPmywI/KWLUHd8NVt055uSwVhnEVy2LuD8SYFdaDslD3OMhDCkyWeDOh1EqDB4eZj
        Qg7mUiN4o3ijFB+oSpv3BN5ghIeVPqM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-nmjrnaQANYO7qw0z4h8s2Q-1; Tue, 12 Dec 2023 08:02:01 -0500
X-MC-Unique: nmjrnaQANYO7qw0z4h8s2Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1ef5c7f80cso53422166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386120; x=1702990920;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pwd7BiRfpK47/Io5shbJP3Cy3f59uwOes8Wr8Lvrva8=;
        b=sc/EO0phs3UySmENL7g0NNSj9E/yIl8rouFudbRwSUDxTBsHczhTevAoPDxx8ibdA2
         QrS+fAoIEunnzYdwFo21SWZUB3EGk2v3zt6+xxYPvAyMsDPKkDXxmMVMd8zOvPhVJiBL
         c33QAZ620yu3a+sct7SUWWk2dGhBkSfvrzQg+qXijwNWKOITWGZ4cNX7JYqQttfCVaNj
         xCSI7fBTASKnVCsNMW/2BuykhYpA9JF9hqo9r9w7IHc5CMKIKnGFlSFgiRKipV0DjYlk
         8NcdFU6u5jf/5KHM0tZVbUZ8ZAKqIK0/8WqopeaBJNW3wBI3Ltq8nzLvb9/FgBhszPf5
         +LEA==
X-Gm-Message-State: AOJu0Yy7odHFMCU2cmSl+C9u9IrqZZM4SEvU7hIKk7+WhiXGn5+NJhzc
        6VBe5oe+ULiq0tX/++ek0qhC+NWmFOBZPtp0bpYCU/6c9BH8D67peyiK7m9FjTSqz01HCBYta/9
        +knl2YsrDlbk54Yi/8F4o0em0
X-Received: by 2002:a17:907:a709:b0:a1c:7661:d603 with SMTP id vw9-20020a170907a70900b00a1c7661d603mr6928834ejc.4.1702386120053;
        Tue, 12 Dec 2023 05:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5g83w7evg33Vd8C9GAyYeKqss93O2Ukh1y4L6a6ULzDrQV3DT3RWcXn3D5W2sAt4VilmHVA==
X-Received: by 2002:a17:907:a709:b0:a1c:7661:d603 with SMTP id vw9-20020a170907a70900b00a1c7661d603mr6928809ejc.4.1702386119682;
        Tue, 12 Dec 2023 05:01:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id sl9-20020a170906618900b00a1cf7b31e9csm6170122ejc.89.2023.12.12.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:01:59 -0800 (PST)
Message-ID: <94d394d2833754a0a3f7d2cb8c595f44a2b23e43.camel@redhat.com>
Subject: Re: [PATCH net-next v4 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
From:   Paolo Abeni <pabeni@redhat.com>
To:     Siddh Raman Pant <code@siddh.me>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Date:   Tue, 12 Dec 2023 14:01:57 +0100
In-Reply-To: <4233248c0ca219693c6e6476aa6e59c799241ac8.1702118242.git.code@siddh.me>
References: <cover.1702118242.git.code@siddh.me>
         <4233248c0ca219693c6e6476aa6e59c799241ac8.1702118242.git.code@siddh.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-12-09 at 16:34 +0530, Siddh Raman Pant wrote:
> llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame() which in turn calls
> nfc_alloc_send_skb(), which accesses the nfc_dev from the llcp_sock for
> getting the headroom and tailroom needed for skb allocation.
>=20
> Parallelly the nfc_dev can be freed, as the refcount is decreased via
> nfc_free_device(), leading to a UAF reported by Syzkaller, which can
> be summarized as follows:
>=20
> (1) llcp_sock_sendmsg() -> nfc_llcp_send_ui_frame()
> 	-> nfc_alloc_send_skb() -> Dereference *nfc_dev
> (2) virtual_ncidev_close() -> nci_free_device() -> nfc_free_device()
> 	-> put_device() -> nfc_release() -> Free *nfc_dev
>=20
> When a reference to llcp_local is acquired, we do not acquire the same
> for the nfc_dev. This leads to freeing even when the llcp_local is in
> use, and this is the case with the UAF described above too.
>=20
> Thus, when we acquire a reference to llcp_local, we should acquire a
> reference to nfc_dev, and release the references appropriately later.
>=20
> References for llcp_local is initialized in nfc_llcp_register_device()
> (which is called by nfc_register_device()). Thus, we should acquire a
> reference to nfc_dev there.
>=20
> nfc_unregister_device() calls nfc_llcp_unregister_device() which in
> turn calls nfc_llcp_local_put(). Thus, the reference to nfc_dev is
> appropriately released later.
>=20
> Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbbe84a4010eeea00982d
> Fixes: c7aa12252f51 ("NFC: Take a reference on the LLCP local pointer whe=
n creating a socket")
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> Reviewed-by: Suman Ghosh <sumang@marvell.com>
> ---
>  net/nfc/llcp_core.c | 55 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>=20
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 1dac28136e6a..0ae89ab42aaa 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -145,6 +145,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_=
local *local, bool device,
> =20
>  static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *=
local)
>  {
> +	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
> +	 * we hold a reference to local, we also need to hold a reference to
> +	 * the device to avoid UAF.
> +	 */
> +	if (!nfc_get_device(local->dev->idx))
> +		return NULL;
> +
>  	kref_get(&local->ref);
> =20
>  	return local;
> @@ -177,10 +184,18 @@ static void local_release(struct kref *ref)
> =20
>  int nfc_llcp_local_put(struct nfc_llcp_local *local)
>  {
> +	struct nfc_dev *dev;
> +	int ret;
> +
>  	if (local =3D=3D NULL)
>  		return 0;
> =20
> -	return kref_put(&local->ref, local_release);
> +	dev =3D local->dev;
> +
> +	ret =3D kref_put(&local->ref, local_release);
> +	nfc_put_device(dev);
> +
> +	return ret;
>  }
> =20
>  static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *lo=
cal,
> @@ -930,9 +945,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_loc=
al *local,
> =20
>  	if (sk_acceptq_is_full(parent)) {
>  		reason =3D LLCP_DM_REJ;

'reason' is set to 'LLCP_DM_REJ' every time you jump to the
'fail_put_sock' or 'fail_free_new_sock' labels, you can as well move
the assignment after 'fail_put_sock:'

Cheers,

Paolo

