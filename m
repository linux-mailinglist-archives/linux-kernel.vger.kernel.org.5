Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9969D7D2D01
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjJWIm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjJWIm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:42:56 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5DFDD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:42:53 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SDTGd4JwDz9sTb;
        Mon, 23 Oct 2023 10:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1698050569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYr2H+MAjRLIImn6u5izyM0A6DQVXuI2FZoqu1Z6Zbo=;
        b=jdaPcrNcB0xPtWIjsdigdQ70FAWRJl6niRDY5quiNqwNwysBi+0kCJRpbvjn3YMhihAwO7
        HN/9HBOcph42sMLVmWNH5QGfZsUjlc2qCTmgsfmmRdcmG/qJvJMwhn9AeFcNzvvEsNIrXt
        LGIAtefpIutewUUSbk5o4NvQy/SYmxCMTgkrRHXpJVS2E8ftQNfUNq5gjh3/a+UzM9Dy9j
        ZBMrAzibEJh7QWT/OVTeTq18o/lHBd+VDuAHcbFTB8fZoVw6qLZH8SUeFp5rG77ntcV0wZ
        obfKOzZW3aTFipizNpD1UgzRmabU/SZvV9gY/kMWD8ZY29hPBkEd6zCRdwZagw==
Message-ID: <745e35ee-d617-9ce0-8b4e-795c84a5af48@mailbox.org>
Date:   Mon, 23 Oct 2023 10:42:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
Content-Language: de-CH-frami, en-CA
To:     Simon Ser <contact@emersion.fr>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, hwentlan@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
References: <20231017092837.32428-1-andrealmeid@igalia.com>
 <20231017092837.32428-5-andrealmeid@igalia.com>
 <CzEtDALWvF3EU4DDLLEmH3ms0B25PbsEHRU9b_IqwfyhzdG4zC-XXAU6fm2PnMcngAYmntH7s4iuew0vocN6cO8zUit8kgi-Sb1hBQXNYiw=@emersion.fr>
 <3r5-_03WC5dK3LaRt1Is78zD_bmT2aaGc5h9jpUGzo2o5GCtGP1zpQNzUxglsieewFklY7xwTrOS9jtI18YlNnnzHNx2Ccw9yM2NuJpDQZU=@emersion.fr>
 <8c1641e4-a7e2-ecb2-ab7a-c6e2bb3e951b@mailbox.org>
 <Bi9El_nuZXA997YlVyCzD5s7KfP820IVUuYiB69mgXnjQbfCgOucCBe6aKvSFrMzB_9DwxO2lli_MqLzMuGZ-rmrRp57vePsTwUarEweLJs=@emersion.fr>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <Bi9El_nuZXA997YlVyCzD5s7KfP820IVUuYiB69mgXnjQbfCgOucCBe6aKvSFrMzB_9DwxO2lli_MqLzMuGZ-rmrRp57vePsTwUarEweLJs=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5f900b922b850b866e6
X-MBO-RS-META: wpapn7uy8zys441xyzy5gwxubqa7ewo4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 10:27, Simon Ser wrote:
> On Sunday, October 22nd, 2023 at 12:12, Michel Dänzer <michel.daenzer@mailbox.org> wrote:
>> On 10/17/23 14:16, Simon Ser wrote:
>>
>>> After discussing with André it seems like we missed a plane type check
>>> here. We need to make sure FB_ID changes are only allowed on primary
>>> planes.
>>
>> Can you elaborate why that's needed?
> 
> Current drivers are in general not prepared to perform async page-flips
> on planes other than primary. For instance I don't think i915 has logic
> to perform async page-flip on an overlay plane FB_ID change.

That should be handled in the driver's atomic_check then?

Async flips of overlay planes would be useful e.g. for presenting a windowed application with tearing, while the rest of the desktop is tear-free.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

