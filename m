Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1880E8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjLLKJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjLLKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FCD2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702375772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6M/XvsgEA+noH1tcrJHEuC0orIXI1iUMmdFqUMBoqe8=;
        b=NaXWuvLkVbyZyRqh5NUEcyOWGb4lUt0nwRsN+RoevZDyI4A2nlmIkuskv8ADn1yzdXl/pD
        LEsrODgUdK9nQVOYxZjqIb97EcLjq8VswKBTD4vVTJjpJUraweSCZKfwihzHeA1W5xU4Rn
        DKwvl1UjEjN7XVkkA9d3uBa8oVnBI0Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Ji4Ynf9xMDGn7Ugvxm2-Dw-1; Tue, 12 Dec 2023 05:09:29 -0500
X-MC-Unique: Ji4Ynf9xMDGn7Ugvxm2-Dw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1e27c6de0eso116501766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375768; x=1702980568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6M/XvsgEA+noH1tcrJHEuC0orIXI1iUMmdFqUMBoqe8=;
        b=skbJxZIEbHu4CUgpgSzzR33IyT1ajzhGHtmHlkM3hEv1VJRHzt+FGTkHQXYquO1B5D
         kWjPVQp34Zi9T9/U+pV6gshPh642euqZ9myvQCx2kcRonGUvyriB/SnkfPptVl4JC1Ly
         94GmqVO3MEUeLqTMh5SeQZbbPR/vnG0dL79LkG9TaQ4BZy/pgxvy4+QcYOmROKBn8JP+
         /84STKTaKxt8aRPf0No1LajiqQiPUgbfGYyeVZo2Hun4SNXwPXdG7x0O5uMEsduAmPtl
         U5oyPoW6xlX2VCWYHyzSvyY98qvZqw8EGIytnQrpXa+STOsM34C0jvpiu4cgmv+hKBUY
         D+Sw==
X-Gm-Message-State: AOJu0YwOeIC9q214N+xiAc8nFTfhKEcWq3YpjMg7Ik66zSKbOKh/Azub
        YBisswLpVFDJFJd1ZcUKgiR/vqdn8jZeiccd0n4rcw6eEdWRGL5eS+BL7paFSy/B6eY5n9jAKY6
        DL3neq1OB2IiG+bESQIBVabEl
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr6089853ejn.7.1702375768352;
        Tue, 12 Dec 2023 02:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMk1yIC7lV8N6DHVhTHBZBSHd+M1WbawYmyYj2VdjRNDphGCbZUoQdjg2Snt8KS+xKq/RRMg==
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr6089833ejn.7.1702375767944;
        Tue, 12 Dec 2023 02:09:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id rr17-20020a170907899100b00a1d457954d6sm5994983ejc.75.2023.12.12.02.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:09:27 -0800 (PST)
Message-ID: <955d390c57a93406d40985fbd1856bd1c500d75c.camel@redhat.com>
Subject: Re: [PATCH net-next v14 08/13] rtase: Implement net_device_ops
From:   Paolo Abeni <pabeni@redhat.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com
Date:   Tue, 12 Dec 2023 11:09:26 +0100
In-Reply-To: <20231208094733.1671296-9-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
         <20231208094733.1671296-9-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 17:47 +0800, Justin Lai wrote:
> +static netdev_features_t rtase_fix_features(struct net_device *dev,
> +					    netdev_features_t features)
> +{
> +	netdev_features_t features_fix =3D features;
> +
> +	if (dev->mtu > MSS_MAX)
> +		features_fix &=3D ~NETIF_F_ALL_TSO;
> +
> +	if (dev->mtu > ETH_DATA_LEN)
> +		features_fix &=3D ~NETIF_F_ALL_TSO;

This latter condition is strictly more restrictive than the previous
one, you can drop the latter. Also could you please drop a note about
the why of it?

Cheers,

Paolo

