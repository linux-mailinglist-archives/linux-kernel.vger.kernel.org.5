Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD037C6822
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjJLIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjJLIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD0A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697099498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDXTErD9yX+SuZgZbDMto+/s3M8gWyq6fvO38E6htEU=;
        b=UFGMT1raXrBRU2z39qMWETvaI4bKePz2qyKkWNLRR7hvflC3ghb+3Nr2kbOFz7YAikWNni
        1K+WtYED8IPYNyHVk+bVKdAxCdYjDmqmKHj9INkR1/RU8J4D1Je+O8vV6aamksiqEZRXO9
        A+vJput7+Otkl4rBF+AVHjFF95UjUEc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-q1dNdOTvNRGRWq5geoL82w-1; Thu, 12 Oct 2023 04:31:37 -0400
X-MC-Unique: q1dNdOTvNRGRWq5geoL82w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-534c9a316cbso100429a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697099496; x=1697704296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDXTErD9yX+SuZgZbDMto+/s3M8gWyq6fvO38E6htEU=;
        b=L2H8Iaadrz6eKKnPNuhRB7+dsGuYfe96g9QYAECSr+kKBnLHLhE66mH+MgLnZgrt38
         OTdHGA6Oa0TKooxciFVe6agdVppV/N63CSd/q4YBkAxTnJYAKcZGK1OL8xuI9uOAK1+b
         eb9p0dqihz3yVbcTF5NqKUDYNc2s3VrcbFewGeD108MSt7hycctDd+veLRW+bQCpf5dd
         O6vCJeT+94trCdRMNpsAdvDCaPhIGpl/HqZiAXOuiP1VpYbDpQ0xxrv9dZXXB38wB6Dx
         tRc25o5UHBskILFWqeB/E0plasjZoH3rxghrim7W2G4K5NSl4y45c8mTpLWokbIxe1Ys
         x9EA==
X-Gm-Message-State: AOJu0Yy81U6LrTrfCWOig+YqggJi++V0jrnui+HbTecGsZ5tozwwCg2d
        CSbUDZSST/SkS5skFghUMTRlnQql2q3ak34gV33vhRoeVWALUUcaT6a6qIQTRpPi8Pclvta7STs
        /gHA8uexQT2ZUhScc7FTMY07B
X-Received: by 2002:a05:6402:290c:b0:53d:aaf5:c49e with SMTP id ee12-20020a056402290c00b0053daaf5c49emr3925139edb.1.1697099495953;
        Thu, 12 Oct 2023 01:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsDOMpD2VqYx4OQvPxT4GPKqTdL4UTaNatbTMWJVg2p9WFu8D79ionvNKPMnlR0Lw9tOHV9A==
X-Received: by 2002:a05:6402:290c:b0:53d:aaf5:c49e with SMTP id ee12-20020a056402290c00b0053daaf5c49emr3925127edb.1.1697099495658;
        Thu, 12 Oct 2023 01:31:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-181.dyn.eolo.it. [146.241.228.181])
        by smtp.gmail.com with ESMTPSA id cb5-20020a0564020b6500b0053ddbfa71ddsm1660937edb.47.2023.10.12.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:31:35 -0700 (PDT)
Message-ID: <237ad66815a7988eaf9b0ed2132772c58e868cd8.camel@redhat.com>
Subject: Re: [net PATCH] octeon_ep: update BQL sent bytes before ringing
 doorbell
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hgani@marvell.com
Cc:     vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>
Date:   Thu, 12 Oct 2023 10:31:33 +0200
In-Reply-To: <20231010115015.2279977-1-srasheed@marvell.com>
References: <20231010115015.2279977-1-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 04:50 -0700, Shinas Rasheed wrote:
> Sometimes Tx is completed immediately after doorbell is updated, which
> causes Tx completion routing to update completion bytes before the
> same packet bytes are updated in sent bytes in transmit function, hence
> hitting BUG_ON() in dql_completed(). To avoid this, update BQL
> sent bytes before ringing doorbell.
>=20
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt suppo=
rt")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index dbc518ff8276..314f9c661f93 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -718,6 +718,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *s=
kb,
>  	/* Flush the hw descriptor before writing to doorbell */
>  	wmb();
> =20
> +	netdev_tx_sent_queue(iq->netdev_q, skb->len);

If tx completion and start_xmit happen on 2 different CPUs, how do you
ensure that xmit_completion will observe the values written here?

Specifically, don't you need to move netdev_tx_sent_queue() before the
above memory barrier?

Thanks,

Paolo

