Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4279B7ED71E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKOWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjKOWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:22:50 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839719B;
        Wed, 15 Nov 2023 14:22:47 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b3e13fc1f7so108748b6e.0;
        Wed, 15 Nov 2023 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700086966; x=1700691766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aI6R9aaYD107OtUapB5oOZMDCikpKBXLRbioJLRf0o=;
        b=e5eTu3gWNYpJJGRA7raynoBv1Iw4WGxFCxdaAfETwCyEPDsiPSNiufArfl0ng+FdWe
         DLMPDDLhgEdE3YW2HFg9FV1LYfQlU4aAJX4BaSciFILlXd/JQXZ/PLA1VeySKJlWrybt
         dPay+PsNgTrWuvE0j5QUinQXWiGyOoC27Whphha/b92zaEF2tbvrB2+Zgl/L/sM4BtTW
         JfSy9sZtm5qZATWAbS3JAsQTzMZpakIgvcb3rtt0gXKU7rtfK6dQlIkZ0syUfaFRuSZd
         OEkPH2d2YD5tRdR1ZuWJFDwSSjlld0FJVm5qWNPgktkMXXXfLi7blgRuTNq6ty/x5rRY
         EMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700086966; x=1700691766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aI6R9aaYD107OtUapB5oOZMDCikpKBXLRbioJLRf0o=;
        b=QrtyPCnEADj4wfUti2fNPUcvkDfb6zb93wl9koGXqerK/FLMS1eIimWSDxzz+k8l7/
         a7yK6E/eHqIAnvgbf44g0v7zKaCaQMLUlJMTXgzJDX6lrbRPZesTFH98fKsSxtpEJfaL
         cg/6vy3hXSercuNkYVkzoFGEXI0YeB7Y5XDli9pz1X5BFy9AdDETOvX0+NSjNCqAABO3
         WZZx5kH/ZxtVIlid5mFxZTsVYG8V5++TB03LQNsjfoFJ2NYwcuVknGEn1ZyN0EmozoBJ
         VZM5aVjjnwt7GfJm2KLJ/PWoUfEud1g56PEFTq9RPwXTs98PJOFnGZhswmuVic6EfnEL
         6XUA==
X-Gm-Message-State: AOJu0YyQ0GXAPW8Z9qL803uql+j/tpnzxW+9PmcAc8lIK2n5yFmpKTOZ
        pi+bFrRZHOqKM9EcDGP5UjR0M27efgo=
X-Google-Smtp-Source: AGHT+IFbDKt0KJHE3OrotFdhddTB0L5qxCOcVWTxS4UIoOAB8JuwemAqmCZcKjpoRCzdPqfQP7C/eA==
X-Received: by 2002:a54:478b:0:b0:3b6:a8cb:1ecb with SMTP id o11-20020a54478b000000b003b6a8cb1ecbmr15527165oic.40.1700086966644;
        Wed, 15 Nov 2023 14:22:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l22-20020a544516000000b003ae425fc9bdsm1610901oil.23.2023.11.15.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:22:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Nov 2023 14:22:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: max6650: Use i2c_get_match_data()
Message-ID: <1d2d6251-1301-4a15-b1ee-fe48a3f745c9@roeck-us.net>
References: <20231115205703.3730448-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115205703.3730448-1-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:57:00PM -0600, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() and
> i2c_match_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied.

Guenter
