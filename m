Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC47C4AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbjJKGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345233AbjJKGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:32:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259B9B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:32:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AD1C433C7;
        Wed, 11 Oct 2023 06:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697005964;
        bh=Lb/42Qm3utcBiONCdOP5wqcXR9jQ63Q9gVfbicfEypU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJ1y0hVjDY3aMOnoiWuOcOcILh7Na/FhtOBCP4aV1dJ2WYF5CGXwRrUS9WKTH2zd8
         GfEInF+nvGrhVHoQVEP717m9aqO7DiugAnRHe0W18hMcInCXUvsmegElpfsxQwGeFN
         DgBUhXBcBWtWBc/FAdoR91bE5vQQ0N+02jkGrbFA=
Date:   Wed, 11 Oct 2023 08:32:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic: deduplicate comomn code
Message-ID: <2023101113-squatter-stew-5d66@gregkh>
References: <20231011-pvpanic-cleanup-v1-1-5c93b05ec331@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011-pvpanic-cleanup-v1-1-5c93b05ec331@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:10:08AM +0200, Thomas Weißschuh wrote:
> +int devm_pvpanic_probe(struct device *dev, void __iomem *base)
> +{
> +	struct pvpanic_instance *pi;
> +	int ret;
> +
> +	if (!base)
> +		return -EINVAL;
> +
> +	ret = devm_device_add_groups(dev, pvpanic_dev_groups);

You just raced with userspace and lost :(

Please just use the default groups attribute pointer, you should NEVER
need to manually add groups to a device like this.

And why are you calling this devm_*() for a probe function?  That's
risky as you are now in the global namespace and this really is not a
devm_*() like function

thanks,

greg k-h
