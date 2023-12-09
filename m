Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B980B47F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 14:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjLINBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjLINBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:01:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C1F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:01:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0A3C433C8;
        Sat,  9 Dec 2023 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702126906;
        bh=tLQNu65wbF7DzIeT8McHn0JFIAviqlbeBR9/VLN2jw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pzvv/d6mCsdrYIXfd/aNExUyQKLD17xKrc1GzBXIJK/Q1ui6K+HoyPlfP9RyYQHps
         oDtb1KA6Y8xo8i4zNtj1zfU1k89u67gb9lYLjyfuagriEcTykmySljWSUATGgKy8df
         ngoKmfsovgqz84k1+XZP+bxdoQowH+tAqQSQ4U6MrUKbcaF27UUFm5yiNirZzmquz5
         8iocrQiRQrSKUe269izRmUFuHl2FRrVXFsH8W87ff2JWiT4vZ1FZx3LBYwsc9yUDZo
         huG6FKZRANOR+D4dYIuifeVSMaHMZBexWwU3la8uyXHY0HeWepdjeDtiD/WdhCGbqe
         wZAPHQjrAu2+w==
Date:   Sat, 9 Dec 2023 14:01:40 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     Michal Simek <michal.simek@amd.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: cadence: Add system suspend and resume PM support
Message-ID: <20231209130140.m2ym5yy5rv3pwtzn@zenone.zhora.eu>
References: <20231209030955.1156905-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209030955.1156905-1-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ji Sheng,

[...]

> +static int __maybe_unused cdns_i2c_resume(struct device *dev)
> +{
> +	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = cdns_i2c_runtime_resume(dev);
> +	if (err)
> +		return err;
> +
> +	if (pm_runtime_status_suspended(dev)) {
> +		cdns_i2c_runtime_suspend(dev);
> +		if (err)
> +			return err;

have you forgotten to assign 'err'?

Andi

> +	}
