Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83009808868
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379405AbjLGMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjLGMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:48:59 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E5122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:49:05 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bed6c1716so4174e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701953344; x=1702558144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rOWXHXcE/bl3GnAmoX8Mz2P8oxpbxVD71OVPuO+AYA=;
        b=QXt/W1Qp51lyrQ4PEje7CGArUBuPVOOrjaOEIu8n1UXRV2j2AqY7P8gH2X/Cke1uin
         421p2d/SwK0IxDJYgHKsnUrJ2aUnEIjPLSJeT08aCSD6GDTPK4GzFy6gWzCueqKb6504
         LTlRwgMywH7fO+aecSihYQf3Mko57gFg+DPN6Kd90EqxVbaWDRTWpVpPDkJTajevAyqP
         njSRsB1dA+pFaKcAKx+zVApwl3B5KV51AxCeMsD3pH3HquZ4t9ahX6bC0hGrZwK0Vvq6
         lTfYbBqlHHqpG70fZvks19yD5yZVXELYkIm50t9E0dzYf3LPe8kCFm4CAlmBIhRQch6J
         lI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953344; x=1702558144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rOWXHXcE/bl3GnAmoX8Mz2P8oxpbxVD71OVPuO+AYA=;
        b=RcYH4MFX9R8Dhr7RCjNcQozTkZNuMczAmK+WBS0nHijL3jB7RbdtVxxnB8JJHfyqKD
         emHRmGivqvqOGJiCGkDrk8q7Uvl6dCys91VczqEAVJ/vUU0f7FQKU1zBjxl+0Am2Qen3
         mX2K0mGm7hcBbWrnQrO3RGU6oAoX4vgqdMa4Fg2UE9WChhKTxo8AALXZ7bW9STRo/yfp
         CG7EdPewMqb7Qk8rD6AYqAodlysaHUr172my0ICxfufG3w1eadJfLDn0Q+vCef3ryoPu
         bwfe2Q35D+tlwyjeGKzHyUkgDIo7tnSv9FHmXDqOzsonFghSH8RXypuggTgNX5DE6GaY
         uL4w==
X-Gm-Message-State: AOJu0YxLETCftGRVlVpJ8k4mc+ADPO3NROVw83gA7Q63C+Zj9PmQbpb/
        pxFcE4QDrtxvtoMxzw4PEw3zzucjijJMxU5bsyn/sg==
X-Google-Smtp-Source: AGHT+IGbt+UpAMoyYY7GlgknL8bUKAI9Y8W4Kc2Ebc7/+lJDbwPMqattnZK6taTE0zf1tBEM6IywWv2eeiMKtkj7RBA=
X-Received: by 2002:ac2:4439:0:b0:50b:fced:ca9b with SMTP id
 w25-20020ac24439000000b0050bfcedca9bmr87733lfl.7.1701953343451; Thu, 07 Dec
 2023 04:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20231201143821.1091005-1-aleksander.lobakin@intel.com> <20231207115751.GG50400@kernel.org>
In-Reply-To: <20231207115751.GG50400@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Dec 2023 13:48:52 +0100
Message-ID: <CANn89iKiiexYLXP1fW3anaZt0TJWPUBBmXdjsAV8t3CH3Ra8aw@mail.gmail.com>
Subject: Re: [PATCH iwl] idpf: fix corrupted frames and skb leaks in singleq mode
To:     Simon Horman <horms@kernel.org>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 12:58=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Dec 01, 2023 at 03:38:21PM +0100, Alexander Lobakin wrote:
> > idpf_ring::skb serves only for keeping an incomplete frame between
> > several NAPI Rx polling cycles, as one cycle may end up before
> > processing the end of packet descriptor. The pointer is taken from
> > the ring onto the stack before entering the loop and gets written
> > there after the loop exits. When inside the loop, only the onstack
> > pointer is used.
> > For some reason, the logics is broken in the singleq mode, where the
> > pointer is taken from the ring each iteration. This means that if a
> > frame got fragmented into several descriptors, each fragment will have
> > its own skb, but only the last one will be passed up the stack
> > (containing garbage), leaving the rest leaked.
> > Just don't touch the ring skb field inside the polling loop, letting
> > the onstack skb pointer work as expected: build a new skb if it's the
> > first frame descriptor and attach a frag otherwise.
> >
> > Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

It seems singlequeue mode is not really used on idpf :)

Reviewed-by: Eric Dumazet <edumazet@google.com>
