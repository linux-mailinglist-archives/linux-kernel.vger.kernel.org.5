Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F417E7732F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHGW2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjHGW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C76CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691447271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OoCQj+gG1dm9NiP0aYa0b0pvxLVU+VxmVMWhUGehjZE=;
        b=NpbFsbl57bIz9neiq1mAaQZP6tQKmIESEtES6JWvyJ8kBMbp8PfjT53iS/DEZqjM7g/sLa
        wD705cxT3f06CIJ0d4KL9m33MZ4SyvVbl3o53iZwp+zwufHrRAGqpE1IIoV8xNNG1YsITd
        KR2m15gp1smKEP2sdl9fXzSouoBqA0M=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-ykALw4tGOtq3j4G-tzR8fg-1; Mon, 07 Aug 2023 18:27:48 -0400
X-MC-Unique: ykALw4tGOtq3j4G-tzR8fg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-447cb8a9766so984185137.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 15:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691447267; x=1692052067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoCQj+gG1dm9NiP0aYa0b0pvxLVU+VxmVMWhUGehjZE=;
        b=HjaQIfC4elaipQpevGfLzKqXzmPz5BIG1jbHdyolFriwNUZgiFknl1MgWbRO7wG78y
         aYUNvtB1IJ7uDUct+DYvp1LES13UPSApqEF2AnfWljAhjbSL2Yy3i3AOlb0M3sUTo7t7
         TySxfspslNtMcXuF/WIth+DCyAIJFctgdaFjV6QQowxirC7oWfI5v0KLzEofGNUZ3StD
         +LxkfVeWTC3AqjQ8yG9MOnGZggOyRwI8gJLeZvh62ShFxS6lG+AzJqgPKwDfi3/EkBsS
         dmFZuykjyWMj2N2bwf6lDw27oFNAk2rJz36f701kQeOsy4JzxdJozC7PDitAcckPYStH
         yg/w==
X-Gm-Message-State: AOJu0Yw/q0KizofQBqIWYxuif5MD2yBgVGNPzqTKiROgsNz6ZuVCfZXG
        g45wXjH2v3CHsqoFKFZ9WXgiasj8wbgQYA6pL2vsXbCl4zsEXTx2lgZWcr2bO1rDkS8gBVKGdyj
        PtZbbhos8QqaLMenSwoPvE7bk
X-Received: by 2002:a67:b602:0:b0:447:a303:bbf2 with SMTP id d2-20020a67b602000000b00447a303bbf2mr4519788vsm.24.1691447267718;
        Mon, 07 Aug 2023 15:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoKaR+izuGwqD5ORej9M/bSlTm97V1zhmD9i50ejqm8XmB/Yp0iCZwCW0ekYfB7D367IWYEQ==
X-Received: by 2002:a67:b602:0:b0:447:a303:bbf2 with SMTP id d2-20020a67b602000000b00447a303bbf2mr4519771vsm.24.1691447267397;
        Mon, 07 Aug 2023 15:27:47 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id x19-20020a0cda13000000b0063d585225e0sm3136365qvj.61.2023.08.07.15.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 15:27:46 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:27:44 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 5/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios
 property of the PHY
Message-ID: <ld2j4llgfba6j43gesqxs6wz2baucka5scbj4nef5ehbex2cmt@d4dxsqp2vuoj>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-6-brgl@bgdev.pl>
 <siqiyihftz3musfjulpcqunhgi7npftumrfwfyh2pqnlx6zeb7@rrpwmkvjshfb>
 <da679b5e-6712-4849-b29c-6aa42022abc4@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da679b5e-6712-4849-b29c-6aa42022abc4@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:51:40PM +0200, Andrew Lunn wrote:
> > > I have proposed a solution for this problem in 2020 but it never got
> > > upstream. Now we have a workaround in place which allows us to hard-code
> > > the PHY id in the compatible property, thus skipping the ID scanning).
> > 
> > nitpicky, but I think that already existed at that time :D
> 
> Yes, it has been there are long long time. It is however only in the
> last 5 years of so has it been seen as a solution to the chicken egg
> problem.
> 
> > >  		sgmii_phy: phy@8 {
> > > +			compatible = "ethernet-phy-id0141.0dd4";
> > >  			reg = <0x8>;
> > >  			device_type = "ethernet-phy";
> > > +			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> > > +			reset-deassert-us = <70000>;
> > 
> > Doesn't this need reset-assert-us?
> 
> If i remember correctly, there is a default value if DT does not
> provide one.
> 

I've been trying to make sure I view devicetree properties as an OS
agnostic ABI lately, with that in mind...

The dt-binding says this for ethernet-phy:

  reset-assert-us:
    description:
      Delay after the reset was asserted in microseconds. If this
      property is missing the delay will be skipped.

If the hardware needs a delay I think we should encode it based on that
description, else we risk it starting to look like a unit impulse!

