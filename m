Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D737CF355
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbjJSIym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJSIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EDA121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697705630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKYvltGDTZPHmBBUWHHWQGHBOyryxG9yuCEoL9SPiSs=;
        b=T67CeVGOuvDddeHsoncqbuoFEV5DibgB1GtLWXvjvwQeKRZvco5L/gE8AcLo6SvXA4rXgZ
        kKZuzHJjGTmfPK/3d4urqfQOb6CzmEfdoto78BMr9a/FJQtjh3Jugw+b3a4cJTdCjV+1UK
        cIzDhQ/lFQNJSYTciVzA5w0PorOsPII=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-jLKJdEikMl2mQ0J917H-nw-1; Thu, 19 Oct 2023 04:53:46 -0400
X-MC-Unique: jLKJdEikMl2mQ0J917H-nw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53faa428157so9181a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697705626; x=1698310426;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKYvltGDTZPHmBBUWHHWQGHBOyryxG9yuCEoL9SPiSs=;
        b=YfVImIs4oRefKlyGv83aU2hH4bjVBvpCqUDE+Kh8drEtrRJOqmm570ceet0f/lT7DR
         /QkZxowNNJPcaaCLt89kWQZnNYkcy51sCrCSw8m8CnUeUgZqCTIVLV1c6aA7xCbbJM4+
         BlN/oRDukd7CJerlPhBXDQbrxEhEepTpDnGB1l0xff1T8KtgzyR8d/RRsemmrnXJM9qo
         wDn6zmwOrDh5qKQ4SZPC5UDCetNNBXHqui/Bl+Co2cT5iX9iOeYCMc3gSKw78ULMfz3W
         EI8boAzSsq/Yc+JsE/H452yBo1wwuyAgoFRqiP1MbIyKmKfLiAs/FHvVeETbunOqRV8Q
         yRAw==
X-Gm-Message-State: AOJu0YyvNubapm2atMJEnL7/N0pkRYf12QnLA2xvGCFnMTsrJ5emupVQ
        PWmO3tzWSxfmW2mqrui391fcUB3fTwJ9oa42N/Q7PT8mGlcsHZHE/SoKg392uT+CvFXs3pKWisq
        rh0P8gbxSctB7lx+OyoK6jK5Q
X-Received: by 2002:a50:9f82:0:b0:53f:1a04:e4e4 with SMTP id c2-20020a509f82000000b0053f1a04e4e4mr1054313edf.2.1697705625849;
        Thu, 19 Oct 2023 01:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAUZUJc0kzm+7kKUWEc28P8pZT8ZjRc38n6nk/Neu6/YYJzX8nberMRXNYx7or9BO1aWDr3A==
X-Received: by 2002:a50:9f82:0:b0:53f:1a04:e4e4 with SMTP id c2-20020a509f82000000b0053f1a04e4e4mr1054298edf.2.1697705625468;
        Thu, 19 Oct 2023 01:53:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id a6-20020aa7cf06000000b0053e625da9absm4050443edy.41.2023.10.19.01.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:53:44 -0700 (PDT)
Message-ID: <d1271d557adb68b5f77649861faf470f265e9f6b.camel@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising
 memory
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Oct 2023 10:53:43 +0200
In-Reply-To: <20231016132812.63703-3-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
         <20231016132812.63703-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 21:28 +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>=20
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by reverting to the behavior before that commit.
>=20
> After this fix, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>=20
> Fixes: e1aab161e013 ("socket: initial cgroup code.")

I think it's better to drop this fixes tag. This is a functional change
and with such tag on at this point of the cycle, will land soon into
every stable tree. That feels not appropriate.

Please repost without such tag, thanks!

You can send the change to stables trees later, if needed.

Paolo

