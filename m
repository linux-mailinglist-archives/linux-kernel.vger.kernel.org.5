Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC27598BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGSOne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGSOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:43:21 -0400
Received: from mail.mu-ori.me (mail.mu-ori.me [185.189.151.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A161998
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mu-ori.me; s=mail;
        t=1689777735; bh=5SzV9lZnY5Svy8uSTXRoJICIQHcSgzv2SVVYJuoUntY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WtHpcUGEZZpGQYx2qPOtOen1G7xu3ZuNZeyihmkfZcdiYuqIOUE7/hQFC5cW8TeoV
         kcfwItAnhDdtJ7yHVERI5lgITilYZPqNqvIpAKharUt4COz3aC2ybbNHPf+lERxcvd
         oKRgHuy9IH0hbfbkwons3WcvREzHc+8LHqSINrRtSHbwU13pP192hbpkmcq1/mdjJc
         28Atx72s3drh3NW/g5NhjDqfU9aiuLHLe+KoRK1T1ekA59hMLO7HaQpE3i3uoA5Z5c
         n5IeBNGahWvWBMyW71NioAVhcg7jdplyYMooxdtCVhxpxCzdClcgzcPdSj+OtlzDp2
         3B73i56FK74bQ==
Received: from webm.mu-ori.me (localhost [127.0.0.1])
        by mail.mu-ori.me (Postfix) with ESMTPSA id 403EE5FE84;
        Wed, 19 Jul 2023 14:42:15 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 14:42:15 +0000
From:   "Drew B." <subs@mu-ori.me>
To:     David Laight <David.Laight@aculab.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Misbehavior with setsockopt timeval structure with -fpack-struct
 enabled
In-Reply-To: <4ae99731d4b54c1d98f6b77f6e67d295@AcuMS.aculab.com>
References: <559f4003c263a7aaa873cbc80947cc57@mu-ori.me>
 <8049a5598fe54002851b2224ada58209@AcuMS.aculab.com>
 <41150408e841274d792ef0a905ee1c52@mu-ori.me>
 <4ae99731d4b54c1d98f6b77f6e67d295@AcuMS.aculab.com>
Message-ID: <c8f4da177546339dfd935ed4f7441a6a@mu-ori.me>
X-Sender: subs@mu-ori.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

>> #pragma pack(1, push)
>> ...
>> #pragma pack(pop)
> That is M$ C :-)
> For gcc you can use __attribute__((packed))
Noted. I new about things like __attribute__ ((unused)), but forgot 
about mentioned above. My thanks!

> You also pretty much never, ever, want to 'pack' a structure
> unless you need to match a 'hardware/protocol structure' that
> has fields that aren't on their natural boundaries.
Straight to the point! That was the reason why I "packed" the things :).

> Everything that uses a structure has to use the same alignment.
> So 'randomly' packing system structures will break things.
And by 'randomly' you mean using the gcc param instead of attribute 'in 
place'?

> If you need to make structures portable between architectures
> then add explicit padding to ensure 64bit items are on their
> natural boundaries (as well as byteswapping as necessary).
Frankly speaking, the size of the data is relatively small. And 
byteswapping thing is resolved through the union and byte array, so 
everything is being sent as a bytearray of known size and then the type 
casting thing happens based on the header information.

Kind regards,
Drew.
