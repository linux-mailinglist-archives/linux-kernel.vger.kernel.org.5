Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29C75FEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjGXR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGXR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE0199C;
        Mon, 24 Jul 2023 10:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E10F661357;
        Mon, 24 Jul 2023 17:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8E4C433C8;
        Mon, 24 Jul 2023 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690221500;
        bh=u9D54zq4EdgBWh/eN7pPZ8Dj/7qWB0LLjRe/rMAT3ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cKcJFTHDevuSI0ZlnIWdCBK0O9NxDuj0WLboJT6+Zk0IyAg5JNx/x1ak2bOLT0Yjy
         N/wiH824oULVzq+bSZPdotHXs1+XAYTcfybPV3Hd7k05viyvSDI54vGuE5Uj7OPwif
         L/PmpnN8mGDvJZvy8hrWZdPxATu88KRrwWVVtkMU=
Date:   Mon, 24 Jul 2023 10:58:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 0/4] memory tiering: calculate abstract distance
 based on ACPI HMAT
Message-Id: <20230724105818.6f7b10fc8c318ea5aae9e188@linux-foundation.org>
In-Reply-To: <875y6dj3ok.fsf@nvdebian.thelocal>
References: <20230721012932.190742-1-ying.huang@intel.com>
        <875y6dj3ok.fsf@nvdebian.thelocal>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 14:15:31 +1000 Alistair Popple <apopple@nvidia.com> wrote:

> Thanks for this Huang, I had been hoping to take a look at it this week
> but have run out of time. I'm keen to do some testing with it as well.

Thanks.  I'll queue this in mm-unstable for some testing.  Detailed
review and testing would be appreciated.

I made some adjustments to handle the renaming of destroy_memory_type()
to put_memory_type()
(https://lkml.kernel.org/r/20230706063905.543800-1-linmiaohe@huawei.com)
