Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196FB7BF750
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjJJJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJJJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E2194
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696930144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OxCiYvYV9qvLPGaQcB0kw4NAjm9ttFkbDiaJd+SrBGA=;
        b=Gwz5LlOWhejF8EMoDb5BjKxRcb2dCqeYhKWqf4BQKOBbJvQb9yIXPDL08HXOGYlDm8YEuh
        DE2qxBRJO2TaZx/TL2N8tnIgLfESK7kM2aEeGOhhFCEnkQxQF66mZL/6nfB1D8O5Olf3ag
        1eIknom6Lz21BdnHbNA4+00KDTphKc0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-82k_DWvcPeerVxFoEk0UUA-1; Tue, 10 Oct 2023 05:28:57 -0400
X-MC-Unique: 82k_DWvcPeerVxFoEk0UUA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53479f2bfb7so824634a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930136; x=1697534936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxCiYvYV9qvLPGaQcB0kw4NAjm9ttFkbDiaJd+SrBGA=;
        b=CgV0UPBzKQcCr8XFJFiLjFI4b22N7a02LZl7Hz+UwMHLhmYkkEb05kAO4ad17LrpUi
         rv7t/FxZHA6u8K6BftxiWUtpyinKZNesvWLH47hHsCrbd+1tSxKeqng3BAvT4Mnnm5nQ
         WiKexZhd1po+E0qY3E0ZAvtrUi3SRSIENzJUYJMrPOf7YkDLtU0IrLaWv2X0FqxFXtFQ
         lLNYd3C4GKKHzv48iYvRB/FxVu2s16UyS/wGHu6wODXdY51nE/8EP5KTmfjhrWSFRaib
         vsTn4mSoEuC/wEhwirKoKjyWtqXAd3wb/8qBAL34j2OPU8uOz7aAFVU7TJ4clpPUyUJt
         ElzA==
X-Gm-Message-State: AOJu0YzvRwOyKIJMbfoQV07aapl52mzY3iAcq8SKdHNSEYPTapIUw28r
        L5d3QKvCXTWHRzvJPoV2NofCCCS7S2FJyXjMPcaMTr+CUsLczwzhIQeBOenrJXjnNNRa5qUkGYz
        dZ7qr4ZnTpnSsRknXtf4IXHO7
X-Received: by 2002:a05:6402:40c2:b0:523:37cf:6f37 with SMTP id z2-20020a05640240c200b0052337cf6f37mr14733546edb.4.1696930136465;
        Tue, 10 Oct 2023 02:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJPAx0QHx22OMargM+EBFoGBj2R+pr1dyTcELronIVBN9Cn975WI9liuJm10euXLGllBG8kw==
X-Received: by 2002:a05:6402:40c2:b0:523:37cf:6f37 with SMTP id z2-20020a05640240c200b0052337cf6f37mr14733531edb.4.1696930136150;
        Tue, 10 Oct 2023 02:28:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id c6-20020aa7c746000000b00537f5e85ea0sm7326021eds.13.2023.10.10.02.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:28:55 -0700 (PDT)
Message-ID: <39546eb7836e577b53a3b403a2bb20ec07010f25.camel@redhat.com>
Subject: Re: [net-next PATCH] octeon_ep: pack hardware structures
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hgani@marvell.com
Cc:     egallen@redhat.com, mschmidt@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 10 Oct 2023 11:28:54 +0200
In-Reply-To: <20231006120225.2259533-1-srasheed@marvell.com>
References: <20231006120225.2259533-1-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-06 at 05:02 -0700, Shinas Rasheed wrote:
> Add packed attribute to hardware structures.

Could you please elaborate a bit more why this is needed? Is this a
bugfix? Or something needed by later changes? Please update the
changelog accordingly

Thanks!

Paolo

