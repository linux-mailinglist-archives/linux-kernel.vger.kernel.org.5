Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA579E82C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjIMMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjIMMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED73D19AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694608702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a99oLOwjNNMyzFFsHd0MXUMcklXas63C6jeF9Gj5oJI=;
        b=Bqk8amhDhtaPdwJhf0cIsXk4ee9IIQsbuwJDbHm1nx2EYm0v9MwML2LfJ9BcJoyp2DKgZe
        DVdUx+34LX+JVLns95tn8i6uIp7acPMYsBUmz3IGyBIL/9QEcjPC0tYjeOFkLOw9bMLShO
        hIqqWUd2kyu9Ntdi8GLAriA+WGzh8Ak=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-8T3gjMQ_MHWVk6quJKdEcQ-1; Wed, 13 Sep 2023 08:38:20 -0400
X-MC-Unique: 8T3gjMQ_MHWVk6quJKdEcQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5925fb6087bso72702947b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608700; x=1695213500;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a99oLOwjNNMyzFFsHd0MXUMcklXas63C6jeF9Gj5oJI=;
        b=MXJ+hTlS1csA0GZnb3gS/ih96byyyzVlOC42MxROCWJKIZWUqi16n/nm/aYOONFMCG
         qoGMFwwX4Kdy1Q6it/HxrEHjRaNjYEUobzGh9uFiqf/HLg5mv9VJLDPSeHSY53yVxLql
         dDoAKoGQGTmxc2roYaiSCn0UabRb5lKDP+c889l9OPfpkpcPtTHGf5oM6kQKzVp4w6AX
         PtKSdJZNtJOL+c0+NYmuZ6gggiJjo49zp7D5ItJ+2L4KMsHv7bGbVVLPsvtG/mYVM1Rx
         06l939fhw22fj64rV9uJyafnqIg8wPDC/GfuB4Y5zQQrjTaOrtb/QW5NRePhysO68xKZ
         zlzQ==
X-Gm-Message-State: AOJu0YxjLR0gW5OreS/dawFhDL3AFhIwbCc1Nhv4IOJQpRs3lfVr314x
        AmLdxn/ScBIFLGSGpJ/V7gAge6DkQV0RD3zq/oUpms0iHgFs74DGucb1Bcy3UZp37pF3jWInFGH
        zq5o6kl0eN90Pj6Ua6tYuxv2t
X-Received: by 2002:a81:840d:0:b0:592:227f:7964 with SMTP id u13-20020a81840d000000b00592227f7964mr2260156ywf.47.1694608700355;
        Wed, 13 Sep 2023 05:38:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkbtdNrR0YTB2Q5btwwGtmqxiH9pOyvhyovj8vNZpVcBvf93C7I4xQpOhZ3c2r3zgxp2VXpw==
X-Received: by 2002:a81:840d:0:b0:592:227f:7964 with SMTP id u13-20020a81840d000000b00592227f7964mr2260142ywf.47.1694608700123;
        Wed, 13 Sep 2023 05:38:20 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y198-20020a0dd6cf000000b005707fb5110bsm3106302ywd.58.2023.09.13.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 05:38:19 -0700 (PDT)
Date:   Wed, 13 Sep 2023 08:38:17 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: correct PMIC GPIO label in
 gpio-ranges
Message-ID: <ZQGtObktGq3tvEuf@brian-x1>
References: <20230818135538.47481-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818135538.47481-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:55:38PM +0200, Krzysztof Kozlowski wrote:
> There are several PMICs with GPIO nodes and one of the nodes referenced
> other's in gpio-ranges which could result in deferred-probes like:
> 
>   qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: can't add gpio chip
> 
> Reported-by: Brian Masney <bmasney@redhat.com>
> Closes: https://lore.kernel.org/all/ZN5KIlI+RDu92jsi@brian-x1/
> Fixes: e5a893a7cec5 ("arm64: dts: qcom: sa8775p: add PMIC GPIO controller nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

