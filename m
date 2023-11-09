Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066537E6667
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjKIJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjKIJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E92693
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699521282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlxAh75JGCxuVSjk/DiobkLepAxu5g+JZPGhaCfgbCo=;
        b=Win3FiOjehxt05BlXlANmyuxv74kzOpvK4SBFcVkv/DzuCFgI+z22BmQIYuQ7tE9W59YLp
        tz5ftSwi2f8ApnHbP52XW7RqjZQGbELdqypYjvBcVh86VM5/6rC2Y2pgHQrC2jEoYzSWaf
        /bsBACXcOeAdE7xoeTdAnDl0p+ANWLs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-iCeYNx-CPkm6mfItX6WkaQ-1; Thu, 09 Nov 2023 04:14:41 -0500
X-MC-Unique: iCeYNx-CPkm6mfItX6WkaQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9bfbc393c43so15947866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521280; x=1700126080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlxAh75JGCxuVSjk/DiobkLepAxu5g+JZPGhaCfgbCo=;
        b=rH35YOSpjYNpwE3zdmhVSUBIFPbT+zcRntn7q3/Qu0eD02niAiXLjIsEl0Ymrpi30u
         s5034hOP/3xzB9pG+Yohjgv7ZRR5C9pco4TKM8IyilDpG91ZTU2kkLdX+NlzvdFHjb2t
         yAHPJi2CF6JGvp44zCDuFt9o3ojmoP2aQ091pMnT6ZXBp6bl9I9siuW4/Ppy1YAqDNa3
         XeK9q0mBY4Q2uik5RCqQ7jp6zFc9NypBDrkHNq9gZIKOUmLH133P0hGFBq5N+PXX8Oxj
         AvEos3VW1p4/GKtjDaAnTX2URO+ZThNtVm82XfTQUhn/krZOjYCFVDRKQMTR0ohqGqeu
         g+cw==
X-Gm-Message-State: AOJu0Yy0No8SF2+wA9luDB9WaYf2YLByF7ux/KI/WoNfNPhW5Xs1WN66
        3FPesuiIqiLtptavOh3Arcbiuj1RX/iDW8O3rWTJvkhNtL0HzmtFhfMtEY2AJbl6aGofQ9Apn68
        19zcMwwnzHn+ycfQ/JKkjp/Ce
X-Received: by 2002:a17:906:e84:b0:9e3:a1a9:3db3 with SMTP id p4-20020a1709060e8400b009e3a1a93db3mr3052493ejf.0.1699521280335;
        Thu, 09 Nov 2023 01:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrN7rWZV1LJySiH/LlJHce45p7c2N1o4c7lFbPUX87ekT7bdY/faJ0o5ksbIAqMgIYGTojqQ==
X-Received: by 2002:a17:906:e84:b0:9e3:a1a9:3db3 with SMTP id p4-20020a1709060e8400b009e3a1a93db3mr3052473ejf.0.1699521280043;
        Thu, 09 Nov 2023 01:14:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id dv16-20020a170906b81000b009a1c05bd672sm2252071ejb.127.2023.11.09.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:14:39 -0800 (PST)
Message-ID: <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
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
        Praveen Kaligineedi <pkaligineedi@google.com>
Date:   Thu, 09 Nov 2023 10:14:37 +0100
In-Reply-To: <20231106024413.2801438-9-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
         <20231106024413.2801438-9-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> @@ -3421,7 +3446,7 @@ static inline struct page *skb_frag_page(const skb_=
frag_t *frag)
>   */
>  static inline void __skb_frag_ref(skb_frag_t *frag)
>  {
> -	get_page(skb_frag_page(frag));
> +	page_pool_page_get_many(frag->bv_page, 1);

I guess the above needs #ifdef CONFIG_PAGE_POOL guards and explicit
skb_frag_is_page_pool_iov() check ?


Cheers,

Paolo

