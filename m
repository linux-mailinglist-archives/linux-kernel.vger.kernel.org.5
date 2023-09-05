Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3A7929DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353941AbjIEQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354718AbjIENsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:48:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF29191;
        Tue,  5 Sep 2023 06:48:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bcfe28909so363106066b.3;
        Tue, 05 Sep 2023 06:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693921720; x=1694526520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivI8ki1e5TGUUKYpVg+QTE/tjrcLWAvCLa+dhdl5XEI=;
        b=CY3j1AHeVNCevs0ooms++jx2DMipFFv4A+FTAGA/1qDIvzPxUkMskJEOlW7O4er9VH
         4JdhD+Kc4vas6EV4y0gHrAdWB0Jvt1UegrKsapIxtsZGQRZ8T7D1ye4jH2YkLDCSBQ8K
         49Yf5kudHvZDNpsDy/wL6kLVVgnhof+FoqVDR9jjty5rs5GFusIXYLsGJDMC9UQwFizK
         VWnzQz3urUG3xfduWAjfVWUvz3krAMtMsB3j9XyQ4ka5QxcKK1wYzlDpBD1mtLQz931T
         kS63lZvLJDa7b9TsILbs0euYnMTqfQMtgpqVHagPP1uQ0wj74RWqPoGat7QlRAu+ZfPq
         jjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693921720; x=1694526520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivI8ki1e5TGUUKYpVg+QTE/tjrcLWAvCLa+dhdl5XEI=;
        b=SZFP6RHlWkkQpxD1iTQTDYSPYfiMvFsS+MrxWjdh1CqW/BJ4UceBavoq+y+h3QdNjo
         7x1mbS+vk2z+tCSfh7ORnNkg01UOES0ZmynCdY2E/eWmC/xEGgmIMmxGuZDCEaS3cfmM
         Prcrh2u2a4DcdPyxvTqB37XJ6HI8iKenpGS9TMyYZNzQSzkXfkxbXvFjhrs1Fu7r0SNq
         vIP4S2XXYPAp0SA9B6LkuRIqF6va42NrAszPthilwpwceDqopITjYiAWajGfq0QyHXeW
         qBaDrzjwOTaz3S5K30s55OkY7KJVoKhVO4IZyqjoYJZOr1vUabNmYWCKi1SULFCmnB8z
         LxsA==
X-Gm-Message-State: AOJu0Yy2xne0jEfS4rCPN/q63RpE2iWGNv4UmJiVUfaql3t1HTWUlW+p
        HQTFBJkMnssebIeTrYSg50E=
X-Google-Smtp-Source: AGHT+IEUa6ooT0fp9TE1xzrdpb7voSWSn4UcmzmYyPMQJD4a+aEz8sShQeZ0Jsw+MpXrM6jeGbKZbQ==
X-Received: by 2002:a17:906:116:b0:9a6:4fed:e132 with SMTP id 22-20020a170906011600b009a64fede132mr4279516eje.55.1693921720372;
        Tue, 05 Sep 2023 06:48:40 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id kg12-20020a17090776ec00b0099364d9f0e6sm7627262ejc.117.2023.09.05.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:48:40 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:48:37 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW
 HSR offloading
Message-ID: <20230905134837.dzp3yk2hjgt6hf4a@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
 <20230904120209.741207-4-lukma@denx.de>
 <20230905103750.u3hbn6xmgthgdpnw@skbuf>
 <20230905131103.67f41c13@wsk>
 <20230905130355.7x3vpgdlmdzg6skz@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905130355.7x3vpgdlmdzg6skz@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 04:03:55PM +0300, Vladimir Oltean wrote:
> > > What are the causes due to which self-address filtering and duplicate
> > > elimination only work "most of the time"?
> > 
> > Please refer to section "KSZ9477 CHIP LIMITATIONS" in:
> > https://ww1.microchip.com/downloads/en/Appnotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf
> 
> Ok, so the limitation is a race condition in hardware such that, when
> duplicate packets are received on member ports very close in time to
> each other, the hardware fails to detect that they're duplicates.

It would be good to leave at least the link as part of the comment,
if not also a short summary (in case the PDF URL gets moved/removed).
