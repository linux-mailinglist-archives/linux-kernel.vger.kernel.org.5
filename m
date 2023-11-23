Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F177F60FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbjKWOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345677AbjKWOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:04:05 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D673DD44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:04:11 -0800 (PST)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTPS
        id 66xurlysFL9Ag6AJPr5jo6; Thu, 23 Nov 2023 14:04:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 6AJOrlCqaM0U26AJOrCanC; Thu, 23 Nov 2023 14:04:10 +0000
X-Authority-Analysis: v=2.4 cv=BuKOfKb5 c=1 sm=1 tr=0 ts=655f5bda
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=TyODs4qkaV_lWZKKSI4A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h+9YDrrgXihyBNGSPCRa97Nm187+ooBonzAaom98yPE=; b=KwvHoGfWlgXmuikl+1Fzj4t30L
        VQ0qOH+dNUtobfYPsP9I9LGWc/bDTU6mVz36H4IYlpdLS4jhgqKFtStlFX49JmCtWLHeyE6zAs8+W
        cFUmNYOHROW7K0IZIoQo6bugGtCs5tdjmZxoG8wsVfTGVIyiKACu1sKeEjEo6QLtIttDWJ+nXnPHU
        NsnfBbAIhxYKmYKPALZkl58EmokbyikK5moYtWX2R5PaWzc0abYFAyBnWoXR3ay68elB/V/u6cQqq
        /Bnm2Pto3F6250fdat1QlMJvKuD7/RunRIVoSKGDVEhblMYVvy/efERwRTqgsCzcueXsoeVs5d7Dj
        MH6r2s9Q==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:63657 helo=[192.168.0.25])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r6AJM-000Y6t-09;
        Thu, 23 Nov 2023 08:04:08 -0600
Message-ID: <f018b794-8af5-4c08-ae7f-0528a3e0f0e8@embeddedor.com>
Date:   Thu, 23 Nov 2023 08:03:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
To:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122222007.3199885-1-arnd@kernel.org>
 <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r6AJM-000Y6t-09
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:63657
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPZ8c1b8neACsz8C+3dNR4LSHoD8Kfymw85fuWfh/LLP7IAaVNC0XL9BxBxtrLDLD3ScpAqzdGUWD/fncv+LgA4QPx/+xVfgoHzapjPe6TgHjKWDuAbh
 LX58CFZKexRI97+4DNVTdYHnXbxPJeteNj37mjLaJ4B+7zi9fp4St/uFoQw0u6DJ6SBO3eFJ8r4IDhQHbf8CM6Eu2mKqsozpYt2bu6VoVBHGgEdaDAvTX84X
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 05:58, Borislav Petkov wrote:
> On Wed, Nov 22, 2023 at 11:19:53PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a
> 
> $ git describe 1b56c90018f0
> fatal: Not a valid object name 1b56c90018f0
> 
> I'm assuming that's in linux-next?

That's correct, yes.

--
Gustavo
