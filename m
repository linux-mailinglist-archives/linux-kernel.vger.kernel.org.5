Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA27E15EF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjKES4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKES4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:56:07 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 10:56:04 PST
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0CED8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 10:56:04 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1699210563; x=1699217763; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=Yi3ZhkzUKG+q8LbzxYY/3xmuWMmLwTf4+vaaMTe7hsE=;
 b=cRLkExwgliUKAnwMQCiBgUXE2pLE0d6w4jUZqD9ydxRvgclzmTzex7/tqQD7vqP6kCeyI8xMlKL9swBCDbmNgk4V39hmG9wsmRqL1atR75ngUo7kmtUg/ku9qZqjXdrl8eSgOYuDeygIb/oLAO9akDvi+Tku4/m7dhIJcplViz+qVVCrq90IqmrGJnunQ5mgJwtuSkQP+7SJPZHKzE+33FDnL1enW5OTTIFGxYlOVk9X5vgGoOTB0HF+TFFQgJSSPXcAev1RKS8IhychSHenw7r0nSVx6wJyMMI3AspfnyNaDpuvuEcNNb+XvLCwWlvYTAc58FzThpy7JFob8dcAZg==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by b5fcd0d995c4 with SMTP id
 6547e415cf03ca46bac0c8d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 05 Nov 2023 18:51:01 GMT
Sender: james@equiv.tech
Date:   Sun, 5 Nov 2023 10:51:00 -0800
From:   James Seo <james@equiv.tech>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk
 800 G6
Message-ID: <ZUfkFHmrlnL7gbfG@equiv.tech>
References: <20231103181931.677796-1-james@equiv.tech>
 <dec086cc-7403-4a06-b860-aae6daf8f0e7@roeck-us.net>
 <ZUZsPO9aN+E3qAng@equiv.tech>
 <2b48b41d-7d82-470a-a40e-c8f3c9de94dd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b48b41d-7d82-470a-a40e-c8f3c9de94dd@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 09:29:43AM -0700, Guenter Roeck wrote:
> On 11/4/23 09:07, James Seo wrote:
>> 
>> #define HP_WMI_WSTR_INFO(name, wids) {					\
>> 	.matches = {							\
>> 		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),	\
>> 		DMI_EXACT_MATCH(DMI_BOARD_NAME, (name)),		\
>> 	},								\
>> 	.driver_data = (void *)(wids),					\
>> }
>> 
> 
> Quite frankly, I dislike multi-line macros because they make it (more)
> difficult to understand the code. If that is where you want to go,
> I'd rather keep the current code (or wait until someone else maintains
> the hwmon subsystem).

OK, I'll remove that macro if I end up using a DMI table for this. 

>> Out of curiosity, how would you feel about just adding full raw WMI string
>> support now? It wouldn't take much more work and for various small reasons
>> it's starting to look like a better idea to me.
>> 
> 
> I don't know; I would have to see the code.

I'll submit something in a bit.
