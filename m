Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F747973CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbjIGPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbjIGP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:28:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC501FF3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:28:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76ef935abaeso62289785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694100455; x=1694705255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aycCTyJOheIDKo1ZgbnwW6zsxD+FQHxnfjQ1uwRRryI=;
        b=OgvSFXkE1sh1JKfS/yNyFPiXPNOc/nRIrXJ5yqEmZlmbkJjONb+SVJUhGaIJg+P2jn
         Ob1E5Z71vGtLkv0gZgVYaeSCBydYME6pUaYwJ+D2Uc0o+wANVSl/rJ9eIMHd91zD6dd6
         U36hQb3S0jRZPjDwiUokR58qLO27Sc8FMnPE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100455; x=1694705255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aycCTyJOheIDKo1ZgbnwW6zsxD+FQHxnfjQ1uwRRryI=;
        b=HG6yKZHkvelvN2mPXGbJ0sxA07Cya4iWlaaR0SjjaxsaTPyTtJHklDyvFZAx/N/Xtn
         kHlnpEgiWN+oRVo4rax3TC0i/NumRUf+hx/iL3AWVvQ/2lpZH2LtKXod2xVXHE02v8s4
         z7p14A+Kk8ecbZXRHzR9a17MuIboDEYXOYE8od94XL0EIXMCGBDv0ROejxB+iulYsZ8s
         2Scd/QcFdbVHnx6dE2hFefbPP1WoVhyW+cX5v6LgAMPT0aajzOcrQq9PxYXQK3a5psNf
         Egr6w1XvhQy9t6NaaYqluRxi4Ni8z0eqiQQP+Ww0gqSyG1gooC6DzT7ELYVa7Oj6hn6L
         GRiw==
X-Gm-Message-State: AOJu0Yw3KfI7y5g//R6CDRTcbZdGDy2jBm+sK5Q0UaE0nK/LxgW7YGKU
        2DPYt5wba0fIZuHORsq9ScrbojLoFcCwfQLZ+FEcrbep9pOxGnqw
X-Google-Smtp-Source: AGHT+IFj2FlIKXoMOrdA8m6h1SxwqJEdWc5x6fTQOPsL29IpibzHq4rNR/U1JI7AAj1ZLriuWigLzvMPJRO0C0GjGD0=
X-Received: by 2002:a92:cc82:0:b0:34d:f026:7aa1 with SMTP id
 x2-20020a92cc82000000b0034df0267aa1mr18419028ilo.26.1694078781179; Thu, 07
 Sep 2023 02:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230906102940.1120269-1-treapking@chromium.org> <CABRiz0r8qHgx-4b7QdCj6iz9FDsyChznEHOn5eByVoUYuLa-PQ@mail.gmail.com>
In-Reply-To: <CABRiz0r8qHgx-4b7QdCj6iz9FDsyChznEHOn5eByVoUYuLa-PQ@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 7 Sep 2023 17:26:10 +0800
Message-ID: <CAEXTbpdqhxWVMSHz-8+=50_qd1UViKvD5YZY08=RFMBu5E6b2A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Matthew Wang <matthewmwang@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, Sep 7, 2023 at 5:10=E2=80=AFPM Matthew Wang <matthewmwang@chromium.=
org> wrote:
>
> > -       if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> > -                    sizeof(bridge_tunnel_header))) ||
> > -           (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> > -                    sizeof(rfc1042_header)) &&
> > -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_AARP &=
&
> > -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) !=3D ETH_P_IPX)) =
{
> > +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <=3D skb->len &&
>
> sizeof(*rx_pkt_hdr)?

Thanks for catching this. I'll upload a v2 for this.

Best,
Pin-yen
