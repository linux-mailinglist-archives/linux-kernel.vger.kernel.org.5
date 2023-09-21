Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBBF7A9D73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjIUThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjIUThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:37:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8E3FBB35;
        Thu, 21 Sep 2023 12:12:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so1808573e87.1;
        Thu, 21 Sep 2023 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695323552; x=1695928352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfOa60jin+Cg2UGV5vWmkOgyjYutq/4P6GMhlzuMcDo=;
        b=PLJlxNIyWrNPIcQKpgONFau4S/DloaKpWyLed0pKo2Crv3KQpt0eFbXt4pLTZFCKdp
         3OtYpe3k+rimHz1mnLNuyb6jWbYZKVk8M0be6iYW26inIwcbup/PcebGVY2GUFhpX2GM
         MfQ0ZyHe1j/V5UzdKsvsKy58Xf03MkgkZTUG/momHoa7bPC7VBfc+BP85Wa9dGbcpHaq
         dq13ub1Rq99sqMf2n3Rvz4yTNY9Kkr2Gz5UxScIav7B8ctLx6zGvZutR9bWAv6xe7V6e
         zE4c/lw9PhyR3eyFacTWFL/l1kfOTy50VGL7RfaUHkyHAbVgmmGwsvnRUzg4QNWCcSiZ
         ZYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323552; x=1695928352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfOa60jin+Cg2UGV5vWmkOgyjYutq/4P6GMhlzuMcDo=;
        b=wIpteHIdYcdmvOa2b3ZaA9H5LSkW6EVH5b/hqQ+7RLZAuqIZx41vSN1NiINb54Zuku
         aei9OILKIL4ZQR60OsetjnODoZtqp1rmlH6JxTkOdJIV2u2Lw2fD5LYTNkef/J70az6p
         jK0eMRJ3RKnOl7nxg/0FGvnWFJDYns4hCPQum8RHG2tXWp7X+kh1lN47Xt84z2WYS0+6
         hrzAcwf0VW4NgCqbZIO16M9sAmVDrLTlwK5bCfvQ0sMaSZ1q9zrBwkbaILgl5fn7p4bf
         Sbaho/1fH+c9GlZr9uyXsIdPdq6j7vu68YWvYLi9ty7POWMk4j80//2kiQLQYjED6+FV
         o4bg==
X-Gm-Message-State: AOJu0YxsxCgcKrNp/5piz3fZCGYm9/f/+1Y5dPAMSZN+B/r+WA5CUgcI
        1h51DWAbQPbFKLRj3hPkpeM=
X-Google-Smtp-Source: AGHT+IFiR3BZ50HhvuUo0VjWL52ste+XHJS0kip8vz2GEZHYZy+dHSf6y3rQjd8WF2vTCW0bvKMZ/Q==
X-Received: by 2002:a05:6512:3147:b0:500:c5df:1872 with SMTP id s7-20020a056512314700b00500c5df1872mr4619332lfi.44.1695323551612;
        Thu, 21 Sep 2023 12:12:31 -0700 (PDT)
Received: from skbuf ([188.25.255.147])
        by smtp.gmail.com with ESMTPSA id l24-20020aa7c318000000b00533349696f1sm1206729edq.16.2023.09.21.12.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:12:31 -0700 (PDT)
Date:   Thu, 21 Sep 2023 22:12:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 3/5] net: dsa: tag_ksz: Extend ksz9477_xmit()
 for HSR frame duplication
Message-ID: <20230921191229.72v3ndgli66lyhdy@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-4-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920114343.1979843-4-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:43:41PM +0200, Lukasz Majewski wrote:
> The KSZ9477 has support for HSR (High-Availability Seamless Redundancy).
> One of its offloading (i.e. performed in the switch IC hardware) features
> is to duplicate received frame to both HSR aware switch ports.
> 
> To achieve this goal - the tail TAG needs to be modified. To be more
> specific, both ports must be marked as destination (egress) ones.
> 
> The NETIF_F_HW_HSR_DUP flag indicates that the device supports HSR and
> assures (in HSR core code) that frame is sent only once from HOST to
> switch with tail tag indicating both ports.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---

I'm not sure what in your process causes this, but there is an atypical
extra new line between the last Signed-off-by: line and ---. Anyway.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
