Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7C7ECDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjKOTir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjKOTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:38:45 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A693E9E;
        Wed, 15 Nov 2023 11:38:42 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2ea7cc821so16666b6e.1;
        Wed, 15 Nov 2023 11:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700077122; x=1700681922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFx0ekih11cOSCq3z7TR5VeZ62EcRixYTQFMUdafBX0=;
        b=lsY1/n01dSgimPQtPyjtgTEkbiAWKFwNdrGziHjaINQZJkL3A+FZoue3cjs6Uqmusc
         CWfnd/rapg8tnaoT2eyylGbYFsTLUWK7cElk5lyZvH9w9DRWmnkyAnAm5XBGv69tEaQM
         u/i8IZhDWjKCPIQR8sii7H3b3aK7A2qnBui9JLbfENJs7C97Yy+4IZKXkZbVrEpt5GNG
         FHRm4dgAC6mFQVBSUSnFJ+CFhS7h0i3vjX/Q3Zpv/OD1XEYiQtPGn4WOb0iy1l4IiyCl
         l29pBzq7am5A8+UYc3vl7CoDaxF0R41enPR470SgzbDjJ3QwThLo0/kTVoUknNe8czEB
         R8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700077122; x=1700681922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFx0ekih11cOSCq3z7TR5VeZ62EcRixYTQFMUdafBX0=;
        b=vdLUp4KdShmiFgW8ChFZWTq/zTZPnUBARLpYLAFwwA1/QVk4eSyr5zHpbpeNihWjp/
         HZTznPHTs9prMu9epeFSe8O7GOoCfeMayuu/ZUBn1Ym+JlmqkeckAlraIpapHeDMfRIX
         lb5p4Fk87yxclLVEHapxqromJcJiCEU88kivO1yCpOAxZ2VJtjgJ1eSUh0Gu15cfwibR
         U5DU9gZw7So2BfMfK9X5MMvI7xHDdaCYOI7DIaG575tULBGcGa1NCXq9wVCHlINBEMZm
         10bboEhEdnBHvFubnKHkQIRDFsDQG06Bd7heQ73vTRRssoxP5fmxHqwBb0mQhMzevIrB
         WdCw==
X-Gm-Message-State: AOJu0YzMVqDUZFxeuyUHD/X0nTtYmQ+/4/G7Xxqmega9ptJsGf9qIFHE
        xmCF6xjd83VCh8BLT7y66WjvEQAwQRE=
X-Google-Smtp-Source: AGHT+IE9lQnZB3PWooEWwKrWprNsROTgUn1GfyeuPLXbeFCz8a3jVbe/iz5qJ9CHEge/G/4XifpZLA==
X-Received: by 2002:a05:6870:4997:b0:1e9:fd9b:735 with SMTP id ho23-20020a056870499700b001e9fd9b0735mr17664766oab.56.1700077121736;
        Wed, 15 Nov 2023 11:38:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s23-20020ac85297000000b00419c39dd28fsm3744298qtn.20.2023.11.15.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 11:38:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Nov 2023 11:38:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     marius.cristea@microchip.com
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] adding support for Microchip PAC193X Power Monitor
Message-ID: <3679da4c-fd70-4d2f-adfe-23592290eb30@roeck-us.net>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115134453.6656-1-marius.cristea@microchip.com>
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

On Wed, Nov 15, 2023 at 03:44:51PM +0200, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> Adding support for Microchip PAC193X series of Power Monitor with
> Accumulator chip family. This driver covers the following part numbers:
>  - PAC1931, PAC1932, PAC1933 and PAC1934
> 
>   This device is at the boundary between IIO and HWMON (if you are
> looking just at the "shunt resistors, vsense, power, energy"). The
> device also has ADC internally that can measure voltages (up to 4
> channels) and also currents (up to 4 channels). The current is measured as
> voltage across the shunt_resistor.
> 
>   I have started with a simple driver (this one that is more appropriate to be a
> HWMON) and willing to add more functionality later (like data buffering that is quite
> important for example if someone wants to profile power consumption of the
> processor itself, or a peripheral device, or a battery, this kind of functionality
> was requested by our customers).
> 

I sdon't immediately see any typical hwmon properties such as limit registers
or alarms. The hwmon subsystem also doesn't support data buffering.
Given that, the iio implementation seems more appropriate to me.
Anyone using the chip for hardware monitoring can use the iio->hwmon bridge.

Thanks,
Guenter
