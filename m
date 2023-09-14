Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F35C7A02D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjINLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINLmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:42:03 -0400
X-Greylist: delayed 8386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 04:41:59 PDT
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net [178.33.251.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3CBCC3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:41:58 -0700 (PDT)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.108.16.216])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id B04F425E05
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:02:48 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-hwfnb (unknown [10.110.115.90])
        by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 45B251FEA2;
        Thu, 14 Sep 2023 08:02:47 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net ([151.80.29.19])
        by ghost-submission-6684bf9d7b-hwfnb with ESMTPSA
        id o3rgISe+AmVUCAAA7wW1ag
        (envelope-from <rafal@milecki.pl>); Thu, 14 Sep 2023 08:02:47 +0000
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 10:02:47 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
In-Reply-To: <3f175090-4c5f-4821-9155-06c4868d0489@arinc9.com>
References: <20230914064922.3986-1-zajec5@gmail.com>
 <3f175090-4c5f-4821-9155-06c4868d0489@arinc9.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d0545951a0e787792c5cc20eca66a72a@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13702201867296680943
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudeiledguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgffhueeihfeitdettdehfefhieefffevkedvgeetteekteejtdeivddvhffgffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudehuddrkedtrddvledrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 09:56, Arınç ÜNAL wrote:
> On 14.09.2023 09:49, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> This driver uses MMIO access for reading NVRAM from a flash device.
>> Underneath there is a flash controller that reads data and provides
>> mapping window.
>> 
>> Using MMIO interface affects controller configuration and may break 
>> real
>> controller driver. It was reported by multiple users of devices with
>> NVRAM stored on NAND.
>> 
>> Modify driver to read & cache all NVRAM content during init and use 
>> that
>> copy to provide NVMEM data when requested.
>> 
>> Link: 
>> https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
>> Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
>> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
>> Cc: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> This is a bug fix, could you add a "Fixes" tag so it will be backported 
> to
> stable releases?

I suppose we could try:
Fixes: 3fef9ed0627a ("nvmem: brcm_nvram: new driver exposing Broadcom's 
NVRAM")

Srini: can you append it while applying if you find it OK?

-- 
Rafał Miłecki
