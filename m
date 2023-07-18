Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A581D75724C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGRDaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGRD3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:29:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9419A0;
        Mon, 17 Jul 2023 20:28:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8c364ad3bso10724075ad.1;
        Mon, 17 Jul 2023 20:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689650903; x=1692242903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=psBP24l7zlb5k0jEystqFOMehQF8hRtk/uG9lxnBgBQ=;
        b=XAnXgt3B8RD4u5xrk0zG82Hk6LEKPGGoCqISAfbI3dK7ctg+m1DWgYz8wr+dQ/0NoT
         3nWtB0t2DKCjlzg0k/7dgSHTl7P87e1kS3urOv2FJbGkV29mzOuU6Aj/EkH6il341UXH
         ICQjR1048trzcyXPuGSk/exPUAiVj2EEd84rfavYsai5maJ0fYdjq46R0KBuLAWddwO1
         ik6ERx3hJMlLpLDbZpQ0o8kd2OqIKNjVMTEdFPPS4KnK82hNIJx40XBH6z7lmafkCZn/
         iOcwQSLkpfi1IeTUzpMyEdf5Kh3OgOLhw/QJqifwaWEq+OLCkrxzRQ9djIef0CFToahi
         SSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650903; x=1692242903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psBP24l7zlb5k0jEystqFOMehQF8hRtk/uG9lxnBgBQ=;
        b=WjK1A8Ae2o4hcTtZXdVJwfMcgzDp+e3G84fJf9KlBwWe5n+wX6Nxjxa5SPwtWzrrAh
         JxFEuPTvztEOFBDbjB/Vwd+rGzMjDQ2pFOoa81paPTU4VzA6+q7retYAzSvJucwbyd3O
         EaSsYdY3ppXqwJFLBM7bvfEZR9CYB8G/+8NjiTi51/gKM3Mnbo+bfLkXwKt7dCI/59TY
         w4bfFUOeChYBoI5+CkmOgXn72cSoii7/6DN/P9iBBU5F7B3e7lwx4QNiet3efGxzzyIL
         TqB3Nbe37tZO1ksSs+rkqcJxSIoD2KrIHkleGdanYJfcoDDTvSs/sarxMq62BUCvCXzM
         krxQ==
X-Gm-Message-State: ABy/qLZzLc2lU+FDVPYNxZcjdE9JXrEyHZLpED3bZ2f7lkELpzjkdl4E
        IKRI/BOGjKr0k+HREYIi9Es=
X-Google-Smtp-Source: APBJJlH/LxAG9wfB0qXauFE3c0hRH9osU27co+0/TEO32WfnGe5PDqNa0thcqtzx8qKYTAxTvWG0Iw==
X-Received: by 2002:a17:902:e883:b0:1b8:1591:9f81 with SMTP id w3-20020a170902e88300b001b815919f81mr9634860plg.4.1689650902887;
        Mon, 17 Jul 2023 20:28:22 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b001b9e9edbf43sm601461pls.171.2023.07.17.20.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:28:22 -0700 (PDT)
Date:   Mon, 17 Jul 2023 20:28:13 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Max Georgiev <glipus@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <ZLYGzUQRyjE689tW@hoboy.vegasvil.org>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <CAP5jrPFbt7vc77wVi5buYM88gDQ-OCHzm3Hg=EzRxJiha7Ur5A@mail.gmail.com>
 <20230717112534.nhy7ldeer42r4rz3@skbuf>
 <5f8da155-736e-cdd8-35bf-0f68385c6117@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8da155-736e-cdd8-35bf-0f68385c6117@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:23:02PM -0700, Jacob Keller wrote:

> For a mock device thats not really an issue. However, I'd prefer to
> avoid such in the kernel so that its not available for copying when
> someone without such knowledge comes along to write a new driver.

+1
