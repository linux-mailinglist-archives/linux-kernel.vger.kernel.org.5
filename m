Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1441A7C7B98
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMC1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJMC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:27:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84800D8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:27:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d2b814912so580170a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697164061; x=1697768861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hzd1ftMQtB2BTCy0YmK46EH/0A56hMuJ7a7pVN/TrKs=;
        b=QjsGWQkDqh7XeOimt5zyJjEd94HQyoG6is2+nk1cAN8zf+4HpRZsQ5VhniDLgbEULE
         8577dWPvUCsyaeWahFMqgRwCauU6HBnTCKpp853yHFwVbFV/aZ+yR6sWX69SxO9R8HJW
         0HN60lNPJq/5ACEcF7mEcpzeCUFiFJoX3Q7Vi6tEisdaPYew73iJkccEBn6TTBPxgXl3
         DqmqYflIOQreHHBRjBOLSItjTznWDpeLHZQKzkcXuKF7ojAK+1SPrNxqE2paExIqfXa8
         idmNp5X0EmOtNA/wZxlctZG8a3v6UBGqRY1ymp9c54XnqRj9C9YMDusHVFOVbNXScFnY
         hP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164061; x=1697768861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hzd1ftMQtB2BTCy0YmK46EH/0A56hMuJ7a7pVN/TrKs=;
        b=X1lJZeL0/DSvSkK/jFr6noiY+b/16/XR1nKIjq57huyCM46MlU7U+snJF1kc71ACOk
         LbD5S+XX+uBVLVyqYiRWQFQCDCdkZ1/KEvcethss+0pdvwTCybVTXuCPZq7qIkQPd/B7
         7fJH7Cr0xHVYvQmq8Sb7XXtG6mA9TeRHMd5CZPaHZnvAZzKs4uj1KYcGlTFKEqZpqEne
         MO+xhUHcIjuqvPo8FHlHq2453/12J+zxtmOnkPWa0pYS8pK49WfynAa4cl0gP5/szcW6
         Ue/+EgJY1yoD42qXQzGtqGD9rSG2/a+3j+g0zazrnB0Di1zkvEW3drRoKDodntLWcglQ
         NaMw==
X-Gm-Message-State: AOJu0YxDIUDdL9r0YkNj7yl6tizDDKingUiamxuJUz+T70dm4ZAifP7s
        wddJwgLasuZ0yUHYyMsAZYyhHg==
X-Google-Smtp-Source: AGHT+IGoTN2C4roNtrSYRKYUnUYawQW/M1P5VhRIdVvftnv9XfoPjBlGSftc3z1ZNzMixxESHb0DkQ==
X-Received: by 2002:a17:90a:fb83:b0:27d:4129:ecd9 with SMTP id cp3-20020a17090afb8300b0027d4129ecd9mr2595pjb.26.1697164060876;
        Thu, 12 Oct 2023 19:27:40 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id gm14-20020a17090b100e00b0027d06ddc06bsm2490510pjb.33.2023.10.12.19.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 19:27:40 -0700 (PDT)
Date:   Thu, 12 Oct 2023 19:27:38 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231012192738.34ed1f19@hermes.local>
In-Reply-To: <20231012231029.tqz3e5dnlvbmcmja@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
        <20231011222026.4181654-1-florian.fainelli@broadcom.com>
        <20231011222026.4181654-2-florian.fainelli@broadcom.com>
        <20231011222026.4181654-2-florian.fainelli@broadcom.com>
        <20231012231029.tqz3e5dnlvbmcmja@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 02:10:29 +0300
Vladimir Oltean <olteanv@gmail.com> wrote:

> >  Secondly, it is possible to perform load balancing between CPU ports on a per
> >  packet basis, rather than statically assigning user ports to CPU ports.
> > -This can be achieved by placing the DSA masters under a LAG interface (bonding
> > +This can be achieved by placing the DSA conduits under a LAG interface (bonding
> >  or team). DSA monitors this operation and creates a mirror of this software LAG
> > -on the CPU ports facing the physical DSA masters that constitute the LAG slave
> > +on the CPU ports facing the physical DSA conduits that constitute the LAG user  
> 
> Replacing "LAG slave devices" with "LAG user devices" wasn't warranted,
> and it alters the meaning.

The term slave is not in the IEEE 802 standard.
Most other implementations use member instead of slave.
