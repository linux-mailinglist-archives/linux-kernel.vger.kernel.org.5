Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAA806CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377879AbjLFK6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377892AbjLFK6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:58:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FBAD6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701860317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ws+hgkygHt/vtC7PcuOkC3qv40aLWwHeYDQTmLjEFPw=;
        b=V3W0jyI/70PxABB6rNlwQrF6b+YcAC6ZktzhgWdOh/WIqdF6nL/93r9N0Xfr8CInUmOzQg
        yENse54kKSlLDzdlncDYuycz2Pun4Lg9OndHK4GR+iK5W0C9d1+w4oFTyNkYsXPF2jSJH9
        7LOKvzYRUTSJruIO1oHsYp9X97hgLzI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Mh4sSrIBPuiCyiWLroO2uQ-1; Wed, 06 Dec 2023 05:58:36 -0500
X-MC-Unique: Mh4sSrIBPuiCyiWLroO2uQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5450c83aa5dso881084a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860315; x=1702465115;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ws+hgkygHt/vtC7PcuOkC3qv40aLWwHeYDQTmLjEFPw=;
        b=opu3GGN/jlMtHR3j1P3ESOC4+J4/ZiY+R49vsr+7JUMiR+R9LW5LTjkWrnmZ3mUm8A
         wUWc1ALGzjmlQRIwttIiimxiB/9PCf8BVrvb5nzxWNDcnG8Q7lVQ2SjubIrlyYYaW7lV
         FAA8uV2T+5aBp6N4LrJjSq7J9eqiRXY/j1bu538nNX4bzY7t01gcumx0Gn3WbQUAAQX0
         XNNmx33rewfTj+Naeh/Rwhos+hTGe8STGu5cJ8fgMPyxJu0WYsSG3ItzD7jJawZ8ycGR
         XBKBkQouOAY3v6LTpBu4AZcShjLZ8ofPgs91kUW2Lc4ODiJPXDJNm5X3VIBaUGgZq0EO
         EeLA==
X-Gm-Message-State: AOJu0YydgU8xWz1o4LmZxHNNeHsdxrUeTTTcs27Hp+Z04siiq31v5KxN
        H9CiBF8x4KltyncQm1AY8ff9r25pwjRT8xMaOTMHKviKFDV/8sID5MpxBEdrVQ/XvAyNNWF2MuX
        mY80O583aClPa9KRSBoqB6QwB
X-Received: by 2002:a17:906:57c8:b0:a1a:541c:561b with SMTP id u8-20020a17090657c800b00a1a541c561bmr994481ejr.6.1701860315011;
        Wed, 06 Dec 2023 02:58:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWly6Sn6L5UhvuHcIpOPIEOfYoGl6GmooOAkWFEeTSkRUFQqvojaS4yL0eew8srCAFkMPLSg==
X-Received: by 2002:a17:906:57c8:b0:a1a:541c:561b with SMTP id u8-20020a17090657c800b00a1a541c561bmr994456ejr.6.1701860314628;
        Wed, 06 Dec 2023 02:58:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090629d500b00a1d3b1c311csm1260323eje.164.2023.12.06.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:58:34 -0800 (PST)
Message-ID: <f18fdc337f58317b85acb45a0ac694f9140fc022.camel@redhat.com>
Subject: Re: [net-next PATCH v6 1/2] octeontx2-af: Add new mbox to support
 multicast/mirror offload
From:   Paolo Abeni <pabeni@redhat.com>
To:     Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lcherian@marvell.com, jerinj@marvell.com, horms@kernel.org,
        wojciech.drewek@intel.com
Date:   Wed, 06 Dec 2023 11:58:32 +0100
In-Reply-To: <20231204141956.3956942-2-sumang@marvell.com>
References: <20231204141956.3956942-1-sumang@marvell.com>
         <20231204141956.3956942-2-sumang@marvell.com>
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

On Mon, 2023-12-04 at 19:49 +0530, Suman Ghosh wrote:
> A new mailbox is added to support offloading of multicast/mirror
> functionality. The mailbox also supports dynamic updation of the
> multicast/mirror list.
>=20
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Note that v5 was already applied to net-next. But I still have a
relevant note, see below.

> @@ -5797,3 +6127,337 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(stru=
ct rvu *rvu, struct msg_req *re
> =20
>  	return 0;
>  }
> +
> +static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix=
_mcast_grp *mcast_grp,
> +							      u32 mcast_grp_idx)
> +{
> +	struct nix_mcast_grp_elem *iter;
> +	bool is_found =3D false;
> +
> +	mutex_lock(&mcast_grp->mcast_grp_lock);
> +	list_for_each_entry(iter, &mcast_grp->mcast_grp_head, list) {
> +		if (iter->mcast_grp_idx =3D=3D mcast_grp_idx) {
> +			is_found =3D true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&mcast_grp->mcast_grp_lock);

AFAICS, at this point another thread/CPU could kick-in and run
rvu_mbox_handler_nix_mcast_grp_destroy() up to completion, freeing
'iter' before it's later used by the current thread.

What prevents such scenario?

_If_ every mcast group manipulation happens under the rtnl lock, then
you could as well completely remove the confusing mcast_grp_lock.

Cheers,

Paolo

