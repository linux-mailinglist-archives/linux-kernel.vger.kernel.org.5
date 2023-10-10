Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840647BF8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJJKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjJJKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1DB8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696933871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1C2ePqqy9Lk6VTckZlTq+a1e83GQqbEDpw2ShG10pB0=;
        b=NS7lJDG1MK+qISuHTrfr/EUh6vCQ2+BSO3fxLtRA5uPS4RAsY5d1DVokL6iYkisWslFh+a
        H0lGbmv3UbDHnWJML7N16JIk6koH0KRlMcolW2jvne4+pRxolELd65zXJxQ4Vtk13aVSxD
        iY34g5ZuzGeTJIe4Kn6eqblz4Q5HE0g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-jSePuOjWP7imBkMbe8M5vg-1; Tue, 10 Oct 2023 06:31:10 -0400
X-MC-Unique: jSePuOjWP7imBkMbe8M5vg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50301e9e1f0so1398308e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933868; x=1697538668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C2ePqqy9Lk6VTckZlTq+a1e83GQqbEDpw2ShG10pB0=;
        b=MHVO/wx4TzD/molWSM1JTl8+ruxilVSHtkA/UUA0W3kz3gB1kUVjlmBNk5PEChRYhX
         GFdlZ00X/ZJ6n6Y1u0U+i9aiCcAO70JVXcXjHhXgZV12OG0Ntz2LPpPAcLHFqTU2rd8A
         sVlD84HARVmj/me6ZzjgtLoIBkF5yL3GHV55Qab8QtEqou2OZiknJxECu9EDlofG+hQG
         gTQQ8xesrFJQLNMQTWD13892Y4610Oa9xG6tonn0VFTmFJ7kGbV5ioyicSVDc3cIGNRg
         aa0h210luNS57ABIekJx/nedixAhxPoZS6FprPnQgPLYuMXjMcyocSkcva3uZW7i7ctE
         0bHw==
X-Gm-Message-State: AOJu0YwPuMdPoKdjPJvvQzJcPELElqk/fLNjsgIIONuBw/Z+Q1ITwXeb
        C0evf1h6SdJLIl1ivyFXxbGQiFXsfwYra65HKe6Oeq7VzhOasDPE8s7oRX/XzuMWwvxlpY0r5v7
        EqPOJprlb8QONvNIMAFeddJDx
X-Received: by 2002:ac2:44af:0:b0:500:8b8d:d567 with SMTP id c15-20020ac244af000000b005008b8dd567mr13954361lfm.1.1696933868576;
        Tue, 10 Oct 2023 03:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4zbsYE0b6xpuabrHTXmkVT5Ih05AnKqJobbYn9oPPUXFCdOy98fOtleNCBIYF/2hGX1lXUg==
X-Received: by 2002:ac2:44af:0:b0:500:8b8d:d567 with SMTP id c15-20020ac244af000000b005008b8dd567mr13954336lfm.1.1696933868226;
        Tue, 10 Oct 2023 03:31:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004fe7011072fsm1760741lft.58.2023.10.10.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:31:07 -0700 (PDT)
Message-ID: <417e00407c64ccc39fce35bdb41b6765363d9fb1.camel@redhat.com>
Subject: Re: [PATCH net 4/4] selftests: openvswitch: Fix the ct_tuple for v4
From:   Paolo Abeni <pabeni@redhat.com>
To:     Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>
Date:   Tue, 10 Oct 2023 12:31:05 +0200
In-Reply-To: <20231006151258.983906-5-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
         <20231006151258.983906-5-aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
> Caught during code review.

Since there are a few other small things, please additionally expand
this changelog briefly describing the addressed problem and it's
consequences.

Thanks,

Paolo

