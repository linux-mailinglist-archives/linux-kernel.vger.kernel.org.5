Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E07A2122
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjIOOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjIOOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:35:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C91AC;
        Fri, 15 Sep 2023 07:35:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso297039766b.2;
        Fri, 15 Sep 2023 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694788537; x=1695393337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5b78G1Xe/uMbbRctSNTpM0K2JqIF7YMEFr4py30NLE=;
        b=HWxGzrJStLkjqprmbesLMwZHt2KgWITMMlVYsCUYqLcjNZQXNSH5bvEYeeG0kWYX3L
         auMoieZp1kTmPj3NDPQjB0gwBHg7AL6z6V6vKXIKjcKW1b5Sk6Ij4u58Xlzi2+ffGCZy
         Ru6nt/Djge5YekPGxgB1p/dD269JhKysMbY6QiNcPVara850Mte7ejlufyLqi2CaAFwc
         csJkwvRd1GjKEzbjbUkV6K8b3Z+8sE3Q6O3vjWeZOCp7lY8rAedUhXqJOg7RlcYoI9/i
         8OATMBT8q3VZPTu6UToSDC/vSylAuU/bFrDd1Yy6s1/V8LXkhrlY4M6daNNljuYUgJbW
         jUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788537; x=1695393337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5b78G1Xe/uMbbRctSNTpM0K2JqIF7YMEFr4py30NLE=;
        b=YkVc1P1ghCa+boRDAm7cEtFip4LIs/nAGYlIM91DVHkzo8o+OCvh1P6AVv8OKNOQDV
         9ukKzN+0UgUbhfIkIzwmk9VJwnP1emoC/omjzvJm2GWSapbt9ZiyqkrPR4A+bjxze+rW
         9qbm65RPtjV7CQGOdJ/3gpsLTWbIe35UFrRHvLxcNSUn2hImx61YSHXrNK3bfDYetku+
         sJ26UeXJ/imVn2IShShkZCOyMK+eci0kip6hxJlWbgtQSb2YE+UXEC1u4RSlJmG/FBnF
         nbuuFovb1hvsZe0zecSdKEcYSNd8pia0JBd90o4YlEts8fRUqtrOfxVtMGzyLOrihxyr
         Af/Q==
X-Gm-Message-State: AOJu0YxPJAu1E0usK4uf2EP7zahmkyzd17m352r3XCzJ/tjKlsyTxAum
        Z8vR9lF8s1yg2FwYGhYDYLo=
X-Google-Smtp-Source: AGHT+IHytT7TY6J2KcsVUkzYbrU3p/H/odEN/sgR1tTx2/e5kV95KT0xFxKFjrWPLpdywweLHcKAcQ==
X-Received: by 2002:a17:906:150:b0:9a5:cab0:b061 with SMTP id 16-20020a170906015000b009a5cab0b061mr1613521ejh.51.1694788537224;
        Fri, 15 Sep 2023 07:35:37 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id kg11-20020a17090776eb00b009a1a653770bsm2531814ejc.87.2023.09.15.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:35:36 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:35:34 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: Move *_port_setup code
 to dsa_switch_ops::port_setup()
Message-ID: <20230915143534.upiemn6ytjhmcot7@skbuf>
References: <20230914131145.23336-1-o.rempel@pengutronix.de>
 <20230914131145.23336-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914131145.23336-1-o.rempel@pengutronix.de>
 <20230914131145.23336-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:11:44PM +0200, Oleksij Rempel wrote:
> Right now, the *_port_setup code is in dsa_switch_ops::port_enable(),
> which is not the best place for it. This patch moves it to a more
> suitable place, dsa_switch_ops::port_setup(), to match the function's
> purpose and name.
> 
> This patch is a preparation for coming ACL support patch.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
