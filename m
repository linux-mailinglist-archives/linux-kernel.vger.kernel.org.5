Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF1787410
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbjHXPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjHXPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:25:35 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CC19B4;
        Thu, 24 Aug 2023 08:25:33 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 926968667B;
        Thu, 24 Aug 2023 17:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1692890731;
        bh=6mwukQ+8kMJlE3hbojY9BJBXmVCuh+WmE6/Do6/GmVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zTQqNgABM14lzprQFRJLHAcmjewExtCZkSDhFdsseG9EbiQ6nRN/UeA+vkVnIu0nU
         hupxYa8WMWkEhnUxYm3HsxBzKsFHM+BQUVwMwkjJSXQ9djn8NX0JuZIeg9uESZX79W
         0fDU6Go3XHG0d+QmhLlRV1/EeSiitHQ9ISXp+rFG5PgdOfn+qauHvUwCSNYTiC4CMy
         59ERdtYl8Xz3bTLGAP+sx1VD4qUkDnn4KIvaUpGZj/D/q55HDU2NS0k8QpyAkYoWa1
         ag7SfKeSmQoenBq/pgV/pSOnWboboOwfbWc4pT9qusyYTTn0BlXrGGcDdHS7nWOA4R
         HLB7cQTI1Op4A==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Aug 2023 12:25:31 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] thermal: imx8mm: Allow reboot after critical
 temperature
In-Reply-To: <20230824143652.529624-1-festevam@gmail.com>
References: <20230824143652.529624-1-festevam@gmail.com>
Message-ID: <cb7cd8c8eb68320848b3274390a5c373@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 24/08/2023 11:36, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, after the SoC reaches the critical temperature, the board
> goes through a poweroff mechanism.
> 
> In some cases, such behavior does not suit well, as the board may be
> unattended in the field and rebooting may be a better approach.
> 
> The bootloader may also check the temperature and only allow the boot 
> to
> proceed when the temperature is below a certain threshold.
> 
> Introduce a 'reboot_on_crit' sysfs entry to indicate that the board
> will go through a reboot after the critical temperature is reached.
> 
> By default, the original shutdown behavior is preserved.
> 
> Tested on a imx8mm-evk board by issuing the command below:
> 
> echo 1 > 
> /sys/devices/platform/soc@0/30000000.bus/30260000.tmu/reboot_on_crit
> 
> Confirmed that it goes through a reboot after the critical temperature
> is reached.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v3:
> - Add a sysfs entry.

After thinking more about this, I am happier with the previous v3.

The decision to reboot or shutdown is not something that needs to be
changed in runtime.

If the module_param() approach from v3 could be accepted, I think it 
would be
a better solution.

Thanks
