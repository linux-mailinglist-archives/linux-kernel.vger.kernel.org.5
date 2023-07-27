Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E93765521
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjG0NeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjG0NeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:34:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5086F2738;
        Thu, 27 Jul 2023 06:34:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f64817809so124480a12.1;
        Thu, 27 Jul 2023 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690464856; x=1691069656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QMI/vlzpJV7j3wA/LmKMP2eizxiAkesVF2nfD4pPBU=;
        b=Q5wLfe12VdIzPDpblQpZ7UyATf3DQ9s2gq7j5911KRQGlip8vaOO/waDiUjVLQGgJ8
         jVR9jkDwdbHCMYvX8KBIpkB40pcdhb7/Twka0oUJAMeepHNg5ELkCBi/+Z6aHfNgLh0I
         wZ/feFkXBJPN/Vo7vhQp4qhcSCTxMf0COOSOYlP3kL6YnQJ20xcVX3geFuBFGin4aNpr
         UhVjWm7B8CcIphHBV+IcJ94yo6NR4lhifzLOFbkiOrYaiBdftFpJ0Vwrwz/05OHqy61p
         zPtRnDqsLz0U1J9o915kxDJNe20qKre2eYBi0DDAIb5jSwG9zONnt54ouiABWxZ0gbUT
         C+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464856; x=1691069656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QMI/vlzpJV7j3wA/LmKMP2eizxiAkesVF2nfD4pPBU=;
        b=bNFK7BfjCEaiT0dLdwrk5Wb5zduCMcIk50plImpKLDdeKJhGOcZeHUDZqnC2mdrSih
         R7T4LqRPvzPuDJIWICU/5rLxKcIBKcugfM5NuWvAb1UadYeu3AvAtb5sudM9ASlR2Qw1
         pT/gYbHZ4heeOcgRuwWizqVMPoQ7ScdqgfvveyVJN7A/5ImO0IAwoEm/RAudd2512C8k
         hCboJS2fEv+1L4+w0HyKOahyes6GHP+CO/3MhZ3OEmSQgGN1It+YOzqrDuIaXFRqFekX
         E6IMWkEQZb88f2glFLIDV+NxmKLqPpY0b7X5dUgIfki3G3Lxi8viiTApn24AgsX+/5qx
         WLEQ==
X-Gm-Message-State: ABy/qLb2FmHT4F/rDLaB3fn7p+PyqmW65eI8L8JxTawuY+rIjYaqLmwZ
        XjEU6Sllg5fD7cwKnyZcFNo=
X-Google-Smtp-Source: APBJJlFbgEPhyuFnR/27BrDvGPU1qazB9QgORyU0BBYwxq9b2uyVmNVw0ZDY26pO/YAIM1sIZEoB2g==
X-Received: by 2002:a17:902:d2c8:b0:1bb:ac37:384b with SMTP id n8-20020a170902d2c800b001bbac37384bmr6472527plc.6.1690464855668;
        Thu, 27 Jul 2023 06:34:15 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b9cdf11764sm1637276plf.31.2023.07.27.06.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:34:15 -0700 (PDT)
Date:   Thu, 27 Jul 2023 06:34:12 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZMJyVLy4NnBMUI55@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <ZMFfI3xU5pkJW4x4@hoboy.vegasvil.org>
 <06859eed-6f9b-5d66-3221-e55dcd83466c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06859eed-6f9b-5d66-3221-e55dcd83466c@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:42:52AM +0200, Johannes Zink wrote:

> good catch, I think adding the register definition won't hurt, but if you
> feel more comfortable about it I can add them only for IP core version 5.

Adding the offsets in the header is not the issue.

The issue is reading from these offsets when there is nothing there to
read!

Thanks,
Richard
