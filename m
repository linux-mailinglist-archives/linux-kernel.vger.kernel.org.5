Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10367F54EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjKVXoc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 18:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjKVXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:44:31 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C875DB2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:44:27 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso313591a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700696667; x=1701301467;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P0J5SttnkgeWXDvl05+wv/ksdIcmVI4zrsH7P/axnE=;
        b=jtNKVty7dyb2ddpFbehk6w0gu382gqdj0urqHEewohiByI/IihFUnmZJ+aEIY7uLjF
         MSHC+yazydUE4h4jpt/YnAbhs4PKMMsotyOVpXQ6yWcQ17zfXAYMbEp2PS61WJLVxO1z
         v940QRZnDXsIoM98eDxbOX0eXxR1f//5TYG480NbwbDhGZMlT7Op2K/MwB0A2Y46+TKp
         i6psl3OS3Yec8LmmVTi7oxq9phelmr8RJOjwhXzyMYrrp17njLTS2b69Z5RBWyF+1uYZ
         2Z1Zpuc2nzEKcVpvWJ8N704Olx+aD4qHCvvTGLe9j2irFlokejwwJumivYfGIfRwI2pl
         56/g==
X-Gm-Message-State: AOJu0Yz8/2zrkWGPDEdCWB+y6q577V0PomL20wkhMM1w8N56nzOenBbA
        v0OBEO1SyAz2qGzHSpiICccV4Q==
X-Google-Smtp-Source: AGHT+IEp+LZXXxf+QQTkTKPl8I5OZqH8VCX7huviDwbnywfNsNaCjTIJJEtqg/msu4rAk83G4GLD2A==
X-Received: by 2002:a17:90b:1c12:b0:285:657b:f17a with SMTP id oc18-20020a17090b1c1200b00285657bf17amr34930pjb.15.1700696667275;
        Wed, 22 Nov 2023 15:44:27 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001c59f23a3fesm235520plt.251.2023.11.22.15.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:44:26 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/7] usb: cdns: fix suspend on J7200 by assuming
 reset-on-resume
In-Reply-To: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
Date:   Wed, 22 Nov 2023 15:44:22 -0800
Message-ID: <7ho7fle4kp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Théo Lebrun <theo.lebrun@bootlin.com> writes:

> Hi,
>
> Suspend on the TI J7200 platform is broken currently. There are two
> components that need to be patched so that they assume reset on
> resume: (1) the TI wrapper cdns3-ti & (2) the HOST role of the
> controller.
>
> About (1): the TI wrapper only did its hardware configuration at probe
> time. Update so that it is done at resume on J7200 SoC.
>
> About (2): signal from cdns3-ti to cdns3 host to xHCI that the
> controller resets on resume. This way we avoid the following warning:
>
>    xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit
>
> Strictly speaking (2) is not required to have working suspend on J7200;
> its only goal is to silence this warning.
>
> Those patches have been tested on the TI J7200 EVM GP. No need to
> mention that other patches are required for S2R to work, but those will
> be sent later down the road. Those USB patches are rather standalone.
>
> Thanks,
> Théo
>
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
> Changes in v2:
> - Remove runtime PM from cdns3-ti; it brings nothing. That means our
>   cdns3-ti suspend/resume patch is simpler; there is no need to handle
>   runtime PM at suspend/resume.

Sorry I sent comments on v2 before I noticed v3 was out, but this is not
a good idea IMO.  I sent more detailed comment on that specific patch.

Kevin
