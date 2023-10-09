Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A67BEC53
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378640AbjJIVHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378679AbjJIVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:06:49 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE411D;
        Mon,  9 Oct 2023 14:06:38 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d81d09d883dso5411434276.0;
        Mon, 09 Oct 2023 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696885597; x=1697490397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITwY1+60N27SoGiBJsSRzVwQV1xQDhrN46gSRIvwyk0=;
        b=cecKdaEhQZdgWLH0h1gw8jjMdZTKFOOQdhOXJvXeLMu5NKEHqubWIKWP7PHFN5IZ9m
         SQ0o5oIy3h8/YFFDCZRnlS2fw+FlXnjNkqp0//OOe/E6rB/C5g7y2d1CvUECrrb62Zzy
         aY4rpKlA+Hr/HJMWwTDNM3ioqspFwEeDq1FXy9hQVfoNuKvQB/FE0EyYu0uAahssLV2f
         nFG/howmCj95f24H7+qeeM/XYu+mECPPB3Yv6TdnGEbth91o01h1e+T2BaOLxSsB2Odw
         UFO2ble9765RZ0ZG05QIqg8vTGctaop4OzKXyU3QJA7AY2fiHNcinDdpIgKeiYmwodpn
         kjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885597; x=1697490397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITwY1+60N27SoGiBJsSRzVwQV1xQDhrN46gSRIvwyk0=;
        b=TWaAtWc8AqbQZly2zJC+kVlQWZrrSPIu6aMcUMF58Z27ifykg9SkG8sdTRkWQ5hyZ1
         skPh5k1S33lMckaxhGgF3003bXwOKEmd/66xpPupOJd0sDy8FcETSErs+4r+ZdZYIa0N
         Azaqot2q5LGOdt706F1BX6erQB9T/fUfUIlpYPmO/NciiawvMl0CAI7mwifT3ehRqtL1
         imnSzP3sBDwtOaETpgd/AlbxJWKxbUHHYcrVCoQlmFLJi1coiMT/wEhmt93x14hjDHma
         FfbIO+lIqyAri2bQLaiT+ouQgOT4V3VBcFN4Mcy4beLrH/RJh9wolinIft8YzKNTH4cN
         yVKw==
X-Gm-Message-State: AOJu0Yx16u4mWykzRibXdYS3nLqgjrwGnUPTCVG050JdaIoEo9LW4TBz
        +67VAPiypdtrwcItJV0vM0GTLIjSXl8=
X-Google-Smtp-Source: AGHT+IFaJDaAGHtMEHwv5EejutsBIXGBLRDO0b20KC79WiR2pV97VjXxTZDwC96oGjOu9ujlIShedg==
X-Received: by 2002:a25:418a:0:b0:d7b:97e0:14ab with SMTP id o132-20020a25418a000000b00d7b97e014abmr14017865yba.57.1696885596942;
        Mon, 09 Oct 2023 14:06:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x8-20020a0ce0c8000000b00658266be23fsm4148838qvk.41.2023.10.09.14.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:06:36 -0700 (PDT)
Message-ID: <58832d45-9bd5-467d-9810-e7e209ad3fbc@gmail.com>
Date:   Mon, 9 Oct 2023 14:06:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 03/16] net: ethtool: Refactor identical
 get_ts_info implementations.
Content-Language: en-US
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-4-kory.maincent@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-4-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 08:51, Köry Maincent wrote:
> From: Richard Cochran <richardcochran@gmail.com>
> 
> The vlan, macvlan and the bonding drivers call their "real" device driver
> in order to report the time stamping capabilities.  Provide a core
> ethtool helper function to avoid copy/paste in the stack.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

With the unused variables spotted by the kbuild test robot fixed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

