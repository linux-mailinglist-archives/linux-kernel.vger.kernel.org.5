Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379907F9D61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjK0KZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjK0KZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E23E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701080736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZA1nFhs0OclwFV+JNDde8LIxfs9r7hNs3Xy7sP4jpzY=;
        b=I0yAW7Gkn+F2IMOGcjxLfakuvYd9koZWiHK3UoLVte+rtUv9OPZCldWQ8z7c04n9+6TRDH
        H/oBhIeVdT3HB/us5XQ8N7OenJbNaK+kucI0Ve70C2x70i35VqLTzrr/6GObMd9UiY9TFY
        nJ3p6QH1SuairVR1MxmxXFqrdS/8ScQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-yGMCxpESPcmviUeCo4mrAw-1; Mon, 27 Nov 2023 05:25:33 -0500
X-MC-Unique: yGMCxpESPcmviUeCo4mrAw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a043b44aec3so83297666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701080732; x=1701685532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZA1nFhs0OclwFV+JNDde8LIxfs9r7hNs3Xy7sP4jpzY=;
        b=GgGkYi9538loxBZFCIv5LSg8XE1jZ1h8IzHwGV2IT2UxjoEa/7g06p3FnvY7TwibJy
         YOuO55aHgfYLVKN6obaLi3jbJBuNuyqPy0NGQ8/sWRnVVj1ZzO/jHbQ2E5IwW8AtI4eK
         T3GkhoJB/lP1p2rek+41kOu1enE6y4evIdfuUwu4gx6057Z9xRAwk0KGoFMYw7WBzIRL
         QolCIO1Ym8+xb7hreoHL5aIPSAVe8TAu2DbDjypeCnrpRSLy8iPh2wb1Qj2L7bXPTxSU
         nNq5epQx41sCWvc/zFy7faYlf1bHCgO/SHH3SmC3/vT+LenBcFH/X2x4tL/WUDnFZqze
         PBjQ==
X-Gm-Message-State: AOJu0YwuA86vKEfVqK8ytT3zLAkKgbYDl5cb7UEMtMuq+C2R0uNiFZdP
        xWeTSyWOB4ZWI399ULBCm8wUeHzhd9fP9glQUwVlGstEDY1Q3TTY61c9M3mWkyO6yBlshmTeGij
        ZGfUKNUlzbp2rInN6us89gBju3b1uWx7o
X-Received: by 2002:a17:906:5a8f:b0:a00:1acf:6fd2 with SMTP id l15-20020a1709065a8f00b00a001acf6fd2mr6782651ejq.6.1701080732573;
        Mon, 27 Nov 2023 02:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeKcndtCLYR26j5o6+zmpQ6DyJAi6+l0R/Qa4rCze0PYyzY5W87VbdL2kbGHS3jOSujk9NTQ==
X-Received: by 2002:a17:906:5a8f:b0:a00:1acf:6fd2 with SMTP id l15-20020a1709065a8f00b00a001acf6fd2mr6782643ejq.6.1701080732204;
        Mon, 27 Nov 2023 02:25:32 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5430486eje.81.2023.11.27.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:25:31 -0800 (PST)
Message-ID: <f5a633a8fb4fa0d4375d90e7c3797b016f494711.camel@redhat.com>
Subject: Re: [PATCH] net: make config lines follow common pattern
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Nov 2023 11:25:30 +0100
In-Reply-To: <20231123111256.10757-1-lukas.bulwahn@gmail.com>
References: <20231123111256.10757-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-23 at 12:12 +0100, Lukas Bulwahn wrote:
> The Kconfig parser is quite relaxed when parsing config definition lines.
> However, there are just a few config definition lines that do not follow
> the common regular expression 'config [0-9A-Z]', i.e., there are only a f=
ew
> cases where config is not followed by exactly one whitespace.
>=20
> To simplify life for kernel developers that use basic regular expressions
> to find and extract kernel configs, make all config lines follow this
> common pattern.
>=20
> No functional change, just helpful stylistic clean-up.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

IMHO this is a bit too much noise for a small gain: simple REs can
match all the existing patterns with 100% accuracy.

I think this should be dropped.

Cheers,

Paolo

