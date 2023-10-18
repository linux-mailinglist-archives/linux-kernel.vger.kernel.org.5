Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC997CE0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbjJRPMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjJRPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:12:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B63AFA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E983C433C8;
        Wed, 18 Oct 2023 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641955;
        bh=fr5zaOzgWJ22rsMn0JC7sZ22BkfuCDopCtSjW7N5yHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y54PYHPhnx82rs4cdBxW3IACo8wtYtFZj8XIckJ1LFZNhwI9DMPwpuDG5JCfRI2AA
         oiQ8JOV/Chsam/a8AZF+yt/TSYEMChNppUd6dZbGF/zd7PXeL6mC/xHEK6W1mGG7hQ
         rrpzGiW4bUTwf8qHe7DfntG/0fOdFIbMtuWkh69kU+wjdbBXYSTyASgLhvcColAibY
         /xOSn/qmxjXsTvBEZU0AldcfXSuo0LkbA057OhTfa0jzg6iPI67BvQT05wGhPoLE4u
         iCQmpqgnEtpCgC0TsMlxMmo3xD49FhR+ddYTUbp8pg3psdbGVBQ8b24+oR8fMB3yMn
         2oC+2Ph37KUog==
Date:   Wed, 18 Oct 2023 23:00:22 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: vialab,vl817: remove reset-gpios from
 required list
Message-ID: <ZS/zBvaWicGAeaGq@xhacker>
References: <20231017160158.1065-1-jszhang@kernel.org>
 <04ee08a4-e804-40fe-b24e-7a56c9e24e8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04ee08a4-e804-40fe-b24e-7a56c9e24e8b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 06:53:56PM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2023 18:01, Jisheng Zhang wrote:
> > The "reset-gpios" is optional in real case, for example reset pin is
> > is hard wired to "high". And this fact is also reflected by the
> > devm_gpio_get_optional() calling in driver code.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../bindings/usb/thead,th1520-usb.yaml        | 42 ++++++++++---------
> >  .../devicetree/bindings/usb/vialab,vl817.yaml |  1 -
> >  2 files changed, 23 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
> > index afb618eb5013..ce1cab75f0ff 100644
> > --- a/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
> > +++ b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
> > @@ -28,6 +28,10 @@ properties:
> >  
> >    ranges: true
> >  
> > +  thead,misc-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: a phandle to the misc system register controller syscon node.
> 
> Either you combined two unrelated changes or this should be resets from
> reset-controller.

oops, this change isn't expected... I was working on TH1520 usb but
add local changes step by step, but then found vl817 need to be patched.
I forgot to reset TH1520 usb part. Sorry for noise. V2 will be sent out
soon.
