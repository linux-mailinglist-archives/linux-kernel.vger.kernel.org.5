Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22E75CB1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjGUPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjGUPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397353A86;
        Fri, 21 Jul 2023 08:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE04861CE8;
        Fri, 21 Jul 2023 15:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B21C433C8;
        Fri, 21 Jul 2023 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689952302;
        bh=R0NhFhytJ7ntKMBnmoZsaLDFPS7OOg0XwxgrSgryfZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaY/CC9CHcS0AKIP12EvojQB3JHtnnHgSo6sS6QBUtZq/2bcEF/2S2QFUJdksYy5p
         /gBv+ubGoXqxgeNnfCYkon4nZV13JjnP10+m8w3tYLnUzWo3at4qcoE8XkKL+SvfwA
         mTwKzbFbkaBvVc8NOWhRgKHGPy450gaygZFm0xwmuUv+djG9zOjZ2CdY2Y5slc8C1Q
         PIBg59QZy0jRH94b6jAg67YEwOjULAhlj2iXshb0/PxIOV2aGW9mywMRDsK5hN1pvm
         nXGwvQdeTyTEkXdcr+6eAXhpw5nBLWkeNcoebRRz8KQ60P7/Zsb7e44V/vYiX7/Dqz
         PXfL5fldCah9w==
Date:   Fri, 21 Jul 2023 11:11:40 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rob Barnes <robbarnes@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.4 01/12] platform/chrome: cros_ec: Report EC
 panic as uevent
Message-ID: <ZLqgLDwKN+KngEAf@sashalap>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <CA+ASDXMZ_ZnJfpsY-8ZRByiox8HCSZeY08MvGSpznLYBtVR1bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXMZ_ZnJfpsY-8ZRByiox8HCSZeY08MvGSpznLYBtVR1bw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:46:21PM -0700, Brian Norris wrote:
>On Sun, Jul 2, 2023 at 12:51 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Rob Barnes <robbarnes@google.com>
>>
>> [ Upstream commit 2cbf475a04b2ae3d722bbe41742e5d874a027fc3 ]
>>
>> Create a uevent when an EC panic is detected. This will allow udev rules
>> to trigger when a panic occurs. For example, a udev rule could be added to
>> capture an EC coredump. This approach avoids the need to stuff all the
>> processing into the driver.
>>
>> Signed-off-by: Rob Barnes <robbarnes@google.com>
>> Reviewed-by: Prashant Malani <pmalani@chromium.org>
>> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
>> Link: https://lore.kernel.org/r/20230509232624.3120347-1-robbarnes@google.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/platform/chrome/cros_ec_lpc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
>What sorcery determined this was a valid for-linux-stable patch? It's
>a new feature, and definitely not a for-stable candidate. Please
>remove this from the queue.

Dropped, thanks.

-- 
Thanks,
Sasha
