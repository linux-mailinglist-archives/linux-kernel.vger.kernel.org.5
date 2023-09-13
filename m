Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EAC79ECCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjIMP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIMP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:28:02 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB81BC3;
        Wed, 13 Sep 2023 08:27:58 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Rm48T4zjDzyRq;
        Wed, 13 Sep 2023 18:27:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1694618875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KtJQ13C7aWh7rZj0Lwe+NgyzXlnh8ie4gD9UtoD1Y3E=;
        b=B//6ZcGsnW8Yq4Zm+3b+tLEMAaBPazwV666r1xdd89TPMSkULwsu0sz+QxZGqOhzA1EZ1c
        ofuiJ9KuWEcebTzUgva+ucpZf5y8W3ByDlieajrm4r1bZyF5dR/eixLvaV4RXQ5LXTcXtW
        hEXfBV3FRlBxNA22to/wiy1uQTz9uFk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1694618875; a=rsa-sha256; cv=none;
        b=nsz23pU4dYYIegYK7rguZu1M6UP/jWV1WaCQcGP+lT1QupZU15E8MeTGc0UfY+tJoSjq1O
        2VWm0C8H9Ax9XbxI/ucz2tm8/qkg+tPR++U3guQordJJNtoMbbcoVf1EfkJbxs5F9+ASEd
        WScrY+jNwMhmxlfU36WYL6QX+ZdXLN4=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1694618875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KtJQ13C7aWh7rZj0Lwe+NgyzXlnh8ie4gD9UtoD1Y3E=;
        b=OFixtXpEfoNGrgJuE90rl32J34RqC0Zz4eukLvzINr/Xsn2g1jyju0NDp0D/imx3uc7f2v
        QomO+I9sSv45LZ5SEhDWsHlfEepDvOEcTL3LdNMepTh/UfnB3CrPVx4wyCfppTBb1z08EG
        aModKR+kujUj2yoyE7vGjfa5YHYQ8p8=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C600D634C93;
        Wed, 13 Sep 2023 18:27:52 +0300 (EEST)
Date:   Wed, 13 Sep 2023 15:27:52 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] media: ov5640: use pm_runtime_force_suspend/resume for
 system suspend
Message-ID: <ZQHU+LA+BEB7jzx1@valkosipuli.retiisi.eu>
References: <20230818173416.2467832-1-andrej.skvortzov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818173416.2467832-1-andrej.skvortzov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Fri, Aug 18, 2023 at 08:34:16PM +0300, Andrey Skvortsov wrote:
> If system was suspended while camera sensor was used, data and
> interrupts were still coming from sensor and that caused unstable
> system. Sometimes system hanged during a resume. Use
> pm_runtime_force_* helpers in order to support system suspend.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Thanks for the patch.

It's not been documented really how system suspend and resume should
work for complex cameras. But I don't think it can be done by drivers
separately as the CSI-2 bus initialisation requires actions from both
sender and receiver drivers, at particular points of time.

So I think we'll need to initiate this from the driver handling DMA, just
as starting and stopping streaming. Even then, there needs to be a
certainty that the sensor device has resumed before streaming is started. I
recall Laurent suggested device links for that purpose, but I don't think
any work has been done to implement it that way.

-- 
Kind regards,

Sakari Ailus
