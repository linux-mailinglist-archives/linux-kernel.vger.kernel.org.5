Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB37F614B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbjKWOWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbjKWOWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:22:14 -0500
X-Greylist: delayed 1635 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 06:22:20 PST
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE8DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HegN/JokOC5Cr/ra274AGW9sR3rftIw8sv970+pSd7k=; b=l6pvcBENv8JrmMpHh6qfKz+3rM
        cvRvXrsdv6sYkFpiGcfJzb5pSatqH50Y6EuZzymPoC4st0NTCjOIl/sS+NteehG4zwNvbDP6vcQpD
        ZWkHoDv0cdKyK1eVDk6q1GMIlTblDC4czyAAoaVvHGCbv8Gls58ZPADN4a8RcRpP1Bt+zAVMAPJ+W
        zGuSIZEno1in3XoI27HSjJ2UbRF8Nd2kwP/D5wbMVrwd8V/8rPWPy9XK+lL5XIkWlCn4XJDtt1kYw
        fJxTJOmvxXK092bCnAgHkvA6HR8sQoqy85MwI1EIRGHxa6wv+SUM3kGsVS8PXxUtsgHR2wDAQ6Js6
        cA4vwMkQ==;
Received: from [167.98.27.226] (helo=[10.35.4.236])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r6AAR-004SyZ-GP; Thu, 23 Nov 2023 13:54:56 +0000
Message-ID: <1b937600-bfb5-4378-ba27-b4f3e0068cbd@codethink.co.uk>
Date:   Thu, 23 Nov 2023 13:54:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: declare overflow_stack as exported from traps.c
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
References: <20231123134214.81481-1-ben.dooks@codethink.co.uk>
 <20231123-blooper-very-cefbf92c0f05@wendy>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20231123-blooper-very-cefbf92c0f05@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 13:51, Conor Dooley wrote:
> On Thu, Nov 23, 2023 at 01:42:14PM +0000, Ben Dooks wrote:
>> The percpu area overflow_stacks is exported from arch/riscv/kernel/traps.c
>> for use in the entry code, but is not declared anywhere. Add the relevant
>> declaration to arch/riscv/include/asm/stacktrace.h to silence the following
>> sparse warning:
>>
>> arch/riscv/kernel/traps.c:395:1: warning: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?
>>
>> We don't add the stackinfo_get_overflow() call as for some of the other
>> architectures as this doesn't seem to be used yet, so just silence the
>> warning.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> I suppose this should also be
> Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")

Thanks, never sure if the Fixes: should be applied when it is simply a
warning fix and there's nothing actually being currently flagging an
issue with anything else using it (currently just the assembly)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

