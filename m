Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899DD77470D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjHHTIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHHTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A8D4BEB;
        Tue,  8 Aug 2023 09:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AAF9624E6;
        Tue,  8 Aug 2023 11:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8AFC433C7;
        Tue,  8 Aug 2023 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691494924;
        bh=7W8arS9xc1VsyrYsfgzjRG4MftCWFePfOyZF4K36c+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW9seNGRY4R+UZe/yEDFe+2l2D1h1LIQb9LdZocYP0kb717N0yTUxlV35S6OgUjHp
         8SUo26EeRVvTqvoWI2SBfckr2Ri0EcA+xycqL98KEk5aZCvtbFOXfqGxl6jvccniFN
         8qrLIix/ofVBDvPuL+f190jlLZUUKOKPxLBUvcILbzx5+Zz3/ExRT8gsdLrhGf4ODQ
         6LQF/BA7Re9Q8+v5jY9mpo1TNNaTTFND+P67bfIO4j/glifactZTPFQmNIEOBEBbe4
         KfErmMg2IMP7OvtR8dSeL6QmNa5L9bhcn2r+//aC1njNAPMNeb2/8xOpE1+Vqox/En
         wlPM9oyA/t/eQ==
Date:   Tue, 8 Aug 2023 13:42:01 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: exynos4-is: fimc-is: replace duplicate pmu
 node with phandle
Message-ID: <20230808114201.ztr22migzzyfsfwq@intel.intel>
References: <20230807131256.254243-1-krzysztof.kozlowski@linaro.org>
 <20230807131256.254243-3-krzysztof.kozlowski@linaro.org>
 <20230807231320.svssge6uymw3jiho@intel.intel>
 <84fbcc37-d226-b637-caa1-b24ebaf03d58@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84fbcc37-d226-b637-caa1-b24ebaf03d58@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +static void __iomem *fimc_is_get_pmu_regs(struct device *dev)
> >> +{
> >> +	struct device_node *node;
> >> +	void __iomem *regs;
> >> +
> >> +	node = of_parse_phandle(dev->of_node, "samsung,pmu-syscon", 0);
> >> +	if (!node) {
> >> +		dev_warn(dev, "Finding PMU node via deprecated method, update your DTB\n");
> >> +		node = of_get_child_by_name(dev->of_node, "pmu");
> >> +		if (!node)
> >> +			return IOMEM_ERR_PTR(-ENODEV);
> > 
> > in my opinion this should be:
> > 
> > 		...
> > 		if (!node)
> > 			return IOMEM_ERR_PTR(-ENODEV);
> > 
> > 		dev_warn(dev, "Finding PMU node via deprecated method, update your DTB\n");
> > 
> > Because if you don't have both "samsung,pmu-syscon and "pmu" then
> > the warning should not be printed and you need to return -ENODEV.
> 
> Why not? Warning is correct - the driver is trying to find, thus
> continuous tense "Finding", PMU node via old method.

Alright, I'll go along with what you're suggesting, but I have to
say, I find it misleading.

From what I understand, you're requesting an update to the dtb
because it's using deprecated methods. However, the reality might 
be that the node is not present in any method at all.

Your statement would be accurate if you failed to find the
previous method but then did end up finding it.

Relying on the present continuous tense for clarity is a bold
move, don't you think? :)

Andi

> > ... and... "*please* update your DTB", the user might get upset
> > and out of sheer spite, decides not to do it – just because! :)
> 
> The message is already long enough, why making it longer? Anyone who
> ships DTS outside of Linux kernel is doomed anyway...
> 
> Best regards,
> Krzysztof
> 
