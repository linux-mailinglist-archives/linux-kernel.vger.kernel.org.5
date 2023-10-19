Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D37CFF66
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjJSQWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjJSQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:22:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94150115;
        Thu, 19 Oct 2023 09:22:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso12899000a12.3;
        Thu, 19 Oct 2023 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697732556; x=1698337356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n5rOzh4NsVaOOSxKWGZFpGCW4lugWu7iKjVHUZWaVZk=;
        b=PErpdba+A12zyy1OOCJPqHb2lgbvpF9ceOuqrAl8eJfcj5yZLD+lF1zEM5SuoWpNJh
         mQVWGwMOkrRyAIGieEH5pdxc/X3mFJEOUB47a/o9v9otsvOHkhJREvcsRPirAMFXk0aS
         X8Z1VTOufxpJCs387ncRcYOWUVPHF1V1dBBTuqZLJ+rN6vV8k9ewe7EmBe1IevcVIZlE
         fQDT/+4eMdDZCnb+9ZvOIdoPhvtPoNVaXxiWwg1KEjpfuFyWYiAjiVGRTkxTV/NhgmC9
         iMgPNDJ9uKbMGW12HG/vpyr5ZGVtGyNSWharbqPSMLcMCCc7IMuDxYLjLcVI1wVK9tJU
         R9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732556; x=1698337356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5rOzh4NsVaOOSxKWGZFpGCW4lugWu7iKjVHUZWaVZk=;
        b=k9oOa3h1aOd8Ll67FqeZsTEwyZufZM++MIdYWLLGFqZ90/QHLxjDW8+Cj3o946GJ4L
         H8EcJ7Ou0pJmNFi7aXoCCenejy7Elj5ynB2zE1BquUbkDgCy1QQYYoXjOKwZ6lN81klg
         ijmTURTbbWe4qUxCeEjscmP5DsRdG8DHl5TpVrfZ1i4a4u2MEmrEzLzVnWojUT2pPi3B
         iEAp1rWGy1njHZ4hyEPPgXZKxP1bETjKgakjgZ9i3HPvc3RsATzaJr7LMo5kFRnXcd/U
         cU9OeRbt/dMpt+J6CnrcG9SJoMzGWrL4Ym43Qjau5jqSc/0g+CN/sY5sqmaAWWTlBGX0
         wBxw==
X-Gm-Message-State: AOJu0Yyw3egDPzM4Sxt3+jyaikvCDu+TbgRTWI0RtPZj11TZlFRGaps9
        FcmEffZ2pYz7wxzAXvsASkw=
X-Google-Smtp-Source: AGHT+IF6bsxSat5ywHjsBB78bIVfof4867geBLkvQA/W6QWXnRiK3ADP7C0r5cvn4SEdlnv0JBowyg==
X-Received: by 2002:a17:907:a46:b0:9ae:522e:8f78 with SMTP id be6-20020a1709070a4600b009ae522e8f78mr1796117ejc.74.1697732555873;
        Thu, 19 Oct 2023 09:22:35 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b009ade1a4f795sm3773323ejc.168.2023.10.19.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:22:35 -0700 (PDT)
Date:   Thu, 19 Oct 2023 19:22:32 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231019162232.5iykxtlcezekc2uz@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
 <20231019144021.ksymhjpvawv42vhj@skbuf>
 <20231019144935.3wrnqyipiq3vkxb7@skbuf>
 <20231019172649.784a60d4@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019172649.784a60d4@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:26:49PM +0200, Marek Behún wrote:
> Yes, unfortunately changing that node name will break booting.
> 
> Maybe we could add a comment into the DTS to describe this unfortunate
> state of things? :)

Well, the fact that Linus didn't notice means that there are insufficient
signals currently, so I guess a more explicit comment would help. Could
you prepare a patch?
