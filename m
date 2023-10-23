Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765D07D2AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjJWHMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJWHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:12:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143CDD5B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:12:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso432252966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698045141; x=1698649941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDpgNYJBZWfpDGAZyLDDwSjicDHKCRY45Gtgt4Snt7Y=;
        b=ve0zNz5Q8R4r8Wkpn2WN+1QSLg9K9NDUPZP4MFDHzjWDCNb6ZZmMkYbL5xme7XVWwb
         KIrfHeGNfk/CSkvQWTleJDabnsiiUeId7zgCXGgiXa2YSuaCACY0eCk+sMDJ+UbNLHGW
         Jq+ZeLpxdeamBeggJvAGKlANdpSnfpONqaKM/G9Yl4UgWXcKu0EWj7huIsNlTczWvEyA
         ZIV/DtZw2arA3Ojr4BAygILzIa4FIhltWVdXgX8tt0pV7pM7kmwr1tkRpbDdGzoaFOrf
         GdeK4cn4FoCnJBQdQYfgnDLfOJYMfsDj7AdsRtNPfcUQUDS0aN3pQ6lhT58hUdHVPdim
         u1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045141; x=1698649941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDpgNYJBZWfpDGAZyLDDwSjicDHKCRY45Gtgt4Snt7Y=;
        b=alWRcg3W095YeIOD5BGBBFBXpj40Cj51mEmo5W6dCDVxV3/t2FKmO3Xh0BcYGQ4j84
         08WD9HWTAH3DBz6bsAdNIGUyQRiQgqGeHVo2pcE8LCEv7H0VRp7BEX2S7ND6sHNWAHVk
         U33o3v7fVc944X9yDa81Bjtnw3HDvU+SUuOBbk5xzBtfzpTdq8nEJKd1rp8jj8sgzjU5
         PJhZzgamR2Iw/Qm3/WUy8VjkLVgdN00eon4vsA4LdCpyT7U9gLf/qgr7YeI0nsZJksYV
         +0phdjsKH2FxunUUqyAPsMWumQBcftLGNd+Ij47+ozZrmMdG/D2+tDSDIBhnZ5+QnF6h
         eywA==
X-Gm-Message-State: AOJu0YynyM3PqPqLzdrVZ3GXcBfiDioOquDZyK1uTzQ4VfK3kUj5poBq
        3OUzyvM+PaeLFYlm38s5UCKHGQ==
X-Google-Smtp-Source: AGHT+IFNEqdPmZMghAIy7qjWE2pPnFeO4o0LaZi8rPbo2VteX3nMu1nl4MGz2o+B+svnGR5EbZ9hJw==
X-Received: by 2002:a17:907:86a6:b0:9bf:388e:8e93 with SMTP id qa38-20020a17090786a600b009bf388e8e93mr7195167ejc.0.1698045141185;
        Mon, 23 Oct 2023 00:12:21 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906225000b0098921e1b064sm6158861ejr.181.2023.10.23.00.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:12:20 -0700 (PDT)
Date:   Mon, 23 Oct 2023 09:12:19 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Ahern <dsahern@kernel.org>
Cc:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests:net change ifconfig with ip command
Message-ID: <ZTYc04N9VK7EarHY@nanopsycho>
References: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
 <fde654ce-e4b6-449c-94a9-eeaad1eed6b7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde654ce-e4b6-449c-94a9-eeaad1eed6b7@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Oct 22, 2023 at 07:50:52PM CEST, dsahern@kernel.org wrote:
>On 10/22/23 5:31 AM, Swarup Laxman Kotiaklapudi wrote:
>> diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
>> index 116bfeab72fa..3ab9beb4462c 100755
>> --- a/tools/testing/selftests/net/route_localnet.sh
>> +++ b/tools/testing/selftests/net/route_localnet.sh
>> @@ -18,8 +18,10 @@ setup() {
>>      ip route del 127.0.0.0/8 dev lo table local
>>      ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
>>  
>> -    ifconfig veth0 127.25.3.4/24 up
>> -    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
>> +    ip a add 127.25.3.4/24 dev veth0
>
>ip addr add ...

Why not "address" then? :)
What's wrong with "a"?


>
>> +    ip link set dev veth0 up
>> +    ip netns exec "${PEER_NS}" ip a add 127.25.3.14/24 dev veth1
>
>ip addr add ...
>
>> +    ip netns exec "${PEER_NS}" ip link set dev veth1 up
>>  
>>      ip route flush cache
>>      ip netns exec "${PEER_NS}" ip route flush cache
>
>
