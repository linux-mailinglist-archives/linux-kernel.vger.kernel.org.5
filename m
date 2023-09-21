Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62FE7A9DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjIUTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjIUTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA317D314F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695323188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDPElF5fbv46uRKTOW4yOLPXCpK6plAuYJE21eTW+f8=;
        b=gQnhm9Jy0abHUMis9+VPPp1CAsiTWFOtgUmXuxQIadweuTJTtjyennWyG/WUFzYes8DHbX
        VrLmnj7iY8+UwPqRus9TAiVDTCZJikfPlVAElxofvYFPLsgAU4oWWLv0XntQgHsWz6ewpV
        iC34jd/41fnczOO8im+Yyyrdmd1bUiI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-ZDMJikxANiSAc2s7Vz1-jQ-1; Thu, 21 Sep 2023 15:06:26 -0400
X-MC-Unique: ZDMJikxANiSAc2s7Vz1-jQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso27026666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323186; x=1695927986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDPElF5fbv46uRKTOW4yOLPXCpK6plAuYJE21eTW+f8=;
        b=NNTx8+LLO+nEDCaUJ5lWMV8bEXA9YJHov4nztXDYqjLsJohf0cYc2EvMAjFo0c/Y0r
         3PMVMZgJqOpEmdM8QTwZFygOle/FfZVEuRTf27lUBjeubu7xp9XlwLeAkPVpbddshtiN
         Ke116jKy6uJG0SKvf8tACAYtGRE+phd8oyvgT8MIB1ite26RM4ECjeoG04NrjKZovT+f
         pgXNOHJ12LieBYExNsRXLIs7B2kk4rPSYEBZ3K//MDqpP0C1cr9xebnN+ddTl4zES9w+
         KdvMhcbDKGNoMlvNUuTHc9iu1Q/0tYDFmbi7hhVR/oXW/3ReGHla/NSRUU+ghMxcHuZC
         ZsPA==
X-Gm-Message-State: AOJu0YxDd363MGcXUof31T/xTXTkIyDClGGbHC03ANZWnZDyw8/rVP5a
        4iHnpmb3JWKxxz6IChqxFoRYThJdyhR5FVdOThEqgO/Ocj8tEFt4MtAWRq9uBNEI8o6xOsi7BBT
        i4Xgdj9dp8bV2ljEuxtzVxVOl
X-Received: by 2002:a17:906:535e:b0:9a2:1e03:1570 with SMTP id j30-20020a170906535e00b009a21e031570mr4984709ejo.0.1695323185855;
        Thu, 21 Sep 2023 12:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLZS6/xYFBep1mcS+XqWUS4NAEaA4kUx8Q1oVSWNtB1xILFo4hy4Nk4J2xTi4tE2TiQVW7Bg==
X-Received: by 2002:a17:906:535e:b0:9a2:1e03:1570 with SMTP id j30-20020a170906535e00b009a21e031570mr4984702ejo.0.1695323185514;
        Thu, 21 Sep 2023 12:06:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b009adca8ada31sm1484792ejr.12.2023.09.21.12.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:06:25 -0700 (PDT)
Message-ID: <ccd7930fd410540c4d9c971feb470466386e8977.camel@redhat.com>
Subject: Re: [GIT PULL] Networking for 6.6-rc3
From:   Paolo Abeni <pabeni@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Sep 2023 21:06:24 +0200
In-Reply-To: <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
References: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
         <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-21 at 11:30 -0700, Linus Torvalds wrote:
> On Thu, 21 Sept 2023 at 07:35, Paolo Abeni <pabeni@redhat.com> wrote:
> >=20
> > I'm wondering is if my PR reached somehow your inbox and/or if I have
> > to re-send it.
>=20
> I got it fine, and just merged it (still going through the build test etc=
)

Ah, better! Thank you for the feedback!

Cheers,

Paolo

