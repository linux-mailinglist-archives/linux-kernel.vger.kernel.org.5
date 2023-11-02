Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98417DF119
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347356AbjKBL0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347243AbjKBLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54E111
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698924314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9+EloQzdVYeoamONcM2Hc+44nMTwaQEa+a85PRBSe4=;
        b=LQdFt3ZKGdEApjSx/97bjMdIMNvO9Reubs6+q6d/ybk4JUSmqFjxmHQd9RS4HuhaZIHi7Q
        EBJP0G8XejMPD7A+oa0rFXD8arHVs0zCdgY8fsjK1q7ZG5JtxNldHwUDkL4DKTqmqOSZMf
        cB4Bp2eyoAGcRypkXsp01/OP4tmy4I0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-VJKJh3BmORWtFs_pUIMFgg-1; Thu, 02 Nov 2023 07:25:12 -0400
X-MC-Unique: VJKJh3BmORWtFs_pUIMFgg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d3f71f49cso2471286d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698924312; x=1699529112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G9+EloQzdVYeoamONcM2Hc+44nMTwaQEa+a85PRBSe4=;
        b=we16ULCRQGpYSkOFxtXUc4+JJBztH0hw6lON9LyvsAYIrPvp2+6AEoVCUtFtFcefza
         4xbCUckKDtuzt6VgJj7ByvF03rshcRzkw/DDmuND/H8zpYQ52MsjeP47nxyzYCH4/Bau
         wIs3wvndojr1vMBClVk94UCrV324Uc3iw3kXHzhnanpEuh7neuVspyG/RJLDug2ytmCs
         yIdADXxlwW21btT3RFsoS7RGLbb/ol8tivY9abm8Wyx34S8gZd6JQ48J1SIQWyKqpMyk
         gotnQ0bxmqnPZbkouIWb4FMA4CE6H006+9cC6TN5EKVfCCctQ507NLquiTRatfGAGQaw
         Wo3w==
X-Gm-Message-State: AOJu0YyW2arrfxIo8tll+NYUbHGK0ogDQA0a2HxAmgzzdorq2QQMo+eg
        7dM8fDYJqW1i/dbNVORQpR4zn6tm4yl2Q6TXE90zAMdjNh20XXMRRaQK8m6r6RZA1/ettnQal4N
        vD25TpQq9OSg0545QzGF/3EOZ
X-Received: by 2002:a05:620a:24c3:b0:76f:27af:2797 with SMTP id m3-20020a05620a24c300b0076f27af2797mr21315834qkn.0.1698924312385;
        Thu, 02 Nov 2023 04:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT5geDHIolp0aNPY1+MLsvDeWC3teHeCm8p/b1jYgutWDc0LnG9FJFSFJHpLLBT8Z59NWKDA==
X-Received: by 2002:a05:620a:24c3:b0:76f:27af:2797 with SMTP id m3-20020a05620a24c300b0076f27af2797mr21315813qkn.0.1698924311978;
        Thu, 02 Nov 2023 04:25:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a144700b0075ca4cd03d4sm2228731qkl.64.2023.11.02.04.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:25:11 -0700 (PDT)
Message-ID: <5a265e5541ab1de2258a6e61bd672ef5fb6be65f.camel@redhat.com>
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
From:   Paolo Abeni <pabeni@redhat.com>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Nov 2023 12:25:07 +0100
In-Reply-To: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-30 at 07:01 +0100, Bernd Edlinger wrote:
> otherwise the synopsys_id value may be read out wrong,
> because the GMAC_VERSION register might still be in reset
> state, for at least 1 us after the reset is de-asserted.
>=20
> Add a wait for 10 us before continuing to be on the safe side.

This looks like a bugfix: you should target explicitly the 'net' tree,
adding such tag into the subj. More importantly you should include a
suitable 'Fixes' tag.

Please send a new revision with the above changes. You can retain the
already collected reviewed tags.

Thanks,

Paolo

