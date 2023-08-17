Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240D0780117
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355780AbjHQWgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjHQWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:36:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58F2722;
        Thu, 17 Aug 2023 15:36:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68730bafa6bso1022180b3a.1;
        Thu, 17 Aug 2023 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692311768; x=1692916568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu2Bex9ZZEBUMNHHS416lQn75kmUTiLhrrmV505zb7o=;
        b=Dsfqn/KeOcq3Kau6h0piGLYueIIe87DTrRTbH5UQxxCJrV0Ni668dHX/pP6LPyNgte
         oPiwJ5mJ4UJim2UrxdErPW0kZOJKPdf/sZ7uaU5Kb7RrDNaBJ4EmkmfafkvQDjFBrA/6
         3B2PwlnWqKsQZZpLLJkGMtAcqjLVXVpHAatbnnOw4LAb+Zi6jQfX5VQMi6Qnymp2W10x
         gQu6Cp1KqlzNs+8A2yswa0UNydv/kACZKBRA9vO9lezvTTo+ieZSC5qUm3gQbB9sMg5S
         /DZGWW0Lb0JqCASs/kdaU9L2PGPlFSgnzs81jniJmneCnzxA94HKQFnLYhF/xEBMbTHy
         Padw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692311768; x=1692916568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu2Bex9ZZEBUMNHHS416lQn75kmUTiLhrrmV505zb7o=;
        b=YXWLlHO8cuN/QzAfSlitj0DdRTcL8WivvDB9h+tKVKZ/kJxH9arGlCjR5D9as4tEU3
         kM8YD4BC5rOSgoOVHh47zxcwrtG9Z4kbl/JhOVidht8OjkVi9IwxQoyWLq87evhrlpMA
         7ljggAjTfWdPiceYgW9su/6JXAKZ+sc3xsYquIj3A/YnVf8IvWvBTbS+x2rv8oPiLfKc
         Lnvrv/AwVqj1xq6et9DZ/6By43n3wIV7uMEpiXMUbUqIbV4kfVULFfvpT6W/Zd5pZxY/
         y/TIWpAUAhVVrhmIgGF0HlTA8c44TgMUgD7JLlZYQG3hkC29+xbozrjPiiLeltHpjK74
         fnTw==
X-Gm-Message-State: AOJu0YyrpBZ6GkWFtXbv30thBeXkRdJaVADmRQ6Lhhztdikm8ZsZm2+7
        Fw0o4cEXll+s93KFgRrLFYw=
X-Google-Smtp-Source: AGHT+IEcKbP6rcb7SmE5I4FjVf2tXw9JRpsBkijEOr9G6YFSnvmLL4DAtEUf/V199GW507ni1552DA==
X-Received: by 2002:a05:6a00:138c:b0:688:79c6:1c13 with SMTP id t12-20020a056a00138c00b0068879c61c13mr962118pfg.9.1692311767976;
        Thu, 17 Aug 2023 15:36:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j25-20020aa783d9000000b006873aa079aasm257756pfn.171.2023.08.17.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:36:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Aug 2023 15:36:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/7] rtc: Add support for limited alarm timer offsets
Message-ID: <571107fb-9b2d-425d-9201-25bae900341f@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816150353137debc5@mail.local>
 <8079bdf4-f790-451b-a2c2-be4e23c0c3a1@roeck-us.net>
 <20230816161435bd2bbd4a@mail.local>
 <6ffc915e-ca91-4b64-b7a5-f13f60df8b1d@roeck-us.net>
 <202308171951177626a54c@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308171951177626a54c@mail.local>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:51:17PM +0200, Alexandre Belloni wrote:
> On 16/08/2023 12:12:14-0700, Guenter Roeck wrote:
> > On Wed, Aug 16, 2023 at 06:14:35PM +0200, Alexandre Belloni wrote:
> > > On 16/08/2023 08:50:12-0700, Guenter Roeck wrote:
> > > > > I'm fine with the series, however, this doesn't solve the issue for RTCs
> > > > > that have an absolute limit on the alarm (as opposed to an offset to the
> > > > > current time/date).
> > > > > 
> > > > 
> > > > I thought that is checked by rtc_valid_range() in rtc_set_alarm().
> > > > Am I missing something ? Of course that assumes that the absolute
> > > > maximum alarm timeout matches range_max, but I didn't find any
> > > > drivers where that would not be the case.
> > > > 
> > > 
> > > There are RTCs where this is not the case. When this is far away in the
> > > future enough, the usual solution is to clip range_max which works but
> > > is not really great intellectually.
> > > 
> > Do you have an example, by any chance ?
> > 
> 
> I'm sorry, I've been looking and I couldn't find it anymore. Don't
> bother with this for now.
> 

I have been looking as well and did not find it either.
I'll go ahead and send v2 with the suggested changes.

Thanks,
Guenter
