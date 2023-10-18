Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBF57CE6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjJRScO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjJRScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:32:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC53119;
        Wed, 18 Oct 2023 11:32:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1B8C433C7;
        Wed, 18 Oct 2023 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697653931;
        bh=tOqSoJfV6UaA+IPipuWQfTMZpKrjsZ4IKE5zi0uW75Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hEsrVwG26XgWeooyYzpdHRZizqpNkD/qWqR4Pm4qMBYXfVYDYvY3AjObVH9iTtBoP
         NdwFAX5OA1bWSK90CZ1tmYQ1jaN4XGZu2L3OKX+d36MpWX/qBRCUZ2NGYKm2Uu4mN5
         zhXSPExIU/oB2I3iEKXFuQNfkAlqVuBrUd+lvlEUD7g2+rknHH1ZKKtkHEHYglGEwu
         ct1+4lmRuyhyj+RvXLEC4nmcRCTwLDwxJ4ruin67DLYjfIl33o+9lbwXe2YWnHiqeb
         MSehl76slfRpmBpSBNxNznHjg1cu02Ze2BlE2WzZO41GnAzD+yvH+S3IpIOGDBaofP
         vJCbmMVelOgLw==
Date:   Wed, 18 Oct 2023 19:32:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add maxim max34408/34409 ADC driver and yaml
Message-ID: <20231018193230.60736165@jic23-huawei>
In-Reply-To: <20231014211254.16719-1-fr0st61te@gmail.com>
References: <20231014211254.16719-1-fr0st61te@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2023 00:12:52 +0300
Ivan Mikhaylov <fr0st61te@gmail.com> wrote:

> Add Maxim max34408/34409 ADC driver and yaml for it. Until now it
> supports only current monitioring function without overcurrent
> threshold/delay, shutdown delay configuration, alert interrupt.
> 
> Changes from v1:
>    - minor changes from Rob's comments for yaml
>    - add ena, shtdn and make 4 inputs for R sense from Jonathan's comments for yaml
>    - add _REG suffix and make prefix for bitmasks and statuses
>    - add SCALE/OFFSET instead of AVG/PROCESSED from Jonathan and
>      Lars-Peter comments
>    - add chip data from Jonathan and Lars-Peter comments
>    - minor changes from Lars-Peter and Jonathan comments for driver
> 
> Changes from v2:
>    - add channels into hardware description into yaml
>    - add rsense property per channel
>    - rename pins for shtdn and ena pins
>    - make one array for input_rsense values
> 
> Changes from v3:
>    - change *_34408_OCT3 and 4 to *_34409_OCT3 and 4
>    - change of_property_read_u32 to fwnode family calls
>    - add i2c dev table
>    - change of_match_device to i2c_of_match_device
>    - change match->data to i2c_get_match_data 
> 
> Changes from v4:
>    - minor changes in yaml
> 
> Changes from v5:
>    - name and minor changes to properties in yaml from Rob's comments
>    - shtdn-enable-gpios -> powerdown-status-gpios from Krzysztof and
>      Jonathan comments in yaml
>    - minor changes to driver
> 
> Ivan Mikhaylov (2):
>   dt-bindings: adc: provide max34408/9 device tree binding document
>   iio: adc: Add driver support for MAX34408/9
> 
>  .../bindings/iio/adc/maxim,max34408.yaml      | 139 +++++++++
>  drivers/iio/adc/Kconfig                       |  11 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/max34408.c                    | 276 ++++++++++++++++++
>  4 files changed, 427 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
>  create mode 100644 drivers/iio/adc/max34408.c
> 

Series applied to the togreg branch of iio.git and pushed out as testing.
We are very late in the cycle, so this is probably destined for 6.8

Jonathan
