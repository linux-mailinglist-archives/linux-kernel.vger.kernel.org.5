Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF57AB0DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjIVLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjIVLbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:31:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF3AC;
        Fri, 22 Sep 2023 04:31:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso3344572e87.1;
        Fri, 22 Sep 2023 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382300; x=1695987100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDWp5uiOwDwoGc4/Ybg3Oz+ADX7nwDhG7f/HnAB3i7M=;
        b=OwaeSkJnWHuDQ/Ayxlc8hTQ+cUH2a0b9mxuKqskUTMuY3lXoYiOa6eqzU7JDrBlZtV
         OI+mMUSQAmkqByZfzQMRnwZxIvl5hsRw5v2hlmc7GIEEOj4yhD1gFx3okv70+JQTbJte
         uI9UBtbO6WfvTIoFbe+12A0i8ABsdCsl5FK+dq+YaUjeQBFN7kCHrRev1ETTjryINGpN
         1+r5FqvWLQZMSGRmXRbUm0MFGRrasa0tYxk6DXXQgZUeWV2EQChvmu+d21UhcCTr6Md7
         6LmBBBkc/VUYcd0+smZid+Ex0iayyRNs3ctXBSmhVVL8CcRBw9i5hU7SrSkH1jVa7qd1
         HMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382300; x=1695987100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDWp5uiOwDwoGc4/Ybg3Oz+ADX7nwDhG7f/HnAB3i7M=;
        b=UGjd2cah2F44GARSnlNoKGio58AWWYxEdiCzQEvUYqkmqsqQFNSXOMYYA04KodNCEl
         duvnvYRUlDJhTe3XLLfuoOTxZKVpkh9SLW3blPDoKCxthAhMoiceBgNABcvRgAQddD5L
         QYtxTNYunBoRt239yb8WhpXJmze5z3FiNJwT3aGVO3nWIoIgNlmoX/lOs9Km5t1p2/fd
         IJsbgvmLFW7r+itr91TzJyQ/ILVbKLbvOFyEhswqDlytPCKo4hOtAC7hUc2MQSirF+H2
         oJcz0O0V9ggHRYzppCl8wzspJVGb6WNC4BWyJQdRp3cz7JGR6o71SVN0bVMeV5uzj0Aj
         Eu+A==
X-Gm-Message-State: AOJu0YwBexk3NGI/I3h+UfZwzb8QMOTA2AtkKlyQSFAmmtunxU+0Vs+M
        vo6Hj2sA+f+uyR6imTh3z90=
X-Google-Smtp-Source: AGHT+IH+Po4obqpRXpBKtY/vOBw8JlAG0X1n45dmY7bPGn0wadoIcozZVmPT1J/z6KSYak5aQQ08IA==
X-Received: by 2002:a05:6512:2013:b0:502:ffdf:b098 with SMTP id a19-20020a056512201300b00502ffdfb098mr6495626lfb.6.1695382299590;
        Fri, 22 Sep 2023 04:31:39 -0700 (PDT)
Received: from skbuf ([188.25.255.147])
        by smtp.gmail.com with ESMTPSA id d13-20020a50fb0d000000b0052567e6586bsm2188130edq.38.2023.09.22.04.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:31:39 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:31:36 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20230922113136.jgfo2waalz2pya6b@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230921192308.kntudhbwc4j4skza@skbuf>
 <20230922131838.4bab19e7@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922131838.4bab19e7@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 01:18:38PM +0200, Lukasz Majewski wrote:
> By mistake my net-next repo was pointing to:
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 
> Please correct me if I'm wrong but it looks like the net repo for
> current mainline fixes...

Yes, net.git is for fixes to the current mainline branch, and net-next
is for new features to be included in mainline during the next merge window.
They are the same at the beginning of the development cycle and then
they start to diverge.

> However, after fetching net-next - I can apply v5 without issues on top
> of it.
> 
> SHA1: 5a1b322cb0b7d0d33a2d13462294dc0f46911172
> "Merge branch 'mlxsw-multicast'"
> 
> https://source.denx.de/linux/linux-ksz9477/-/commits/net-next-ksz-HSR-devel-v5?ref_type=heads
> Linux version from `uname -a`: 6.6.0-rc2+
> 
> However, it looks like I would need to prepare v6 anyway...

I don't know. "git rebase" is a bit smarter than "git am" and can
automatically resolve some conflicts, on which "git am" will simply bail
out if even the context is not identical. Either way, both patchwork and
me failed to apply your v5 series on net-next, and the patches won't be
accepted without build testing.
