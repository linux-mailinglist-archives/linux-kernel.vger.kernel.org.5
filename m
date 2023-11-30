Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8D7FFEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377178AbjK3Wqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjK3Wqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:46:44 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2C991;
        Thu, 30 Nov 2023 14:46:47 -0800 (PST)
Received: from i53875b1a.versanet.de ([83.135.91.26] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r8pnf-0002fN-EM; Thu, 30 Nov 2023 23:46:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 13/14] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Date:   Thu, 30 Nov 2023 23:46:25 +0100
Message-ID: <18610737.hlxOUv9cDv@diego>
In-Reply-To: <20231130122500.13491-1-andyshrk@163.com>
References: <20231130122001.12474-1-andyshrk@163.com>
 <20231130122500.13491-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am Donnerstag, 30. November 2023, 13:25:00 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add a Rockchip RK3588 compatible
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index ba9124f721f1..3febf0c3c404 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -22,6 +22,7 @@ properties:
>      enum:
>        - rockchip,iommu
>        - rockchip,rk3568-iommu
> +      - rockchip,rk3588-iommu

This enum only allows that the compatible has one element, namely one of
those listed here. In the dts though you declare
	compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
meaning that the rk3588-iommu is compatible to the rk3568-iommu

I think you'll need a construct like:

properties:
  compatible:
    oneOf:
      - enum:
          - rockchip,iommu
          - rockchip,rk3568-iommu
      - items:
          - enum:
              - rockchip,rk3588-iommu
          - const: rockchip,rk3568-iommu

to describe both the single-compatibles and the 2-item compatible for the
rk3588. For example pci/rockchip-dw-pcie.yaml does a similar thing already.

Heiko


