Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6E7F54EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjKVXnK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 18:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKVXnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:43:07 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF09199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:43:04 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b2e4107f47so245038b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700696583; x=1701301383;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYvKtH0uC1Xw+emGBJHmqRIg3ESjCNY6W647Zk5nRmU=;
        b=wiKIDunUuJJAVDK5XVsgqpzFRcJx8raQU0mUWyZlBwD/D395Rvm/kY3qiseDed9LWj
         dFg1viF/NVBxhhjtKP7S5l+6cm/drBPJavIVnhI+2PViGi4M2T7beCMQuNDiE1mTDzYZ
         lj7EXlNwGbWOApX0GIKobH4dQvQTjl6n8drstXhjFzn0apDyPAlWY0IA0cMAI4xSrIxK
         JV/Ww6tsBGjec8AKvTbYMxPM626pg9xNz4KUYQ/MgDiMFu7D3gySsDuiF3JMutizm4A7
         VLJKuTLK1WV7Svs8Vkb5MqTJt78iLkBITNSvswQRLV23biecVW6w5JjYrProrYyru1O8
         ofjQ==
X-Gm-Message-State: AOJu0YxB2hZTop/U3prtzFxZCAIu6HjP7DhigFK2+fsIBQqngpqV26/P
        GcfV2NDln+JjuZH+eaBtly55kTq41FOatIwMY1IuGw==
X-Google-Smtp-Source: AGHT+IFB3fqlojOjhH+0cBIGDS2/UI/yhNL9SP/079Zuyp5ruQ//yt4GEIYrBmTBUBkVuIaRfwE67A==
X-Received: by 2002:a05:6808:1514:b0:3a6:fbe3:45cf with SMTP id u20-20020a056808151400b003a6fbe345cfmr4863766oiw.35.1700696582784;
        Wed, 22 Nov 2023 15:43:02 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id cm12-20020a056a020a0c00b0058c1383fa8bsm62497pgb.0.2023.11.22.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:43:02 -0800 (PST)
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
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 2/7] usb: cdns3-ti: remove runtime PM
In-Reply-To: <20231120-j7200-usb-suspend-v2-2-038c7e4a3df4@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
 <20231120-j7200-usb-suspend-v2-2-038c7e4a3df4@bootlin.com>
Date:   Wed, 22 Nov 2023 15:42:56 -0800
Message-ID: <7hsf4xe4n3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Théo Lebrun <theo.lebrun@bootlin.com> writes:

> The driver does not use RPM. It enables it & gets a reference at probe.
> It then undoes that on probe error or at remove.

...which is a fairly standard thing to do for a rudimentary runtime PM
support on platforms that use power domains.

This will likely (almost surely) break other platforms.

Without a runtime PM get call, the power domain that this device is in
could be powered off without this driver ever knowing about it, causing
a crash as soon as the driver is used after the domain is turned off.

Kevin
