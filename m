Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5168E7DC32D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJ3Xdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjJ3Xdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:33:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E14C2;
        Mon, 30 Oct 2023 16:33:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-408425c7c10so39900355e9.0;
        Mon, 30 Oct 2023 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698708816; x=1699313616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYm41u7ayhqnUK+JOXZSmWC57AQCSUDe57Jp92vB994=;
        b=ShMnix/a5ByCpr8GpO+JzXAgVA4kgrSCewhJVqBC4rKz1ExVX1M8A8W7TSDgZr2e2P
         PANFAAX/F0HzY5sqjdvSB4OZ/kM9YF9MHhPG1X1tMh7G8yaclKGn1OQlHTPoewNZovmB
         MNEM2uKM5BEgKBwTphWzzIycPiUFzvdLWn6vBsVLn5wQXaSPcSEgjIYOMypF9tm9igG/
         /Yajpc6WGG+BEQt5ybDwnpPksqpgI5q9u7Imq7RREtX4/36rPui7eYgvpiohmDdhTb+I
         eVSbxymfwtBa+co0ZMaOEekSMGvkpDZryXixGs5RvhFbzCPKaeADiyFF4AqL4wYApZek
         92nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698708816; x=1699313616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYm41u7ayhqnUK+JOXZSmWC57AQCSUDe57Jp92vB994=;
        b=C3irSiGC0TD/oDUrZCKatECGQnpgFwjrq1wVZLA+ROJSQgg3p2RXOVKPrKbgdC46o+
         LzudyA2sTHKJdFSfoKpsHnNgILxpJIBWRD2wux2WLdyxtCSwbSgUlogYEcv82YXJUMaD
         zVd9v0yP/mAYuM5rFkigAM6D2kOeq2tYD1pMvhJcAFbMJsjLTIsllPd/9wbgK836zJv0
         bnAmI/WpKeIAc64cW+tlxgnC2txp5i8BromaYm5nUW7YhkRAsCLzfFPSnxJe9utGO5NE
         aE1d5NWTANh0zADnp3WHTIlUz1keKLsRI7gWuVrpHqOQUlpKKAM8nXOiVmUc14OZjkqz
         V1SA==
X-Gm-Message-State: AOJu0YykYkOgMS8hi/kpCiQnwZgAgg6NMC2z1vb+hS+vauacDxfyxVJO
        xe6akNf3YbjiFutGs3pcbGX8tJOhz4yfqA==
X-Google-Smtp-Source: AGHT+IEDx2dVwZ1t1/yIHxEQSJixAWuO6iqcNtDsXt5AMo8FXtAQWMsEuNtBVZWnqRilzygnlq6LWw==
X-Received: by 2002:a05:600c:468e:b0:3fe:e7b2:c97f with SMTP id p14-20020a05600c468e00b003fee7b2c97fmr8689466wmo.36.1698708816388;
        Mon, 30 Oct 2023 16:33:36 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a15-20020a056000050f00b00326dd5486dcsm104081wrf.107.2023.10.30.16.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 16:33:36 -0700 (PDT)
Date:   Tue, 31 Oct 2023 01:33:34 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231030233334.jcd5dnojruo57hfk@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> Here you can incidentally also see what happens if we don't pad the big packets:
> the packet gets truncated.

Are we sure we are debugging a switch problem? On how many platforms
with the RTL8366RB can the issue be seen? Is the conduit interface the
same on all these platforms, or is it different and that makes no
difference?
