Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0317D0D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376812AbjJTK0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376794AbjJTK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:26:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F4EB8;
        Fri, 20 Oct 2023 03:26:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso922540a12.1;
        Fri, 20 Oct 2023 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697797582; x=1698402382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqPy64WSZA+4wUylMe4RJhArwfqJFkAGmouyl6GLC3U=;
        b=SoedXVhAXGqFPCgRlijCipN0O+FNqeOjo42goy00lCcoIiAxuieNLAzYrX3NXLZ9i0
         BlG8vc4xBIXbnB70FsUVieC4fpvqi0T/N/6usK7g2Lxs4kLUvNx415xJMTFIz3sAkJCk
         sukpaHBhvMIne9pXx4i2OsKoolK6tsH5DeLQBsjmUSrPIpETpICLTd7Px61OmpupH2bk
         CHFUD4aSi6QFidV/XWaqxkVRwoKbbBJbBudnD01Sfopjl5ImZQE4oxuTC22E/8gfyv2o
         EM1nJoLMg91oBMMdZFb2NN85zUUcVKqEROdkZRPANLbCCyWYIZn27FGOS1bB/O00y473
         58wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797582; x=1698402382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqPy64WSZA+4wUylMe4RJhArwfqJFkAGmouyl6GLC3U=;
        b=PlRcsbTZiezfsl9aiG268dof0810fyXXMRUxwYte45qgqly37PosI0W2/o8wCWgOBn
         hFB681fYaIU/lIBvo+aoFm+q+yZw0wXE6oggthrCDYgNrOuf1wdZcW2iCroBYt18xben
         vlomAF7wvpLG9zIVbVWQYwqY1hM3N0nwloCpQU3Z7Id2P0HXmlr39reNPjpmaGVNsoV3
         SqykcWVIk68LSDRJnva889RlGuHzcG5XswalZsL8FuRgR7WJ1Wb9jlYEOqcN006iXKGm
         nzvzybweiWbyK6hX6bgrb8TeMRovqszodU949VdiApeccw09LfCiEOmQwreHtdAjlNbZ
         Chgw==
X-Gm-Message-State: AOJu0YwYlyYgh0eq6fFXElcqHY40ZZr8ZdQKiBK2RAAVXdlcLlpru3M7
        JnU0KmUwrd1ndFMFaHCtY04=
X-Google-Smtp-Source: AGHT+IEnlFPzgFG5Txjbr+/GrDtBQ71LyQiWuJ/n2/IlW+m/PujVaS1JJ1mqNN/tW7RHg3Sul40//g==
X-Received: by 2002:a17:907:2d27:b0:9a1:c991:a521 with SMTP id gs39-20020a1709072d2700b009a1c991a521mr929212ejc.4.1697797582567;
        Fri, 20 Oct 2023 03:26:22 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709066bcf00b009a13fdc139fsm1183335ejs.183.2023.10.20.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:26:22 -0700 (PDT)
Date:   Fri, 20 Oct 2023 13:26:19 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Message-ID: <20231020102619.67fc3aaknvukwij4@skbuf>
References: <20231019165409.5sgkyvxsidrrptgh@skbuf>
 <20231020084620.4603-1-ante.knezic@helmholz.de>
 <20231020092729.gpbr7s2cbmznmal7@skbuf>
 <20231020100053.wf3jivdkdfaunfgh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020100053.wf3jivdkdfaunfgh@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Oleksij

On Fri, Oct 20, 2023 at 01:00:53PM +0300, Vladimir Oltean wrote:
> On Fri, Oct 20, 2023 at 12:27:29PM +0300, Vladimir Oltean wrote:
> > On Fri, Oct 20, 2023 at 10:46:20AM +0200, Ante Knezic wrote:
> > > Ok, will do. I am guessing I should leave the existing 
> > > ksz8795_cpu_interface_select() as it is?
> > 
> > I would encourage moving it to the simpler call path as well, but
> > ultimately this is up to you.
> 
> Also, could you please put spaces in the commit prefix ("net: dsa: microchip: ")?

One more thing. You two are working on separate things on the KSZ
driver (Oleksij on
https://patchwork.kernel.org/project/netdevbpf/cover/20231019122850.1199821-1-o.rempel@pengutronix.de/),
and this creates conflicts in the DT schema and in ksz_common.h.
For the most part, those are avoidable. Could you coordinate so that
both of your next submissions do not conflict with each other? That
means that each of your series can be applied independently of the other
(Ante's first, or Oleksij's first).

For example, the dt-schema properties do not seem alphabetically sorted
(microchip,synclko-125 comes after reset-gpios), so putting
wakeup-source after reset-gpios, and leaving microchip,rmii-clk-internal
at the end, seems a viable strategy in avoiding that conflict.

The conflict in ksz_common.h will be automatically avoided when
rmii_clk_internal stops being stored in struct ksz_device.
