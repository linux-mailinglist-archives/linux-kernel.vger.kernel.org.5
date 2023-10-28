Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE72E7DA802
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjJ1QSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1QSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:18:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55300E5;
        Sat, 28 Oct 2023 09:18:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc3be631edso1458205ad.1;
        Sat, 28 Oct 2023 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698509922; x=1699114722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQr/JKJ20NxDyi3ZLvQIALEY/brdZQ+S+sOOj2QS18c=;
        b=WM1y5H8x9d9qwiwoNSf5SKNv5LNHvqhruwwTX84NhgEfktmslMaKYSy8i9RXVudUGh
         nkPx8OlW7jyoXpSQJAKuTAPmfb9ELfOfgQG91SvtCsOyqEBeFVNgd1moT1o7yycEN0dv
         aYBD/yFQ6nsEcgtEWLa/Noh8gqvLQ6UDY9ceU6D1y+Se7adOJ7Zexw0iusNTqXch06OG
         ArWsE0y/babp45ashy3nQazaIBvOxo9dpFFsp0bYIOb2BrtfNVncyg5MqNvP3sS/fCUx
         9OUwkOa16icoYIOF2Te0GfjrZoKZZfU1tHHuX1DuWJ8GA2R3RcWvoZl1Q49EcP0bhjPT
         /KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698509922; x=1699114722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQr/JKJ20NxDyi3ZLvQIALEY/brdZQ+S+sOOj2QS18c=;
        b=ZgC1a6N4PwWhZ0MLAJluauls2z5+B3pQSd5CZ/H2+UwHTH1wYHEwdRCQ+wW4OqTpR7
         6LGLCvw51CdFzVsTxJylKgXnC4uXwwMFWYYdsnFRQCYPyTrP1u+PtmIHV0CHZvBNy5ms
         W8zr3NXwmlp/3B0wyCeVWh0eI+V4eK1oo5xthzzd79eNQMqa6Jh5QxDEYAtl8v5QqBOx
         ruTKml2qfFbV1CeA77BYd79FyRHMwV2QK+tppeN5gJoq1RuftxJmNqj0gQGNwrmVsF8K
         1aWbrFBmb0qPGiaI6+tyHHoju7Nyjqio/DbpCHGK6A5lpuJJVhtb/QpodiPNk19+Fxwy
         pbCw==
X-Gm-Message-State: AOJu0YwfJN7dKHo4kXFGnq8Jm0yK/jwVLW9s5Sm4CfMQNfQB5DuUuL0x
        VkT7x9mPOYZ84pgJf88WMsNktLn4/z8=
X-Google-Smtp-Source: AGHT+IFa3NdU3dWpCnrtNWAIk9N+RGjbZF0n2bFVsZdbkNj5f9Yw8NKeqLJhya2SlWziDL7lGZXJyQ==
X-Received: by 2002:a17:902:e0c5:b0:1c8:8f5f:b610 with SMTP id e5-20020a170902e0c500b001c88f5fb610mr4913848pla.13.1698509921714;
        Sat, 28 Oct 2023 09:18:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b001c7443d0890sm3375649pla.102.2023.10.28.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 09:18:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 Oct 2023 09:18:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] hwmon: ltc2991: add driver support
Message-ID: <075f6150-74f2-478e-9290-aa7186140cee@roeck-us.net>
References: <20231026103413.27800-1-antoniu.miclaus@analog.com>
 <20231026103413.27800-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026103413.27800-2-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:33:13PM +0300, Antoniu Miclaus wrote:
> Add support for LTC2991 Octal I2C Voltage, Current, and Temperature
> Monitor.
> 
> The LTC2991 is used to monitor system temperatures, voltages and
> currents. Through the I2C serial interface, the eight monitors can
> individually measure supply voltages and can be paired for
> differential measurements of current sense resistors or temperature
> sensing transistors. Additional measurements include internal
> temperature and internal VCC.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Applied. I do have one comment (see below) about code which
I would normally reject, but I am getting tired.

[ ... ]

> +
> +struct ltc2991_state {
> +	struct device		*dev;

It is completely pointless to have a reference to dev in struct
ltc2991_state because it is only used in the init function and
dereferenced six times there. It would have been much easier to
pass it as argument to that function. That would also have avoided
the wrong assumption or expectation that it is needed/used elsewhere.

Guenter
