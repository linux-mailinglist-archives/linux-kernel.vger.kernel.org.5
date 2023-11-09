Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B47E68BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjKIKuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjKIKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:50:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380211B1;
        Thu,  9 Nov 2023 02:50:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32daeed7771so384904f8f.3;
        Thu, 09 Nov 2023 02:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699527040; x=1700131840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6XHp8ZxUUWF+Lmmh8ZFzScZepwpVrVtTeNoN9NNTn4=;
        b=J7bWnqWWodhW18eG9uO7GWQBybW0XWuhR0Td94F2eeq3fpTH/tVgVHiNamInYb2pLT
         u7Yag/qNva5/yAyvNYw8KS99rtkuDKvZeusZDXoZ+ulHL1eGU4TvoLFLiWIN1mbew8Hw
         HEUWksAVCW91fGPKMGvIKWIuXtAcHE3DguCjieWYqX7inAEoUl1XX1vQ/k2+HX3qm6+Z
         q4JZurC7lb860m4HfUt6Hp7RcRoq7FMsOgu5J/2h/26YIANeBI8m39BIfsBVHndXNmAO
         U1dse3045evg26Pel6ODs8DwjAyrkjhVWs/qA3TyZKur8gdJCYi25dmF9xu+daAkV6Mc
         uZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527040; x=1700131840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6XHp8ZxUUWF+Lmmh8ZFzScZepwpVrVtTeNoN9NNTn4=;
        b=AYDRfXo4XBs5uMnIVT8JxJGK9fLHRMps3RMShG4dp5qMjo/ujztf4Pnkw4m1ou3VaL
         7M2r4H5j+NIQ+a8yehrBlVVpsBDSSbBC1uBXvbelM3NOk+JVIVANKuIsXU6komLaZOqZ
         X/43kapdneiZu5QEEdj0naR34cIqDqwbJ0VrfNsuhy1s0Kvx0YE6mi+A77W9LNs0UxVC
         /KjxzS1yecdA2LeUod1xVTCNbqEWGSzQJtlJu4GVkbzLsbBK9g3HPTw1AvDm5LK1UxJK
         Kf2YC5d1YrC0n7t2oIZgQqBJs3Yfzv0zBeeV8SIOUtdnHEZsbJVzR/GgpmiVgwIZMCFL
         zIdA==
X-Gm-Message-State: AOJu0Yzv+3AxqE4BMJQvxwqup0/Lw+9IO9Ubi9oGwzHO8YbGYA+/1d8e
        Ua8bwPH87wfTR1FfjDtanp0=
X-Google-Smtp-Source: AGHT+IHkTzzHCRer28VEszakWXegQq7fkpcKQVYrtPkskdHGdqFchpM3qgS6wDDvnF2Oa4VQcpPgqQ==
X-Received: by 2002:a05:6000:188b:b0:32f:89e5:ef60 with SMTP id a11-20020a056000188b00b0032f89e5ef60mr3501570wri.11.1699527040321;
        Thu, 09 Nov 2023 02:50:40 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6607000000b0032db1d741a6sm7079646wru.99.2023.11.09.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:50:40 -0800 (PST)
Date:   Thu, 9 Nov 2023 12:50:37 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet driver
Message-ID: <20231109105037.zppxrr3bptd7a7i6@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:03:11AM +0100, Linus Walleij wrote:
> This is the result of a bug hunt for a problem with the
> RTL8366RB DSA switch leading me wrong all over the place.
> 
> I am indebted to Vladimir Oltean who as usual pointed
> out where the real problem was, many thanks!
> 
> Tryig to actually use big ("jumbo") frames on this
> hardware uncovered the real bugs. Then I tested it on
> the DSA switch and it indeed fixes the issue.
> 
> To make sure it also works fine with big frames on
> non-DSA devices I also copied a large video file over
> scp to a device with maximum frame size, the data
> was transported in large TCP packets ending up in
> 0x7ff sized frames using software checksumming at
> ~2.0 MB/s.
> 
> If I set down the MTU to the standard 1500 bytes so
> that hardware checksumming is used, the scp transfer
> of the same file was slightly lower, ~1.8-1.9 MB/s.
> 
> Despite this not being the best test it shows that
> we can now stress the hardware with large frames
> and that software checksum works fine.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks for being persistent with this! I hope we didn't miss today's
"net" pull request :)
