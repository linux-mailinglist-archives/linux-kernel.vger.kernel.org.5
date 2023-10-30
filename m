Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1307DB591
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjJ3JAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3JAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:00:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB13AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:00:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so12002a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698656408; x=1699261208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K4ygboP/GY4APGAOCgABrUsbdlE386siBpiiPBK5b4=;
        b=Al4YIthuHsCebp5zB5/FcVynOQD56NadVL/vZ3hETTpbsM3FYRBRRgszm+2lQC7vdo
         SjcCkwmyLToaFuuhiQm4S5bnxTiNMu06/D7HTGbXH+iiRegqO8TZfuRgxJZ+i9mQPJhn
         f20t03bcmLOBf6tVxjJwDeEpn0VAnVhoJvBWMCwtDXTtmaadqCSgPyntK8a5OW7ElBX1
         gB34YsZAxsC6VuFCVam8f3xWbCoWF2TZlzNoP3JdxgWzSnOLzLbDtsQp8V2FUZMf3/4c
         q4gIb3E8zRdCCXnKNOrDWG1CiZcgRwyIvfZR74XT0RNzvVka5+lS6uclVf3BYC5ksbKE
         An7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656408; x=1699261208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K4ygboP/GY4APGAOCgABrUsbdlE386siBpiiPBK5b4=;
        b=j7csaRQQC4ePN7qUJznyQPBpI1hvLkmsCnkglvi4lkQWl/hQ+lukZ8G8DypZGuf1zZ
         Kbd8bTTvemW6uIqBL7kyIU6dkCYWfr56aRKitqZwu+dLwTOKIZOLOgb7w5D8kdPqyZge
         85t1Z/WfHRzOSd7A+zY9dgL8nYXhz7NQuRD9ft4GxBDKwbnVKD+LbYmHRlPBFSpKGEW9
         yPo+MAGU5Pi4vTWsqOyOjy5JxYrK6t+bDevf3+bLnRwByEnkNpcySKu30mznNszTx9tm
         zRcbIs66x82+1xIS7YwrQ4RkL+lzwAlFsMLTqsz1AOF0i5jQrVLWK8F9Kh8+HeIs4qaj
         KsGQ==
X-Gm-Message-State: AOJu0Yw6UjP3aYiEmOuI0yMVQM6AZ4aZX49ACgnATlEkwlscsKt874HT
        i7fxsbHZB+tEJ7AXXIWNhtBAa1rtZygQhrgdT4M43Q==
X-Google-Smtp-Source: AGHT+IErb4XhfJbrSp9lfHzfI//VJKL1ekE/nZgdVzyVZOXhZC/i3UxpGK9LB5ic6pJn/hf9toCdfYFiUNa2/8U8F2o=
X-Received: by 2002:a05:6402:5409:b0:543:1909:1a3a with SMTP id
 ev9-20020a056402540900b0054319091a3amr48233edb.4.1698656408315; Mon, 30 Oct
 2023 02:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231028144136.3462-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231028144136.3462-1-bragathemanick0908@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 30 Oct 2023 09:59:54 +0100
Message-ID: <CANn89iJyLWy6WEa_1p+jKpGBfq=h=TX=_7p_-_i4j6mHcMXbgA@mail.gmail.com>
Subject: Re: [PATCH net] dccp: check for ccid in ccid_hc_tx_send_packet
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 4:41=E2=80=AFPM Bragatheswaran Manickavel
<bragathemanick0908@gmail.com> wrote:
>
> ccid_hc_tx_send_packet might be called with a NULL ccid pointer
> leading to a NULL pointer dereference
>
> Below mentioned commit has similarly changes
> commit 276bdb82dedb ("dccp: check ccid before dereferencing")
>
> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc71bc336c5061153b502
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  net/dccp/ccid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dccp/ccid.h b/net/dccp/ccid.h
> index 105f3734dadb..1015dc2b9392 100644
> --- a/net/dccp/ccid.h
> +++ b/net/dccp/ccid.h
> @@ -163,7 +163,7 @@ static inline int ccid_packet_dequeue_eval(const int =
return_code)
>  static inline int ccid_hc_tx_send_packet(struct ccid *ccid, struct sock =
*sk,
>                                          struct sk_buff *skb)
>  {
> -       if (ccid->ccid_ops->ccid_hc_tx_send_packet !=3D NULL)
> +       if (ccid !=3D NULL && ccid->ccid_ops->ccid_hc_tx_send_packet !=3D=
 NULL)
>                 return ccid->ccid_ops->ccid_hc_tx_send_packet(sk, skb);
>         return CCID_PACKET_SEND_AT_ONCE;
>  }
> --
> 2.34.1
>

If you are willing to fix dccp, I would make sure that some of
lockless accesses to dccps_hc_tx_ccid
are also double checked and fixed.

do_dccp_getsockopt() and dccp_get_info()
