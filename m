Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928377E658A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjKIIpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjKIIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:45:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F51210A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699519464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTFEp4CMLoFdUcZdEGfmISXt6fDITsZHDJnL/kZD0Z4=;
        b=SqFitLB1TSyNREGTdHtGWxZfsNdP9BSQ7NMLO/aQ90o4GRSk8cyqlK8oTAgWrC07Gd+AyR
        WedjTOHOkBIDd/6SKFe8DM7bsR5G0tVZnuu26+AtJ/kScMZEOiXuNeo02cbsYcCiYBZAcD
        Tf+8cuxmM1IwCdLGJkGnrMQQjQ9cbQs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-bvDB7JIZN4OoeUGCCFqMqg-1; Thu, 09 Nov 2023 03:44:22 -0500
X-MC-Unique: bvDB7JIZN4OoeUGCCFqMqg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9bfacbcabb1so8611166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 00:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699519461; x=1700124261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTFEp4CMLoFdUcZdEGfmISXt6fDITsZHDJnL/kZD0Z4=;
        b=hv4vfwtCYHSk4+YDw/cWm+3n7zEOViwlUfnqmkQFISbIUsF/HKARI/3zosvvcEnu8C
         TjRdqzgKOmcT607uuf6BrNzwrwmaqZfG7imkPTir0UQkQLiUklz5CIfynIURGWLbsWv+
         Y+Vn0typRSsibfxLvVl3SPOZxDKGPdCLPOc2VeJe+PeW7EHiT/Xuo3CuNSX5NDYV3H45
         iFLrUIUTTOemfwcUZ7T273VhKMqiFFjMTew11/OXOTo6u/JgNMEtaSrYKGuwXJyBgpgV
         Ts2CKn/++FkJpfuSDPKdU889My4IyjO/gKcq9RWv7/JmU7AbpjIDrJ7X6tA2yyNdDCHt
         WoOQ==
X-Gm-Message-State: AOJu0YyH4TpdaNp0MlwxP6Jl3uiT6UUkW2bvlRIcwr5UV4rMMhs0GZZj
        OQofq/J+QLSrD86DyNLuPL+cZRgZmdIaSpXDTKTPtkgNeYbIDJhwd03eOZfbDeK3AuLtwSnYhww
        GpZ30VJ1FgotBphmZfZu9CTRb
X-Received: by 2002:a17:906:6a0e:b0:9ae:50de:1aaf with SMTP id qw14-20020a1709066a0e00b009ae50de1aafmr3323743ejc.4.1699519461248;
        Thu, 09 Nov 2023 00:44:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpt6f4OXVKtH4i3m412g4H1Y1OUcpmAtKJLGhLybamCWeX8G1/7ze6DLbaN+L9dFmPNZ/PZg==
X-Received: by 2002:a17:906:6a0e:b0:9ae:50de:1aaf with SMTP id qw14-20020a1709066a0e00b009ae50de1aafmr3323714ejc.4.1699519460914;
        Thu, 09 Nov 2023 00:44:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id ha12-20020a170906a88c00b0099d804da2e9sm2235687ejb.225.2023.11.09.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:44:20 -0800 (PST)
Message-ID: <21e4ef7d4a1b4ad298b0688f2b9ce8f5572e1e69.camel@redhat.com>
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
From:   Paolo Abeni <pabeni@redhat.com>
To:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Date:   Thu, 09 Nov 2023 09:44:18 +0100
In-Reply-To: <20231106024413.2801438-6-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
         <20231106024413.2801438-6-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> +void netdev_free_devmem(struct page_pool_iov *ppiov)
> +{
> +	struct netdev_dmabuf_binding *binding =3D page_pool_iov_binding(ppiov);
> +
> +	refcount_set(&ppiov->refcount, 1);
> +
> +	if (gen_pool_has_addr(binding->chunk_pool,
> +			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE))
> +		gen_pool_free(binding->chunk_pool,
> +			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE);

Minor nit: what about caching the dma_addr value to make the above more
readable?

Cheers,

Paolo

