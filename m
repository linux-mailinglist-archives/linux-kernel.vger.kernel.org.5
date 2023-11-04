Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FE7E0F6B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjKDMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:43:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EF1194;
        Sat,  4 Nov 2023 05:43:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f78dcf036so2413916f8f.0;
        Sat, 04 Nov 2023 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699101811; x=1699706611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxa4/ZweIex1VqKoqDmxE/9uSnxRKGCH7GKr2nKccwk=;
        b=UxXOuVzeJOgF63TIFoWE81NYOYTCd9g74/P7pafkcYuTwtnamKi/DqPoSy8yr7PsxL
         V8lEwt2mzUjZCMqIN1j33xlsNPV9VG8f05TYbjtTAYWLVHjABedAxeU83M8/bcvpWNNy
         cU6G2jj1e+oaDav+8LuFQ+VVqM5OplYFnuoXi50ULV8e/2Z5EVqj9Ghal0brZvpsAofw
         gweGMo4+APPxQszA+QhEMkzH3MVnS7Es+zR2N4AmzxxoZo5+T5lRUSWia/Cn6ZeS8gLq
         40SIVdo8VVUSCNluSrDMk8g7WaavudkhudBuKiqjXzAFBF2Stlb15+0LlIl7RF+n/yqk
         KVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101811; x=1699706611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxa4/ZweIex1VqKoqDmxE/9uSnxRKGCH7GKr2nKccwk=;
        b=WlyPWWtZ20VtzV9cS+SJ4M9Igu3WnGTpm7PNe0mGKt5amFMxs/thZjv62Wcrx9z8hH
         BFGrBeTGIO6vcexM1Ysilsya1puE+riFNTXP6w/GuLj6DNRZ+UeIJYSChUNSRQYqqyCv
         KGK4P/4768YxUdt5I6wmagshLQRF9ZZWtAfeJsI50jofbux5HT+Jemz/kj1ySfmnz8ti
         ZTYwXRc6v4bGmdrtMdy+n31FLgNbZvDENkf6ed1tCb1WVFRDtaYKPjYgdZv7QSvnY22Z
         M2358vUftfJLbhTMcqqxZNrgnVF3ElzJOmxBl+OS2u8BUf6lJc1tRUFlP5aLvM1mumqQ
         TBHw==
X-Gm-Message-State: AOJu0YzyUmwwHZL6/Uf45IHgVOQhQQewqEQdmnzRt9PJcW3esAdIuB35
        oUS54KF/Cook2GYfnLRoIlE=
X-Google-Smtp-Source: AGHT+IH/yamI+PoJkzgApPx4Yho+dNKf+oaTeV0SfNvwacQSU139yuLbtZ8VTZAZjEe/NIWMfqbFXw==
X-Received: by 2002:a05:6000:2c2:b0:32f:7a22:8b42 with SMTP id o2-20020a05600002c200b0032f7a228b42mr6260216wry.23.1699101810490;
        Sat, 04 Nov 2023 05:43:30 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:701:cd04:5842:2095])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003fefb94ccc9sm5831876wmq.11.2023.11.04.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:29 -0700 (PDT)
Date:   Sat, 4 Nov 2023 13:43:28 +0100
From:   Stefan Eichenberger <eichest@gmail.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>
Subject: Re: [PATCH] USB: xhci-plat: fix legacy PHY double inity
Message-ID: <ZUY8cGrofUtPOMV8@eichest-laptop>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103164323.14294-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 05:43:23PM +0100, Johan Hovold wrote:
> Commits 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") and
> 9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support") added support
> for looking up legacy PHYs from the sysdev devicetree node and
> initialising them.
> 
> This broke drivers such as dwc3 which manages PHYs themself as the PHYs
> would now be initialised twice, something which specifically can lead to
> resources being left enabled during suspend (e.g. with the
> usb_phy_generic PHY driver).
> 
> As the dwc3 driver uses driver-name matching for the xhci platform
> device, fix this by only looking up and initialising PHYs for devices
> that have been matched using OF.
> 
> Note that checking that the platform device has a devicetree node would
> currently be sufficient, but that could lead to subtle breakages in case
> anyone ever tries to reuse an ancestor's node.
> 
> Fixes: 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support")
> Fixes: 9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support")
> Cc: stable@vger.kernel.org      # 4.1
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Stanley Chang <stanley_chang@realtek.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Tested-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
