Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4E37F64CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbjKWREs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjKWREp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:04:45 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B437C1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:04:50 -0800 (PST)
Message-ID: <77c3ad35-24e4-4bf4-87a1-f48e13a6b838@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700759088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+oX6Z1R5D902d7QsFYgso+yPiFC9aIghMuoj3BGEfk=;
        b=jQfW6O848KtMwh90BwxowE88Yb2tw+fOohmBQXIG8fxTKGnbKn2PtIDmXCf4nr6b33NCYX
        0e5e8sXTeNgxpDwySP5U7QKWB/PF2eUQjAWP0ZZ3z3DycIHjYqF/wHRzBzo66GoB5Ot3S2
        TFre8bWupfsIEedGtc55MJAzC401+bU=
Date:   Fri, 24 Nov 2023 01:04:43 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev>
 <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
 <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev>
 <CAA8EJpowjhX=LL-9cnQL4pfCei63zNkCGW5wGOeeFxcnFpNCVA@mail.gmail.com>
 <00ba2245-0e48-4b21-bcd4-29dfb728e408@linux.dev>
 <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/11/23 16:08, Dmitry Baryshkov wrote:
>>> The host can not specify the
>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, it will cause a warning here. And
>>> it can not omit the flag (as otherwise the first bridge will create a
>>> connector, without consulting the second bridge).
>> The semantics of DRM_BRIDGE_ATTACH_NO_CONNECTOR flagare implement-defined,
> No, they are not. Semantics are pretty simple: do not create the
> drm_connector instance. Pass the flag to the next bridge in the chain.
>
>> for our case, I could just ignore it if their
>> don't have a signal(DT or ACPI) tell me that there are multiple bridges
>> in the chain. This depend on community's attitude.
> Ignoring a flag is a bad idea.


Can you also read the code in the bridge/lontium-lt8912.c please?
when flags == 0 is true, the lt8912 driver will just create
a drm_connector instance in the drm bridge drivers. The behavior
is similar with this patch in the perspective of spirit.

And the most important thing is that no matter what the flag the upstream
port is passed, lt8912 just always pass the DRM_BRIDGE_ATTACH_NO_CONNECTOR
flags to the next bridge. Does this count as a kind of ignore? or

This is to say that both the lt8912 and the tfp410 drm bridge drivers are
allowing create a drm_connector manually in drm bridge drivers. They didn't
being asked to move the drm_connector related code to display controller
driver. I don't know why I can't follow this way?

Do you really read the code before do comments or I failed to understand something?

