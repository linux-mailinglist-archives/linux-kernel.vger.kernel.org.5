Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9036F7C6362
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376778AbjJLDox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJLDov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:44:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B5CA9;
        Wed, 11 Oct 2023 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5X7YKW++WxUcJ+6G5AkHQiR5GiU4yQQi5VuTzBvMGV0=; b=q7r7RueYUE+xjONkh0Wiz0EqXo
        S/E7clfEBDjMYQrFQbA/1AWEFx9EW+9FRCqp9P3mFLp+eZUbkVCQ+9nC+TCEW+e5RVnLIolsniWhr
        seIiPlBoI9KySsurTYxC0PuqXGfpEAXPkijRXNlsT1LKDTp3+VzQGVRP47tlhnssR9XM/HtH44Meu
        8giLYx0AO38HjfOYHdYAvMQXhYkOD0/1+UL8beJOLpzr2zb6xEKn/pS9rQGFoQMp0dDCwqVwZJPpE
        EcvJfIMERtmq24/6ZS/nLOjIJSG2RsQk7FgryDn14TPqpCpU35efiacmkx37i//tsaylh6j0u5C9H
        JEwnexDA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqmcz-00HImw-2A;
        Thu, 12 Oct 2023 03:44:49 +0000
Message-ID: <13eeb01a-2f4f-4c8e-b097-6e80d822862b@infradead.org>
Date:   Wed, 11 Oct 2023 20:44:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ssb: relax SSB_EMBEDDED dependencies
Content-Language: en-US
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20231007182443.32300-1-rdunlap@infradead.org>
 <20231008093520.42ead15f@barney>
 <22bc05d3-86e9-4cf6-aec6-10d11df1acc3@infradead.org>
 <e551fb4c-1e3d-4e1a-a465-5b88842789c6@infradead.org>
 <20231010204346.78961fc4@barney>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231010204346.78961fc4@barney>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 10/10/23 11:43, Michael Büsch wrote:
> On Sun, 8 Oct 2023 23:12:49 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> -	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
>> +	depends on PCI=n || SSB_PCICORE_HOSTMODE
> 
> I thought about something like this:
> 
> depends on (SSB_DRIVER_MIPS && PCI=n) || (SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE)
> 
> Would that solve the warning?

Yes, that works as well, although I prefer to express it like this:

 config SSB_EMBEDDED
 	bool
-	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
+	depends on SSB_DRIVER_MIPS
+	depends on PCI=n || SSB_PCICORE_HOSTMODE
 	default y

although if you prefer the way that you have it above,
I'm OK with that also.

Thanks for your help.

-- 
~Randy
