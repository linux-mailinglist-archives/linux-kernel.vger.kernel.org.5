Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B712F7B729A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbjJCUhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbjJCUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:37:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06332AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:37:32 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nm94qRJHbs3p2nm94qPxBe; Tue, 03 Oct 2023 22:37:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696365451;
        bh=IKG3F6hJ3v/L25Z0w91DgqZDC5nYGOA6uzkidIkVaf4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VBS+xN1HohHEC37JSmZks97ZPR+Inp0YSI+FNwPF/QAUA/KT3PAStE9KlOV02jVwM
         6851mKbQLhnbIh1Hzo/oKGRMfmJY2K45OU8ySY4Dmt57EPsT4+RzliOs3Zfa+uizUd
         Tu2LmWX9I2ZlWZ+H7LcuoCCaeS6UZuQUvPI+t9Zd0GCcyGIyJCh5INNQNTXkrdDcws
         NCwfANy1Ftq7BJG1HZwtyDhtxSeUG+FPh3d+HQsV1pXPDQqaLvbkdXCtKsA25mA4sx
         PnW6Xutl385l89APfyVNkKUki2TMRFJd0Q9u/IX3r0gXeZuoZ29d73BeSDeKrDJg8T
         d8iq8y881+TOg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 03 Oct 2023 22:37:31 +0200
X-ME-IP: 86.243.2.178
Message-ID: <29133480-ad61-482b-9b3e-d7c73344b2f4@wanadoo.fr>
Date:   Tue, 3 Oct 2023 22:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2: gadget: Fix a warning when compiling with W=1
Content-Language: fr, en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Ben Dooks <ben@simtec.co.uk>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
References: <5cf603809388aa04c9a02bbfe3cf531c20bb043e.1695466447.git.christophe.jaillet@wanadoo.fr>
 <2023100226-cloak-tissue-7efa@gregkh>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2023100226-cloak-tissue-7efa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/10/2023 à 13:45, Greg Kroah-Hartman a écrit :
> On Sat, Sep 23, 2023 at 12:54:24PM +0200, Christophe JAILLET wrote:
>> In order to teach the compiler that 'hs_ep->name' will never be truncated,
>> we need to tell it that 'epnum' is not negative.
>>
>> 'epnum' comes from in a 'for' loop in dwc2_gadget_init(), starting at 0
>> and ending at 255. (hsotg->num_of_eps is a char)
>>
>> When building with W=1, this fixes the following warnings:
>>
>>    drivers/usb/dwc2/gadget.c: In function ‘dwc2_hsotg_initep’:
>>    drivers/usb/dwc2/gadget.c:4804:55: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
>>     4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
>>          |                                                       ^~
>>    drivers/usb/dwc2/gadget.c:4804:52: note: directive argument in the range [-2147483645, 255]
>>     4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
>>          |                                                    ^~~~~~~~
>>    drivers/usb/dwc2/gadget.c:4804:9: note: ‘snprintf’ output between 6 and 17 bytes into a destination of size 10
>>     4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
>>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Fixes: 5b7d70c6dbf2 ("USB: Gadget driver for Samsung HS/OtG block")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Looks like the kernel test robot didn't like this one :(
> 

Hi,

unless I missed something, this was built-tested.
I use gcc 12.3.0 and the report is done with gcc 11.3.0.

Maybe the value range propagation algorithm of how the diagnostic for 
such potential overflow has been improved in recent gcc?


For your information, I got a similar feedback for another patch.
It was also built tested from my side, but the maintainer report that 
there is still some potential overflow warning.

Strange :/

CJ
