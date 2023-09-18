Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8E7A50F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjIRR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIRR12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:27:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9385ADB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:27:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A95EC433C8;
        Mon, 18 Sep 2023 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695058042;
        bh=vblYavse5REeHZTur9wUxZXCUJeSaDa6nOcObQCi4Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwDPdc2iMP6JEC0GiN+vf1KuT/TpP5/WY3Ik+9UZGzatkyVXvdIhmHZh41pf1uC7D
         2aLDIqtm/G4qL9/KBtAYyxZnKkLqxDsUj0c8lPR9Om/L/0q0sNyAANSeh7z9+Emwnk
         MWuCDfGqiVWQTdjqu0B5XLRqfWZ++rvbQzR7pJ3npz77wQacsWDLd17IR3JAhxhP1L
         s8OL/gVEgx8FPtyccL5ei+bwQVVFZKCkTdkfq6MCxGKTbGM195soKtWuyCUzhT92Gb
         LdIdpufyHxqBXpeuA2ZqGVljFoVlErtL6vLbJ2TBIcUY9nU8DutHxfjDfr2hpgV6uc
         yjhx0bsiV0NdQ==
Received: (nullmailer pid 1413154 invoked by uid 1000);
        Mon, 18 Sep 2023 17:27:20 -0000
Date:   Mon, 18 Sep 2023 12:27:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: armltd: Move Arm board syscon's to
 separate schema
Message-ID: <20230918172720.GA1411360-robh@kernel.org>
References: <20230915201520.4179115-1-robh@kernel.org>
 <169481377499.149218.2656119781038291714.robh@kernel.org>
 <20230918143639.GP13143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918143639.GP13143@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:36:39PM +0100, Lee Jones wrote:
> On Fri, 15 Sep 2023, Rob Herring wrote:
> 
> > 
> > On Fri, 15 Sep 2023 15:15:05 -0500, Rob Herring wrote:
> > > The Arm Ltd board bindings are a bit unusual in that they define child
> > > nodes for various syscon's. The schemas are also incomplete as they lack
> > > constraints on having additional properties and some properties are
> > > missing. As the bindings for the different platforms only vary by
> > > compatibles, combine them into a single schema doc.
> > > 
> > > Add the "arm,im-pd1-syscon" compatible which was not documented. Add
> > > "ranges", "#address-cells", and "#size-cells properties which were
> > > missing.
> > > 
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/arm/arm,integrator.yaml          | 39 -----------
> > >  .../devicetree/bindings/arm/arm,realview.yaml | 37 ----------
> > >  .../bindings/arm/arm,versatile.yaml           | 40 +++--------
> > >  .../mfd/arm,dev-platforms-syscon.yaml         | 67 +++++++++++++++++++
> > >  4 files changed, 75 insertions(+), 108 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> Errr ... I'm a little torn.
> 
> Do I trust the maintainer or his bot? :)

New version fixing the example coming...

Rob
