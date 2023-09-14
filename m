Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19F67A1028
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjINV75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINV74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:59:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE051BFA;
        Thu, 14 Sep 2023 14:59:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF368C433C8;
        Thu, 14 Sep 2023 21:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694728791;
        bh=GxKaFk3rplvM7m0rL6kO5iEM50r31EOuHsWyk+7a2TI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IU1PccVk5kvDjWqDTktqH3CShMMjSyl97m9r0daFoqI4QBksLbiaUIFxLfKfBRy1L
         U5nKlztxYyKQs55BGeJW1hl26B5lTbfL62sYki8RbmwBm2jz1atbz/7W915nAf6zP7
         Q94oK61aE6DGqRwhwmp8ac5DwH07wwCFRsL4tWpD0AVpnhSC6Cyln5F8+YajQfvat8
         806ZrdKxdyzriO3rM+YRuxyvbDUXIvbrQtRefcvsdHPOj87MQyCJjYPOcclTfNaZuH
         Ka22l4o2QBn7RbXFgJaazIxY67wBLvRwrQHeNLovvBehmnvjEh7r0WKus4Zg5gT9nV
         pw26vPQUL4Qiw==
Message-ID: <c2cc1965-f041-5bac-4d57-12ce1b582a8e@kernel.org>
Date:   Fri, 15 Sep 2023 06:59:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
 <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
 <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
 <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
 <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
 <b919c7fd-babb-5557-dd8d-c2b8bb428d54@bell.net>
 <4fee8886-daa3-fb03-f9e7-89358fb5fc38@bell.net>
 <b9ceba24-345e-20dc-783b-3759a9819359@bell.net>
 <10887293-fa2e-83e1-9305-487905a8afd2@kernel.org>
 <3e4040cf-bb54-7652-72cc-0ad2d1288cb8@bell.net>
 <bed98fc9-fb84-4912-6c73-5b7db575c375@kernel.org>
 <ea24cb95-f129-8297-6779-995decdf7e2b@bell.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ea24cb95-f129-8297-6779-995decdf7e2b@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 00:07, John David Anglin wrote:
> On 2023-09-13 10:24 p.m., Damien Le Moal wrote:
>> On 9/14/23 09:29, John David Anglin wrote:
>>> I think the issue is with the root ST373207LW drive.  The console output indicates that the
>>> ROOT drive doesn't exist when the boot fails.
>>>
>>> Your change only appeared to affect actual SCSI drives.  That's why I tried disabling CDL.
>>>> Could you send a full dmesg output for a clean boot and for a failed one so that
>>>> I can compare ?
>>> I'll try to get this together tomorrow.
>> Please try the attached patch. That should address the issue with your drive.
> Mainline and v6.5.3 both booted successfully with the attached patch.

Great ! Thanks for testing. Posting the patch.

> 
> Thanks,
> Dave
> 

-- 
Damien Le Moal
Western Digital Research

