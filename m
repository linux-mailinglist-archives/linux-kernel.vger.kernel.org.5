Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24D8790DDB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbjICUKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjICUKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:10:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77DAAD;
        Sun,  3 Sep 2023 13:10:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a32506e90so168749b3a.1;
        Sun, 03 Sep 2023 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693771828; x=1694376628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puAECqiDJbB9jeRDIyNPM7w1+Ch2B9Tc82Z85RGyYE4=;
        b=Z2vMApRVlWDAbTw6OB1vbSTm2zadWHyxSL92d5faj26UM/lznjGNjo3GyPkavMJQL/
         la/B6gipMkfLo8wHcJUHSMOERQ5JqEtzIqMvH5soElQHYUtDoH+if27zOtdfKvpY1Tm3
         v13Knx5OCPZfluUU0ZPdreQchDPdmm3wbtZhdDulVuLzDwTZL2uX1DRX/OehyYn7Pi1c
         AtLgplLclEqU4r/vYXmlU6K6D7Im5dFTAF1KPGVZH0MtokJo66CxG8ZH1Ow7csx1rqkf
         YPIkt8W0kBKL2YLRZ8XgyRNMw/jEDPuEV24Uf7Gb52TwBCaUc4fRNeVmTh3BxkbzZcFg
         Pmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693771828; x=1694376628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puAECqiDJbB9jeRDIyNPM7w1+Ch2B9Tc82Z85RGyYE4=;
        b=hGSJEKYslo7mP5X4iph3FzpO1Q+QJ5a4ybD/dS3gKV9Deiz3w6B/z3g0X9th2FAogh
         HCh6dUCtV3vqGKdm+kBkoJ6qr0HZ7YFnCbglkQhehE94Sa4iJn4uJBglEyRqMSuuWy8N
         JNAOxjQvipInm8MxPTz2LbPKayRHx05XWnJN4o0xWEvMxQwZBAsA9gE2ZIniIUbR7hkX
         CgrzhTUFasb4gnb9uEWd+LJaBe9lxOqS8tPHkKlVCAh4VKHBEEsVxOC4vGfq85SCR3Al
         Sz9M4UALEua3hOd1SDScCeOBll7zAYXRC+8LP95UiQXSaj551zkS9SoA3UjPhqnwe5ps
         0aDg==
X-Gm-Message-State: AOJu0YwcmGgS3Sem01KdqrKox7psLRaPHVJfFfjRwN5QuD7i3hceiFQM
        x9tndcUu2EWCOzBFBrZJXsk=
X-Google-Smtp-Source: AGHT+IFxeHxBvXotGDkvpS6Mwbk3NgmVRNXot/PGNkQHxb0RvUOtgAOsQCBK8rvSwKjJTeE2Gu9YiQ==
X-Received: by 2002:a05:6a20:7d97:b0:145:3bd9:1377 with SMTP id v23-20020a056a207d9700b001453bd91377mr11035893pzj.5.1693771828186;
        Sun, 03 Sep 2023 13:10:28 -0700 (PDT)
Received: from sivslab-System-Product-Name ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7914f000000b0068bc2432ee2sm6028823pfi.51.2023.09.03.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 13:10:27 -0700 (PDT)
Date:   Mon, 4 Sep 2023 04:10:24 +0800
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md/raid5: eliminate if-statements in cmp_stripe()
Message-ID: <20230903201024.GD2692213@sivslab-System-Product-Name>
References: <20230903095059.2683850-1-visitorckw@gmail.com>
 <20230903183058.1301b149@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903183058.1301b149@nvm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 06:30:58PM +0500, Roman Mamedov wrote:
> On Sun,  3 Sep 2023 17:50:59 +0800
> Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > Replace the conditional statements in the cmp_stripe() function with a
> > branchless version to improve code readability and potentially enhance
> > performance.
> 
> The new code will always do two comparisons and a subtraction (3
> instructions in total), whereas the old version could return after just 1
> comparison, or after 2 comparisons. So depending on the data values it is 3x
> to 1.5x as much operations performed than before, there unlikely to be any
> enhancement of performance.
> 
> Also IMO the previous version is more easily readable.
>
The reason behind my proposed changes was to eliminate conditional
branches in the code. While the original code could occasionally achieve
early returns, many compilers, such as x86-64 gcc 13.2 compiling with
-O2 flag, still generate branch instructions. Processors typically have
deep pipelines, and a branch prediction miss can result in a high
penalty. Therefore, even though early return might not be possible, the
new branchless version of code could still offer efficiency
improvements.
> > The new code calculates the result using a subtraction of
> > comparison results, making it more concise and avoiding conditional
> > branches. This change does not alter the functionality of the code.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  drivers/md/raid5.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index 4cb9c608ee19..b14d7ba38f0f 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -1035,11 +1035,7 @@ static int cmp_stripe(void *priv, const struct list_head *a,
> >  				struct r5pending_data, sibling);
> >  	const struct r5pending_data *db = list_entry(b,
> >  				struct r5pending_data, sibling);
> > -	if (da->sector > db->sector)
> > -		return 1;
> > -	if (da->sector < db->sector)
> > -		return -1;
> > -	return 0;
> > +	return (da->sector > db->sector) - (da->sector < db->sector);
> >  }
> >  
> >  static void dispatch_defer_bios(struct r5conf *conf, int target,
> 
> 
> -- 
> With respect,
> Roman

--
Best regards,
Kuan-Wei Chiu
