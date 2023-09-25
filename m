Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CAD7AD6A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjIYLEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYLEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:04:38 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A06C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:04:31 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 2CBBE480A13;
        Mon, 25 Sep 2023 07:04:31 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1695639871;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=/2nRSgIGwcIXLfFGBRBMlC+RuoWnlLiBvDoLOCxIysk=;
 b=1UpFARj9MX0XUAo9Z8r3Hx0naiG5hLe1Xir7vgp897x3iJILNGBoP8pxB51rNVVNX8sD2
 qkFt2fBROA73mcCBQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1695639871;
        cv=none; b=sfP58aqPcFi+rdLzNBiJ/jXbtAuDqbbYo5NFdfcsOZkp4aRy1tdzEMiCRpBsrWKQdXs0rQRTnBP5ZgItv/CqSGEGkKlmnjINLP+87mX4tqZoiM5zVQYZDzYodDnPjbfPl1PEeKgNBOiL2e1XAdBsy90rs1idk8tJiyq5QduT4fWP5GIiwA4XzbjfBwuoPvzUiMgSaqpWtxf4AWDNBdl3VE4vdbY6H0+tPv5suOZv4orPjZi6DXlJkOcQUO+Ts91hjM9fu99s4S+S5AWNF/VATD4RDD8+Y2DFOyoWprxiNWthYpEWlmBAhhLkk7b8heHEL8rjRCMhobktcWwlaA5b1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1695639871; c=relaxed/simple;
        bh=KzpP1OvmQ/8FDPtIo74w1/eELbL686mZ2lPBLe4BJy0=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=BFCNlpXDdgfn31KSEioNyYOJyp4yYaP670eCA8a8TM0uF92a4gcRByacevCeKUzLDnGct2y17gz4egv/WZBj08lf0wJbCnL8v48+MJzfCWF45xWW2LfuF8GxDk/SPv+PNbudEs21G4gpQLa4L/d93WtAoBk8F9CtRq8fyJnAPl0pcPhjEeufGPIapmH+LVmb8nkdB+8HYrG5XwzoyRC5QwP/mHplTd2/p7nl/sUMs2o/Sf+p9zOLwoy3sOEKX12XCw/oMO5g5ZzsJ6hiZTlSDaIvB9F7yABR8Nnk0FVoLkQhXPJUhkkt92q0wL0bV1sTuiL11hlT8npzfwKBuGUA+w==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1695639871;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=/2nRSgIGwcIXLfFGBRBMlC+RuoWnlLiBvDoLOCxIysk=;
 b=QP433d9r4UplzFZolnYExFKGXyI3a1WLLUjJY/vmRdQ4S6QqS28kjkY28s9LqKRIOkiYc
 AWNgGTsWdJEMdUUEHaIqNNg7fBh21SiPgmc+/Oh7bAM9904JGPGMU4Mptm3ebVTmHPQ9lnx
 jZwoEw4ipEDK3MznF6WJ3NjXXPOkMK9sxrvS2sUvQNuSgl599H7Er0/eS4LFpYaZ8hrbIE3
 gpMVIuOmJmQeM885w/OQpaNJbXv3Ke8eprN1yIKvq7uZNH+D0lFU+VH+wYJYWxmWEBu1vWZ
 8pnwtqqkn+X5EVBO9VOrIJJGMkNzKZCY5UuNEjz3qVPkVKEFubfv+4/dYb7A==
Message-ID: <3ce3f25e-6dd0-494b-8aa8-e94f49ce8db0@sapience.com>
Date:   Mon, 25 Sep 2023 07:04:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux regressions report for mainline [2023-09-24]
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <169557219938.3206394.2779757887621800924@leemhuis.info>
 <2023092522-climatic-commend-8c99@gregkh>
 <0efa9992-c2f8-4ae3-943f-9b17d0e1b1b7@leemhuis.info>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <0efa9992-c2f8-4ae3-943f-9b17d0e1b1b7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 05:11, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 25.09.23 10:02, Greg KH wrote:
>> On Sun, Sep 24, 2023 at 04:17:40PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
>>> (2) Nearly six weeks ago there was a report that 101bd907b4244a ("misc:
>>> rtsx: judge ASPM Mode to set PETXCFG Reg") [v6.5-rc6, v6.4.11, v6.1.46,
>>> v5.15.127] broke booting various laptops (many or all of them are Dell).
>>> This apparently plagues quite a few users, hence there were multiple
>>> reports (see [2] for those I'm aware of). At least Fedora, openSUSE, and
>>> nixOS have meanwhile reverted the change in their latest stable kernels
>>> [3]. I one and a half week proposed to revert the culprit when I fully
>>> noticed it's impact, but Greg wanted to give the developers more time.
>>> We finally have a fix in sight now [5]; someone affected replied that it
>>> helps. Not sure what's the right way forward now. But overall this to me
>>> feels a lot like "this is not how a regression should be handled".
>>> That's why I wanted to bring it up here in case to ensure your are aware
>>> of this.
>>
>> We now have confirmed testing that the proposed fix resolves the issue
>> so I'll be getting it to Linus in time for the next -rc.
> 
> Many thx!
> 
Thank you all for taking care of this - much appreciated.

gene

