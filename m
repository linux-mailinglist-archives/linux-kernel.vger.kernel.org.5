Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F117F61C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345849AbjKWOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:41:34 -0500
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D265D44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:41:41 -0800 (PST)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTPS
        id 5wCTryyvxWcCI6AtgrzEdB; Thu, 23 Nov 2023 14:41:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 6AtfrvGr1GKIc6AtfrY0bO; Thu, 23 Nov 2023 14:41:39 +0000
X-Authority-Analysis: v=2.4 cv=E+beGIRl c=1 sm=1 tr=0 ts=655f64a3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=p2ykMCA_h0iMFoP7yXwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dt4d8CBI9R6xcGZ6xTcYn2JKpbyJhiop6wJrJXud98I=; b=cr4M38J8GnhaQnN3H4Vp4PuYJv
        1+ud3IqycQDgGP20zVdRNLVlM+EoAnF3W4AUEz4K0Y/PHFxC1zIrj6EruQB9vPbWPYl2kJGrumdcK
        YZ0oyUAOINI7F7mRg1SiTMICNWscWz8pVEqvTI3KixUgjbFOP9TSKpiCP/hD6YhkrUSKoN/WxDhzh
        Dy79TkjPCHw+jaRUDwqdHxI5WsRvLl0sTCeYKdjxQSHTEW+Lb3KGEu26C35BxMdyPV9GhUyTnza+5
        1VRfOX8jvcQkBNYgrYrTDXffnsfU9lhU7rQEsyXk10EdjhhkXOkV/m7o8H88fB6lShVURwU9qYf6K
        GajJnMRA==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:19365 helo=[192.168.0.25])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r6Atd-00174u-1i;
        Thu, 23 Nov 2023 08:41:37 -0600
Message-ID: <ece872de-46fa-4138-959d-28e76e6b5edb@embeddedor.com>
Date:   Thu, 23 Nov 2023 08:41:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
 <f018b794-8af5-4c08-ae7f-0528a3e0f0e8@embeddedor.com>
 <20231123143019.GDZV9h+zIVj5pBQySh@fat_crate.local>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231123143019.GDZV9h+zIVj5pBQySh@fat_crate.local>
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
X-Exim-ID: 1r6Atd-00174u-1i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:19365
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD0pt5avZCAR0xRYZCbAe+SWuI1jpMM8ZHcwJnpvlM5AZhlwMbVuEXDAm2tosbfvR5JRrE02ywpsc31NuYnd5CrNQ141K4LHCEx8tl/dhQtADPZaw2Cu
 S/bRD5NO20QtGYsW8p4cBf8Nm0oWWd9D5NjCW4hbi/fdLNdSle5oEP8NYMT532i+gbMjvyWY8mHt3CW9CHhNP1OsXFO3bLM/h918PUKDlETTe26/PWwznuz8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 08:30, Borislav Petkov wrote:
> On Thu, Nov 23, 2023 at 08:03:58AM -0600, Gustavo A. R. Silva wrote:
>> That's correct, yes.
> 
> Commit ID is stable enough so that it doesn't change?

Well, it has changed a couple of times in a week.

> 
> I don't want to commit it now and it would happen to change later and
> I'll have a stale reference in the commit message...
> 

To avoid that, I would just say (in the changelog text) that this patch
is fixing some -Wstringop-overflow warnings, without specifying any
commit ID.

--
Gustavo
