Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335479D482
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjILPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjILPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:13:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D7E115;
        Tue, 12 Sep 2023 08:13:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913A6C433C7;
        Tue, 12 Sep 2023 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694531598;
        bh=ea+gMZwwDwB8LmUzQVtkGw+0MFVf843FNDk6DOXglVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sE73tRM9zXQ57IeeWPVn1gj240Ttf6nKGWLct5GGBDXfzIWYaLMaEh2Mlp7YcUjyw
         h+oWDvDVYIgTLsxb3Db9Ay6loOpQFSuRUfc9y1NWZVpGWQd8gxxKT/LQdEsudZbuml
         ZhU238OvG4ngMBhX3m897VrnybUvn4X+H/73GK3h2LIXI57MNdlwWKkOSMSB/LF50U
         el7vXuIjDNIrUbzj3pqKCWN1iIRMaBF3ZrV1q6vutU4m4cF4j0dtJy5CW44L3imA6S
         qLIEVKnMk31PQIm4CLVjmap1Dliwnaz3Y/WbBkii/toChj92gQ6WNOK7+fvWG/W4ux
         R8VZIUFp0goEw==
Received: (nullmailer pid 811693 invoked by uid 1000);
        Tue, 12 Sep 2023 15:13:16 -0000
Date:   Tue, 12 Sep 2023 10:13:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4] dt-bindings: hwmon: Add MAX6639
Message-ID: <20230912151316.GA809732-robh@kernel.org>
References: <20230831092403.1929317-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831092403.1929317-1-Naresh.Solanki@9elements.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:24:03AM +0200, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Add binding documentation for Maxim MAX6639 fan-speed controller.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
> Changes in V4:
> - Drop property pulses-per-revolution
> Changes in V3:
> - Update title
> - Add pulses-per-revolution, supplies & interrupts
> Changes in V2:
> - Update subject
> - Drop blank lines
> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> new file mode 100644
> index 000000000000..9c06a61d57c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX6639 Fan Controller
> +
> +maintainers:
> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
> +
> +description: |
> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
> +  fan-speed controller.  It monitors its own temperature and one external
> +  diode-connected transistor or the temperatures of two external diode-connected
> +  transistors, typically available in CPUs, FPGAs, or GPUs.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max6639
> +
> +  reg:
> +    maxItems: 1
> +
> +  fan-supply:
> +    description: Phandle to the regulator that provides power to the fan.

Still a fan property, not a fan controller property. 

Please participate in the discussion with Billy on common fan binding.

Rob
