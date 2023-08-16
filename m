Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5767577E975
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345733AbjHPTNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbjHPTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:13:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C572702;
        Wed, 16 Aug 2023 12:12:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso5142284a12.1;
        Wed, 16 Aug 2023 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692213178; x=1692817978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1ivUNRFJ12GoIJ0pYuFreIGn8XBvyUYANZm2nAAOYU=;
        b=e7l6xIW0pFcMSsqjPqPzcvt9HscU2DtlEkXjOkvDuoTU1j3UGMJvRJjL5GL1kApS6k
         On2Ysdupdc878QkNCymTLs0doKSdzS4a0nseRl6+iRbCIaoIfGMjyvaYdJLu/DM+TeG7
         nldVSDOLcdm7XXuVEjeVEjQr3LIO4dAtB53iHdeJZ92zidjPZ3sK4TscUkcPIbvF1sXF
         xPPBsjPQ33GlOWDAhysX6QvjOGumo/1RQpduz5/Qy1uQZof2ga0sSqVLfCMyF972iDJK
         wJgImFNV59g1Y5gOFCaV4WTYORXTPhM9tZLb8OmbKQFELjawwbkriRIeYunqE5A2K7AR
         FzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692213178; x=1692817978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1ivUNRFJ12GoIJ0pYuFreIGn8XBvyUYANZm2nAAOYU=;
        b=c1BOik3dEzryxvgYyOP1b9DKtfhZFmOU+r0Fnwqr7zpkjvN+3fbETJYA6hapZmOYJb
         p87HeDIXtqrlNZAAHGDPsmoHOYk/D49VoulyNBu+j5ZgFzeanUtD8ud7CmvZKJN9Upq8
         XmkymhsrFvNk1xyYSi5bBEI6xOdD0e9ulN8sc9Qh7XsrnJX0nUgGasqY9m0V0TmN21sK
         SXrOYgv9EGJDR1JMRKc+ZSU8yxTW7MyoLN31HUkKK2GSjuMGnbNw8ErK4VCbt912I2DQ
         Vf4RQjOQAfv5YilbECFEe+vgDlG1AER4oFHGLEQSX/FHwTLSM69JwHZQVldo2jdLSDu8
         fkrQ==
X-Gm-Message-State: AOJu0YxOrtdIUEGDWaBxy9LRRF3wNLcMKX/vSU/G0eaN3MuM55/uNE0w
        zAau1LaP+/zMpxESFS9+FZw=
X-Google-Smtp-Source: AGHT+IFswBah9mgp6UQwm0Zl64mDxM+hZU0fcLreydjYa6ziWJw0VnLkj9b5cKTgf9dDql4JVB60hQ==
X-Received: by 2002:a05:6a20:160b:b0:138:1c5b:24c3 with SMTP id l11-20020a056a20160b00b001381c5b24c3mr3677600pzj.49.1692213178408;
        Wed, 16 Aug 2023 12:12:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s21-20020a639255000000b00564ca424f79sm12354599pgn.48.2023.08.16.12.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:12:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Aug 2023 12:12:56 -0700
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
Subject: Re: [PATCH 1/7] rtc: Add support for limited alarm timer offsets
Message-ID: <3554580b-2b85-444c-8b73-fca6d7090283@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816133936.2150294-2-linux@roeck-us.net>
 <202308161457306eecdefb@mail.local>
 <9b6c7803-f258-472d-9983-530e42e80816@roeck-us.net>
 <202308161619050943672a@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308161619050943672a@mail.local>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:19:05PM +0200, Alexandre Belloni wrote:
> On 16/08/2023 08:24:39-0700, Guenter Roeck wrote:
> > On Wed, Aug 16, 2023 at 04:57:30PM +0200, Alexandre Belloni wrote:
> > > On 16/08/2023 06:39:30-0700, Guenter Roeck wrote:
> > > > Some alarm timers are based on time offsets, not on absolute times.
> > > > In some situations, the amount of time that can be scheduled in the
> > > > future is limited. This may result in a refusal to suspend the system,
> > > > causing substantial battery drain.
> > > > 
> > > > Some RTC alarm drivers remedy the situation by setting the alarm time
> > > > to the maximum supported time if a request for an out-of-range timeout
> > > > is made. This is not really desirable since it may result in unexpected
> > > > early wakeups.
> > > > 
> > > > To reduce the impact of this problem, let RTC drivers report the maximum
> > > > supported alarm timer offset. The code setting alarm timers can then
> > > > decide if it wants to reject setting alarm timers to a larger value, if it
> > > > wants to implement recurring alarms until the actually requested alarm
> > > > time is met, or if it wants to accept the limited alarm time.
> > > > 
> > > > Only introduce the necessary variable into struct rtc_device.
> > > > Code to set and use the variable will follow with subsequent patches.
> > > > 
> > > > Cc: Brian Norris <briannorris@chromium.org>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > >  include/linux/rtc.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> > > > index 1fd9c6a21ebe..b6d000ab1e5e 100644
> > > > --- a/include/linux/rtc.h
> > > > +++ b/include/linux/rtc.h
> > > > @@ -146,6 +146,7 @@ struct rtc_device {
> > > >  
> > > >  	time64_t range_min;
> > > >  	timeu64_t range_max;
> > > > +	timeu64_t range_max_offset;
> > > 
> > > While range_min and range_max are for the wall clock time, I would
> > > prefer using a name that would clearly mark this as an alarm related
> > > variable.
> > 
> > Sure, no problem. Do you have a suggestion ? alarm_range_max or
> > alarm_range_max_offset, maybe ? I'd also be happy to use some other
> > term for 'offset' if you have a suggestion.
> 
> I don't really know, what about alarm_offset_max? This is the maximum
> value of the offset for the alarm to the current time.
> 
Sounds good to me.

Thanks,
Guenter

> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
