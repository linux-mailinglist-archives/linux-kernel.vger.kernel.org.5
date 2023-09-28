Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA567B25F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjI1TbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1TbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:31:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5771A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:31:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c736b00639so9345035ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695929480; x=1696534280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiM835Qdr8r3YY1MsttP3YD4WAnIIepGWpUnlhXauk8=;
        b=qrRtX/iHC6Fhouk/Fk5b/cGsYjqc7q9ekjy1zaQAg8icBWDg+Ylf6qq/1fIt1iSMdB
         LHprXqVC1daW8xqjH/FXTPU0pgfSe3h6m0mHUVdDKZ/oVwQoXca4INuLHoCPhhErflxj
         u6Dz8c+yHn+2A3OuyrmyxdjPC+FbgvRAH0bNphzOVgfilEU0nqu6MgrUHbErGE9epNTe
         F/bZ6WBwmGkGD+wr8JSnLz7bQrlL++3PFBKGPNzZhwW/BV0UWEGOBzwr+y3WG1+VuMBp
         G4jkxYu1v7pIx7Ml1XWPCJpAEn/3bqTTXp8p2NsutIdptnkmbjS+gFyEwvJr/k8ugJlY
         iPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695929480; x=1696534280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiM835Qdr8r3YY1MsttP3YD4WAnIIepGWpUnlhXauk8=;
        b=a57+waY4+hHLGBu3dJWiITWRfLT32i4X5PPRqQ0+e+Tbkq6CzFnkYCkPYZ8p3iXWXc
         t1ZqeUNhpDbtVQKMHNIV6Xkvpyc1k1SOZxFE6zEW8R8j4YL2CL+NIzX8LcNcOQi67hAz
         LMm4H1yYNSdyaFHs9xPOg31rXWNn2D53dyTbE7IzWknpUu/yvfBJUSav+Owl2EFBhrVz
         Hl5V+ja+0zgBnT3OBhRN0+UQ7a7A3hnnqwJb1NjqWxtJjX7oxPCE/D1Z7CrybmUiCW/6
         3nVAL48DV1x+VB6qU2vpeerwFO/wd359ZjOG4daqBeBXzz9F3nIOHDGe/SWDj80cAeHy
         gncg==
X-Gm-Message-State: AOJu0YxO6eYgKc5r6GtreU/kt/LU/VJvovNyx5DaTa5MwIPp9OTSH4t9
        T2lGEdkNgq0Yo7m/Jb+9UozuoA==
X-Google-Smtp-Source: AGHT+IE95MGmqksj4rnPsJlhQcIbTza6nvpDZ3jVQORmb3wxwujuxwIunVo313zxNSIjjCOnvIToSQ==
X-Received: by 2002:a17:902:8649:b0:1c3:1f0c:fb82 with SMTP id y9-20020a170902864900b001c31f0cfb82mr1816980plt.41.1695929480038;
        Thu, 28 Sep 2023 12:31:20 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:46f7:63a8:c7b8:44bb])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001bf8779e051sm7236931plc.289.2023.09.28.12.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:31:19 -0700 (PDT)
Date:   Thu, 28 Sep 2023 13:31:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: remoteproc: mtk,scp: Add missing
 additionalProperties on child node schemas
Message-ID: <ZRXUhSqHPt9R5Zd8@p14s>
References: <20230926164513.101958-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926164513.101958-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Sep 26, 2023 at 11:45:08AM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 895415772d1d..24422fd56e83 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -91,6 +91,7 @@ allOf:
>  
>  additionalProperties:
>    type: object
> +  additionalProperties: false

Things have changed in the remoteproc tree [1] and this patch doesn't apply.
Please see if it is still needed.

Thanks,
Mathieu

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml?h=rproc-next#n80

>    description:
>      Subnodes of the SCP represent rpmsg devices. The names of the devices
>      are not important. The properties of these nodes are defined by the
> -- 
> 2.40.1
> 
