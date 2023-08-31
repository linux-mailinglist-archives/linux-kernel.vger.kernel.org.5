Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFF578EFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbjHaPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHaPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C9319A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693494055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vgwa1dB9SPLXrOuebcpc/xedsvZ9jq5rbgcVN4pe9yQ=;
        b=PlZo130GRPz4BlJtUoeXaBxANh6YnYyyHcqSRKL5zbr+lTeKBuF3WfyIGHvwzasPC0xErn
        Aw2hf4TZvuEtuxclp/S9/zbLYq4eAyWSQ41WuiY+4zh4rTD8eA2/xmcdeXzJCsw/t0zh3s
        VZmavZq/uqUt8HS4AzVOX1yQ7aZ+KaM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-pOK9FwVNPbCkrIp_RrIXXw-1; Thu, 31 Aug 2023 11:00:53 -0400
X-MC-Unique: pOK9FwVNPbCkrIp_RrIXXw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1cf3e6c04so68038166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693494052; x=1694098852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgwa1dB9SPLXrOuebcpc/xedsvZ9jq5rbgcVN4pe9yQ=;
        b=NdWzT1J5BRFqZAaBTmIBo/MBsIPTPp7rQiAx4yt8R3J1TP7GRtz2IGdqFDggPtAQSC
         ZrX/k63hBAxSJSwbx6y4HjohoCL0yPWjz3oOLhnwrQ32c1ReNyNjeTBgWO63bxPIUpeI
         FszL+Kr36nHgoy5tnvMEYtosAK0i/Qjy6bMO86DHZw/axdb4HzPt+eFBMd7JJCIndS4u
         2DIeFCicrvdhMzo5taLUxYaBDgH4MXohlYCK6K8ly+492Dz2w8tt2qUMaE4lhD5N//o7
         Ogn8oDCu0xt3zcO5jpbgaRZ8sbTBvWEAe2V5F+WpvAMTRqrfvlTS0TqdkJwOiyXclV3r
         FoXw==
X-Gm-Message-State: AOJu0Yyjiw/63KIBacIMrIDL2VkMCpN6gpRQsP5ObB1x6oIbivTzSpVb
        IOthlKI9httljctZc5nZ6OJYtLW5QNEdBkYYjn2Gd4EW+bKjtFc9t40uW2if9rAqHWqx0zm0Ozg
        Aj/VfS17ie1voPaeyC789Evpy
X-Received: by 2002:a17:906:5a6f:b0:9a3:c4f4:12dc with SMTP id my47-20020a1709065a6f00b009a3c4f412dcmr4524813ejc.7.1693494052174;
        Thu, 31 Aug 2023 08:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEItJP1c9NKLWMSDU2Fjxe2iKrYoxUCLRWz4/6JWjMqNieHJ8iRQusTIkf8kXERSXMOfiazaw==
X-Received: by 2002:a17:906:5a6f:b0:9a3:c4f4:12dc with SMTP id my47-20020a1709065a6f00b009a3c4f412dcmr4524784ejc.7.1693494051830;
        Thu, 31 Aug 2023 08:00:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id rs10-20020a170907036a00b00992b510089asm855137ejb.84.2023.08.31.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:00:51 -0700 (PDT)
Date:   Thu, 31 Aug 2023 17:00:40 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <gqhfmvel7kkglvaco5lnjiggfj57j7ie5erp6vjvfmm5ifwsw5@o2tzqsnvoc7x>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
 <20230826175900.3693844-2-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230826175900.3693844-2-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 08:58:59PM +0300, Arseniy Krasnov wrote:
>POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 020cf17ab7e4..013b65241b65 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			err = total_written;
> 	}
> out:
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = sk_stream_error(sk, msg->msg_flags, err);
>+
> 	release_sock(sk);
> 	return err;
> }
>-- 
>2.25.1
>

