Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080CC7A02B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjINLeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjINLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:34:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4222F1BE8;
        Thu, 14 Sep 2023 04:34:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a645e54806so112349966b.0;
        Thu, 14 Sep 2023 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691253; x=1695296053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jU+/vaAdL7V/15DsnYyd/r36ogvO2f5D0t3bVwa4MJk=;
        b=WLyY/N+NNp12zIvUt6tdOoRyQZEBJ8KNlze+Zk+9UqOemukMRiU15W34ztTGlViWo2
         cH++bB+7ehWycESTDX2/fsbR1hqGEaRoulkLnBOH7hdV/IEKRopnxzfpKakjydhNGoPk
         E/xQHIpdrJ7mJy1+ZaziUenPAEpO3rwzhgXdyWcbvuumj3gjep1dtscREaJZZeIUPEnt
         SeyE6ba3CAe6BpJ7jrCU8WJ1TCqa6cHSgZc6GX70vvsv8y1GEhSXYNaagF/uMIYu+l1M
         /+U7KdR/K+prBay/uOZBpXfUVpMwO17bFZEXN1y8OFfmU2/qoCvO9PCQ8S8v+E+bjwpL
         CQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691253; x=1695296053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU+/vaAdL7V/15DsnYyd/r36ogvO2f5D0t3bVwa4MJk=;
        b=gVto1JK6dP8pVr2gtd3DkhOSXfsNgrjSncoIF3cZH8f9y48ZwkS20fW5ac7tSBP+oD
         EO0l1vLCBiynPYGT40RJuk/EG6cK1ZmEozgmrZCuAlUMp6LOQgLHuDD7YgG9IUB0MNZ3
         Ircs2+LlnwA7RMtqHy+92z5yqH3KenuHjrJ5rpgeq7E2o0UuPZWJCujwoMqN3w3GB3Qh
         eBtlMN+3MjpO7M9WR6rviubL3JPNBYJku5CVyvCSawPl2/VRBiEUMWm2hBjfE6QF7gVF
         ptbVshdc7wb8cJbuG4grosPRBi3CYywyJ24sKRl9A2IvZYxIYdQmEFDATvDY29ly32ck
         6CSA==
X-Gm-Message-State: AOJu0YzyMQqGC59Q6gWZhtv1xWMyIMsmFcUdSnezqf3fBuF5bXzXxIhy
        RGRiaLH/rIbOor91e+7MAsg=
X-Google-Smtp-Source: AGHT+IEo2AN2heLwgqGobes+LwHh4vQg7d6lEXZZ//jBa7GDaS6HTdnNur4ZpEDoKCiop9ZRT8vM3A==
X-Received: by 2002:a17:906:31d9:b0:9a2:232f:6f85 with SMTP id f25-20020a17090631d900b009a2232f6f85mr4323483ejf.52.1694691253255;
        Thu, 14 Sep 2023 04:34:13 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id rp15-20020a170906d96f00b009a1b857e3a5sm882096ejb.54.2023.09.14.04.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:34:12 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:34:10 +0300
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
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] net: dsa: microchip: Add drive strength
 configuration
Message-ID: <20230914113410.7trf2267r4eijuim@skbuf>
References: <20230914075107.2239886-1-o.rempel@pengutronix.de>
 <20230914075107.2239886-1-o.rempel@pengutronix.de>
 <20230914075107.2239886-3-o.rempel@pengutronix.de>
 <20230914075107.2239886-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914075107.2239886-3-o.rempel@pengutronix.de>
 <20230914075107.2239886-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:51:07AM +0200, Oleksij Rempel wrote:
> Add device tree based drive strength configuration support. It is needed to
> pass EMI validation on our hardware.
> 
> Configuration values are based on the vendor's reference driver.
> 
> Tested on KSZ9563R.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
